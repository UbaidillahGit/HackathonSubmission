
import { db } from "./firebase";
import { collection, getDocs } from "firebase/firestore";
import { gemini } from "./gemini";

const askAboutGivenRestaurantReturnBool = async (restaurant_id, user_id) => {
    let injectedPrompt = `
    DO NOT USE MARKDOWN, HTML, OR ANY OTHER FORMATTING. JUST PLAIN TEXT. WITH EMOJI IF NEEDED, BUT NOT TOO MUCH SENTENCES.
    You're an AI that ALWAYS response with the given boolean format. for example
    {
        "isOk": true
    }
    or
    {
        "isOk": false
    }

    You are an AI that help user to make decision based on the information provided. 
    you might want to consider the following information:
    - halal status for given description
    - food safety
    - food quality
    - allergen information
    - vegan friendly

    if you dont have enough information, you might took a generic information that most likely to be true. if you dont have any information, you should not response that you dont have any information. 
    just make a guess but make sure it is a good guess & give a reason why you make that guess & warning if the guess is probably not 100% correct.
    
    this is a context you've given in JSON format:

    `

    // fetch from firestore db where restaurant_id == restaurant_id
    let menus = await getDocs(collection(db, "restaurant-menus"));
    let context_menus = [];
    menus.forEach((doc) => {
        if (doc.data().restaurant_id == restaurant_id) {
            context_menus.push(doc.data());
        }
    });

    let msg = injectedPrompt + JSON.stringify(context_menus);

    let user_preferences = await getDocs(collection(db, "users"));
    user_preferences.forEach((doc) => {
        if (doc.data().id == user_id) {
            user_preferences = doc.data();
        }
    });

    msg = msg + " This user has these several constraints, preference, and allergies that might be lethal or not suitable for them: " + JSON.stringify(user_preferences);


    let data = await gemini.generateContent(msg);

    let raw_responses = "";

    data.response.candidates[0].content.parts.forEach((part) => {
        raw_responses += part.text;
    }
    );

    let final_responses = JSON.parse(raw_responses);

    console.log(final_responses, "for restaurant_id: ", restaurant_id);

    return final_responses["isOk"];
}

const askAboutGivenRestaurantReturnMessage = async (restaurant_id, user_id) => {
    let injectedPrompt = `
    DO NOT USE MARKDOWN, HTML, OR ANY OTHER FORMATTING. JUST PLAIN TEXT. WITH EMOJI IF NEEDED, BUT NOT TOO MUCH SENTENCES.
    You're an AI that ALWAYS response with the given json format. for example
    {
        "title": "This restaurant might be not good for your health",
        "message": "You have an halal concern, this restaurant might not be suitable for you as they serve pork."
    }

    You are an AI that help user to make decision based on the information provided. 
    you might want to consider the following information:
    - halal status for given description
    - food safety
    - food quality
    - allergen information
    - vegan friendly

    if you dont have enough information, you might took a generic information that most likely to be true. if you dont have any information, you should not response that you dont have any information. 
    just make a guess but make sure it is a good guess & give a reason why you make that guess & warning if the guess is probably not 100% correct.
    
    this is a context you've given in JSON format:

    `

    // fetch from firestore db where restaurant_id == restaurant_id
    let menus = await getDocs(collection(db, "restaurant-menus"));
    let context_menus = [];
    menus.forEach((doc) => {
        if (doc.data().restaurant_id == restaurant_id) {
            context_menus.push(doc.data());
        }
    });

    let msg = injectedPrompt + JSON.stringify(context_menus);

    // fetcgh user predf
    let user_preferences = await getDocs(collection(db, "users"));
    user_preferences.forEach((doc) => {
        if (doc.data().id == user_id) {
            user_preferences = doc.data();
        }
    });

    msg = msg + " This user has these several constraints, preference, and allergies that might be lethal or not suitable for them: " + JSON.stringify(user_preferences);


    let data = await gemini.generateContent(msg);

    let raw_responses = "";

    data.response.candidates[0].content.parts.forEach((part) => {
        raw_responses += part.text;
    }
    );

    console.log(raw_responses);

    // convert string to json format

    let final_responses = {
        "warning": JSON.parse(raw_responses),
        "menus": context_menus,
    }

    return final_responses;
}

const askAboutGivenMenuReturnMessage = async (menu_id, user_id) => {
    let injectedPrompt = `
    DO NOT USE MARKDOWN, HTML, OR ANY OTHER FORMATTING. JUST PLAIN TEXT. WITH EMOJI IF NEEDED, BUT NOT TOO MUCH SENTENCES.
    You're an AI that ALWAYS response with the given json format. for example
    {
        "title": "This restaurant might be not good for your health",
        "message": "You have an halal concern, this restaurant might not be suitable for you as they serve pork."
    }

    You are an AI that help user to make decision based on the information provided. 
    you might want to consider the following information:
    - halal status for given description
    - food safety
    - food quality
    - allergen information
    - vegan friendly

    if you dont have enough information, you might took a generic information that most likely to be true. if you dont have any information, you should not response that you dont have any information. just make a guess but make sure it is a good guess & give a reason why you make that guess & warning if the guess is probably not 100% correct.
    
    this is a context you've given in JSON format:

    `

    // fetch from firestore db where restaurant_id == restaurant_id
    let menus = await getDocs(collection(db, "restaurant-menus"));
    let context_menus = [];
    menus.forEach((doc) => {
        if (doc.data().restaurant_id == restaurant_id) {
            context_menus.push(doc.data());
        }
    });

    let msg = injectedPrompt + JSON.stringify(context_menus);

    // fetcgh user predf
    let user_preferences = await getDocs(collection(db, "users"));
    user_preferences.forEach((doc) => {
        if (doc.data().id == user_id) {
            user_preferences = doc.data();
        }
    });

    msg = msg + " This user has these several constraints, preference, and allergies that might be lethal or not suitable for them: " + JSON.stringify(user_preferences);


    let data = await gemini.generateContent(msg);

    let raw_responses = "";

    data.response.candidates[0].content.parts.forEach((part) => {
        raw_responses += part.text;
    }
    );

    console.log(raw_responses);

    // convert string to json format

    let final_responses = {
        "warning": JSON.parse(raw_responses),
        "menus": context_menus,
    }
}

export { askAboutGivenRestaurantReturnMessage, askAboutGivenMenuReturnMessage, askAboutGivenRestaurantReturnBool };