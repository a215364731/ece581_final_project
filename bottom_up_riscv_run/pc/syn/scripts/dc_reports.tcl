####################################################
# For ECE-581 Class
# Author: Venaktesh Patil (v.p@pdx.edu)
# Modular Script to redirect reports for
# Synopsys DC compiler.
# Add different stages if needed
# 
# Modify as needed.
# #################################################

puts "INFO: Reports"

set stage dc

report_qor                     > ../reports/${top_design}.${stage}.qor.rpt
report_constraint -all_viol    > ../reports/${top_design}.${stage}.constraint.rpt
report_timing -delay max -input -tran -cross -sig 4 -derate -net -cap  -max_path 10000 -slack_less 0 > ../reports/${top_design}.${stage}.timing.max.rpt
check_timing                   > ../reports/${top_design}.${stage}.check_timing.rpt
check_design                   > ../reports/${top_design}.${stage}.check_design.rpt


#check_mv_design  > ../reports/${top_design}.$stage.mvrc.rpt


