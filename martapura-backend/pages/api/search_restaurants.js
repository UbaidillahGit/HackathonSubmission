import { db } from "../../lib/firebase";
import { collection, getDocs } from "firebase/firestore"; 

export const maxDuration = 300;

export default async function handler(req, res) {

    let keyword = req.body.keyword;
    let user_id = req.query.user_id;

    let restaurants = await getDocs(collection(db, "restaurants"));
    let list = [];
    restaurants.forEach((doc) => {
        list.push(doc.data());
    });

    let menus = await getDocs(collection(db, "restaurant-menus"));
    let list_menu = [];
    menus.forEach((doc) => {
        list_menu.push(doc.data());
    });

    list = list.map((resto) => {
        let menu = list_menu.filter((menu) => {
            return menu.restaurant_id == resto.id;
        });
        return {
            ...resto,
            menus: menu
        }
    }
    );

    if (keyword) {
        list = list.filter((resto) => {
            return (
                resto.name.toLowerCase().includes(keyword.toLowerCase()) ||
                resto.category.toLowerCase().includes(keyword.toLowerCase()) || 
                resto.menus.some((menu) => {
                    return menu.name.toLowerCase().includes(keyword.toLowerCase());
                })
            );
        });
    }

    let data = list
    // add image url
    data = data.map((resto) => {
        return {
            ...resto,
            imageUrl: `http://angelhack.gremlinflat.com/static/sample_tenant` + Math.floor(Math.random() * 10) + `.jpg`,
            isOk: true
        }
    });

    res.status(200).json({ data });
}