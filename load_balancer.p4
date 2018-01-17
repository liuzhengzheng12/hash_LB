#include <tofino/intrinsic_metadata.p4>
#include <tofino/stateful_alu_blackbox.p4>

#include "include/macro.p4"
#include "include/header.p4"
#include "include/metadata.p4"
#include "include/parser.p4"
#include "include/hash.p4"
#include "include/action.p4"

table conn_table {
    reads {
        LB_meta.sip : exact;
        LB_meta.sPort : exact;
        LB_meta.proto : exact;  //0 for TCP and 1 for UDP
        LB_meta.vip : exact;
        LB_meta.vPort : exact;
    }
    actions {
        set_dip_dport;
    }
}

table vip_table {
    reads {
        LB_meta.vip : exact;
        LB_meta.vPort : exact;
    }
    action_profile : ecmp_action_profile;
}

table forward {
    reads {
        ipv4.dip : lpm;
        LB_meta.proto : exact;
    }
    actions {
        tcp_forward;
        udp_forward;
    }
}

control ingress {
    apply(conn_table) {
        miss {
            apply(vip_table);
        }
    }
    apply(forward);
}

control egress {
}
