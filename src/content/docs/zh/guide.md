---
title: API接口使用指南
description: OmniAI API详细使用说明，包含所有模型的调用方法和高级功能配置
---

## 接口说明

OmniAI提供统一的API接口标准，**完全兼容OpenAI API格式**，支持无缝切换。通过一个接口地址即可访问包括OpenAI、Claude、Gemini、Midjourney等在内的所有主流AI模型。

### 🌐 基础配置

#### API地址
将原始OpenAI API地址替换为OmniAI地址：
```
原地址: https://api.openai.com
新地址: https://api.pandalla.ai
```

#### 身份认证
在 [令牌管理页面](https://api.pandalla.ai/token) 生成您的专属API密钥

> 💡 **重要提示**: 生成令牌时请注意选择分组，不同分组对应不同的服务渠道和计费标准

![Token管理界面](/token_index.jpg)

---

## 快速开始

### 📋 前置要求
参考官方OpenAI文档进行开发环境配置：
- [Python SDK](https://github.com/openai/openai-python) 
- [Node.js SDK](https://github.com/openai/openai-node)

### 🐍 Python SDK

#### 安装依赖
```bash
pip install openai
```

#### 基础调用示例
```python
from openai import OpenAI

# 初始化客户端
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key="sk-your-omniai-api-key"  # 替换为您的密钥
)

# 发起聊天请求
response = client.chat.completions.create(
    model="gpt-4o-mini",
    max_tokens=16384,
    messages=[
        {"role": "user", "content": "你好，介绍一下OmniAI平台"}
    ]
)

print(response.choices[0].message.content)
```

### 🌐 HTTP请求示例

#### 标准聊天接口
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
                "content": "你是一个专业的AI助手，擅长回答技术问题。"
            },
            {
                "role": "user", 
                "content": "请解释一下什么是大语言模型？"
            }
        ]
    }'
```

#### 多模态图像理解
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
                "content": "你是一个专业的前端开发专家，擅长使用Tailwind CSS"
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": "请根据这张图片生成对应的网页代码，使用Tailwind CSS样式"
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

## 模型支持

### 🤖 文本生成模型

#### OpenAI系列
支持所有OpenAI官方模型，使用相同的调用方式：
- `gpt-4o`, `gpt-4o-mini` - 最新多模态模型
- `gpt-4-turbo`, `gpt-4` - 高性能推理模型  
- `gpt-3.5-turbo` - 经济实用模型
- `o1-preview`, `o1-mini` - 推理优化模型

#### Anthropic Claude
完全兼容OpenAI API格式，只需更换模型名称：
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",  # 使用Claude模型
    messages=[{"role": "user", "content": "你好"}]
)
```

支持的Claude模型：
- `claude-3-5-sonnet-20241022` - 最新Sonnet模型
- `claude-3-5-haiku-20241022` - 快速响应模型
- `claude-3-opus-20240229` - 最强性能模型

#### Google Gemini
同样支持OpenAI API格式调用：
```python
response = client.chat.completions.create(
    model="gemini-1.5-flash-002",  # 使用Gemini模型
    messages=[{"role": "user", "content": "Hello Gemini"}]
)
```

---

## 高级功能

### 🔍 Gemini专属功能

#### 联网搜索
为Gemini模型启用实时搜索功能：

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "2024年最新的AI技术发展趋势是什么？"}
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "googleSearch",
                    "description": "Search the web for current information",
                    "parameters": {}
                }
            }
        ]
    }'
```

#### 代码执行
启用Gemini的代码执行能力：

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "请计算斐波那契数列的前20项，并绘制图表"}
        ],
        "tools": [
            {
                "type": "function",
                "function": {
                    "name": "codeExecution",
                    "description": "Execute Python code",
                    "parameters": {}
                }
            }
        ]
    }'
```

---

## 推理模型特别说明

### 🧠 OpenAI推理模型
针对 `o1`、`o1-mini`、`o3`、`o3-mini`、`o4-mini` 等推理模型的特殊配置：

#### 默认设置
- ✅ **自动启用推理**: 默认开启，无法手动关闭
- ⚠️ **参数限制**: 不支持 `temperature`、`top_k`、`top_p` 等参数
- 📝 **推理过程**: 内部推理过程不返回给用户

#### 推理强度控制
```python
response = client.chat.completions.create(
    model="o1-preview",
    messages=[{"role": "user", "content": "解决这个复杂的数学问题..."}],
    reasoning={
        "effort": "high"  # 可选: low, medium, high
    }
)
```

#### 注意事项
- 🔄 **Token设置**: 推荐设置较大的 `max_tokens` 值
- ⚡ **响应时间**: 推理模型响应时间较长，请耐心等待
- 📋 **内容合规**: 如返回400错误，请检查提示词是否符合使用规范

### 🎭 Claude推理模型
Claude推理模型默认**关闭推理**，需手动启用：

#### 启用推理
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4096,
    messages=[{"role": "user", "content": "分析这个复杂问题..."}],
    reasoning={
        "effort": "medium",     # 推理强度: low/medium/high
        "max_tokens": 2048      # 推理专用token数量
    }
)
```

#### 推理参数说明
- `effort`: 控制推理深度，对应 `max_tokens` 的 20%/50%/80%
- `max_tokens`: 推理过程专用token，不能超过总 `max_tokens`
- ⚠️ **参数限制**: 启用推理后，`temperature` 等参数只能设为1

### 🔮 Gemini推理模型

#### Gemini 2.5-flash
```python
response = client.chat.completions.create(
    model="gemini-2.5-flash",
    messages=[{"role": "user", "content": "深度分析..."}],
    reasoning={
        "max_tokens": 2048  # 最低1024，设为0可关闭推理
    }
)
```

#### Gemini 2.5-pro
```python
response = client.chat.completions.create(
    model="gemini-2.5-pro", 
    messages=[{"role": "user", "content": "复杂推理任务..."}],
    reasoning={
        "max_tokens": 4096  # 默认开启，不可关闭，最低1024
    }
)
```

---

## 计费说明

### 📊 计费模式

#### 基于Token计费
适用于文本生成模型（OpenAI、Claude、Gemini等）：
```
实际费用 = Token数量 × 模型官方单价 × 渠道折扣 × 用户等级折扣
```

#### 按次计费  
适用于生成类模型（Midjourney、Suno等）：
```
实际费用 = 调用次数 × 模型固定单价 × 渠道折扣 × 用户等级折扣
```

### 💰 优惠政策
- 🏢 **企业客户**: 享受商用优惠定价和专用高速通道
- 📈 **大用量客户**: 自动升级用户等级，享受更低折扣
- 🔄 **动态定价**: 价格根据市场情况和成本进行合理调整

---

## 最佳实践

### ⚡ 性能优化

#### 1. 合理选择模型
```python
# 简单任务使用经济模型
simple_response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "翻译这个句子"}]
)

# 复杂任务使用高级模型
complex_response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "分析这份复杂的商业报告"}]
)
```

#### 2. 优化提示词
```python
# ❌ 低效提示
bad_prompt = "帮我写代码"

# ✅ 高效提示
good_prompt = """
作为一个专业的Python开发者，请帮我：
1. 编写一个处理CSV文件的函数
2. 包含错误处理和数据验证  
3. 添加详细的注释和文档字符串
4. 返回处理结果的统计信息
"""
```

#### 3. 流式响应
```python
# 启用流式响应提升用户体验
stream = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "写一篇长文章"}],
    stream=True
)

for chunk in stream:
    if chunk.choices[0].delta.content is not None:
        print(chunk.choices[0].delta.content, end="")
```

### 🔒 安全建议

#### API密钥管理
```python
import os
from openai import OpenAI

# ✅ 使用环境变量存储密钥
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key=os.getenv("OMNIAI_API_KEY")
)

# ❌ 不要在代码中硬编码密钥
# api_key="sk-hardcoded-key-in-code"  # 危险！
```

#### 内容过滤
```python
# 实现内容安全检查
def safe_chat_completion(user_input):
    # 检查输入内容
    if contains_sensitive_content(user_input):
        return {"error": "Content not allowed"}
    
    # 正常调用API
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": user_input}]
    )
    return response
```

---

## 常见问题

### ❓ 常见错误处理

#### 身份认证失败
```python
try:
    response = client.chat.completions.create(...)
except Exception as e:
    if "401" in str(e):
        print("API密钥无效，请检查密钥是否正确")
    elif "403" in str(e):
        print("权限不足，请检查账户余额或权限设置")
```

#### 模型不可用
```python
# 模型回退策略
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

### 📞 技术支持

遇到问题？我们随时为您提供帮助：

- 📧 **技术支持邮箱**: support@pandalla.ai
- 📱 **企业客户热线**: 专享7x24小时技术支持
- 📚 **在线文档**: [https://docs.pandalla.ai](https://docs.pandalla.ai)
- 💬 **社区论坛**: [https://community.pandalla.ai](https://community.pandalla.ai)

---

立即开始使用OmniAI，体验最便捷的AI模型接入服务！