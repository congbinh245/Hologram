#!/bin/bash

# Reset media controller
media-ctl -d /dev/media0 -r

# 1. Cảm biến IMX219 (1080p Raw Bayer 10-bit)
media-ctl -d /dev/media0 --set-v4l2 '"imx219 6-0010":0 [fmt:SRGGB10_1X10/1920x1080]'

# 2. MIPI CSI-2 Rx Subsystem (Địa chỉ mới: 80000000)
media-ctl -d /dev/media0 --set-v4l2 '"80000000.mipi_csi2_rx_subsystem":0 [fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d /dev/media0 --set-v4l2 '"80000000.mipi_csi2_rx_subsystem":1 [fmt:SRGGB10_1X10/1920x1080 field:none]'

# 3. Demosaic (Địa chỉ mới: a0020000)
media-ctl -d /dev/media0 --set-v4l2 '"a0020000.v_demosaic":0 [fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d /dev/media0 --set-v4l2 '"a0020000.v_demosaic":1 [fmt:RBG888_1X24/1920x1080 field:none]'

# 4. Gamma LUT (Địa chỉ mới: a0080000)
media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_gamma_lut":0 [fmt:RBG888_1X24/1920x1080 field:none]'
media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_gamma_lut":1 [fmt:RBG888_1X24/1920x1080 field:none]'

# 5. VPSS CSC (Địa chỉ mới: a0000000)
media-ctl -d /dev/media0 --set-v4l2 '"a0000000.v_proc_ss_csc":0 [fmt:RBG888_1X24/1920x1080 field:none]'
media-ctl -d /dev/media0 --set-v4l2 '"a0000000.v_proc_ss_csc":1 [fmt:RBG888_1X24/1920x1080 field:none]'

# 6. VPSS Scaler (Địa chỉ mới: a0040000): Thu nhỏ từ 1920x1080 xuống 360x360 cho Hologram
media-ctl -d /dev/media0 --set-v4l2 '"a0040000.v_proc_ss_scaler":0 [fmt:RBG888_1X24/1920x1080 field:none]'
media-ctl -d /dev/media0 --set-v4l2 '"a0040000.v_proc_ss_scaler":1 [fmt:RBG888_1X24/360x360 field:none]'

# Thiết lập Gain camera
v4l2-ctl --set-ctrl=analogue_gain=120
v4l2-ctl --set-ctrl=digital_gain=400

echo ">> Cấu hình Media Controller hoàn tất!"
