import { askAboutGivenRestaurantReturnMessage } from "@/lib/prompting";
import { db } from "../../../lib/firebase";
import { collection, getDocs } from "firebase/firestore"; 

export const maxDuration = 300;

export default async function handler(req, res) {
    let restaurant_id = req.query.slug;
    let user_id = req.query.user_id;

    let restaurants = await getDocs(collection(db, "restaurants"));
    let rest = [];
    restaurants.forEach((doc) => {
        if (doc.data().id == restaurant_id) {
            rest.push(doc.data());
        }
    });

    let geminiSuggestion = await askAboutGivenRestaurantReturnMessage(restaurant_id, user_id);
    rest[0] = { ...rest[0], ...geminiSuggestion };

    res.status(200).json({ restaurant: rest[0] });

    // fetch from firestore db where restaurant
    
}
