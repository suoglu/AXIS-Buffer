
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/AXIS_Buffer_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set AXIS_Interface_Data_Widths [ipgui::add_group $IPINST -name "AXIS Interface Data Widths" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "C_M00_AXIS_TDATA_WIDTH" -parent ${AXIS_Interface_Data_Widths}
  ipgui::add_param $IPINST -name "C_S00_AXIS_TDATA_WIDTH" -parent ${AXIS_Interface_Data_Widths}

  #Adding Group
  set Optional_Ports [ipgui::add_group $IPINST -name "Optional Ports" -parent ${Page_0}]
  set BUFFERING_O_EN [ipgui::add_param $IPINST -name "BUFFERING_O_EN" -parent ${Optional_Ports}]
  set_property tooltip {IP is currently buffering a package} ${BUFFERING_O_EN}
  ipgui::add_param $IPINST -name "TLAST_EN" -parent ${Optional_Ports}
  ipgui::add_param $IPINST -name "TSTRB_EN" -parent ${Optional_Ports}
  set DROP_COUNTER_EN [ipgui::add_param $IPINST -name "DROP_COUNTER_EN" -parent ${Optional_Ports}]
  set_property tooltip {Droped Counter Enable} ${DROP_COUNTER_EN}
  ipgui::add_param $IPINST -name "DROP_COUNTER_WIDTH" -parent ${Optional_Ports}

  #Adding Group
  set Behavioral_Customization [ipgui::add_group $IPINST -name "Behavioral Customization" -parent ${Page_0}]
  ipgui::add_param $IPINST -name "SLAVE_ALWAYS_READY" -parent ${Behavioral_Customization}



}

proc update_PARAM_VALUE.DROP_COUNTER_WIDTH { PARAM_VALUE.DROP_COUNTER_WIDTH PARAM_VALUE.DROP_COUNTER_EN } {
	# Procedure called to update DROP_COUNTER_WIDTH when any of the dependent parameters in the arguments change
	
	set DROP_COUNTER_WIDTH ${PARAM_VALUE.DROP_COUNTER_WIDTH}
	set DROP_COUNTER_EN ${PARAM_VALUE.DROP_COUNTER_EN}
	set values(DROP_COUNTER_EN) [get_property value $DROP_COUNTER_EN]
	if { [gen_USERPARAMETER_DROP_COUNTER_WIDTH_ENABLEMENT $values(DROP_COUNTER_EN)] } {
		set_property enabled true $DROP_COUNTER_WIDTH
	} else {
		set_property enabled false $DROP_COUNTER_WIDTH
	}
}

proc validate_PARAM_VALUE.DROP_COUNTER_WIDTH { PARAM_VALUE.DROP_COUNTER_WIDTH } {
	# Procedure called to validate DROP_COUNTER_WIDTH
	return true
}

proc update_PARAM_VALUE.BUFFERING_O_EN { PARAM_VALUE.BUFFERING_O_EN } {
	# Procedure called to update BUFFERING_O_EN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BUFFERING_O_EN { PARAM_VALUE.BUFFERING_O_EN } {
	# Procedure called to validate BUFFERING_O_EN
	return true
}

proc update_PARAM_VALUE.DROP_COUNTER_EN { PARAM_VALUE.DROP_COUNTER_EN } {
	# Procedure called to update DROP_COUNTER_EN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DROP_COUNTER_EN { PARAM_VALUE.DROP_COUNTER_EN } {
	# Procedure called to validate DROP_COUNTER_EN
	return true
}

proc update_PARAM_VALUE.SLAVE_ALWAYS_READY { PARAM_VALUE.SLAVE_ALWAYS_READY } {
	# Procedure called to update SLAVE_ALWAYS_READY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SLAVE_ALWAYS_READY { PARAM_VALUE.SLAVE_ALWAYS_READY } {
	# Procedure called to validate SLAVE_ALWAYS_READY
	return true
}

proc update_PARAM_VALUE.TLAST_EN { PARAM_VALUE.TLAST_EN } {
	# Procedure called to update TLAST_EN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TLAST_EN { PARAM_VALUE.TLAST_EN } {
	# Procedure called to validate TLAST_EN
	return true
}

proc update_PARAM_VALUE.TSTRB_EN { PARAM_VALUE.TSTRB_EN } {
	# Procedure called to update TSTRB_EN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TSTRB_EN { PARAM_VALUE.TSTRB_EN } {
	# Procedure called to validate TSTRB_EN
	return true
}

proc update_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M00_AXIS_TDATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.BUFFERING_O_EN { MODELPARAM_VALUE.BUFFERING_O_EN PARAM_VALUE.BUFFERING_O_EN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BUFFERING_O_EN}] ${MODELPARAM_VALUE.BUFFERING_O_EN}
}

proc update_MODELPARAM_VALUE.TLAST_EN { MODELPARAM_VALUE.TLAST_EN PARAM_VALUE.TLAST_EN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TLAST_EN}] ${MODELPARAM_VALUE.TLAST_EN}
}

proc update_MODELPARAM_VALUE.TSTRB_EN { MODELPARAM_VALUE.TSTRB_EN PARAM_VALUE.TSTRB_EN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TSTRB_EN}] ${MODELPARAM_VALUE.TSTRB_EN}
}

proc update_MODELPARAM_VALUE.DROP_COUNTER_EN { MODELPARAM_VALUE.DROP_COUNTER_EN PARAM_VALUE.DROP_COUNTER_EN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DROP_COUNTER_EN}] ${MODELPARAM_VALUE.DROP_COUNTER_EN}
}

proc update_MODELPARAM_VALUE.DROP_COUNTER_WIDTH { MODELPARAM_VALUE.DROP_COUNTER_WIDTH PARAM_VALUE.DROP_COUNTER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DROP_COUNTER_WIDTH}] ${MODELPARAM_VALUE.DROP_COUNTER_WIDTH}
}

proc update_MODELPARAM_VALUE.SLAVE_ALWAYS_READY { MODELPARAM_VALUE.SLAVE_ALWAYS_READY PARAM_VALUE.SLAVE_ALWAYS_READY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SLAVE_ALWAYS_READY}] ${MODELPARAM_VALUE.SLAVE_ALWAYS_READY}
}

