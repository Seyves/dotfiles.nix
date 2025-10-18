require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "anthropic",
        },
        inline = {
            adapter = "anthropic",
        },
        cmd = {
            adapter = "anthropic",
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
            })
        end,
        anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
                url = "https://api-proxy.itoolabs.com/anthropic/v1/messages",
                env = {
                    api_key = "cmd:cat ~/aitokens/itl/credential",
                },
            })
        end,
    },
})
