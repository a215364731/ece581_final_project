###########################################################
# Custom insert_io procedure
# Creates IO PAD cells for a given port
# Places it on specified side of the chip
# Chooses input or output cells
# Re-connects so IO sits between external net and 
# internal logic
# Updated: Venkatesh Patil (v.p@pdx.edu) for modular flow
############################################################
proc insert_io { port side } {

    set this_io io_${side}_${port}

    if { [get_attribute [get_ports $port] direction] == "in" } {
        create_cell $this_io saed32io_wb_ss0p95v125c_2p25v/I1025_NS
    } else {
        create_cell $this_io saed32io_wb_ss0p95v125c_2p25v/D8I1025_NS
    }

    set pins [get_pins -of_obj [get_net $port]]
    foreach_in p $pins { disconnect_net [get_net $port] $p }

    if { [sizeof_collection [get_nets -quiet $port]] == 0 } {
        create_net $port
        connect_net $port [get_ports $port]
    }

    connect_net [get_net $port] $this_io/PADIO
    create_net ${this_io}_net

    foreach_in p $pins { connect_net ${this_io}_net $p }

    if { [get_attribute [get_ports $port] direction] == "in" } {
        connect_net [get_nets *Logic1*] $this_io/R_EN
        connect_net ${this_io}_net $this_io/DOUT
    } else {
        connect_net [get_nets *Logic1*] $this_io/EN
        connect_net ${this_io}_net $this_io/DIN
    }
}
