import { askAboutGivenRestaurantReturnMessage } from "@/lib/prompting";

export const maxDuration = 300;

export default async function handler(req, res) {
    const { slug } = req.query;
    const user_id = req.query.user_id;

    let final_responses = askAboutGivenRestaurantReturnMessage(slug, user_id);
       
    res.status(200).json( final_responses );
    
}