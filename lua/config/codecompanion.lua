require("codecompanion").setup({
	adapters = {
		qwen_coder_32b = function()
			return require("codecompanion.adapters").extend("ollama", {
				name = "Qwen2_5Coder32B",
				schema = {
					model = {
						default = "qwen2.5-coder:32b",
						num_ctx = { default = -1 },
						num_predict = { default = -1 },
					},
				},
			})
		end,
	},
	-- strategies = {
	-- 	chat = {
	-- 		adapter = "Qwen2_5Coder32B",
	-- 	},
	-- },
})
