/*
    This file is a fork of the art-factory/main.leo by demox labs.
    *********
                ZKYC: Zero Knowledge Know Your Customer
    *********
*/
program zkyc.aleo {
    
    struct  TokenId {
        data1: u128, // Part 1 of the image data -- i.e., a way to link this nft to image or aws
        data2: u128,
        data3: bool, // email
        data4: bool, // phone
        data5: bool, // kyc
        data6: bool, // over18
        data7: bool, // address
    }

    // base uri ascii bits. Include as many data pieces as necessary to encapsulate the uri. Padded with 0s at the end.
    struct BaseURI {
        data0: u128, // Part 1 of the base uri in bits. Bits should be the representation of the hexadecimal bytes for the ASCII text of the URL
        data1: u128,
        data2: u128,
        data3: u128
    }

    struct EmailInfo {
        user: address,
        email_hash: field,
    }

    struct KycInfo {
         identification_number: u128,
         first_name: field,
         second_name: field,
         last_name: field,
         birth_timestamp: u128,
         country: field,
         city: field,
         kyc_hash: field,
    }

    struct PhoneInfo {
        user: address,
        phone_number: u128,
        phone_hash: field,
    }

    struct AddressInfo {
        user: address,
        country: field,
        city: field,
        street: field,
        street_number: u128,
        postal_code: u128,
    }

    record KYC {
        private owner: address,
        private data: KycInfo,
    }

    record Phone {
        private owner: address,
        private data: PhoneInfo,
    }

    record Email {
        private owner: address,
        private data: EmailInfo,
    }

    record NFT {
        private owner: address,
        private data: TokenId,
        private edition: scalar, // which edition of the nft this particular one is -- will be 0 for unique NFTs
    }

    record NFT_mint {
        private owner: address,
        private amount: u8,
    }
//TODO: CONTROL THIS
    record NFT_claim {
        private owner: address,
        private claim: field
    }

    // a way to prove ownership of an nft privately
    record NFT_ownership {
        private owner: address,
        private nft_owner: address,
        private data: TokenId,
        private edition: scalar, // which edition of the nft this particular one is -- will be 0 for unique NFTs
    }
    mapping kycMap: address => bool;
    mapping phoneMap: address => bool;
    mapping emailMap: address => bool;
    mapping over18Map: address => bool;

    // keys: setting index
    // values: setting value
    mapping general_settings: u8 => u128;

    // keys: index of the nft to mint
    // values: hash of the token id + edition
    mapping nfts_to_mint: u128 => field;

    // keys: fields that represent claims for having minted an nft
    // values: fields that are the hash of the nft that was minted
    mapping claims_to_nfts: field => field;

    // keys: just two, 0u8 which corresponds to different on/off settings for the contract, and 1u8
    // which corresponds to the mint block height.
    // values: the bitstring that represents the settings that can be toggled
    // in order of least significant bit index to most significant bit:
    // 0: collection has been initialized
    // 1: can minters mint
    // 2: do minters have to have a mint record (i.e. is the private whitelist a requirement)
    // 3: is the collection frozen
    mapping toggle_settings: u8 => u32;

    transition initialize_collection(
        public total: u128,
        public symbol: u128,
        public base_uri: BaseURI,
    ) {
        assert_eq(self.caller, aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7);
        return then finalize(total, symbol, base_uri);
    }

    finalize initialize_collection(
        public total: u128,
        public symbol: u128,
        public base_uri: BaseURI,
    ) {
        // Ensure initialize cannot be called twice!
        let toggle_settings_status: u32 = toggle_settings.get_or_use(0u8, 0u32);
        let is_initialized: u32 = toggle_settings_status & 1u32;
        assert_eq(is_initialized, 0u32);

        general_settings.set(0u8, 1u128); // number of mintable NFTs (all editions)
        general_settings.set(1u8, total); // Number of total NFTs (first-editions) that can be minted
        general_settings.set(2u8, symbol); // Symbol for the NFT
        general_settings.set(3u8, base_uri.data0); // Base URI for NFT
        general_settings.set(4u8, base_uri.data1);
        general_settings.set(5u8, base_uri.data2);
        general_settings.set(6u8, base_uri.data3);
        // initialized flag = 0b0000...0001 = 1u32
        // minting flag = 0b0000...0010 = 2u32
        // whitelist flag = 0b0000...0100 = 4u32
        // frozen flag = 0b0000...1000 = 8u32
        // defaults -- not frozen, whitelist required, not minting, initialized
        // 0b0000...0101 = 5u32.
        toggle_settings.set(0u8, 5u32);
        toggle_settings.set(1u8, 0u32); // block height when mint is allowed
    }
    
    // Load the data into the mapping
    // Enables someone to mint an NFT with provided image data
    transition add_nft(public tokenId: TokenId, public edition: scalar) {
        assert_eq(self.caller, aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7);
        let tokenHash: field = BHP256::hash_to_field(tokenId);
        let tokenEditionHash: field = BHP256::commit_to_field(tokenHash, edition);
        return then finalize(tokenEditionHash);
    }

    finalize add_nft(public tokenEditionHash: field) {
        // Ensure collection is initialized and not frozen.
        let toggle_settings_status: u32 = toggle_settings.get(0u8);
        // initialized & frozen flags = 0b0000...1001 = 9u32
        // what the settings should be = 0b0000...0001 = 1u32
        let is_initialized_and_not_frozen: u32 = toggle_settings_status & 9u32;
        assert_eq(is_initialized_and_not_frozen, 1u32);

        // Reduce the amount of total nfts that can be initialized
        let remaining: u128 = general_settings.get(1u8);
        general_settings.set(1u8, remaining - 1u128);

        // Add this NFT to the mintable NFT collection
        let mintable_num: u128 = general_settings.get(0u8);
        nfts_to_mint.set(mintable_num, tokenEditionHash);
        general_settings.set(0u8, mintable_num + 1u128);
    }
    //TODO: LET THE MINTER ONLY CAN MINT SPESIFIC NFT THAT WE ALLOWS HIM TO MINT
    transition add_minter(private minter: address, public amount: u8) -> NFT_mint {
        assert_eq(self.caller, aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7);
        return NFT_mint {
            owner: minter,
            amount,
        } then finalize();
    }

    finalize add_minter()
    {
        // Ensure collection is initialized and not frozen.
        let toggle_settings_status: u32 = toggle_settings.get(0u8);
        // initialized & frozen flags = 0b0000...1001 = 9u32
        // what the settings should be = 0b0000...0001 = 1u32
        let is_initialized_and_not_frozen: u32 = toggle_settings_status & 9u32;
        assert_eq(is_initialized_and_not_frozen, 1u32);
    }

    transition set_mint_block(public mint_block: u32) {
        assert_eq(self.caller, aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7);
        return then finalize(mint_block);
    }

    finalize set_mint_block(public mint_block: u32) {
        // Ensure collection is initialized and not frozen.
        let toggle_settings_status: u32 = toggle_settings.get(0u8);
        // initialized & frozen flags = 0b0000...1001 = 9u32
        // what the settings should be = 0b0000...0001 = 1u32
        let is_initialized_and_not_frozen: u32 = toggle_settings_status & 9u32;
        assert_eq(is_initialized_and_not_frozen, 1u32);

        toggle_settings.set(1u8, mint_block);
    }


    transition update_base_uri(public base_uri: BaseURI) {
        assert_eq(self.caller, aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7);
        return then finalize(base_uri);
    }

    finalize update_base_uri(public base_uri: BaseURI) {
       // Ensure collection is initialized and not frozen.
        let toggle_settings_status: u32 = toggle_settings.get(0u8);
        // initialized & frozen flags = 0b0000...1001 = 9u32
        // what the settings should be = 0b0000...0001 = 1u32
        let is_initialized_and_not_frozen: u32 = toggle_settings_status & 9u32;
        assert_eq(is_initialized_and_not_frozen, 1u32);

        general_settings.set(3u8, base_uri.data0); // Base URI for NFT
        general_settings.set(4u8, base_uri.data1);
        general_settings.set(5u8, base_uri.data2);
        general_settings.set(6u8, base_uri.data3);
    }
    // TODO: delete the input. provide random hiding nonce and store it in a mapping to access later.
    transition open_mint(private hiding_nonce: scalar, private nftId: u128) -> NFT_claim {
        // CAUTION: If the minter selects the same hiding nonce,
        // that minter will not be able to mint all of their NFTs without claiming some first.
        // Additionally, some privacy will be lost as the claim is a deterministic hash and is held in public state.
        let address_hash: field = BHP256::hash_to_field(self.caller);
        let claim: field = BHP256::commit_to_field(address_hash, hiding_nonce);
        return NFT_claim {
            owner: self.caller,
            claim
        } then finalize(claim, hiding_nonce, nftId);
    }

    // note, much of this code should be combined in a closure, but finalize closures are not yet stable on aleo.
    finalize open_mint(public claim: field, public hiding_nonce: scalar, public nftId: u128) {
        // Ensure mint block height is less than current block height
        let mint_block: u32 = toggle_settings.get(1u8);
        let passed_height_check: bool = mint_block >= 0u32;
        assert_eq(passed_height_check, true);

        // Ensure collection is not frozen, whitelist is not required, minting is allowed, and is initialized, 
        let toggle_settings_status: u32 = toggle_settings.get(0u8);
        // frozen & whitelist & minting & initialized flags = 0b0000...1111 = 15u32
        // what the settings should be = 0b0000...0011 = 3u32
        let collection_settings_met: u32 = toggle_settings_status & 15u32;
        assert_eq(collection_settings_met, 3u32);

        // Ensure this claim has not already been made
        let existing_claim: field = claims_to_nfts.get_or_use(claim, 0field);
        assert_eq(existing_claim, 0field);

        // Randomly select an NFT to mint
        // TODO: DO NOT MAKE IT RANDOM
        let tokenEditionHash: field = nfts_to_mint.get(nftId);
        claims_to_nfts.set(claim, tokenEditionHash);

        // Decrease the number of mintable nfts

        // Replace the minted nft from the mintable nfts with the last mintable nft.
        // This is done to ensure that the minted nft is not minted again.
        // If the minted nft was the last mintable nft, it still won't be minted again because the next random index must stay
        // within the bounds of the mintable nfts, set by the new mintable num.
    }

    transition claim_nft(nft_claim: NFT_claim, private tokenId: TokenId, private edition: scalar) -> NFT {
        let tokenHash: field = BHP256::hash_to_field(tokenId);
        let tokenEditionHash: field = BHP256::commit_to_field(tokenHash, edition);
        return NFT {
            owner: nft_claim.owner,
            data: tokenId,
            edition
        } then finalize(nft_claim.claim, tokenEditionHash);
    }

    finalize claim_nft(public claim: field, tokenEditionHash: field) {
        // ensure that the claimed nft matches the claim
        let claimedNFT: field = claims_to_nfts.get(claim);
        assert_eq(claimedNFT, tokenEditionHash);
        claims_to_nfts.set(claim, 0field);
    }

     // MAIN PART OF zKYC

    transition kyc_make(
        private identification_number: u128,
        private birth_timestamp: u128,
        private first_name: field,
        private second_name: field,
        private last_name: field,
        private country: field,
        private city: field,

    )-> KYC {
        let owner:address = self.caller;
        let kyc_hash: field = BHP256::hash_to_field(identification_number + birth_timestamp);
        let kyc_info: KycInfo = KycInfo {
            identification_number,
            first_name,
            second_name,
            last_name,
            birth_timestamp,
            country,
            city,
            kyc_hash,
        };
        return KYC {owner: owner, data: kyc_info} then finalize(owner);
    }
    finalize kyc_make(
        public owner: address,
    ) {
        Mapping::set(kycMap, owner, true);
    }
    transition phone_make(
        private phone_number: u128,
    )-> Phone {
        let owner:address = self.caller;
        let phone_info: PhoneInfo = PhoneInfo {
            user: owner,
            phone_number,
            phone_hash: BHP256::hash_to_field(phone_number + phone_number),
        };
        return Phone {owner: owner, data: phone_info} then finalize(phone_info,owner);
    }
    finalize phone_make(
        public phone_info: PhoneInfo,
        public owner: address,
    ) {
        Mapping::set(phoneMap, owner, true);
    }
    transition email_make(
        private email: field,
    )-> Email {
        let owner:address = self.caller;
        let email_info: EmailInfo = EmailInfo {
            user: owner,
            email_hash: BHP256::hash_to_field(email),
        };
        return Email {owner: owner, data: email_info} then finalize(email_info,owner);
    }
    finalize email_make(
        public email_info: EmailInfo,
        public owner: address,
    ) {
        Mapping::set(emailMap, owner, true);
    }
    transition over18_make(
        private over18: bool,
    )-> bool {
        let owner:address = self.caller;
        return then finalize(over18,owner);
    }
    finalize over18_make(
        public over18: bool,
        public owner: address,
    ) {
        Mapping::set(over18Map, owner, over18);
    }
    transition address_make(
        private country: field,
        private city: field,
        private street: field,
        private street_number: u128,
        private postal_code: u128,
    )-> AddressInfo {
        let owner:address = self.caller;
        let address_info: AddressInfo = AddressInfo {
            user: owner,
            country,
            city,
            street,
            street_number,
            postal_code,
        };
        return then finalize(address_info,owner);
    }
    finalize address_make(
        public address_info: AddressInfo,
        public owner: address,
    ) {
        Mapping::set(over18Map, owner, true);
    }

    // Proof that you own an nft without revealing the nft.
    // this burn never actually destroys the nft as the finalize
    // block is guaranteed to fail.
    transition authorize(
        nft: NFT,
        public nonce: u64
    )
    {
        return then finalize();
    }

    finalize authorize(
    )
    {
        // fails on purpose, so that the nft is not burned.
        assert_eq(0u8, 1u8);
    }
}
