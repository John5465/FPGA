# Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus II License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: Count_Numb.tcl
# Generated on: Tue Sep 06 10:57:36 2016

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION"USE AS REGULAR IO"

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "Count_Numb"]} {
		puts "Project Count_Numb is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists Count_Numb]} {
		project_open -revision Count_Numb Count_Numb
	} else {
		project_new -revision Count_Numb Count_Numb
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE EP4CE6F17C8
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 15.0.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "20:10:43  APRIL 22, 2016"
	set_global_assignment -name LAST_QUARTUS_VERSION 15.0.0
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR "-1"
	set_global_assignment -name POWER_EXT_SUPPLY_VOLTAGE_TO_REGULATOR 3.3V
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name VERILOG_FILE Count_Numb.v
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_global_assignment -name ENABLE_OCT_DONE OFF
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_location_assignment PIN_E1 -to clk
	set_location_assignment PIN_E15 -to rst_n
	set_location_assignment PIN_G15 -to led[0]
	set_location_assignment PIN_F15 -to led[2]
	set_location_assignment PIN_D16 -to led[3]
	set_location_assignment PIN_E16 -to sw1_n
	set_location_assignment PIN_M16 -to sw2_n
	set_location_assignment PIN_M15 -to sw3_n
	set_location_assignment PIN_F16 -to led[1]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
