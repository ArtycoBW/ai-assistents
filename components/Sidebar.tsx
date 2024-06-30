import { BotMessageSquare, PencilLine, SearchIcon } from 'lucide-react'
import Link from 'next/link'
import React from 'react'

const Sidebar = () => {
  return (
    <div className='bg-white text-white p-5'>
      <ul className='gap-5 flex lg:flex-col'>
        <li className='flex-1'>
          <Link
            href='/create-chatbot'
            className='flex flex-col lg:flex-row items-center text-center lg:text-left gap-2 p-5 rounded-md bg-[#2991ee] hover:opacity-50
						'
          >
            <BotMessageSquare className='h-6 w-6 lg:h-8 lg:w-8' />
            <div className='hidden md:inline'>
              <p className='text-xl'>Создать</p>
              <p className='text-sm font-extralight'>Нового Чат-бота</p>
            </div>
          </Link>
        </li>
        <li className='flex-1'>
          <Link
            href='/view-chatbots'
            className='flex flex-col lg:flex-row items-center text-center lg:text-left gap-2 p-5 rounded-md bg-[#2991ee] hover:opacity-50
						'
          >
            <PencilLine className='h-6 w-6 lg:h-8 lg:w-8' />
            <div className='hidden md:inline'>
              <p className='text-xl'>Редактировать</p>
              <p className='text-sm font-extralight'>Чат-ботов</p>
            </div>
          </Link>
        </li>
        <li className='flex-1'>
          <Link
            href='/review-sessions'
            className='flex flex-col lg:flex-row items-center text-center lg:text-left gap-2 p-5 rounded-md bg-[#2991ee] hover:opacity-50
						'
          >
            <SearchIcon className='h-6 w-6 lg:h-8 lg:w-8' />
            <div className='hidden md:inline'>
              <p className='text-xl'>Просмотр</p>
              <p className='text-sm font-extralight'>Сессий</p>
            </div>
          </Link>
        </li>
      </ul>
    </div>
  )
}

export default Sidebar
