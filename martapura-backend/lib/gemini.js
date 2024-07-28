import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

const generationConfig = {
    maxOutputTokens: 1000,
    temperature: 0.7,
    topP: 0.6,
    topK: 16,
    responseMimeType: "application/json",
};

const gemini = genAI.getGenerativeModel({
    model: "gemini-1.5-pro",
    generationConfig,
});


export { gemini };