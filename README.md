# zKyc: A Privacy-Preserving Identity Verification Solution on the Aleo Blockchain

## Summary of the Project

In the digital age, web2 and web3 services often require identity verification, a necessary but problematic practice as it involves entrusting personal information to these services. To address this issue, we developed an application using Swift SDK that interfaces with necessary verification processes.

## Solution

Upon successful verifications, users can mint a soulbound zkNFT (non-fungible token) within our app. This unique, non-transferable NFT contains proofs of the user's identity verifications. When a service requests identity verification, it compares the proofs generated by the user with those in the zkNFT. A match confirms the user's identity without revealing personal information.

## Technical Explanation and Design

Our project integrates two essential services for its functionality:

### Humine Labs

- We used the Swift SDK to develop our mobile app. Users first log into their Aleo wallet within the zKyc mobile app.
- After successful login, users can verify their identity through various methods, such as government-issued ID checks, producing proofs if the details are correct.
- We utilizies Apple KeyChain to safely create signatures, and prove them later.
- Users can also generate new proofs using web2 services verification (e.g., GitHub, Twitter).
- These verification processes are optional and user-selected.

### Demox Labs

- Utilizing Demox Labs' NFT structure, we store a soulbound zkId on the TokenId. This allows secure storage of various verifications like email, phone number, age, and social media validations.
- Proofs generated in the zKyc mobile app are embedded into zkNFTs created using Demox Labs' infrastructure, making them ready for verification at any time.
- We specifically designed these NFTs as soulbound to avoid the security risks associated with transferable NFTs.
- For instance, a betting site wanting to verify a user's age can direct the user to the zKyc mobile app. The user generates a zk proof using personal knowledge, which, if matched with the NFT, verifies the user's age without exposing their identity to the betting service.
- We are using firebase apis for login with twitter, github so we trying to bring web2 data's to the web3.
In essence, the zKyc mobile app successfully addresses significant privacy concerns by providing a secure and private method of identity verification using the innovative technology of zkNFTs on the Aleo blockchain.

### Example Transition Id
- ZKYCLATEST.ALEO = at1qlryrtjg2vszywhjjr89j2rgwzdr3gh59rq8kmyxpsuhkerck5ysxm6le8
- ADD_NFT = at1ewshe4ee60rxm3r20y8x4redyduwcv5vxrm0gp6qul47rugjxu9qwkfwkg
- ADD_MINTER = at1wtk0tn23yxgsp08vrulww93ugp3982zswmwhd98uhau7kwc985fqpp7306
- SET_MINT_BLOCK = at1dyetfe99h5mqzmqsf3z75s5dkehx8nvpvrk2uyn5zyxne2zgxu9qkqm5lz
- OPEN_MINT = at1wujyh55tkhv99gm4mev9d4zj3a5hag4kl349xus655uj5setxvgsttnxhu
