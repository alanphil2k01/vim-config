function SplitRight()
    vim.cmd('botright vsplit')
    vim.cmd('vertical resize 50')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    return buf
end

local runCmd = {
    ["go"] = { cmd = "go run", pattern={"*.go"} },
    ["rust"] = { cmd = "cargo run", pattern={"*.rs"} },
    ["python"] = { cmd = "python", pattern={"*.py"} },
}

local function get_cmd(ft, fname)
    local cmd = runCmd[ft]
    if cmd then
        cmd = cmd.cmd .. " " .. fname
        return vim.fn.split(cmd)
    end
    return nil
end

local function get_pattern(ft)
    local pattern = runCmd[ft]
    if pattern then
        return pattern.pattern
    end
    return nil
end

local function start_runner(bufn, cmd)
    local pid = vim.fn.jobstart(cmd, {
        width = 50,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufn, -1, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufn, -1, -1, false, data)
            end
        end
    })
    return pid
end

local function create_stop_job_augrop(bufn, pid)
    vim.api.nvim_create_autocmd({"WinClosed"}, {
        group = vim.api.nvim_create_augroup("RunnerGroup", { clear = true }),
        buffer = bufn,
        callback = function()
            vim.fn.jobstop(pid)
            vim.api.nvim_buf_delete(bufn, {force = true})
            -- this will remove all autocmds in this group
            vim.api.nvim_create_augroup("RunnerGroup", { clear = true })
        end
    });
end

local function create_restart_cmd(bufn, pid, cmd, pattern)
    vim.api.nvim_create_autocmd({"BufWritePost"}, {
        group = vim.api.nvim_create_augroup("RunnerGroup", { clear = false }),
        pattern = pattern,
        callback = function()
            RestartRunner(bufn, pid, cmd, pattern)
        end
    });
end

function RestartRunner(bufn, pid, cmd, pattern)
    vim.fn.jobstop(pid)
    vim.api.nvim_buf_set_lines(bufn, 0, -1, false, {})
    local p = start_runner(bufn, cmd)
    create_stop_job_augrop(bufn, p)
    create_restart_cmd(bufn, pid, cmd, pattern)
end

function RunFile(prompt)
    local fname = vim.fn.expand("%")
    local ft = vim.bo.filetype
    local cmd = get_cmd(ft, fname)
    local pattern = get_pattern(ft)
    if not cmd or prompt then
        cmd = vim.fn.split(vim.fn.input("Enter command: "))
    end
    local bufn = SplitRight()
    local pid = start_runner(bufn, cmd)
    create_stop_job_augrop(bufn, pid)
    create_restart_cmd(bufn, pid, cmd, pattern)
end

SetKeymap("n", "<leader>r", RunFile, { silent = true, noremap = true })
SetKeymap("n", "<leader>rc", "<cmd>lua RunFile(true)<CR>", { silent = true, noremap = true })
