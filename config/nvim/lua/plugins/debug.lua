-- debug.lua
--
-- DAP プラグインを使ったデバッグ設定の例です。
--
-- 主に Go 向けのデバッガ設定に焦点を当てていますが、他の言語へも拡張できます。
-- これは Kickstart 設定のサンプルなので、必要に応じて自由に変更してください。

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- きれいなデバッガ用の UI を作成するプラグイン
    'rcarriga/nvim-dap-ui',

    -- nvim-dap-ui の必須依存ライブラリ
    'nvim-neotest/nvim-nio',

    -- デバッグアダプタをインストールするためのツール
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- 必要に応じて追加のデバッガをここに記述してください
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- 最後のセッション結果を表示するトグル。この設定がないと、未処理の例外が発生した場合にセッションの出力が見えないことがあります。
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: 最後のセッション結果を表示',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- さまざまなデバッガを合理的なデフォルト設定でセットアップするための最善の試みを行います
      automatic_installation = true,

      -- ハンドラに追加設定を渡すことができます。
      -- 詳細は mason-nvim-dap の README を参照してください
      handlers = {},

      -- 必要なツールがインストールされていることを確認してください
      -- （インストール方法は README 等を参照してください）
      ensure_installed = {
        -- 使用したい言語のデバッガをここに追加してください
        'delve',
      },
    }

    -- DAP UI の設定
    -- 詳細は |:help nvim-dap-ui| を参照してください
    dapui.setup {
      -- ターミナル間で動作しやすい文字にアイコンを設定します。
      --    必要に応じて削除したり好みのアイコンに変更してください。
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- ブレークポイントのアイコンを変更する例
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
