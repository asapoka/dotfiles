return {
  { -- 小さな独立モジュール群（mini.nvim のコレクション）
    'echasnovski/mini.nvim',
    config = function()
      -- テキストオブジェクトの操作を改善する設定
      --
      -- 例:
      --  - va)  - カッコの周りをビジュアルで選択
      --  - yinq - 次の引用符内をヤンク
      --  - ci'  - 引用符内を変更
      require('mini.ai').setup { n_lines = 500 }

      -- 周囲の括弧や引用符などの追加／削除／置換を可能にします
      --
      -- 例:
      -- - saiw) - 周囲を追加
      -- - sd'   - 周囲の引用符を削除
      -- - sr)'  - 周囲の置換
      require('mini.surround').setup()

      -- シンプルで軽量なステータスラインの設定です。
      --  好みでこの setup を削除して別のステータスラインプラグインを試しても構いません。
      local statusline = require 'mini.statusline'
      -- Nerd Font があればアイコン表示を有効化してください
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- ステータスラインの各セクションはデフォルト挙動を上書きして設定できます。
      -- 例としてカーソル位置の表示を LINE:COLUMN にしています。
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
