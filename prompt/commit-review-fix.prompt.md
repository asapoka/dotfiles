---
agent: agent
description: レビュー指摘対応のコミット＆プッシュ
argument-hint: "PR番号 または PRのURL"
model: Claude Haiku 4.5 (copilot)
---

# レビュー指摘対応のコミット＆プッシュ

PR番号またはURL: $ARGUMENTS

## 前提条件

- `/address-review` でレビュー指摘の修正が完了していること
- 修正内容をユーザーが確認済みであること

## 手順

1. **変更状況の確認**
   - `git status` で未コミットの変更を確認
   - `git diff` で変更内容を確認

2. **コミット＆プッシュ**
   - 修正内容をコミット
   - コミットメッセージ: `fix: レビュー指摘対応 (#{PR番号})`
     - PR番号は数字のみであることを確認
     - HEREDOCを使用してコミットメッセージを安全に渡す
   - `git push` でプッシュ
   - コミットハッシュを取得: `git rev-parse --short HEAD`

3. **【必須】レビューコメントへの返信**

   **この手順は絶対にスキップしないこと。コメントがなくても必ず確認すること。**

   レビューコメントには2種類あるため、両方を確認する：

   ### 3-1. インラインレビューコメントの確認
   ```bash
   gh api repos/{owner}/{repo}/pulls/{pr番号}/comments --jq '[.[] | select(.in_reply_to_id == null) | {id, path, body}]'
   ```
   - インラインコメントがある場合、各コメントに返信:
     ```bash
     gh api repos/{owner}/{repo}/pulls/{pr番号}/comments/{comment_id}/replies -f body="{返信内容}"
     ```

   ### 3-2. PRコメント（github-actionsボットのレビュー等）の確認
   ```bash
   gh api repos/{owner}/{repo}/issues/{pr番号}/comments --jq '[.[] | {id, user: .user.login, body: .body[:500]}]'
   ```
   - レビュー指摘を含むコメント（github-actionsボットの「レビュー結果」等）がある場合、新しいコメントとして返信を追加:
     ```bash
     gh api repos/{owner}/{repo}/issues/{pr番号}/comments -f body="{返信内容}"
     ```

   ### 返信フォーマット
   ```
   Fixed in {commit_hash}:

   ### 指摘1: {指摘タイトル}
   - {対応内容}

   ### 指摘2: {指摘タイトル}
   - {対応内容}
   ```

   ### 返信内容の作成ルール
   - `/03-address-review` で分析した指摘事項を元に返信を作成
   - 修正した指摘：具体的な修正内容を記載
   - 対応不要とした指摘：理由を記載（例：「Issue対象外のため」「既存の設計方針に従い」等）

4. **PR概要の更新確認**
   - ユーザーに「PR概要も更新しますか？」と確認
   - 「はい」の場合:
     - 修正内容を反映してPR本文を更新
     - HEREDOCを使用してPR本文を安全に渡す
   - 「いいえ」の場合: スキップ

## 注意事項

- **レビュー指摘の妥当性を検討すること**: レビュー指摘をそのまま鵜呑みにせず、指摘内容が技術的に正しいか、プロジェクトの方針に合っているかを確認してから修正する
- **【重要】手順3は絶対にスキップしない**: レビュー指摘への返信は、レビュアーへのフィードバックとして必須

## 出力

- コミット内容のサマリー
- PRのURL
- 返信したコメント数（0件の場合も明記）
