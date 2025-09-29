# llama.cpp

## 1. llama.cpp 是什么？

- llama.cpp 是 Meta 的 LLaMA 模型的 轻量推理实现，用 纯 C++ 写的。
- 支持 量化模型（4bit, 5bit, 8bit），可以在普通 CPU 上推理！
- 后来加了一点点微调功能，比如：
  - LoRA 微调
  - QLoRA 微调
- 训练自己的 LoRA Adapter（保存下来以后推理时候叠加）

## 2. 微调原理（简单说）

- llama.cpp 不会改原始模型。
- 它会训练出一个很小的 "LoRA Adapter"，保存为独立的文件，比如 adapter.bin。
- 推理时，加载原始模型 + Adapter，叠加参数 = 定制模型。
  - ✅ 这样不会破坏原版模型
  - ✅ 训练数据量小，设备要求低
  - ✅ 训练速度快，内存需求小

## 3. 微调准备工作

- 前提条件：
  - llama.cpp 源码
    - GitHub下载：https://github.com/ggerganov/llama.cpp
  - 已量化模型	
    - 比如 .gguf 或 .bin 格式（4bit/5bit/8bit）
  - 微调数据集	
    - 格式：一行一条指令或对话
  - 设备	
    - 任意现代 CPU，最好是多核 + 大内存（16G以上更好）

## 4. 微调步骤

### 步骤 1：拉取 llama.cpp
```bash
		git clone https://github.com/ggerganov/llama.cpp.git
		cd llama.cpp
		make
```

### 步骤 2：准备模型
  - 需要一个 量化过的模型文件，比如：
    - models/llama-2-7b-chat.ggmlv3.q4_0.bin
  - 或者最新 .gguf 格式。

### 步骤 3：准备训练数据
  - 你的训练数据需要是很简单的格式，比如：
```
	### Instruction:
	Tell me a joke.
	### Response:
	Why don't scientists trust atoms? Because they make up everything!
	### Instruction:
	Explain what is quantum computing.
	### Response:
	Quantum computing is...
```

- 保存为 finetune-data.txt。
- 注意：数据量不能太大，不然内存爆掉。
- 一般 Surface这类设备，推荐一千条以内小规模测试。

### 步骤 4：开始微调
- llama.cpp 提供了 finetune 工具：
- 👉 最新版命令是：
```bash
	./finetune \
		-m models/llama-2-7b-chat.ggmlv3.q4_0.bin \
		-t 4 \
		-p 32 \
		--train-data ./finetune-data.txt \
		--save-path ./lora-adapter.bin
```
- ✅ 这里主要参数说明：

| 参数 | 说明 |
| --- | --- |
| -m | 指定原始模型路径 |
| -t | 使用的线程数量（建议设为 CPU 核数） |
| -p | batch size（一次送多少条数据） |
| --train-data | 训练数据路径 |
| --save-path | 保存 LoRA Adapter 的位置 |

### 步骤 5：推理时加载 Adapter
- 用微调结果推理，比如：
```bash
	./main \
		-m models/llama-2-7b-chat.ggmlv3.q4_0.bin \
		--lora ./lora-adapter.bin \
		-p "Tell me a joke about computers"
```
- ✅ 这样它就会用你训练好的 lora adapter 进行个性化生成！

## 5. 微调效果

### 微调效果提升小技巧 🎯

- 微调前，模型要 量化得合理，不要太压缩（4bit效果好）
- 数据尽量干净，格式统一
- 训练数据要覆盖各种指令风格（多样化能防止 overfit）
- batch size 和 epoch 控制好，避免过拟合
- 多尝试不同的学习率（虽然 llama.cpp 默认已经调得比较保守了）

### 注意事项 ⚡

- 显存问题
  - llama.cpp 全程 CPU，不吃显存，但吃很多 RAM。
- 文件大小
  - Adapter 通常只有几MB，很小
- 兼容性
  - 旧版 .bin 模型和新版 .gguf 稍微有不同，注意看 README
- 正式支持情况
  - llama.cpp 对 LoRA/finetune支持还在进化中，功能比 Python版 LoRA 少一些。

***

***

# 🎉 EXAMPLE

## 🧰 场景设定
- 你有一个 4bit 量化好的模型，比如 models/llama-2-7b-chat.ggmlv3.q4_0.bin
- 你准备一个很小的训练数据集，比如 2条问答
- 你的目标是：微调出一个 LoRA Adapter，比如保存成 ./adapter/adapter.bin

## 📝 超简单数据集例子（文件：finetune-data.txt）
```
	### Instruction:
	讲一个笑话。
	### Response:
	为什么鱼不说话？因为它们怕水泄露秘密！
	### Instruction:
	苹果和橙子哪个更甜？
	### Response:
	通常来说，苹果比橙子甜，不过也要看品种。
```

## 🖥️ llama.cpp 命令行完整范例
- 💬 假设你已经在 llama.cpp/ 目录下，直接运行：
```bash
	./finetune \
	  --model models/llama-2-7b-chat.ggmlv3.q4_0.bin \
	  --train-data finetune-data.txt \
	  --outdir adapter \
	  --lora-out adapter.bin \
	  --epochs 2 \
	  --batch-size 1 \
	  --learning-rate 1e-4 \
	  --save-every 1
```

- ✅ 每个参数解释一下：

| 参数 | 说明 |
| --- | --- |
| --model | 指定原始模型路径 |
| --train-data | 训练数据路径 |
| --outdir | 保存 LoRA Adapter 的位置 |
| --lora-out | 保存出来的 LoRA Adapter 文件名 |
| --epochs | 训练轮数，2轮就够了（设备弱别设太大） |
| --batch-size | 批次大小，Surface这种电脑建议1 |
| --learning-rate | 学习率，通常1e-4够用了 |
| --save-every | 每隔多少轮保存一次模型 |


## 🛠️ 完成后，会看到生成了：
```bash
	adapter/
	  └── adapter.bin
```

- 以后推理模型时，只要指定 --lora-adapter adapter/adapter.bin
- 就可以自动叠加了，不需要重训练！

***
***


# 🚀 SERVER 模式

## 🛠️ 第一步：启动 llama.cpp 的 server，并加载微调模型

- 在 llama.cpp/ 目录下，运行：
```bash
	./server \
		--model models/llama-2-7b-chat.ggmlv3.q4_0.bin \
		--lora-adapter adapter/adapter.bin \
		--host 0.0.0.0 \
		--port 8080
```

- ✅ 这里主要参数说明：

| 参数 | 说明 |
| --- | --- |
| --model | 指定原始模型路径 |
| --lora-adapter | 指定微调后的 LoRA Adapter 路径 |
| --host | 监听所有IP，局域网其他设备也能访问 |
| --port | 开在8080端口 |

## 🌟 第二步：用 curl 发送 HTTP 请求

- 启动完毕以后，直接用 curl 调用：
```bash
		curl http://localhost:8080/completion \
		  -H "Content-Type: application/json" \
		  -d '{
			"prompt": "讲一个笑话。",
			"temperature": 0.7,
			"n_predict": 128
		}'
```
- ✅ 解释一下 -d 部分的 JSON：

| 参数 | 说明 |
| --- | --- |
| prompt | 你的提问内容 |
| temperature | 控制回答的随机性（0-1之间） |
| n_predict | 最多生成多少个 token |


- 🔥 返回内容示例（比如）
```json
	{
	  "content": "为什么鱼不开派对？因为他们害怕起水花！",
	  "stop": true
	}
```
