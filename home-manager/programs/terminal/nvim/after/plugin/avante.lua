-- img-clip: Enables pasting images from clipboard directly into markdown files
-- This is useful for quickly adding screenshots and images to documentation
require('img-clip').setup({
    default = {
        -- Save images as separate files instead of embedding as base64 strings
        -- This keeps markdown files clean and makes images reusable
        embed_image_as_base64 = false,

        -- Automatically generate filenames for pasted images
        -- Images will be saved with timestamps or sequential names
        prompt_for_file_name = false,

        drag_and_drop = {
            -- Allow dragging images directly into the editor while in insert mode
            insert_mode = true,
        },

        -- Use absolute paths for image references (required for Windows compatibility)
        -- Ensures images can be found regardless of working directory
        use_absolute_path = true,
    }
})
-- copilot: GitHub Copilot AI code completion
-- Provides intelligent code suggestions and completions as you type
-- Works across multiple programming languages
require('copilot').setup({
    -- Using default recommended settings for optimal performance
})
-- render-markdown: Enhanced markdown rendering in Neovim
-- Provides beautiful syntax highlighting and formatting for markdown files
-- Displays headers, lists, code blocks, and other markdown elements with rich formatting
require('render-markdown').setup({
    file_types = { "markdown", "Avante" }
    -- Using default recommended settings for optimal markdown display
})
-- avante: AI-powered coding assistant for Neovim
-- Provides intelligent code suggestions, explanations, and refactoring capabilities
-- Integrates with Claude AI to assist with various coding tasks
require('avante').setup({
    -- Project-specific instructions file that customizes AI behavior
    -- Create 'avante.md' in your project root to provide context about your codebase
    instructions_file = "avante.md",

    -- UI input provider configuration
    input = {
        -- Use dressing.nvim for enhanced input prompts with better UX
        provider = "dressing",
    },

    -- Primary AI provider to use (options: "claude", "openai", "copilot", etc.)
    provider = "claude",

    -- Provider-specific configurations
    providers = {
        claude = {
            -- Custom API endpoint (using a proxy server for Anthropic's API)
            -- Replace with "https://api.anthropic.com" for direct access
            endpoint = "https://api-proxy.itoolabs.com/anthropic",

            -- Authentication type for API requests
            auth_type = "api",

            -- AI model to use - Claude Sonnet 4.5 balances performance and cost
            -- Other options: "claude-opus-4", "claude-haiku-4"
            model = "claude-sonnet-4-5",

            -- Maximum time to wait for API response (30 seconds)
            -- Increase for complex queries, decrease for faster timeouts
            timeout = 30000,

            -- Maximum context window size in tokens (200k tokens)
            -- Determines how much code/conversation history the AI can process
            context_window = 200000,

            -- Additional parameters sent with each API request
            extra_request_body = {
                -- Controls randomness of responses (0.0-1.0)
                -- Lower values = more focused/deterministic, higher = more creative
                temperature = 0.75,

                -- Maximum tokens in AI response (64k tokens)
                -- Limits the length of generated code/explanations
                max_tokens = 64000,
            },
        }
    }

})
