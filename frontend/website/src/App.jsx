import {useState} from 'react';
import { Menu } from '@headlessui/react'
import { ChevronDownIcon } from '@heroicons/react/20/solid'

import { Account, AleoNetworkClient, ProgramManager } from "@aleohq/sdk";
import "../index.css";

function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

const accountSdk = new Account();
let public_connection = new AleoNetworkClient("https://vm.aleo.org/api");
const programManager = new ProgramManager();
programManager.setAccount(accountSdk);
const privateKey1 = "APrivateKey1zkp5Vtu3njQ5HZZZ9mWMjKQ4stRgVWkXCRNo3eBrBCqfWhS"
const privateKey2 = "APrivateKey1zkp4nk34W3u4gesHXmZDr4LToVANNRLNk7oibLvc9YuQgu8"
const publicKey1 = "aleo1hp4v0gd9m376g8dlraq6wkdy0j7h54zc9u8vd7e4e5at5p3jxgxs8g3hha"
const publicKey2 = "aleo10yyq3rx4ygcjwku575dss7sfmwcxz3k9xcxxyqzd9e5c5gya3vqqxyycn6"
const App = () => {
  const [privateKey, setPrivateKey] = useState(privateKey1)
  const [isKChecked, setIsKChecked] = useState(false)
  const [is1Checked, setIs1Checked] = useState(false)
  const [isPChecked, setIsPChecked] = useState(false)
  const [isEChecked, setIsEChecked] = useState(false)
  const [isTChecked, setIsTChecked] = useState(false)
  const [isGChecked, setIsGChecked] = useState(false)
  return (
    <>
      <div className="flex flex-row justify-start items-start gap-8">
        <h1 className="text-white w-full justify-left absolute text-center text-4xl mt-5">zKyc</h1>
        <Menu as="div" className="relative inline-block text-right">
          <div>
            <Menu.Button className="inline-flex w-full justify-right gap-x-1.5 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
              Private Keys
              <ChevronDownIcon className="-mr-1 h-5 w-5 text-gray-400" aria-hidden="true" />
            </Menu.Button>
          </div>
            <Menu.Items className="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
              <div className="py-1">
                <Menu.Item>
                  {({ active }) => (
                    <a
                      onClick={setPrivateKey(privateKey1)}
                      className={classNames(
                        active ? 'justify-center items-center bg-gray-100 text-black' : 'text-gray-700',
                        'block px-4 py-2 text-sm'
                      )}
                    >
                      Private Key 1
                    </a>
                  )}
                </Menu.Item>
                <Menu.Item>
                  {({ active }) => (
                    <a
                      onClick={setPrivateKey(privateKey2)}
                      className={classNames(
                        active ? 'bg-gray-100 text-gray-900' : 'text-gray-700',
                        'block px-4 py-2 text-sm'
                      )}
                    >
                      Private Key 2
                    </a>
                  )}
                </Menu.Item>
              </div>
            </Menu.Items>
        </Menu>
      </div>
      <div className="flex flex-row justify-center items-center gap-8">
        <div className="flex flex-row items-center justify-center gap-8 h-screen">
          <button className="text-black bg-blue-500 hover:bg-blue-700 font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1) {
              setIsKChecked(true)
            }
          }}>
            {"Is Kyc Verified?"}
          </button>
          {
            isKChecked ? <img src="public/green.png" height={20} width={20} /> : null
          }
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1) {
              setIs1Checked(true)
            }
          }}>
            {"Is Over 18?"}
          </button>
          {
            is1Checked ? <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
        <div className="flex flex-row items-center justify-center gap-8 h-screen">
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1 || privateKey == privateKey2) {
              setIsPChecked(true)
            }
          }}>
            {"Is Phone Verified?"}
          </button>
          {
            isPChecked ? <img src="public/green.png" height={20} width={20} /> : null
          }
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1 || privateKey == privateKey2) {
              setIsEChecked(true)
            }
          }}>
            {"Is Email Verified?"}
          </button>
          {
            isEChecked ? <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
        <div className="flex flex-row gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1) {
              setIsTChecked(true)
            }
          }}>
            {"Is Twitter Linked?"}
          </button>
          {isTChecked ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
        <div className="flex flex-row gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={() => {
            if (privateKey == privateKey1 || privateKey == privateKey2) {
              setIsGChecked(true)
            }
          }}>
            {"Is Github Linked?"}
          </button>
          {isGChecked ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
      </div>

    </>
  );
}

export default App;
