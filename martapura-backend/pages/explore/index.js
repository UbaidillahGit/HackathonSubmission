import { CircleUserRound } from 'lucide-react';
import { useEffect, useState } from 'react';
import { Input } from "@/components/ui/input"
import Image from 'next/image';
import Link from 'next/link';

function filterRestos(restos, keyword) {
  if (keyword === '') {
    return restos;
  }
    return restos.filter((resto) => {
        return (
            resto.name.toLowerCase().includes(keyword.toLowerCase()) ||
            resto.category.toLowerCase().includes(keyword.toLowerCase())
        );
    });
}

const Explore = () => {
    const [fetching, setFetching] = useState(true);
    const [restos, setRestos] = useState([]);

    const [keyword, setKeyword] = useState('');

    useEffect(() => {
        const fetchRestos = async () => {
            const res = await fetch('/api/list_restaurants');
            const data = await res.json();
            setRestos(data.data);
            setFetching(false);
        };

        fetchRestos();
    }, []);

    return (
        <div className="flex min-h-screen flex-col items-center justify-between">
          <div className="flex flex-col items-center justify-center w-full md:w-[768px] h-screen p-8">
            <div className="flex flex-col w-full h-full">

            {/* Tab bar */}
            <div className="flex items-center justify-between w-full mb-4">
              <div className="flex items-center space-x-2">
                <CircleUserRound size={24} className="font-bold text-base sm:text-2xl"/>
                <p className="font-bold text-base sm:text-2xl">Hi Jocelyn</p>
              </div>
            </div>

            {/* Search bar */}
            <div className="flex items-center w-full mb-4">
              <Input placeholder="Search for restaurants or menus" value={keyword} onChange={(e) => setKeyword(e.target.value)} />
            </div>

            {/* Explore text */}
            <div className="flex flex-col w-full h-full space-y-4">
              <p className="text-4xl font-bold" >Explore</p>
              {/* menu grid */}
                <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                    {fetching ? (
                        <p>Loading...</p>
                    ) : (
                        
                        filterRestos(restos, keyword).map((resto) => (
                            <Link href={`/restaurant/${resto.id}`}  key={resto.id}>
                            <div className="max-w-sm rounded overflow-hidden h-full shadow-lg">
                                <Image className="w-full" src={
                                    "/static/sample_tenant" + Math.floor(Math.random() * 10) + ".jpg"
                                } alt="Sunset in the mountains" width={500} height={300}/>
                                <div className="px-6 py-4">
                                <div className="font-bold text-xl mb-2">{resto.name}</div>
                                {/* <p className="text-gray-700 text-base">
                                    {resto.description}
                                </p> */}
                                </div>

                                <div className="flex flex-wrap px-6 pt-4 pb-2">
                                {resto.category.split(',').map((category) => (
                                        <span key={category} className="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2">{category}</span>
                                ))
                                }   
                                </div>
                            
                            </div>
                            </Link>
                        ))
                    )}
                </div>
              
                {/* <p className="text-lg font-semibold" >Discover new restaurants and menus</p>
                <p className="text-lg font-semibold" >Find your next meal</p>
              <p className="text-lg font-semibold" >Discover new restaurants and menus</p> */}
            </div>

           </div>
        </div>
        </div>
    );
}

export default Explore;