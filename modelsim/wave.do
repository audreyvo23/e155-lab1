onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab1_tb/clk
add wave -noupdate /lab1_tb/reset
add wave -noupdate /lab1_tb/s
add wave -noupdate /lab1_tb/led
add wave -noupdate /lab1_tb/led_expected
add wave -noupdate /lab1_tb/seg
add wave -noupdate /lab1_tb/seg_expected
add wave -noupdate /lab1_tb/vectornum
add wave -noupdate /lab1_tb/errors
add wave -noupdate /lab1_tb/testvectors
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
