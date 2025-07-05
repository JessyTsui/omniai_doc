---
title: API Interface Usage Guide
description: OmniAI API detailed usage instructions, including calling methods and advanced feature configurations for all models
---

## Interface Description

OmniAI provides a unified API interface standard, **fully compatible with OpenAI API format**, supporting seamless switching. Through one interface address, you can access all mainstream AI models including OpenAI, Claude, Gemini, Midjourney, etc.

### 🌐 Basic Configuration

#### API Address
Replace the original OpenAI API address with the OmniAI address:
```
Original: https://api.openai.com
New: https://api.pandalla.ai
```

#### Authentication
Generate your exclusive API key on the [Token Management Page](https://api.pandalla.ai/token)

> 💡 **Important Note**: When generating tokens, please pay attention to group selection. Different groups correspond to different service channels and billing standards

![Token Management Interface](/token_index.jpg)

---

## Quick Start

### 📋 Prerequisites
Refer to the official OpenAI documentation for development environment setup:
- [Python SDK](https://github.com/openai/openai-python) 
- [Node.js SDK](https://github.com/openai/openai-node)

### 🐍 Python SDK

#### Install Dependencies
```bash
pip install openai
```

#### Basic Call Example
```python
from openai import OpenAI

# Initialize client
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key="sk-your-omniai-api-key"  # Replace with your key
)

# Send chat request
response = client.chat.completions.create(
    model="gpt-4o-mini",
    max_tokens=16384,
    messages=[
        {"role": "user", "content": "Hello, please introduce the OmniAI platform"}
    ]
)

print(response.choices[0].message.content)
```

### 🌐 HTTP Request Example

#### Standard Chat Interface
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
                "content": "You are a professional AI assistant who excels at answering technical questions."
            },
            {
                "role": "user", 
                "content": "Please explain what a large language model is."
            }
        ]
    }'
```

#### Multimodal Image Understanding
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
                "content": "You are a professional frontend development expert skilled in using Tailwind CSS"
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": "Please generate corresponding webpage code based on this image, using Tailwind CSS styles"
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

## Model Support

### 🤖 Text Generation Models

#### OpenAI Series
Support all OpenAI official models with the same calling method:
- `gpt-4o`, `gpt-4o-mini` - Latest multimodal models
- `gpt-4-turbo`, `gpt-4` - High-performance reasoning models  
- `gpt-3.5-turbo` - Economical and practical model
- `o1-preview`, `o1-mini` - Reasoning optimized models

#### Anthropic Claude
Fully compatible with OpenAI API format, just change the model name:
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",  # Use Claude model
    messages=[{"role": "user", "content": "Hello"}]
)
```

Supported Claude models:
- `claude-3-5-sonnet-20241022` - Latest Sonnet model
- `claude-3-5-haiku-20241022` - Fast response model
- `claude-3-opus-20240229` - Strongest performance model

#### Google Gemini
Also supports OpenAI API format calling:
```python
response = client.chat.completions.create(
    model="gemini-1.5-flash-002",  # Use Gemini model
    messages=[{"role": "user", "content": "Hello Gemini"}]
)
```

---

## Advanced Features

### 🔍 Gemini Exclusive Features

#### Web Search
Enable real-time search functionality for Gemini models:

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "What are the latest AI technology development trends in 2024?"}
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

#### Code Execution
Enable Gemini's code execution capability:

```bash
curl -X POST https://api.pandalla.ai/v1/chat/completions \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer sk-your-omniai-api-key' \
    --data '{
        "model": "gemini-1.5-flash-002",
        "messages": [
            {"role": "user", "content": "Please calculate the first 20 terms of the Fibonacci sequence and plot a chart"}
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

## Reasoning Models Special Instructions

### 🧠 OpenAI Reasoning Models
Special configuration for reasoning models like `o1`, `o1-mini`, `o3`, `o3-mini`, `o4-mini`:

#### Default Settings
- ✅ **Auto-enable reasoning**: Default on, cannot be manually disabled
- ⚠️ **Parameter limitations**: Does not support parameters like `temperature`, `top_k`, `top_p`
- 📝 **Reasoning process**: Internal reasoning process is not returned to users

#### Reasoning Intensity Control
```python
response = client.chat.completions.create(
    model="o1-preview",
    messages=[{"role": "user", "content": "Solve this complex math problem..."}],
    reasoning={
        "effort": "high"  # Options: low, medium, high
    }
)
```

#### Notes
- 🔄 **Token Setting**: Recommend setting a larger `max_tokens` value
- ⚡ **Response Time**: Reasoning models have longer response times, please be patient
- 📋 **Content Compliance**: If 400 error is returned, please check if the prompt complies with usage guidelines

### 🎭 Claude Reasoning Models
Claude reasoning models default to **reasoning off**, need manual activation:

#### Enable Reasoning
```python
response = client.chat.completions.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=4096,
    messages=[{"role": "user", "content": "Analyze this complex problem..."}],
    reasoning={
        "effort": "medium",     # Reasoning intensity: low/medium/high
        "max_tokens": 2048      # Reasoning-specific token count
    }
)
```

#### Reasoning Parameter Description
- `effort`: Controls reasoning depth, corresponding to 20%/50%/80% of total `max_tokens`
- `max_tokens`: Reasoning process exclusive tokens, cannot exceed total `max_tokens`
- ⚠️ **Parameter limitations**: After enabling reasoning, parameters like `temperature` can only be set to 1

### 🔮 Gemini Reasoning Models

#### Gemini 2.5-flash
```python
response = client.chat.completions.create(
    model="gemini-2.5-flash",
    messages=[{"role": "user", "content": "Deep analysis..."}],
    reasoning={
        "max_tokens": 2048  # Minimum 1024, set to 0 to disable reasoning
    }
)
```

#### Gemini 2.5-pro
```python
response = client.chat.completions.create(
    model="gemini-2.5-pro", 
    messages=[{"role": "user", "content": "Complex reasoning task..."}],
    reasoning={
        "max_tokens": 4096  # Default on, cannot be disabled, minimum 1024
    }
)
```

---

## Billing Description

### 📊 Billing Mode

#### Token-based Billing
Applicable to text generation models (OpenAI, Claude, Gemini, etc.):
```
Actual Cost = Token Count × Model Official Unit Price × Channel Discount × User Level Discount
```

#### Per-call Billing  
Applicable to generation models (Midjourney, Suno, etc.):
```
Actual Cost = Call Count × Model Fixed Unit Price × Channel Discount × User Level Discount
```

### 💰 Preferential Policies
- 🏢 **Enterprise Customers**: Enjoy commercial preferential pricing and dedicated high-speed channels
- 📈 **High-volume Customers**: Automatic user level upgrade, enjoy lower discounts
- 🔄 **Dynamic Pricing**: Reasonable price adjustments based on market conditions and costs

---

## Best Practices

### ⚡ Performance Optimization

#### 1. Reasonable Model Selection
```python
# Use economical models for simple tasks
simple_response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "Translate this sentence"}]
)

# Use advanced models for complex tasks
complex_response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "Analyze this complex business report"}]
)
```

#### 2. Prompt Optimization
```python
# ❌ Inefficient prompt
bad_prompt = "Help me write code"

# ✅ Efficient prompt
good_prompt = """
As a professional Python developer, please help me:
1. Write a function to process CSV files
2. Include error handling and data validation  
3. Add detailed comments and docstrings
4. Return processing result statistics
"""
```

#### 3. Streaming Response
```python
# Enable streaming response to improve user experience
stream = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "Write a long article"}],
    stream=True
)

for chunk in stream:
    if chunk.choices[0].delta.content is not None:
        print(chunk.choices[0].delta.content, end="")
```

### 🔒 Security Recommendations

#### API Key Management
```python
import os
from openai import OpenAI

# ✅ Use environment variables to store keys
client = OpenAI(
    base_url="https://api.pandalla.ai/v1",
    api_key=os.getenv("OMNIAI_API_KEY")
)

# ❌ Don't hardcode keys in code
# api_key="sk-hardcoded-key-in-code"  # Dangerous!
```

#### Content Filtering
```python
# Implement content security checks
def safe_chat_completion(user_input):
    # Check input content
    if contains_sensitive_content(user_input):
        return {"error": "Content not allowed"}
    
    # Normal API call
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": user_input}]
    )
    return response
```

---

## Common Issues

### ❓ Common Error Handling

#### Authentication Failure
```python
try:
    response = client.chat.completions.create(...)
except Exception as e:
    if "401" in str(e):
        print("Invalid API key, please check if the key is correct")
    elif "403" in str(e):
        print("Insufficient permissions, please check account balance or permission settings")
```

#### Model Unavailable
```python
# Model fallback strategy
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

### 📞 Technical Support

If you encounter any problems, we are always here to help:

- 📧 **Technical Support Email**: support@pandalla.ai
- 📱 **Enterprise Customer Hotline**: Dedicated 24/7 technical support
- 📚 **Online Documentation**: [https://docs.pandalla.ai](https://docs.pandalla.ai)
- 💬 **Community Forum**: [https://community.pandalla.ai](https://community.pandalla.ai)

---

Start using OmniAI now and experience the most convenient AI model access service!