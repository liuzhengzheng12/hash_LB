field_list hash_fields {
    LB_meta.sip;
    LB_meta.vip;
    LB_meta.proto;
    LB_meta.sPort;
    LB_meta.vPort;
}

field_list_calculation gen_digest {
    input {
        hash_fields;
    }
    algorithm : crc32;
    output_width : 16;
}
