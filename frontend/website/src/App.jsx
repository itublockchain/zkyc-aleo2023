import { useState } from "react";
import QRCode from "react-qr-code";

import "../index.css";
import { AleoWorker } from "./workers/AleoWorker.js";

const aleoWorker = AleoWorker();
const App = () => {
  const [account, setAccount] = useState(null);
  const [phoneVerified, setPhoneVerified] = useState(null);
  const [kycVerified, setKycVerified] = useState(null);
  const [emailVerified, setEmailVerified] = useState(null);
  const [over18, setOver18] = useState(null);

  const generateAccount = async () => {
    const key = await aleoWorker.getPrivateKey();
    setAccount(await key.to_string());
    localStorage.setItem("privateKey", await key.to_string());
  };
  const phoneVerifiedFunc = async () => {
  };

  return (
    <>
      <h1 className="text-white w-full justify-center absolute text-center text-4xl mt-5">zKyc</h1>
      <div className="flex flex-row justify-center h-screen items-center gap-8">
        <div className="flex flex-col items-center h-1/2">
          <div className="flex flex-col gap-2 items-center">
            <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
              {account
                ? `Account ${JSON.stringify(account)}`
                : `Click to generate account`}
            </button>
            {
              account ? <QRCode className="mt-5" value={account} /> : null
            }
          </div>
          <div className="flex flex-row items-center justify-center gap-8 h-screen">
            <div className="flex flex-col items-center">
              <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
                {emailVerified
                  ? `Email Verified ${JSON.stringify(account)}`
                  : `Generate account`}
              </button>
              {
                emailVerified ? <QRCode className="mt-5" value={account} /> : null
              }
            </div>
            <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
              {over18
                ? `Over 18 ${JSON.stringify(account)}`
                : `Generate account`}
            </button>
          </div>
        </div>
        <div className="flex flex-col gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
            {kycVerified
              ? `KYC Verified ${JSON.stringify(account)}`
              : `Generate account`}
          </button>
          {kycVerified ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
        <div className="flex flex-col gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
            {phoneVerified
              ? `Phone Verified`
              : `Generate account`}
          </button>
          {phoneVerified ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
      </div>

    </>
  );
}

export default App;
