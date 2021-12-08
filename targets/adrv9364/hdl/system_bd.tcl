source $ad_hdl_dir/projects/adrv9364z7020/common/adrv9364z7020_bd.tcl
source $ad_hdl_dir/projects/adrv9364z7020/common/ccbob_bd.tcl

cfg_ad9361_interface LVDS

set_property CONFIG.ADC_INIT_DELAY 30 [get_bd_cells axi_ad9361]

## AXI DMA

ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP0 1

ad_ip_instance axi_dma axi_dma_0
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

ad_connect sys_ps7/FCLK_CLK0 axi_hp1_interconnect/S00_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp1_interconnect/M00_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp2_interconnect/S00_ACLK
ad_connect sys_ps7/FCLK_CLK0 axi_hp2_interconnect/M00_ACLK

## FFT

ad_ip_parameter axi_dma_0 CONFIG.c_m_axis_mm2s_tdata_width 32

ad_ip_instance xfft xfft_0
ad_connect axi_dma_0/M_AXIS_MM2S xfft_0/S_AXIS_DATA
ad_connect axi_dma_0/S_AXIS_S2MM xfft_0/M_AXIS_DATA
ad_ip_parameter xfft_0 CONFIG.implementation_options radix_4_burst_io
ad_ip_parameter xfft_0 CONFIG.transform_length 2048
ad_ip_parameter xfft_0 CONFIG.output_ordering natural_order
ad_ip_parameter xfft_0 CONFIG.rounding_modes convergent_rounding
ad_ip_parameter xfft_0 CONFIG.complex_mult_type use_mults_performance
#ad_ip_parameter xfft_0 CONFIG.butterfly_type use_xtremedsp_slices
ad_connect sys_cpu_clk xfft_0/aclk

ad_ip_instance xlconstant xlconstant_0
ad_connect xlconstant_0/dout xfft_0/s_axis_config_tvalid

ad_ip_instance axi_gpio axi_gpio_0
ad_cpu_interconnect 0x41000000 axi_gpio_0
ad_ip_parameter axi_gpio_0 CONFIG.C_GPIO_WIDTH 16
ad_connect axi_gpio_0/gpio_io_o xfft_0/s_axis_config_tdata

assign_bd_address