action set_dip_dport(dip, dPort) {
    modify_field(ipv4.dip, dip);
    modify_field(LB_meta.dPort, dPort);
}

action set_ecmp_dip_dport(dip, dPort) {
    modify_field(ipv4.dip, dip);
    modify_field(LB_meta.dPort, dPort);
}

action_selector ecmp_selector {
    selection_key : gen_digest;
}

action_profile ecmp_action_profile {
    actions {
        set_ecmp_dip_dport;
    }
    size : ECMP_ACTION_PROFILE_SIZE;
    dynamic_action_selection : ecmp_selector;
}

action tcp_forward(port) {
    modify_field(tcp.dPort, LB_meta.dPort);
    modify_field(ig_intr_md_for_tm.ucast_egress_port, port);
}

action udp_forward(port) {
    modify_field(udp.dPort, LB_meta.dPort);
    modify_field(ig_intr_md_for_tm.ucast_egress_port, port);
}
