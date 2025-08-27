return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            
            -- Setup with error handling
            local ok, err = pcall(function()
                configs.setup({
                    -- enable syntax highlighting with error handling
                    highlight = {
                        enable = true, -- Re-enable treesitter highlighting
                        -- Disable for languages that commonly have parser issues
                        disable = function(lang, buf)
                            -- Disable for large files
                            local max_filesize = 100 * 1024 -- 100 KB
                            local ok_stats, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                            if ok_stats and stats and stats.size > max_filesize then
                                return true
                            end
                            
                            -- Disable for problematic parsers that might not be installed
                            local problematic_langs = { "c_sharp" }
                            if vim.tbl_contains(problematic_langs, lang) then
                                -- Check if parser is actually available
                                local has_parser = pcall(vim.treesitter.get_parser, buf, lang)
                                if not has_parser then
                                    return true
                                end
                            end
                        end,
                        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                        -- Using this option may slow down your editor, and you may see some duplicate highlights.
                        -- Instead of true it can also be a list of languages
                        additional_vim_regex_highlighting = false, -- Disable vim syntax for better performance
                    },
                    -- enable indentation with error handling
                    indent = { 
                        enable = true,
                        -- Disable indent for problematic languages
                        disable = { "python", "c_sharp" }, -- Python indentation can be problematic
                    },
                    -- enable autotagging (w/ nvim-ts-autotag plugin)
                    autotag = { enable = true },
                    -- ensure these language parsers are installed
                    ensure_installed = {
                        "json",
                        "javascript",
                        "query",
                        "typescript",
                        "tsx",
                        "php",
                        "python",      -- Python syntax highlighting
                        "yaml",
                        "html",
                        "css",
                        "markdown",
                        "markdown_inline",
                        "bash",
                        "lua",
                        "vim",
                        "vimdoc",
                        "c",
                        "go",
                        "c_sharp", -- Remove c_sharp for now as it might be causing issues
                        "dockerfile",
                        "gitignore",
                        "astro",
                    },
                    -- auto install above language parsers
                    auto_install = true,
                })
            end)
            
            if not ok then
                vim.notify("Treesitter configuration failed: " .. tostring(err), vim.log.levels.ERROR)
                -- Fallback to basic syntax highlighting
                vim.cmd("syntax on")
            end
            
            -- Manual parser installation with error handling for C#
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "cs",
                callback = function()
                    -- Try to install c_sharp parser manually
                    local has_parser = pcall(vim.treesitter.get_parser, 0, "c_sharp")
                    if not has_parser then
                        vim.notify("C# treesitter parser not available, using basic syntax highlighting", vim.log.levels.WARN)
                        vim.bo.syntax = "cs"
                    end
                end
            })
        end
    }
}
