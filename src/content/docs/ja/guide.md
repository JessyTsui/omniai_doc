---
title: APIインターフェース使用ガイド
description: OmniAI API詳細使用説明、全モデルの呼び出し方法と高度機能設定を含む
---

## インターフェース説明

OmniAIは統一されたAPIインターフェース標準を提供し、**OpenAI API形式と完全互換**、シームレスな切り替えをサポート。1つのインターフェースアドレスでOpenAI、Claude、Gemini、Midjourney等を含む全主要AIモデルにアクセス可能。

### 🌐 基本設定

#### APIアドレス
元のOpenAI APIアドレスをOmniAIアドレスに置換：
```
元アドレス: https://api.openai.com
新アドレス: https://api.pandalla.ai
```

#### 身元認証
[トークン管理ページ](https://api.pandalla.ai/token)で専用APIキーを生成

> 💡 **重要なヒント**: トークン生成時はグループ選択に注意、異なるグループは異なるサービスチャネルと課金標準に対応

![トークン管理インターフェース](/token_index.jpg)

---

## クイックスタート

### 📋 前提条件
公式OpenAIドキュメントを参照して開発環境設定：
- [Python SDK](https://github.com/openai/openai-python) 
- [Node.js SDK](https://github.com/openai/openai-node)

### 🐍 Python SDK

#### 依存関係インストール
```bash
pip install openai
```

#### 基本呼び出し例
```python
from openai import OpenAI

# クライアント初期化
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key="sk-your-omniai-api-key"  # あなたのキーに置換
)

# チャットリクエスト発行
response = client.chat.completions.create(
    model="gpt-4o-mini",
    max_tokens=16384,
    messages=[
        {"role": "user", "content": "こんにちは、OmniAIプラットフォームを紹介してください"}
    ]
)

print(response.choices[0].message.content)
```

### 🌐 HTTPリクエスト例

#### 標準チャットインターフェース
```bash
curl --request POST \
    --url https://api.pandalla.ai/v1/chat/completions \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --header 'Content-Type: application/json' \
    --data '{
        "model": "gpt-4o-mini",
        "max_tokens": 1024,
        "temperature": 0.8,
        "top_p": 1,
        "presence_penalty": 0,
        "messages": [
            {
                "role": "system",
                "content": "あなたは技術的な質問に答えるのが得意な専門的なAIアシスタントです。"
            },
            {
                "role": "user", 
                "content": "大規模言語モデルとは何かを説明してください。"
            }
        ]
    }'
```

#### マルチモーダル画像理解
```bash
curl https://api.pandalla.ai/v1/chat/completions \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --header 'Content-Type: application/json' \
    --data '{
        "model": "gpt-4-vision-preview",
        "max_tokens": 1024,
        "messages": [
            {
                "role": "system",
                "content": "あなたはTailwind CSSの使用に長けた専門的なフロントエンド開発エキスパートです"
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": "この画像に基づいて対応するWebページコードを生成し、Tailwind CSSスタイルを使用してください"
                    },
                    {
                        "type": "image_url", 
                        "image_url": {
                            "url": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/..."
                        }
                    }
                ]
            }
        ]
    }'
```

---

## モデルサポート

### 🤖 テキスト生成モデル

#### OpenAIシリーズ
全OpenAI公式モデルをサポート、同じ呼び出し方式を使用：
- `gpt-4o`, `gpt-4o-mini` - 最新マルチモーダルモデル
- `gpt-4-turbo`, `gpt-4` - 高性能推論モデル  
- `gpt-3.5-turbo` - 経済実用モデル
- `o1-preview`, `o1-mini` - 推論最適化モデル

#### Anthropic Claude
OpenAI API形式と完全互換、モデル名を変更するだけ：
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",  # Claudeモデル使用
    messages=[{"role": "user", "content": "こんにちは"}]
)
```

サポートされるClaudeモデル：
- `claude-3-5-sonnet-20241022` - 最新Sonnetモデル
- `claude-3-5-haiku-20241022` - 高速応答モデル
- `claude-3-opus-20240229` - 最強性能モデル

#### Google Gemini
同様にOpenAI API形式の呼び出しをサポート：
```python
response = client.chat.completions.create(
    model="gemini-1.5-flash-002",  # Geminiモデル使用
    messages=[{"role": "user", "content": "Hello Gemini"}]
)
```

---

## 高度機能

### 🔍 Gemini専用機能

#### ネット検索
Geminiモデルにリアルタイム検索機能を有効化：

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "2024年最新のAI技術発展トレンドは何ですか？"}
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "googleSearch",
                    "description": "現在の情報をWebで検索",
                    "parameters": {}
                }
            }
        ]
    }'
```

#### コード実行
Geminiのコード実行能力を有効化：

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "フィボナッチ数列の最初の20項を計算し、グラフを描いてください"}
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "codeExecution",
                    "description": "Pythonコードを実行",
                    "parameters": {}
                }
            }
        ]
    }'
```

---

## 推論モデル特別説明

### 🧠 OpenAI推論モデル
`o1`、`o1-mini`、`o3`、`o3-mini`、`o4-mini`等推論モデルの特別設定：

#### デフォルト設定
- ✅ **自動推論有効**: デフォルトでオン、手動でオフにできない
- ⚠️ **パラメータ制限**: `temperature`、`top_k`、`top_p`等のパラメータはサポートしない
- 📝 **推論プロセス**: 内部推論プロセスはユーザーに返されない

#### 推論強度制御
```python
response = client.chat.completions.create(
    model="o1-preview",
    messages=[{"role": "user", "content": "この複雑な数学問題を解いてください..."}],
    reasoning={
        "effort": "high"  # オプション: low, medium, high
    }
)
```

#### 注意事項
- 🔄 **Token設定**: 大きい`max_tokens`値の設定を推奨
- ⚡ **応答時間**: 推論モデルの応答時間は長いので、お待ちください
- 📋 **コンテンツ合規**: 400エラーが返される場合、プロンプトが使用規範に合致するか確認

### 🎭 Claude推論モデル
Claude推論モデルはデフォルトで**推論オフ**、手動で有効化が必要：

#### 推論有効化
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4096,
    messages=[{"role": "user", "content": "この複雑な問題を分析してください..."}],
    reasoning={
        "effort": "medium",     # 推論強度: low/medium/high
        "max_tokens": 2048      # 推論専用token数量
    }
)
```

#### 推論パラメータ説明
- `effort`: 推論深度制御、総`max_tokens`の20%/50%/80%に対応
- `max_tokens`: 推論プロセス専用token、総`max_tokens`を超えてはいけない
- ⚠️ **パラメータ制限**: 推論有効化後、`temperature`等のパラメータは1のみ設定可能

### 🔮 Gemini推論モデル

#### Gemini 2.5-flash
```python
response = client.chat.completions.create(
    model="gemini-2.5-flash",
    messages=[{"role": "user", "content": "深度分析..."}],
    reasoning={
        "max_tokens": 2048  # 最小1024、0に設定すると推論をオフに
    }
)
```

#### Gemini 2.5-pro
```python
response = client.chat.completions.create(
    model="gemini-2.5-pro", 
    messages=[{"role": "user", "content": "複雑な推論タスク..."}],
    reasoning={
        "max_tokens": 4096  # デフォルトでオン、オフにできない、最小1024
    }
)
```

---

## 課金説明

### 📊 課金モード

#### Token基づく課金
テキスト生成モデル（OpenAI、Claude、Gemini等）に適用：
```
実際費用 = Token数量 × モデル公式単価 × チャネル割引 × ユーザーレベル割引
```

#### 回数ベース課金  
生成類モデル（Midjourney、Suno等）に適用：
```
実際費用 = 呼び出し回数 × モデル固定単価 × チャネル割引 × ユーザーレベル割引
```

### 💰 優遇政策
- 🏢 **企業顧客**: 商用優遇価格と専用高速チャネルを享受
- 📈 **大用量顧客**: 自動ユーザーレベルアップグレード、より低い割引を享受
- 🔄 **動的価格**: 市場状況とコストに応じた合理的価格調整

---

## ベストプラクティス

### ⚡ 性能最適化

#### 1. 合理的なモデル選択
```python
# 簡単なタスクには経済モデルを使用
simple_response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "この文を翻訳してください"}]
)

# 複雑なタスクには高級モデルを使用
complex_response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "この複雑なビジネスレポートを分析してください"}]
)
```

#### 2. プロンプト最適化
```python
# ❌ 非効率プロンプト
bad_prompt = "コードを書くのを手伝って"

# ✅ 効率的プロンプト
good_prompt = """
専門的なPython開発者として、以下を手伝ってください：
1. CSVファイルを処理する関数を書く
2. エラー処理とデータ検証を含む  
3. 詳細なコメントとドキュメント文字列を追加
4. 処理結果の統計情報を返す
"""
```

#### 3. ストリーミング応答
```python
# ストリーミング応答を有効にしてユーザー体験を向上
stream = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "長い記事を書いてください"}],
    stream=True
)

for chunk in stream:
    if chunk.choices[0].delta.content is not None:
        print(chunk.choices[0].delta.content, end="")
```

### 🔒 セキュリティ推奨

#### APIキー管理
```python
import os
from openai import OpenAI

# ✅ 環境変数を使用してキーを保存
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key=os.getenv("OMNIAI_API_KEY")
)

# ❌ コードにキーをハードコードしない
# api_key="sk-hardcoded-key-in-code"  # 危険！
```

#### コンテンツフィルタリング
```python
# コンテンツセキュリティチェックを実装
def safe_chat_completion(user_input):
    # 入力コンテンツをチェック
    if contains_sensitive_content(user_input):
        return {"error": "Content not allowed"}
    
    # 正常なAPI呼び出し
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": user_input}]
    )
    return response
```

---

## よくある質問

### ❓ 一般的なエラー処理

#### 身元認証失敗
```python
try:
    response = client.chat.completions.create(...)
except Exception as e:
    if "401" in str(e):
        print("APIキーが無効です。キーが正しいか確認してください")
    elif "403" in str(e):
        print("権限不足です。アカウント残高や権限設定を確認してください")
```

#### モデル利用不可
```python
# モデルフォールバック戦略
def robust_chat_completion(messages, preferred_model="gpt-4o"):
    models = [preferred_model, "gpt-4o-mini", "gpt-3.5-turbo"]
    
    for model in models:
        try:
            return client.chat.completions.create(
                model=model, 
                messages=messages
            )
        except Exception as e:
            print(f"Model {model} failed: {e}")
            continue
    
    raise Exception("All models failed")
```

### 📞 技術サポート

問題が発生した場合はいつでもサポートいたします：

- 📧 **技術サポートメール**: support@pandalla.ai
- 📱 **企業顧客ホットライン**: 24時間技術サポート専用
- 📚 **オンラインドキュメント**: [https://docs.pandalla.ai](https://docs.pandalla.ai)
- 💬 **コミュニティフォーラム**: [https://community.pandalla.ai](https://community.pandalla.ai)

---

今すぐOmniAIの使用を開始して、最も便利なAIモデルアクセスサービスを体験してください！