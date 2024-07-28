import { db } from "../../../lib/firebase";
import { collection, getDocs } from "firebase/firestore"; 

export const maxDuration = 300;

export default async function handler(req, res) {
    let restaurant_id = req.query.slug;
    let user_id = req.query.user_id;

    // fetch from firestore db where restaurant_id == restaurant_id
    let menus = await getDocs(collection(db, "restaurant-menus"));
    let list = [];
    menus.forEach((doc) => {
        if (doc.data().restaurant_id == restaurant_id) {
            list.push(doc.data());
        }
    });

    let data = list

    res.status(200).json({ data });
}