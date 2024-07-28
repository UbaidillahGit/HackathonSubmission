import Image from "next/image";
import { Inter } from "next/font/google";
import Link from "next/link";
import { useEffect, useState } from "react";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {

  useEffect(() => {
    const timer = setTimeout(() => {
      // navigate to login page
      window.location.href = '/explore/';
    }, 1500);
    return () => clearTimeout(timer);
  }
  , [])

  return (
    <main className={`flex min-h-screen flex-col items-center justify-between ${inter.className}`}>
      <div className="flex flex-col items-center justify-center w-full md:w-[768px] h-screen p-4">
        {splashScreen()}
      </div>
   </main>
  );
}

const splashScreen = () => {
  return (
    <div className="flex flex-col items-center justify-center w-full h-full rounded-xl"> 
          <Image src="/logo-brand.png" alt="Next.js Logo" width={180} height={37} className="animate-bounce animate-pulse" />

          {/* COLOR REMOVE */}
          {/* <Link href="/api/list_restaurants">
            <p className="text-blue-500">List Restaurants</p>
          </Link>

          <Link href="/api/list_menus/145">
            <p className="text-blue-500">List Menus</p>
          </Link>

          <Link href="/api/get_restaurant_with_menus/145">
            <p className="text-blue-500">Get Restaurant with Menus</p>
          </Link> */}
        </div>
  )
}