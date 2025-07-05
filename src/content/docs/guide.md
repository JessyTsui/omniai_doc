---
title: OmniAI 多模型接口调用指南
description: A guide
---

## 调用说明

[本站点](https://api.pandalla.ai/)提供统一的API接口，支持多种AI模型的无缝调用，包括OpenAI、Claude、Gemini、Midjourney等。本文档将详细介绍各模型的调用方法和示例。

## 基本配置

### 接口地址

将原始API地址从 `https://api.openai.com` 替换为 `https://api.pandalla.ai`

### 身份认证

使用在令牌页面`https://api.pandalla.ai/token` 生成的密钥进行API调用

**请注意：生成令牌的时候需注意分组，代表了不同的渠道消耗**

![Token Index](/token_index.jpg)

2. 参照`OpenAI`[官方文档](https://platform.openai.com/docs/api-reference/introduction)进行模型配置

- [Python SDK](https://github.com/openai/openai-python)
- [Node SDK](https://github.com/openai/openai-node)

#### Python 示例

```python
pip install openai
```

```python
from openai import OpenAI 

client = OpenAI(
	base_url="https://api.pandalla.ai/v1",
	api_key="sk-替换为你的key"
)

completion = client.chat.completions.create(
	model="gpt-4o-mini", 
	max_tokens=16384,
	messages=[
		{"role": "user", "content": "hi~"} 
	] 
)

print(completion)
```

#### Curl 示例

##### 聊天接口

```shell
curl --request POST \
    --url https://api.pandalla.ai/v1/chat/completions \
    --header 'Authorization: Bearer sk-替换为你的key' \
    -H "Content-Type: application/json" \
    --data '{
      "max_tokens": 1024,
      "model": "gpt-4o-mini",
      "temperature": 0.8,
      "top_p": 1,
      "presence_penalty": 1,
      "messages": [
          {
              "role": "system",
              "content": "You are ChatGPT, a large language model trained by OpenAI."
          },
          {
              "role": "user",
              "content": "hi~"
          }
      ]
  }'
```

##### 图片理解（vision）

```shell
curl  https://api.pandalla.ai/v1/chat/completions \
    -H 'Authorization: Bearer sk-替换为你的key' \
    -H "Content-Type: application/json" \
    -d '{
      "max_tokens": 1024,
      "model": "gpt-4-vision-preview",
      "messages": [
          {
              "role": "system",
              "content": "You are an expert Tailwind developer"
          },
          {
              "role": "user",
              "content": [
                  {
                      "type": "text",
                      "text": "将图片生成网页代码"
                  },
                  {
                      "type": "image_url",
                      "image_url": {
                          "url": "data:image/jpeg;base64,xxxx=图片链接或者图片base64"
                      }
                  }
              ]
          }
      ]
  }'
```

### Anthropic（Claude）

目前支持使用`OpenAI SDK`或者使用`OpenAI API`格式请求调用，您只需要将`model`改成`Claude`的模型名称即可调用`Claude`的模型。

### Google（Gemini）

目前支持使用`OpenAI SDK`或者使用`OpenAI API`格式请求调用，您只需要将`model`改成`Gemini`的模型名称即可调用`Gemini`的模型。

## 特殊用法

由于现在越来越多的模型支持了很多新特性，`OpenAI API`格式已经无法满足需求，有些特殊的调用方法，将在本页面进行说明。

### Gemini

#### 开启**联网搜索**

在请求时，增加 `tools` 参数，并设置 `name` 为 `googleSearch` 即可开启联网搜索。

```shell
curl -X POST https://api.pandalla.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-替换为你的key" \
  -d '{
    "model": "gemini-1.5-flash-002",
    "messages": [{"role": "user", "content": "今天有什么新闻"}],
    "tools": [
		{
			"function": {
				"name": "googleSearch",
				"parameters": {}
			},
			"type": "function"
		}
	]
  }'
```

#### 开启**代码执行**

在请求时，增加 `tools` 参数，并设置 `name` 为 `codeExecution` 即可开启代码执行。

```shell
curl -X POST https://api.pandalla.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-替换为你的key" \
  -d '{
    "model": "gemini-1.5-flash-002",
    "messages": [{"role": "user", "content": "计算2的7次方"}],
    "tools": [
		{
			"function": {
				"name": "codeExecution",
				"parameters": {}
			},
			"type": "function"
		}
	]
  }'
```

## 参数设置（特殊说明）

由于现在越来越多的模型属于推理模型，并且不同模型的参数限制存在差异，有些特殊的参数设置，将在本页面进行说明。

### OpenAI

1. 支持缓存的模型（gpt-4o-mini等）**默认启用缓存功能**，但只有输入即`prompt_tokens`大于`1024`才会触发。同时由于存在多个账号/组织并发承接请求，请求有概率被分发到不同的账号/组织进行转发，因此缓存有小概率不触发。
2. 推理模型（o1、o1-mini、o3、o3-mini、o4-mini等）默认开启推理且无法手动关闭，推理过程内容不返回。
3. 推理模型（o1、o1-mini、o3、o3-mini、o4-mini等）不支持设置`temperature/top_k/top_p`等参数。
4. 推理模型（o1、o1-mini、o3、o3-mini、o4-mini等）支持通过`reasoning.effort`参数来控制推理强度，可以设置为`low/medium/high`。
5. 对于推理模型不推荐设置过小的`max_tokens`，如果返回内容中`finish_reason`为`length`并且`content`为空，则表示对于请求的问题推理长度设置过小。
6. 推理模型（o1、o1-mini、o3、o3-mini、o4-mini等）如果返回`400`，可能是因为提示词不合规或者被识别为蒸馏行为，建议参考[文档](https://platform.openai.com/docs/guides/reasoning#advice-on-prompting)更改提示词。

### Anthropic（Claude）

1. 由于模型必须手动传入`max_tokens`，若请求未传入会自动设置为模型的最大值，例如`claude-3.7`的最大值为 `128000`。
2. 推理模型（claude-3.5，claude-3.7，claude-4等）**默认关闭推理**。
3. 推理模型（claude-3.5，claude-3.7，claude-4等）需要通过`reasoning`参数对象来开启推理，大部分情况下有推理内容返回，**小概率**被官方加密不返回：
   - 推理长度`budget_tokens`未设置则默认为`max_tokens`的`80%`
   - 支持通过设置`reasoning.effort="low/medium/high"`或者`reasoning.max_tokens=xx`来控制推理长度
   - `reasoning.max_tokens`的优先级高于`reasoning.effort`
   - `reasoning.effort`的`high/medium/low`分别对应`max_tokens`的`80%/50%/20%`
   - `reasoing.max_tokens`不可超过`max_tokens`且不能低于`1024`
4. 推理模型（claude-3.5，claude-3.7，claude-4等）开启推理后，`temperature/top_k/top_p`等参数只能设置为`1`，参考[文档](https://docs.anthropic.com/en/docs/build-with-claude/extended-thinking)。

### Google（Gemini）

Gemini每个模型的参数规则和约束不一致，需要看具体模型。另Gemini推理模型的`reasoning_tokens`的计数不包含在输出tokens即`completion_tokens`中，

-  `2.5-flash`默认开启推理，可以通过`reasoning.max_tokens`控制推理长度（最低为`1024`），支持设置`reasoning.max_tokens=0`来关闭推理，返回推理过程
-  `2.5-pro`默认开启推理且不可关闭，可以通过`reasoning.max_tokens`控制推理长度（最低为`1024`），返回推理过程。
-  `gemini-2.5-flash-preview-04-17`对应的`thinking`和`non-thinking`模型不支持`reasoning`参数。
-  若响应返回'message': 'No candidates returned表示内容审核后不合规，需要修改内容。参考[文档](https://cloud.google.com/vertex-ai/generative-ai/docs/multimodal/configure-safety-filters?hl=zh-cn)