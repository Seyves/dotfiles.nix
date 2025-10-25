require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "anthropic",
            model = "claude-haiku-4-5-20251001"
        },
        inline = {
            adapter = "anthropic",
            model = "claude-haiku-4-5-20251001"
        },
        cmd = {
            adapter = "anthropic",
            model = "claude-haiku-4-5-20251001"
        }
    },
    opts = {
        log_level = "DEBUG"
    },
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                url = "https://api-proxy.itoolabs.com/openai/v1/chat/completions",
                env = {
                    api_key = "cmd:cat ~/aitokens/itl/credential",
                },
                schema = {
                    model = {
                        default = "gpt-5"
                    }
                }
            })
        end,
        anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
                url = "https://api-proxy.itoolabs.com/anthropic/v1/messages",
                env = {
                    api_key = "cmd:cat ~/aitokens/itl/credential",
                },
                schema = {
                    model = {
                        default = "claude-haiku-4-5-20251001"
                    }
                }
            })
        end,
    },
})
