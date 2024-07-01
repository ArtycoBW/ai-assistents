import Avatar from '@/components/Avatar'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import React from 'react'

const CreateChatbot = () => {
  return (
    <div className='flex flex-col items-center justify-center md:flex-row md:space-x-10 bg-white p-10 rounded-md m-10'>
      <Avatar seed='create-chatbot' />
      <div>
        <h1 className='text-xl lg:text-3xl font-semibold'>Создать</h1>
        <h2 className='font-light'>
          Создайте нового чат-бота, который будет помогать вам в ваших
          разговорах с клиентами.
        </h2>
        <form className='flex flex-col md:flex-row gap-5 mt-5'>
          <Input
            type='text'
            placeholder='Название чат-бота...'
            className='max-w-lg'
            required
          />
          <Button>Создать чат-бота</Button>
        </form>

        <p className='text-gray-300 mt-5'>Example: Customer Support Chatbot</p>
      </div>
    </div>
  )
}

export default CreateChatbot
