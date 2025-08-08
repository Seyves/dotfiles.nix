require("codecompanion").setup({
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    url = "https://api-proxy.itoolabs.com/openai",
                    api_key = "cmd:op read op://aitokens/OpenAI/credential --no-newline",
                },
            })
        end,
    },
})
