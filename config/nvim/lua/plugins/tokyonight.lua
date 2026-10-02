return {
  { -- 別のカラースキームに簡単に切り替えることができます。
    -- 下のプラグイン名を変更し、設定内のコマンドをそのカラースキーム名に合わせてください。
    --
    -- インストール済みのカラースキームを確認するには `:Telescope colorscheme` を使用できます。
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- ここでカラースキームを読み込みます。
      -- このテーマには複数のスタイルがあり、'tokyonight-storm'、'tokyonight-moon'、'tokyonight-day' などを指定できます。
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
