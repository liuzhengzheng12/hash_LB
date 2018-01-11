parser start {
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.ethertype) {
        0X0800 : parse_ipv4;
        default : ingress;
    }
}

parser parse_ipv4 {
    extract(ipv4);
    set_metadata(LB_meta.sip, ipv4.sip);
    set_metadata(LB_meta.vip, ipv4.dip);
    return select(latest.proto) {
        6 : parse_tcp;
        17 : parse_udp;
        default: ingress;
    }
}

parser parse_tcp {
    extract(tcp);
    set_metadata(LB_meta.proto, 0);
    set_metadata(LB_meta.sPort, tcp.sPort);
    set_metadata(LB_meta.vPort, tcp.dPort);
    return ingress;
}

parser parse_udp {
    extract(udp);
    set_metadata(LB_meta.proto, 1);
    set_metadata(LB_meta.sPort, udp.sPort);
    set_metadata(LB_meta.vPort, udp.dPort);
    return ingress;
}
