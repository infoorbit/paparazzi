#
# $Id$
#  
# Copyright (C) 2009 Antoine Drouin
#
# This file is part of paparazzi.
#
# paparazzi is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# paparazzi is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with paparazzi; see the file COPYING.  If not, write to
# the Free Software Foundation, 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA. 
#
#

ARCHI=arm7

FLASH_MODE = ISP
LPC21ISP_PORT = /dev/ttyUSB0

LPC21ISP_BAUD = 38400
LPC21ISP_XTAL = 12000


LPC21ISP_CONTROL = -control

LDSCRIPT=$(SRC_ARCH)/LPC2129-ROM.ld

BOARD_CFG = \"csc_board_v1_0.h\"



SRC_CSC=csc

main.ARCHDIR = $(ARCHI)
main.ARCH = arm7tdmi
main.TARGET = main
main.TARGETDIR = main

main.CFLAGS += -DCSC_BOARD_ID=0

main.CFLAGS += -I$(SRC_CSC)
main.CFLAGS += -DCONFIG=$(BOARD_CFG)
main.srcs += $(SRC_CSC)/csc_main.c
main.CFLAGS += -DLED -DTIME_LED=1


main.CFLAGS += -DPERIODIC_TASK_PERIOD='SYS_TICS_OF_SEC((1./512.))' -DTIMER0_VIC_SLOT=1
main.srcs += sys_time.c $(SRC_ARCH)/sys_time_hw.c $(SRC_ARCH)/armVIC.c

main.srcs += $(SRC_ARCH)/uart_hw.c


main.CFLAGS += -DUSE_UART0 -DUART0_BAUD=B57600 -DUART0_VIC_SLOT=5
main.CFLAGS += -DUSE_UART1 -DUART1_BAUD=B57600 -DUART1_VIC_SLOT=6
main.CFLAGS += -DDOWNLINK -DDOWNLINK_TRANSPORT=PprzTransport \
	                  -DDOWNLINK_DEVICE=Uart0
main.srcs += downlink.c pprz_transport.c


main.CFLAGS += -DAP_LINK_CAN
main.CFLAGS += -DUSE_CAN1 -DCAN1_BTR=CANBitrate125k_2MHz
main.CFLAGS +=  -DCAN1_VIC_SLOT=3 -DCAN_ERR_VIC_SLOT=7
main.srcs += $(SRC_CSC)/csc_can.c
#main.CFLAGS += -DUSE_CAN2 -DCAN2_BTR=CANBitrate125k_2MHz -DCAN2_VIC_SLOT=4

#main.CFLAGS += -DAP_LINK_UART -DPPRZ_UART=Uart1
#main.CFLAGS += -DUSE_UART1 -DUART1_BAUD=B57600 -DUART1_VIC_SLOT=6
#main.srcs += pprz_transport.c

main.srcs += $(SRC_CSC)/csc_ap_link.c

main.srcs += $(SRC_CSC)/csc_servos.c

main.CFLAGS += -DTHROTTLE_LINK=Uart1
main.srcs += $(SRC_CSC)/uart_throttle.c


#
#
# test uart
#
test_uart.ARCHDIR = $(ARCHI)
test_uart.ARCH = arm7tdmi
test_uart.TARGET = test_uart
test_uart.TARGETDIR = test_uart


test_uart.CFLAGS += -I$(SRC_CSC)
test_uart.CFLAGS += -DCONFIG=$(BOARD_CFG)
test_uart.srcs += $(SRC_CSC)/csc_test_uart.c
test_uart.CFLAGS += -DLED

# -DTIME_LED=1
test_uart.CFLAGS += -DPERIODIC_TASK_PERIOD='SYS_TICS_OF_SEC((1./512.))' -DTIMER0_VIC_SLOT=1
test_uart.srcs += sys_time.c $(SRC_ARCH)/sys_time_hw.c $(SRC_ARCH)/armVIC.c

test_uart.srcs += $(SRC_ARCH)/uart_hw.c

test_uart.CFLAGS += -DUSE_UART1 -DUART1_BAUD=B57600 -DUART1_VIC_SLOT=6
test_uart.CFLAGS += -DDOWNLINK -DDOWNLINK_TRANSPORT=PprzTransport \
	                  -DDOWNLINK_DEVICE=Uart1
test_uart.srcs += downlink.c pprz_transport.c


#
# TEST CAN1
#

test_can1.ARCHDIR = $(ARCHI)
test_can1.ARCH = arm7tdmi
test_can1.TARGET = test_can1
test_can1.TARGETDIR = test_can1


test_can1.CFLAGS += -I$(SRC_CSC)
test_can1.CFLAGS += -DCONFIG=$(BOARD_CFG)
test_can1.srcs += $(SRC_CSC)/test_can1.c
test_can1.CFLAGS += -DLED

# -DTIME_LED=1
test_can1.CFLAGS += -DPERIODIC_TASK_PERIOD='SYS_TICS_OF_SEC((1./512.))' -DTIMER0_VIC_SLOT=1
test_can1.srcs += sys_time.c $(SRC_ARCH)/sys_time_hw.c $(SRC_ARCH)/armVIC.c

test_can1.CFLAGS += -DUSE_CAN1 -DCAN1_BTR=CANBitrate125k_2MHz
test_can1.CFLAGS +=  -DCAN1_VIC_SLOT=3 -DCAN_ERR_VIC_SLOT=7
test_can1.srcs += $(SRC_CSC)/csc_can.c
test_can1.CFLAGS += -DCSC_BOARD_ID=0



#
# TEST CAN2
#

test_can2.ARCHDIR = $(ARCHI)
test_can2.ARCH = arm7tdmi
test_can2.TARGET = test_can2
test_can2.TARGETDIR = test_can2


test_can2.CFLAGS += -I$(SRC_CSC)
test_can2.CFLAGS += -DCONFIG=$(BOARD_CFG)
test_can2.srcs += $(SRC_CSC)/test_can2.c
test_can2.CFLAGS += -DLED

# -DTIME_LED=1
test_can2.CFLAGS += -DPERIODIC_TASK_PERIOD='SYS_TICS_OF_SEC((1./512.))' -DTIMER0_VIC_SLOT=1
test_can2.srcs += sys_time.c $(SRC_ARCH)/sys_time_hw.c $(SRC_ARCH)/armVIC.c

test_can2.CFLAGS += -DUSE_CAN2 -DCAN2_BTR=CANBitrate125k_2MHz
test_can2.CFLAGS +=  -DCAN2_VIC_SLOT=3 -DCAN_ERR_VIC_SLOT=7
test_can2.srcs += $(SRC_CSC)/csc_can.c
test_can2.CFLAGS += -DCSC_BOARD_ID=0
