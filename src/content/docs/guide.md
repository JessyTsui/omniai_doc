---
title: OmniAI 多模型接口调用指南
description: A guide
---

## 概述

OmniAI 提供统一的API接口，支持多种AI模型的无缝调用，包括OpenAI、Claude、Gemini、Midjourney等。本文档将详细介绍各模型的调用方法和示例。

## 基本配置

### 接口地址

将原始API地址从 `https://api.openai.com` 替换为 `https://api.pandalla.ai`

### 身份认证

使用在令牌页面`https://api.pandalla.ai/token` 生成的密钥进行API调用

**请注意：生成令牌的时候需注意分组，代表了不同的渠道消耗**

![](/public/token_index.jpg)

## OpenAI 模型调用

### Python SDK 调用示例

```python
pip install openai
from openai import OpenAI

client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key="sk-xxxxxx"
)

completion = client.chat.completions.create(
    model="gpt-4o-mini",
    max_tokens=16384,
    messages=[
        {"role": "user", "content": "hi"}
    ]
)
print(completion)
```

### Curl 调用示例

#### 聊天接口

```bash
curl --request POST \
    --url https://api.pandalla.ai/v1/chat/completions \
    --header 'Authorization: Bearer sk-你的key' \
    -H "Content-Type: application/json" \
    --data '{
      "max_tokens": 1200,
      "model": "gpt-3.5-turbo",
      "temperature": 0.8,
      "messages": [
          {
              "role": "system",
              "content": "You are ChatGPT, a large language model."
          },
          {
              "role": "user",
              "content": "你是chatGPT吗？"
          }
      ]
  }'
```

#### DALL-E 图像生成

```bash
curl https://api.pandalla.ai/v1/images/generations \
    -H 'Authorization: Bearer sk-你的key' \
    -H "Content-Type: application/json" \
    -d '{
      "model": "dall-e-3",
      "prompt": "a white siamese cat",
      "n": 1,
      "size": "1024x1024"
    }'
```

#### Vision 图像识别

```bash
curl https://api.pandalla.ai/v1/chat/completions \
    -H 'Authorization: Bearer sk-你的key' \
    -H "Content-Type: application/json" \
    -d '{
      "max_tokens": 1200,
      "model": "gpt-4-vision-preview",
      "messages": [
          {
              "role": "system",
              "content": "You are an expert Tailwind developer"
          },
          {
              "role": "user",
              "content": [
                  {"type": "text", "text": "将图片生成网页代码"},
                  {
                      "type": "image_url",
                      "image_url": {
                          "url": "data:image/jpeg;base64,图片base64"
                      }
                  }
              ]
          }
      ]
  }'
```

#### Whisper 语音转文字

```bash
curl --request POST \
    --url https://api.pandalla.ai/v1/audio/transcriptions \
    --header 'Authorization: Bearer sk-你的key' \
    --header 'Content-Type: multipart/form-data' \
    --form file=@/path/to/file/openai.mp3 \
    --form model=whisper-1
```

#### 文本转语音(TTS)

```bash
curl https://api.pandalla.ai/v1/audio/speech \
    -H "Authorization: Bearer sk-你的key" \
    -H "Content-Type: application/json" \
    -d '{
      "model": "tts-1",
      "input": "你说点什么 包括中文!",
      "voice": "alloy"
    }' \
    --output speech.mp3
```

## 其他模型调用

### Claude & Gemini

对于Claude和Gemini，只需将`model`参数修改为对应模型名称即可。

### Midjourney API 使用指南

#### 基础配置

API 基础地址支持三种模式：
- Relax模式：`/mj-relax`
- Fast模式：`/mj-fast`（默认）
- Turbo模式：`/mj-turbo`

使用时需要配置以下信息：
```python
BASE_URL = "https://api.pandalla.ai/mj-fast"  # 或其他模式
BEARER_TOKEN = "your-token-here"
```

#### 主要功能

##### 1. 生成图片

基本使用方式：
```python
generator = MJImageGenerator()
task_id = generator.submit_task(prompt)
result = generator.wait_for_completion(task_id)
```

prompt 参数支持以下配置：

###### 风格选项
- Cyberpunk (賽博朋克)
- Warframe (星際)
- ACGN (動漫)
- Japanese comics/manga (日本漫畫)
- Ink Wash Painting Style (水墨畫風格)
- Original (原創)
- landscape (風景畫)
- illustration (插畫)
等...

###### 视角选项
- Wide view (寬視角)
- Aerial view (鳥瞰視角)
- Top view (頂視角)
- Upview (仰視角)
- Front view (正面視角)
等...

###### 人物特写选项
- Face Shot (VCU) (臉部特寫)
- Big Close-Up(BCU) (大特寫)
- Close-Up(CU) (特寫)
- Waist Shot(WS) (腰部以上)
等...

###### 灯光选项
- Cold light (冷光)
- Warm light (暖光)
- hard lighting (硬光)
- Dramatic light (戲劇性光線)
等...

##### 2. 参数说明

在 prompt 末尾可以添加以下参数：

- `--q <value>`: 质量参数
  - 可选值：0.25, 0.5, 1, 2
  
- `--s <value>`: 艺术程度
  - 范围：0-1000
  
- `--v <version>`: 版本号
  - 可选值：1, 2, 3, 4, 5, 5.0, 5.1, 5.2, 6, 6.1
  - 对于 niji 模型使用 `--niji <version>`
  
- `--ar <ratio>`: 宽高比
  - 例如：4:3, 16:9

##### 3. 特殊操作

###### 图片操作按钮
生成图片后可以进行以下操作：
- U1-U4: 放大指定位置的图片
- V1-V4: 对指定位置的图片进行变体生成
- 🔄: 重新生成

```python
# 执行按钮操作
action_id = generator.action("MJ::JOB::upsample::1::xxx", task_id)
result = generator.wait_for_completion(action_id)
```

###### 自定义缩放
```python
# 1. 执行缩放按钮操作
action_id = generator.action("MJ::CustomZoom::xxx", task_id)

# 2. 设置缩放值
prompt += " --zoom 1.8"
modal_id = generator.modal(prompt, action_id)
result = generator.wait_for_completion(modal_id)
```

##### 4. 其他功能

###### 图生文
```python
task_id = generator.describe("base64_image_data", "MID_JOURNEY")
result = generator.wait_for_completion(task_id)
```

###### 缩短提示词
```python
task_id = generator.shorten("your_long_prompt", "MID_JOURNEY")
result = generator.wait_for_completion(task_id)
```

#### 示例

完整的图片生成示例：
```python
prompt = "Cyberpunk,Wide view,Face Shot (VCU),Cold light,可爱的猫 --q 2 --s 50 --v 6.1 --ar 4:3"
task_id = generator.submit_task(prompt)
result = generator.wait_for_completion(task_id)
```

生成完成后，可以通过 `result` 获取以下信息：
- 图片链接
- 原始提示词
- 英文提示词
- 可用的操作按钮

#### 完整示例代码

##### 基础类实现
```python
import requests
import time
import json

class MJImageGenerator:
    def __init__(self):
        self.base_url = "https://api.pandalla.ai/mj-fast"
        self.headers = {
            "mj-api-secret": "your-token-here",
            "Content-Type": "application/json"
        }

    def submit_task(self, prompt):
        """提交图片生成任务"""
        url = f"{self.base_url}/mj/submit/imagine"
        payload = {
            "base64Array": [],  # 可选，用于垫图，最多5张，单张不超过1M
            "prompt": prompt,
            "botType": "MID_JOURNEY"  # 或 "NIJI_JOURNEY"
        }

        response = requests.post(url, headers=self.headers, json=payload)
        data = response.json()

        if data["code"] not in [1, 22]:
            raise Exception(f"提交任务失败: {data['description']}")

        return data["result"]

    def fetch_task_status(self, task_id):
        """获取任务状态"""
        url = f"{self.base_url}/mj/task/{task_id}/fetch"
        response = requests.get(url, headers=self.headers)
        return response.json()

    def wait_for_completion(self, task_id):
        """轮询等待任务完成"""
        while True:
            data = self.fetch_task_status(task_id)
            status = data["status"]
            progress = data["progress"]
            print(f"当前进度: {progress}")

            if status == "SUCCESS":
                print("任务完成!")
                print(f"图片链接: {data['imageUrl']}")
                print(f"提示词: {data['prompt']}")
                print(f"提示词EN: {data['promptEn']}")
                print("\n可用的操作按钮:")
                for button in data["buttons"]:
                    label = button['label'] if button['label'] != "" else button['emoji']
                    print(f"{label}: {button['customId']}")
                return data
            elif status == "FAILURE":
                raise Exception(f"任务失败: {data['failReason']}")

            time.sleep(10)

    def action(self, customId, taskId):
        """执行按钮操作"""
        url = f"{self.base_url}/mj/submit/action"
        payload = {
            "customId": customId,
            "taskId": taskId
        }
        response = requests.post(url, headers=self.headers, json=payload)
        data = response.json()

        if data["code"] not in [1, 22]:
            raise Exception(f"提交任务失败: {data['description']}")

        return data["result"]

    def modal(self, taskId, prompt):
        """执行modal操作（如自定义缩放）"""
        url = f"{self.base_url}/mj/submit/modal"
        payload = {
            "prompt": prompt,
            "taskId": taskId
        }
        response = requests.post(url, headers=self.headers, json=payload)
        data = response.json()

        if data["code"] not in [1, 22]:
            raise Exception(f"提交任务失败: {data['description']}")

        return data["result"]
```

##### 使用示例

###### 1. 基本图片生成
```python
def generate_basic_image():
    generator = MJImageGenerator()
    
    # 基本的图片生成请求
    prompt = "Cyberpunk style cute cat, detailed fur --q 2 --s 50 --v 6.1 --ar 4:3"
    
    print("提交任务中...")
    task_id = generator.submit_task(prompt)
    print(f"任务ID: {task_id}")
    
    print("等待任务完成...")
    result = generator.wait_for_completion(task_id)
    return result
```

###### 2. 使用垫图生成
```python
def generate_with_reference():
    generator = MJImageGenerator()
    
    # 使用base64编码的图片作为垫图
    payload = {
        "base64Array": ["your_base64_image_string"],
        "prompt": "Create similar style cat --q 2",
        "botType": "MID_JOURNEY"
    }
    
    task_id = generator.submit_task(payload)
    result = generator.wait_for_completion(task_id)
    return result
```

###### 3. 图片操作示例
```python
def image_operations():
    generator = MJImageGenerator()
    
    # 1. 首先生成初始图片
    prompt = "Cyberpunk cat --q 2"
    task_id = generator.submit_task(prompt)
    result = generator.wait_for_completion(task_id)
    
    # 2. 放大第一张图片
    if "buttons" in result:
        # 找到U1按钮的customId
        upscale_button = next(
            (b for b in result["buttons"] if b["label"] == "U1"), 
            None
        )
        if upscale_button:
            action_id = generator.action(upscale_button["customId"], task_id)
            result = generator.wait_for_completion(action_id)
    
    return result
```

###### 4. 自定义缩放示例
```python
def custom_zoom():
    generator = MJImageGenerator()
    
    # 1. 生成初始图片
    initial_prompt = "Cyberpunk cat --q 2"
    task_id = generator.submit_task(initial_prompt)
    result = generator.wait_for_completion(task_id)
    
    # 2. 执行缩放操作
    zoom_button = next(
        (b for b in result["buttons"] if "CustomZoom" in b["customId"]), 
        None
    )
    if zoom_button:
        # 执行缩放按钮操作
        action_id = generator.action(zoom_button["customId"], task_id)
        
        # 添加缩放参数
        zoom_prompt = initial_prompt + " --zoom 1.8"
        modal_id = generator.modal(action_id, zoom_prompt)
        result = generator.wait_for_completion(modal_id)
    
    return result
```

##### 主函数示例
```python
def main():
    try:
        # 基本图片生成
        result = generate_basic_image()
        print("基本图片生成完成:", result["imageUrl"])
        
        # 执行图片操作
        operated_result = image_operations()
        print("图片操作完成:", operated_result["imageUrl"])
        
        # 执行自定义缩放
        zoom_result = custom_zoom()
        print("自定义缩放完成:", zoom_result["imageUrl"])
        
    except Exception as e:
        print(f"发生错误: {str(e)}")

if __name__ == "__main__":
    main()
```



### Suno 音乐生成

详细的Python示例请参考文档原始代码。

### Udio 音乐生成

详细的Python示例请参考文档原始代码。

## 注意事项

1. 请妥善保管您的API密钥
2. 遵守各平台的使用条款
3. 对于图像和音频等资源，注意版权和使用限制

## 更多帮助

如需详细支持，请联系OmniAI技术支持团队。