program zkyc.aleo;

struct KycInfo:
    identification_number as u8;
    first_name as field;
    second_name as field;
    last_name as field;
    birth_date as field;
    country as field;
    city as field;

struct MailInfo:
    email as field;

struct PhoneInfo:
    phone_number as u8;

struct AddressInfo:
    country as field;
    city as field;
    street as field;
    street_number as u8;
    postal_code as u8;

record kyc:
    owner as address.private;
    kyc_info as KycInfo.private;
    mail_info as MailInfo.private;
    phone_info as PhoneInfo.private;
    address_info as AddressInfo.private;


mapping kycs:
	key as address.public;
	value as boolean.public;


mapping hash:
	key as address.public;
	value as field.public;

function main:
    input r0 as u8.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as field.private;
    input r5 as field.private;
    input r6 as field.private;
    cast r0 r1 r2 r3 r4 r5 r6 into r7 as KycInfo;
    hash.bhp256 aleo13quw5mswjlr02vfc64slavc848ed6ceku4ah50jmwj74myj5vurq4h9wnu into r8 as field;
    add r8 1field into r9;
    hash.bhp256 r9 into r10 as field;
    async main r7 self.caller r10 into r11;
    output r11 as zkyc.aleo/main.future;

finalize main:
    input r0 as KycInfo.public;
    input r1 as address.public;
    input r2 as field.public;
    set true into kycs[r1];
    set r2 into hash[aleo13quw5mswjlr02vfc64slavc848ed6ceku4ah50jmwj74myj5vurq4h9wnu];


function check_kyc:
    async check_kyc into r0;
    output r0 as zkyc.aleo/check_kyc.future;

finalize check_kyc:
    hash.bhp256 aleo13quw5mswjlr02vfc64slavc848ed6ceku4ah50jmwj74myj5vurq4h9wnu into r0 as field;
    add r0 1field into r1;
    hash.bhp256 r1 into r2 as field;
    get hash[aleo13quw5mswjlr02vfc64slavc848ed6ceku4ah50jmwj74myj5vurq4h9wnu] into r3;
    assert.eq r2 r3;
