return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui", -- Correct the dependency path
        dependcies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dap.defaults.fallback.terminal_win_cmd = "50vsplit new" -- Use vertical split for terminal
            -- Set up dap-ui
            dapui.setup()

            -- Open/close dap-ui automatically during debugging
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- Key mappings for debugging
            vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue debugging" })
            vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "Terminate debugging" })
            vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap", -- Ensure nvim-dap is installed first
        },
        config = function()
            local dap_python = require("dap-python")

            -- Path to the Python executable in your virtual environment
            local python_path = "C:/Users/taylor.mccoy/.virtualenvs/debugpy/Scripts/python.exe"

            dap_python.setup(python_path)


            -- Optional: Add key mappings for testing and debugging Python code
            -- vim.keymap.set("n", "<Leader>dn", function()
            --     dap_python.test_method()
            -- end, { desc = "Debug current Python test method" })

            -- vim.keymap.set("n", "<Leader>df", function()
            --     dap_python.test_class()
            -- end, { desc = "Debug current Python test class" })

            -- vim.keymap.set("v", "<Leader>ds", function()
            --     dap_python.debug_selection()
            -- end, { desc = "Debug Python selection" })
        end,
    },
    {
        "nvim-neotest/nvim-nio",
    },
}
