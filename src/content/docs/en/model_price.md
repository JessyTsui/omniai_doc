---
title: Model Pricing and Billing Instructions
description: Detailed pricing information for OmniAI supported models, transparent billing standards and usage optimization recommendations
---

## Pricing Overview

OmniAI provides transparent, competitive pricing across four service tiers to meet different user needs from development to enterprise production.

### 💰 Pricing Structure

All prices are calculated based on:
```
Actual Cost = Usage Amount × Official Model Price × Channel Multiplier × User Level Discount
```

#### Channel Multipliers by Tier:
- **Economy Tier**: 0.3× official price
- **Standard Tier**: 0.7× official price  
- **Professional Tier**: 1.0× official price
- **Premium Tier**: 1.8× official price

---

## Text Generation Models

### 🤖 OpenAI Models

#### GPT-4 Series
| Model | Input (per 1M tokens) | Output (per 1M tokens) | Context Window |
|-------|----------------------|------------------------|----------------|
| gpt-4o | $2.50 | $10.00 | 128K |
| gpt-4o-mini | $0.15 | $0.60 | 128K |
| gpt-4-turbo | $10.00 | $30.00 | 128K |
| gpt-4 | $30.00 | $60.00 | 8K |

#### GPT-3.5 Series
| Model | Input (per 1M tokens) | Output (per 1M tokens) | Context Window |
|-------|----------------------|------------------------|----------------|
| gpt-3.5-turbo | $0.50 | $1.50 | 16K |

#### Reasoning Models
| Model | Input (per 1M tokens) | Output (per 1M tokens) | Context Window |
|-------|----------------------|------------------------|----------------|
| o1-preview | $15.00 | $60.00 | 128K |
| o1-mini | $3.00 | $12.00 | 128K |
| o3-mini | $1.25 | $5.00 | 128K |

### 🎭 Anthropic Claude Models

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Context Window |
|-------|----------------------|------------------------|----------------|
| claude-3-5-sonnet-20241022 | $3.00 | $15.00 | 200K |
| claude-3-5-haiku-20241022 | $0.25 | $1.25 | 200K |
| claude-3-opus-20240229 | $15.00 | $75.00 | 200K |

### 🔮 Google Gemini Models

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Context Window |
|-------|----------------------|------------------------|----------------|
| gemini-1.5-pro-002 | $1.25 | $5.00 | 2M |
| gemini-1.5-flash-002 | $0.075 | $0.30 | 1M |
| gemini-2.5-flash | $0.075 | $0.30 | 1M |
| gemini-2.5-pro | $1.25 | $5.00 | 2M |

---

## Image Generation Models

### 🎨 Per-Generation Pricing

| Model | Resolution | Price per Image | Batch Discount |
|-------|------------|----------------|----------------|
| Midjourney v6.1 | 1024×1024 | $0.04 | 10% off 100+ |
| Midjourney v6.0 | 1024×1024 | $0.035 | 10% off 100+ |
| DALL-E 3 HD | 1024×1024 | $0.08 | - |
| DALL-E 3 Standard | 1024×1024 | $0.04 | - |
| DALL-E 2 | 1024×1024 | $0.02 | - |

### 🖼️ Resolution Multipliers

| Resolution | Multiplier |
|------------|------------|
| 512×512 | 0.5× |
| 1024×1024 | 1.0× (base) |
| 1024×1792 | 1.5× |
| 1792×1024 | 1.5× |
| 2048×2048 | 2.0× |

---

## Audio Processing Models

### 🎵 Audio Generation

| Model | Price per Minute | Max Duration | Quality |
|-------|------------------|--------------|---------|
| Suno v3.5 | $0.10 | 4 minutes | Standard |
| Suno v4 (Beta) | $0.15 | 4 minutes | Enhanced |

### 🎤 Speech-to-Text

| Model | Price per Hour | Languages | Features |
|-------|---------------|-----------|----------|
| Whisper Large v3 | $0.36 | 100+ | Timestamps, diarization |
| Whisper Turbo | $0.24 | 100+ | Fast processing |

### 🔊 Text-to-Speech

| Model | Price per 1M Characters | Voices | Quality |
|-------|------------------------|---------|---------|
| ElevenLabs Standard | $1.50 | 50+ | High |
| ElevenLabs Professional | $3.00 | 100+ | Ultra |

---

## Video Generation Models

### 🎬 Video Creation

| Model | Resolution | Price per Second | Max Duration |
|-------|------------|------------------|--------------|
| Luma Dream Machine | 720p | $0.50 | 10 seconds |
| Luma Dream Machine | 1080p | $0.75 | 10 seconds |
| Runway Gen-3 | 720p | $0.60 | 10 seconds |
| Runway Gen-3 | 1080p | $0.90 | 10 seconds |

---

## Billing Modes

### 📊 Token-Based Billing

Applies to all text generation models (OpenAI, Claude, Gemini):

**Calculation Formula:**
```
Total Cost = (Input Tokens × Input Price + Output Tokens × Output Price) × Channel Multiplier × User Discount
```

**Example Calculation:**
```
Request: 1,000 input tokens + 500 output tokens using gpt-4o on Standard Tier
Input Cost = 1,000 × $2.50/1M × 0.7 = $0.00175
Output Cost = 500 × $10.00/1M × 0.7 = $0.0035
Total = $0.00175 + $0.0035 = $0.00525
```

### 🔄 Per-Call Billing

Applies to generation models (Midjourney, Suno, etc.):

**Calculation Formula:**
```
Total Cost = Number of Calls × Fixed Unit Price × Channel Multiplier × User Discount
```

**Example Calculation:**
```
Generate 5 Midjourney images on Professional Tier
Total = 5 × $0.04 × 1.0 = $0.20
```

---

## Service Tier Comparison

### 🥉 Economy Tier (0.3× Official Price)

**Best For:** Learning, testing, batch processing
- ✅ **Lowest Cost**: Maximum savings for high-volume usage
- ⚠️ **Limitations**: Lower stability, no Function Calling support
- 📊 **Use Cases**: Data annotation, content generation, batch translation

**Example Monthly Cost for 1M tokens (gpt-4o):**
- Input: 1M × $2.50 × 0.3 = $0.75
- Output: 1M × $10.00 × 0.3 = $3.00
- **Total: $3.75/month**

### 🥈 Standard Tier (0.7× Official Price)

**Best For:** Small-medium projects, prototypes, startups
- 📈 **Performance**: ~1,000 RPM, <2s latency
- ✅ **Features**: All standard features supported
- 💰 **Value**: Best cost-performance ratio

**Example Monthly Cost for 1M tokens (gpt-4o):**
- Input: 1M × $2.50 × 0.7 = $1.75
- Output: 1M × $10.00 × 0.7 = $7.00
- **Total: $8.75/month**

### 🥇 Professional Tier (1.0× Official Price)

**Best For:** Production environments, commercial applications
- 📈 **Performance**: 2,000-3,000 RPM, <1.5s latency
- 🛡️ **SLA**: 99.5% availability guarantee
- 🏢 **Enterprise**: Full feature support

**Example Monthly Cost for 1M tokens (gpt-4o):**
- Input: 1M × $2.50 × 1.0 = $2.50
- Output: 1M × $10.00 × 1.0 = $10.00
- **Total: $12.50/month**

### 💎 Premium Tier (1.8× Official Price)

**Best For:** Large enterprises, mission-critical applications
- 🏆 **Premium**: Highest tier accounts, minimal risk controls
- 📞 **Support**: Dedicated technical support and account manager
- 🔧 **Custom**: Tailored solutions and private deployment options

**Example Monthly Cost for 1M tokens (gpt-4o):**
- Input: 1M × $2.50 × 1.8 = $4.50
- Output: 1M × $10.00 × 1.8 = $18.00
- **Total: $22.50/month**

---

## Cost Optimization Strategies

### 💡 Model Selection Guidelines

#### 1. Task-Appropriate Models
```python
# For simple tasks
simple_tasks = ["translation", "summarization", "basic_qa"]
recommended_model = "gpt-3.5-turbo"  # Most cost-effective

# For complex reasoning
complex_tasks = ["analysis", "code_generation", "research"]
recommended_model = "gpt-4o-mini"    # Balanced performance/cost

# For premium quality
premium_tasks = ["creative_writing", "critical_analysis"]
recommended_model = "gpt-4o"         # Best quality
```

#### 2. Token Management
```python
# Optimize token usage
def optimize_prompt(text):
    # Remove unnecessary whitespace
    text = " ".join(text.split())
    
    # Use concise language
    # Instead of: "Could you please help me understand..."
    # Use: "Explain..."
    
    return text

# Set appropriate max_tokens
response = client.chat.completions.create(
    model="gpt-4o-mini",
    max_tokens=512,  # Don't over-allocate
    messages=[{"role": "user", "content": optimized_prompt}]
)
```

### 📊 Usage Monitoring

#### Track Your Spending
```python
import requests

def get_usage_stats(api_key):
    headers = {"Authorization": f"Bearer {api_key}"}
    response = requests.get(
        "https://api.pandalla.ai/v1/usage", 
        headers=headers
    )
    return response.json()

# Monitor costs by model
usage = get_usage_stats("your-api-key")
print(f"Monthly spend: ${usage['total_cost']}")
print(f"Token usage: {usage['total_tokens']:,}")
```

---

## Payment and Billing

### 💳 Payment Methods

- **Credit/Debit Cards**: Visa, Mastercard, AMEX
- **Digital Wallets**: PayPal, Apple Pay, Google Pay
- **Bank Transfer**: For enterprise customers ($1000+ monthly)
- **Cryptocurrency**: Bitcoin, Ethereum (Premium tier)

### 📋 Billing Cycle

- **Pay-as-you-go**: Real-time usage deduction
- **Monthly Billing**: Detailed invoices sent monthly
- **Enterprise**: Custom billing terms available

### 🎯 Usage Alerts

Set up automatic alerts to control spending:
- **Daily Limits**: $10, $50, $100, $500, Custom
- **Monthly Budgets**: Percentage-based warnings at 50%, 80%, 95%
- **Model-Specific**: Track expensive model usage separately

---

## Enterprise Pricing

### 🏢 Volume Discounts

| Monthly Spend | Additional Discount |
|---------------|-------------------|
| $500 - $1,999 | 5% off |
| $2,000 - $4,999 | 10% off |
| $5,000 - $9,999 | 15% off |
| $10,000+ | Custom pricing |

### 📞 Enterprise Benefits

- **Dedicated Account Manager**: Personal support contact
- **Custom SLA**: Tailored availability guarantees
- **Priority Support**: 24/7 technical assistance
- **Private Deployment**: On-premises or private cloud options
- **Custom Integration**: API customization and consulting

### 💼 Contact Sales

For enterprise pricing and custom solutions:
- **Email**: enterprise@pandalla.ai
- **Phone**: +1-555-OMNIAI-1 (US/Canada)
- **Schedule**: [Book a consultation](https://api.pandalla.ai/enterprise-contact)

---

## FAQ - Billing Questions

### ❓ Common Questions

**Q: How are partial tokens counted?**
A: Tokens are counted to the nearest whole number. 1.1 tokens = 2 tokens billed.

**Q: Do failed requests cost money?**
A: No, only successful API responses are billed.

**Q: Can I get a refund for unused credits?**
A: Credits don't expire, but refunds are available within 30 days for unused amounts over $100.

**Q: How do I switch service tiers?**
A: Change anytime in your dashboard. New pricing applies to subsequent requests.

**Q: Are there free tier options?**
A: New users receive $5 in free credits. Additional free tiers available for educational use.

### 🔍 Usage Transparency

- **Real-time Tracking**: Monitor usage as it happens
- **Detailed Logs**: Per-request cost breakdown
- **Export Options**: CSV, JSON, PDF reports
- **API Analytics**: Usage patterns and optimization suggestions

Start optimizing your AI costs today with OmniAI's transparent, competitive pricing!