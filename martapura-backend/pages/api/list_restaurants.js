import { askAboutGivenRestaurantReturnBool } from "@/lib/prompting";
import { db } from "../../lib/firebase";
import { collection, getDocs } from "firebase/firestore"; 

export const maxDuration = 300;

export default async function handler(req, res) {
    let user_id = req.query.user_id;

    let restaurants = await getDocs(collection(db, "restaurants"));
    let list = [];
    restaurants.forEach((doc) => {
        list.push(doc.data());
    });

    let data = list

    for (let i = 0; i < data.length; i++) {
        data[i].isOk = true;
    }

    for (let i = 0; i < 5; i++) {
        let isOkay = await askAboutGivenRestaurantReturnBool(data[i].id, user_id);
        data[i].isOk = isOkay;
    }

    // add image url
    data = data.map((resto) => {
        return {
            ...resto,
            imageUrl: `http://angelhack.gremlinflat.com/static/sample_tenant` + Math.floor(Math.random() * 10) + `.jpg`,
        }
    });

    res.status(200).json({ data });
}