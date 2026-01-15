---
agent: agent
description: Issueに対応する修正を実施
argument-hint: "Issue番号 または IssueのURL"
model: Claude Haiku 4.5 (copilot)
---

# Issue 対応修正

Issue 番号または URL: $ARGUMENTS

## 手順

1. **Issue 内容の確認**

   - `gh issue view` で Issue の内容を取得
   - 要件、受け入れ条件、関連情報を把握

2. **ブランチ作成**

   - `git fetch origin main && git checkout main && git pull origin main` で開発ブランチを最新化
   - main ブランチをベースに新しいブランチを作成
   - ブランチ名: `feature/issue-{番号}-{簡潔な説明}`
   - 例: `feature/issue-123-add-user-validation`

3. **実装**

   - Issue の要件に基づいて修正を実施
   - 既存コードのパターンを参照して統一する

4. **コード整形**

   - formatter / lint を実行

5. **テスト**
   - テストを実行。必要に応じてテストを追加

## 注意事項

- **コミットは行わない**（ユーザーが確認後に `/create-pr` で実施）
- 実装完了後、変更内容のサマリーを報告する
- 不明点があれば実装前にユーザーに確認する
