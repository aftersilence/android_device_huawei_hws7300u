#!/system/bin/sh
# Copyright (c) 2009, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Code Aurora nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Begin: DTS2011062805841 added by w00185945 20110628 for add BT TestMode

BLUETOOTH_SLEEP_PATH=/proc/bluetooth/sleep/proto
BLUETOOTH_STATE_PATH=/sys/class/rfkill/rfkill0/state
#BLUETOOTH_HCD_PATH=/system/etc/bluetooth/BCM4329B1_002.002.023.0313.0343.hcd
#BLUETOOTH_HCD_PATH=/system/etc/BCM4329B1_0019_Murata_SS4329_ES1_CL1_TestOnly.hcd

# Begin: DTS2011072501415 modified by l00190626 20110725 for BT TestMode
#BLUETOOTH_HCD_PATH=/system/etc/bluetooth/BCM4329B1_002.002.023.0313.0390.hcd
BLUETOOTH_HCD_PATH=/system/etc/bluetooth/BCM4329B1_37.4M.hcd
# End: DTS2011072501415 modified by l00190626 20110725 for BT TestMode

LOG_TAG="brcm-bluetooth"
LOG_NAME="${0}:"

hciattach_pid=""

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
#  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

#start_hciattach ()
#{
#  echo 1 > $BLUETOOTH_STATE_PATH
#  logi "Power on Bluetooth"
#  sleep 2
#  echo 1 > $BLUETOOTH_SLEEP_PATH
#  sleep 1
#  /system/bin/hciattach -n -s $QSOC_BAUD $QSOC_DEVICE bcm2035 $QSOC_BAUD flow &
#  /system/bin/hciattach -n -s $QSOC_BAUD $QSOC_DEVICE bcm4325 $QSOC_BAUD flow BD:B2:10:00:AB:BA &
#  hciattach_pid=$!
#  logi "start_hciattach: pid = $hciattach_pid"
#}

#kill_hciattach ()
#{
#  logi "kill_hciattach: pid = $hciattach_pid"
  ## careful not to kill zero or null!
#  kill -TERM $hciattach_pid
#  echo 0 > $BLUETOOTH_SLEEP_PATH
#  echo 0 > $BLUETOOTH_STATE_PATH
  # this shell doesn't exit now -- wait returns for normal exit
#}

# mimic hciattach options parsing -- maybe a waste of effort
#USAGE="hciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]"

while getopts "blnpt:s:" f
do
  case $f in
  b | l | n | p)  opt_flags="$opt_flags -$f" ;;
  t)      timeout=$OPTARG;;
  s)      initial_speed=$OPTARG;;
  \?)     echo $USAGE; exit 1;;
  esac
done
shift $(($OPTIND-1))

QSOC_DEVICE=${1:-"/dev/ttyHS0"}
QSOC_BAUD=${3:-"921600"}

echo 1 > $BLUETOOTH_STATE_PATH
  logi "Power on Bluetooth"

sleep 3

#brcm_patchram_plus -d --pcm 1 --enable_test_mode 1 --baudrate $QSOC_BAUD --patchram=$BLUETOOTH_HCD_PATH $QSOC_DEVICE
brcm_patchram_plus -d --patchram=$BLUETOOTH_HCD_PATH $QSOC_DEVICE
brcm_patchram_plus -d --enable_test_mode 1 $QSOC_DEVICE
exit_code_brcm_patchram_plus=$?

case $exit_code_brcm_patchram_plus in
  0) logi "Bluetooth Broadcom HCD file download succeeded";;
  *) failed "Bluetooth Broadcom HCD file download failed" $exit_code_brcm_patchram_plus;;
esac

# init does SIGTERM on ctl.stop for service
trap "kill_hciattach" TERM INT

#start_hciattach

#wait $hciattach_pid

#logi "Bluetooth stopped"

#exit 0

# End: DTS2011062805841 added by w00185945 20110628 for add BT TestMode
