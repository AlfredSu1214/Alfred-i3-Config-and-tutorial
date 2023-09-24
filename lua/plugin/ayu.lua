require('ayu').setup({
  mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
	overrides = {
		Normal = { bg = "None" },
		ColorColumn = { bg = "None" },
		SignColumn = { bg = "None" },
		Folded = { bg = "None" },
		FoldColumn = { bg = "None" },
		CursorColumn = { bg = "None" },
		WhichKeyFloat = { bg = "None" },
		VertSplit = { bg = "None" },
	}
})

vim.cmd [[colorscheme ayu]]
