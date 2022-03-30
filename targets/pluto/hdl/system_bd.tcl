
source -notrace $ad_hdl_dir/projects/pluto/system_bd.tcl

## AXI DMA

ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP0 1

ad_ip_instance axi_dma axi_dma_0
ad_ip_parameter axi_dma_0 CONFIG.c_micro_dma 1
ad_ip_parameter axi_dma_0 CONFIG.c_sg_include_stscntrl_strm 0
ad_ip_parameter axi_dma_0 CONFIG.c_sg_length_width 23
ad_cpu_interconnect 0x42000000 axi_dma_0
ad_connect sys_cpu_clk axi_dma_0/m_axi_sg_aclk
ad_connect sys_cpu_clk axi_dma_0/m_axi_mm2s_aclk
ad_connect sys_cpu_clk axi_dma_0/m_axi_s2mm_aclk
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_0/M_AXI_SG
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_0/M_AXI_SG
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_0/M_AXI_MM2S
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_0/M_AXI_S2MM
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S00_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/M00_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S01_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S02_ACLK
ad_connect sys_cpu_resetn axi_hp0_interconnect/S00_ARESETN
ad_connect sys_cpu_resetn axi_hp0_interconnect/M00_ARESETN
ad_connect sys_cpu_resetn axi_hp0_interconnect/S01_ARESETN
ad_connect sys_cpu_resetn axi_hp0_interconnect/S02_ARESETN
ad_cpu_interrupt ps-0 mb-0 axi_dma_0/mm2s_introut
ad_cpu_interrupt ps-1 mb-1 axi_dma_0/s2mm_introut

## FFT

ad_ip_parameter axi_dma_0 CONFIG.c_m_axis_mm2s_tdata_width 32

ad_ip_instance xfft xfft_0
ad_connect axi_dma_0/M_AXIS_MM2S xfft_0/S_AXIS_DATA
ad_connect axi_dma_0/S_AXIS_S2MM xfft_0/M_AXIS_DATA
ad_ip_parameter xfft_0 CONFIG.implementation_options radix_2_lite_burst_io
ad_ip_parameter xfft_0 CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors 0
ad_ip_parameter xfft_0 CONFIG.transform_length 2048
ad_ip_parameter xfft_0 CONFIG.output_ordering natural_order
ad_ip_parameter xfft_0 CONFIG.rounding_modes convergent_rounding
ad_ip_parameter xfft_0 CONFIG.complex_mult_type use_mults_resources
#ad_ip_parameter xfft_0 CONFIG.butterfly_type use_xtremedsp_slices
ad_connect sys_cpu_clk xfft_0/aclk

ad_ip_instance xlconstant xlconstant_0
ad_connect xlconstant_0/dout xfft_0/s_axis_config_tvalid

ad_ip_instance xlconstant xlconstant_1
ad_ip_parameter xlconstant_1 CONFIG.CONST_WIDTH 16
ad_ip_parameter xlconstant_1 CONFIG.CONST_VAL 1
ad_connect xlconstant_1/dout xfft_0/s_axis_config_tdata

## AXI DMA 1

ad_ip_instance axi_dma axi_dma_1
ad_ip_parameter axi_dma_1 CONFIG.c_micro_dma 1
ad_ip_parameter axi_dma_1 CONFIG.c_sg_include_stscntrl_strm 0
ad_ip_parameter axi_dma_1 CONFIG.c_sg_length_width 23
ad_cpu_interconnect 0x44000000 axi_dma_1
ad_connect sys_cpu_clk axi_dma_1/m_axi_sg_aclk
ad_connect sys_cpu_clk axi_dma_1/m_axi_mm2s_aclk
ad_connect sys_cpu_clk axi_dma_1/m_axi_s2mm_aclk
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_1/M_AXI_SG
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_1/M_AXI_MM2S
ad_mem_hp0_interconnect sys_cpu_clk axi_dma_1/M_AXI_S2MM
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S03_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S04_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp0_interconnect/S05_ACLK
ad_connect sys_cpu_resetn axi_hp0_interconnect/S03_ARESETN
ad_connect sys_cpu_resetn axi_hp0_interconnect/S04_ARESETN
ad_connect sys_cpu_resetn axi_hp0_interconnect/S05_ARESETN
ad_cpu_interrupt ps-2 mb-2 axi_dma_1/mm2s_introut
ad_cpu_interrupt ps-3 mb-3 axi_dma_1/s2mm_introut

## FFT 1

ad_ip_parameter axi_dma_1 CONFIG.c_m_axis_mm2s_tdata_width 32

ad_ip_instance xfft xfft_1
ad_connect axi_dma_1/M_AXIS_MM2S xfft_1/S_AXIS_DATA
ad_connect axi_dma_1/S_AXIS_S2MM xfft_1/M_AXIS_DATA
ad_ip_parameter xfft_1 CONFIG.implementation_options radix_2_lite_burst_io
ad_ip_parameter xfft_1 CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors 0
ad_ip_parameter xfft_1 CONFIG.transform_length 2048
ad_ip_parameter xfft_1 CONFIG.output_ordering natural_order
ad_ip_parameter xfft_1 CONFIG.rounding_modes convergent_rounding
ad_ip_parameter xfft_1 CONFIG.complex_mult_type use_mults_resources
#ad_ip_parameter xfft_1 CONFIG.butterfly_type use_xtremedsp_slices
ad_connect sys_cpu_clk xfft_1/aclk

ad_ip_instance xlconstant xlconstant_2
ad_connect xlconstant_2/dout xfft_1/s_axis_config_tvalid

ad_ip_instance xlconstant xlconstant_3
ad_ip_parameter xlconstant_3 CONFIG.CONST_WIDTH 16
ad_ip_parameter xlconstant_3 CONFIG.CONST_VAL 0
ad_connect xlconstant_3/dout xfft_1/s_axis_config_tdata

## assign_bd_address

assign_bd_address