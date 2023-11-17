import { useState } from "react";
import QRCode from "react-qr-code";
import { Account, AleoNetworkClient, ProgramManager } from "@aleohq/sdk";
import "../index.css";

const accountSdk = new Account();
let public_connection = new AleoNetworkClient("https://vm.aleo.org/api");
const programManager = new ProgramManager();
programManager.setAccount(accountSdk);
const hashProgram = "program hash.aleo"
const App = () => {
  const [privateKey, setPrivateKey] = useState(null);
  const [viewKey, setViewKey] = useState(null);
  const [publicKey, setPublicKey] = useState(null);
  const [idInput, setIdInput] = useState(null);
  const [birthTimestampInput, setBirthTimestampInput] = useState(null);

  const Hash = async (data) => {
    const executionResponse = await programManager.run(hashProgram, "hash", [`${data}`]);
    const executionResult = executionResponse.getOutputs();
    const hash = executionResult[0].to_string();
    return hash;
  };
  const generateAccount = async () => {
    // check if private key is already generated
    if (!localStorage.getItem("privateKey")) {
      const key = await accountSdk.privateKey();
      console.log(key);
      const view = await accountSdk.viewKey();
      const pub = await accountSdk.address();
      setPrivateKey(await key.to_string());
      setViewKey(await view.to_string());
      setPublicKey(await pub.to_string());
      localStorage.setItem("privateKey", await key.to_string());
      localStorage.setItem("viewKey", await view.to_string());
      localStorage.setItem("publicKey", await pub.to_string());
    } else {
      console.log("private key already generated " + localStorage.getItem("privateKey"));
      setPrivateKey(localStorage.getItem("privateKey"));
      setViewKey(localStorage.getItem("viewKey"));
      setPublicKey(localStorage.getItem("publicKey"));
    }
  };
  const kycHashFunc = async () => {
    let kycHash = public_connection.getProgramMappingValue("zkyc.aleo", "kycMap", `${publicKey}`)
    console.log(kycHash);
    return kycHash;
  };
  const phoneHashFunc = async () => {
    let phoneHash = public_connection.getProgramMappingValue("zkyc.aleo", "phoneMap", `${publicKey}`)
    console.log(phoneHash);
    return phoneHash;
  };
  const emailHashFunc = async () => {
    let emailHash = public_connection.getProgramMappingValue("zkyc.aleo", "emailMap", `${publicKey}`)
    console.log(emailHash);
    return emailHash;
  };
  const over18Func = async () => {
    let over18Hash = public_connection.getProgramMappingValue("zkyc.aleo", "over18Map", `${publicKey}`)
    console.log(over18Hash);
    return over18Hash;
  };
  const wrapKycVerify = async () => {
    let kycHash = await kycHashFunc();
    let kycVerify = await Hash(`${idInput, birthTimestampInput}`);
    console.log(kycVerify);
    if (kycHash == kycVerify) {
      console.log("kyc verified");
      return true;
    } else {
      console.log("kyc not verified");
      return false;
    }
  }
  const wrapPhoneVerify = async () => {
    let phoneHash = await phoneHashFunc();
    let phoneVerify = await Hash(`${idInput, birthTimestampInput}`);
    console.log(phoneVerify);
    if (phoneHash == phoneVerify) {
      console.log("phone verified");
      return true;
    } else {
      console.log("phone not verified");
      return false;
    }
  }
  const wrapEmailVerify = async () => {
    let emailHash = await emailHashFunc();
    let emailVerify = await Hash(`${idInput, birthTimestampInput}`);
    console.log(emailVerify);
    if (emailHash == emailVerify) {
      console.log("email verified");
      return true;
    } else {
      console.log("email not verified");
      return false;
    }
  }
  const wrapOver18Verify = async () => {
    let over18Hash = await over18Func();
    let over18Verify = await Hash(`${idInput, birthTimestampInput}`);
    console.log(over18Verify);
    if (over18Hash == over18Verify) {
      console.log("over18 verified");
      return true;
    } else {
      console.log("over18 not verified");
      return false;
    }
  }
  return (
    <>
      <h1 className="text-white w-full justify-center absolute text-center text-4xl mt-5">zKyc</h1>
      <div className="flex flex-row justify-center h-screen items-center gap-8">
        <div className="flex flex-col items-center h-1/2">
          <div className="flex flex-col gap-2 items-center">
            <button className="text-black bg-blue-500 hover:bg-blue-700 font-bold py-2 px-4 rounded whitespace-nowrap" onClick={generateAccount}>
              {privateKey
                ? `Account ${JSON.stringify(privateKey)}`
                : `Click to generate account`}
            </button>
            {
              privateKey ? <QRCode className="mt-5" value={privateKey} /> : null
            }
          </div>
          <div className="flex flex-row items-center justify-center gap-8 h-screen">
            <div className="flex flex-col items-center">
              <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={async () => { const hash = await emailHashFunc }}>
                {emailHash
                  ? `Email Hash ${JSON.stringify(privateKey)}`
                  : `Generate account`}
              </button>
              {
                emailHash ? <QRCode className="mt-5" value={privateKey} /> : null
              }
            </div>
            <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={over18Func}>
              {over18
                ? `Over 18 ${JSON.stringify(privateKey)}`
                : `Generate account`}
            </button>
          </div>
        </div>
        <div className="flex flex-col gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700  font-bold py-2 px-4 rounded whitespace-nowrap" onClick={kycHashFunc}>
            {kycHash
              ? `KYC Hash ${JSON.stringify(privateKey)}`
              : `Generate account`}
          </button>
          {kycHash ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
        <div className="flex flex-col gap-10 items-center h-1/2">
          <button className="text-black bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded whitespace-nowrap" onClick={phoneHashFunc}>
            {phoneHash
              ? `Phone Hash`
              : `Generate account`}
          </button>
          {phoneHash ?
            <img src="public/green.png" height={20} width={20} /> : null
          }
        </div>
      </div>

    </>
  );
}

export default App;
