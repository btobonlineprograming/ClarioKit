# ClarioKit

ClarioKit is a Swift package for iOS that enables intelligent document understanding through summarization, key point extraction, language translation, and structured parsing. It aims to support plain text, PDF, .docx, and other rich formats using both cloud-based LLMs (like Gemini and GPT) and on-device Foundation Models (iOS 26+)

## Features

- ✨ Summarization with Google Gemini API
- 🧠 Summarization with Apple Foundation Models (iOS 26+, coming September)
- ✅ Easy to use, async/await-powered API

## Installation

Add the package to your project using Swift Package Manager:

```
https://github.com/yohannescodes/ClarioKit.git
```
## Usage

After installing the Swift package from Swift Package Manager, you can use ClarioKit by importing it into the specific Swift file where you want document summarization to happen.

```
import ClarioKit
```
The next step is to instantiate ClarioKit's engine by specifying the model of your choice.

```
let clario = ClarioKit(model: .gemini(apiKey: "YOUR GEMINI API KEY")

```
Initialize the ClarioDocument from the user's upload or document picker.

```
   let documentType = DocumentType.pdf(url)
   do {
            let doc = try ClarioDocument(from: documentType)
            let summary = try await clario.summarize(document: doc)
            print(summary)  
    } catch {
            print("Error")
    }
```

## What is next?

- 📄 DocX support
- ⚪️ Key points extraction
- 🌍 Document Content Translation

## License

MIT

---

Built with care by [@yohannescodes](https://github.com/yohannescodes)
