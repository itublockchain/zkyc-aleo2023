program zkyc.aleo;

struct TokenId:
    data1 as u128;
    data2 as u128;
    data3 as boolean;
    data4 as boolean;
    data5 as boolean;
    data6 as boolean;
    data7 as boolean;

struct BaseURI:
    data0 as u128;
    data1 as u128;
    data2 as u128;
    data3 as u128;

struct EmailInfo:
    user as address;
    email_hash as field;

struct KycInfo:
    identification_number as u128;
    first_name as field;
    second_name as field;
    last_name as field;
    birth_timestamp as u128;
    country as field;
    city as field;
    kyc_hash as field;

struct PhoneInfo:
    user as address;
    phone_number as u128;
    phone_hash as field;

struct AddressInfo:
    user as address;
    country as field;
    city as field;
    street as field;
    street_number as u128;
    postal_code as u128;

record KYC:
    owner as address.private;
    data as KycInfo.private;

record Phone:
    owner as address.private;
    data as PhoneInfo.private;

record Email:
    owner as address.private;
    data as EmailInfo.private;

record NFT:
    owner as address.private;
    data as TokenId.private;
    edition as scalar.private;

record NFT_mint:
    owner as address.private;
    amount as u8.private;

record NFT_claim:
    owner as address.private;
    claim as field.private;

record NFT_ownership:
    owner as address.private;
    nft_owner as address.private;
    data as TokenId.private;
    edition as scalar.private;


mapping kycMap:
	key as address.public;
	value as boolean.public;


mapping phoneMap:
	key as address.public;
	value as boolean.public;


mapping emailMap:
	key as address.public;
	value as boolean.public;


mapping over18Map:
	key as address.public;
	value as boolean.public;


mapping general_settings:
	key as u8.public;
	value as u128.public;


mapping nfts_to_mint:
	key as u128.public;
	value as field.public;


mapping claims_to_nfts:
	key as field.public;
	value as field.public;


mapping toggle_settings:
	key as u8.public;
	value as u32.public;

function initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    assert.eq self.caller aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7;
    async initialize_collection r0 r1 r2 into r3;
    output r3 as zkyc.aleo/initialize_collection.future;

finalize initialize_collection:
    input r0 as u128.public;
    input r1 as u128.public;
    input r2 as BaseURI.public;
    get.or_use toggle_settings[0u8] 0u32 into r3;
    and r3 1u32 into r4;
    assert.eq r4 0u32;
    set 1u128 into general_settings[0u8];
    set r0 into general_settings[1u8];
    set r1 into general_settings[2u8];
    set r2.data0 into general_settings[3u8];
    set r2.data1 into general_settings[4u8];
    set r2.data2 into general_settings[5u8];
    set r2.data3 into general_settings[6u8];
    set 7u32 into toggle_settings[0u8];
    set 0u32 into toggle_settings[1u8];


function add_nft:
    input r0 as TokenId.public;
    input r1 as scalar.public;
    assert.eq self.caller aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7;
    hash.bhp256 r0 into r2 as field;
    commit.bhp256 r2 r1 into r3 as field;
    async add_nft r3 into r4;
    output r4 as zkyc.aleo/add_nft.future;

finalize add_nft:
    input r0 as field.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    get general_settings[1u8] into r3;
    sub r3 1u128 into r4;
    set r4 into general_settings[1u8];
    get general_settings[0u8] into r5;
    set r0 into nfts_to_mint[r5];
    add r5 1u128 into r6;
    set r6 into general_settings[0u8];


function add_minter:
    input r0 as address.private;
    input r1 as u8.public;
    assert.eq self.caller aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7;
    cast r0 r1 into r2 as NFT_mint.record;
    async add_minter into r3;
    output r2 as NFT_mint.record;
    output r3 as zkyc.aleo/add_minter.future;

finalize add_minter:
    get toggle_settings[0u8] into r0;
    and r0 9u32 into r1;
    assert.eq r1 1u32;


function set_mint_block:
    input r0 as u32.public;
    assert.eq self.caller aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7;
    async set_mint_block r0 into r1;
    output r1 as zkyc.aleo/set_mint_block.future;

finalize set_mint_block:
    input r0 as u32.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    set r0 into toggle_settings[1u8];


function update_base_uri:
    input r0 as BaseURI.public;
    assert.eq self.caller aleo1tg9z522lmf8mhpu7vt957gpwn68pmdw6fdpyn8gfjsjrn5e7jqqs48upp7;
    async update_base_uri r0 into r1;
    output r1 as zkyc.aleo/update_base_uri.future;

finalize update_base_uri:
    input r0 as BaseURI.public;
    get toggle_settings[0u8] into r1;
    and r1 9u32 into r2;
    assert.eq r2 1u32;
    set r0.data0 into general_settings[3u8];
    set r0.data1 into general_settings[4u8];
    set r0.data2 into general_settings[5u8];
    set r0.data3 into general_settings[6u8];


function open_mint:
    input r0 as scalar.private;
    input r1 as u128.private;
    hash.bhp256 self.caller into r2 as field;
    commit.bhp256 r2 r0 into r3 as field;
    cast self.caller r3 into r4 as NFT_claim.record;
    async open_mint r3 r0 r1 into r5;
    output r4 as NFT_claim.record;
    output r5 as zkyc.aleo/open_mint.future;

finalize open_mint:
    input r0 as field.public;
    input r1 as scalar.public;
    input r2 as u128.public;
    get toggle_settings[1u8] into r3;
    gte r3 0u32 into r4;
    assert.eq r4 true;
    get toggle_settings[0u8] into r5;
    and r5 15u32 into r6;
    assert.eq r6 7u32;
    get.or_use claims_to_nfts[r0] 0field into r7;
    assert.eq r7 0field;
    get nfts_to_mint[r2] into r8;
    set r8 into claims_to_nfts[r0];


function claim_nft:
    input r0 as NFT_claim.record;
    input r1 as TokenId.private;
    input r2 as scalar.private;
    hash.bhp256 r1 into r3 as field;
    commit.bhp256 r3 r2 into r4 as field;
    cast r0.owner r1 r2 into r5 as NFT.record;
    async claim_nft r0.claim r4 into r6;
    output r5 as NFT.record;
    output r6 as zkyc.aleo/claim_nft.future;

finalize claim_nft:
    input r0 as field.public;
    input r1 as field.public;
    get claims_to_nfts[r0] into r2;
    assert.eq r2 r1;
    set 0field into claims_to_nfts[r0];


function kyc_make:
    input r0 as u128.private;
    input r1 as u128.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    add r0 r1 into r7;
    hash.bhp256 r7 into r8 as field;
    cast r0 r2 r3 r4 r1 r5 r6 r8 into r9 as KycInfo;
    cast self.caller r9 into r10 as KYC.record;
    async kyc_make self.caller into r11;
    output r10 as KYC.record;
    output r11 as zkyc.aleo/kyc_make.future;

finalize kyc_make:
    input r0 as address.public;
    set true into kycMap[r0];


function phone_make:
    input r0 as u128.private;
    add r0 r0 into r1;
    hash.bhp256 r1 into r2 as field;
    cast self.caller r0 r2 into r3 as PhoneInfo;
    cast self.caller r3 into r4 as Phone.record;
    async phone_make r3 self.caller into r5;
    output r4 as Phone.record;
    output r5 as zkyc.aleo/phone_make.future;

finalize phone_make:
    input r0 as PhoneInfo.public;
    input r1 as address.public;
    set true into phoneMap[r1];


function email_make:
    input r0 as field.private;
    hash.bhp256 r0 into r1 as field;
    cast self.caller r1 into r2 as EmailInfo;
    cast self.caller r2 into r3 as Email.record;
    async email_make r2 self.caller into r4;
    output r3 as Email.record;
    output r4 as zkyc.aleo/email_make.future;

finalize email_make:
    input r0 as EmailInfo.public;
    input r1 as address.public;
    set true into emailMap[r1];


function over18_make:
    input r0 as boolean.private;
    async over18_make r0 self.caller into r1;
    output r1 as zkyc.aleo/over18_make.future;

finalize over18_make:
    input r0 as boolean.public;
    input r1 as address.public;
    set r0 into over18Map[r1];


function address_make:
    input r0 as field.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as u128.private;
    input r4 as u128.private;
    cast self.caller r0 r1 r2 r3 r4 into r5 as AddressInfo;
    async address_make r5 self.caller into r6;
    output r6 as zkyc.aleo/address_make.future;

finalize address_make:
    input r0 as AddressInfo.public;
    input r1 as address.public;
    set true into over18Map[r1];


function authorize:
    input r0 as NFT.record;
    input r1 as u64.public;
    async authorize into r2;
    output r2 as zkyc.aleo/authorize.future;

finalize authorize:
    assert.eq 0u8 1u8;
