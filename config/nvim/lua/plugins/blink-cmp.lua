return {
  { -- 補完（Autocompletion）
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default'（推奨）: ビルトイン補完と似たマッピングを使用します
        --   <c-y> で補完を受け入れます（[y]es）。
        --    LSP が対応していれば自動インポートが行われます。
        --    スニペットが送られている場合は展開されます。
        -- 'super-tab' は Tab で受け入れ
        -- 'enter' は Enter で受け入れ
        -- 'none' はマッピングを使用しません
        --
        -- なぜ 'default' が推奨かは `:help ins-completion` を参照してください。
        --
        -- 本当に便利なので `:help ins-completion` を一読することをおすすめします。
        --
        -- すべてのプリセットが以下のマッピングを持ちます:
        -- <tab>/<s-tab>: スニペット展開内で右/左に移動
        -- <c-space>: メニューを開く、または既に開いていればドキュメントを開く
        -- <c-n>/<c-p> または <up>/<down>: 次/前の候補を選択
        -- <c-e>: メニューを閉じる
        -- <c-k>: シグネチャヘルプの切り替え
        --
        -- 独自のキーマップ定義は :h blink-cmp-config-keymap を参照してください
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
