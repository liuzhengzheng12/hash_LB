header_type LB_metadata_t {
    fields {
        sip : 32;
        vip : 32;
        proto : 1;
        sPort : 16;
        vPort : 16;
        dPort : 16;
    }
}
metadata LB_metadata_t LB_meta;
