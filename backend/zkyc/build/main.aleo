program zkyc.aleo;

struct KycInfo:
    identification_number as u128;
    first_name as field;
    second_name as field;
    last_name as field;
    birth_timestamp as u128;
    country as field;
    city as field;

struct MailInfo:
    email as field;

struct PhoneInfo:
    phone_number as field;

struct AddressInfo:
    country as field;
    city as field;
    street as field;
    street_number as u128;
    postal_code as u128;

record kyc:
    owner as address.private;
    kyc_hash as field.private;


mapping kycs:
	key as address.public;
	value as boolean.public;


mapping kyc_hash_map:
	key as address.public;
	value as field.public;

closure calculate_kyc_hash:
    input r0 as field;
    input r1 as field;
    input r2 as field;
    input r3 as field;
    input r4 as field;
    add r0 r1 into r5;
    add r5 r2 into r6;
    add r6 r3 into r7;
    add r7 r4 into r8;
    hash.bhp256 r8 into r9 as field;
    output r9 as field;


function main:
    input r0 as u128.private;
    input r1 as field.private;
    input r2 as field.private;
    input r3 as field.private;
    input r4 as u128.private;
    input r5 as field.private;
    input r6 as field.private;
    cast r0 r1 r2 r3 r4 r5 r6 into r7 as KycInfo;
    call calculate_kyc_hash r1 r2 r3 r5 r6 into r8;
    async main r7 self.caller r8 into r9;
    output r9 as zkyc.aleo/main.future;

finalize main:
    input r0 as KycInfo.public;
    input r1 as address.public;
    input r2 as field.public;
    set true into kycs[r1];
    set r2 into kyc_hash_map[r1];
