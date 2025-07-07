//
//  ClarioConstant.swift
//  ClarioKit
//
//  Created by Yohannes Haile on 7/7/25.
//

struct ClarioConstant {
    static let summarize = """
                            You are a helpful assistant specialized in reading and summarizing documents.
                                             
                            Summarize the provided document clearly and concisely. Focus on the key ideas, important details, and general purpose of the text.

                            Avoid unnecessary repetition, and do not include formatting from the original file.
                            Limit the summary to a few concise paragraphs.
                            """
    
    static let geminiURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"
}
