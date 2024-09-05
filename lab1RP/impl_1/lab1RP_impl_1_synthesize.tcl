if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2024.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/avo/Desktop/Lab1/lab1RP"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- lab1RP_impl_1.vm lab1RP_impl_1.ldc
::radiant::runengine::run_engine_newmsg synthesis -f "lab1RP_impl_1_lattice.synproj" -logfile "lab1RP_impl_1_lattice.srp"
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o lab1RP_impl_1_syn.udb lab1RP_impl_1.vm] [list C:/Users/avo/Desktop/Lab1/lab1RP/impl_1/lab1RP_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
