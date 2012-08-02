#Begin:DTS2011121403930 modified by j00165480 for bluetooth 2012/01/11
#!/system/bin/sh
# Copyright (c) 2009-2010, Code Aurora Forum. All rights reserved.
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

BLUETOOTH_SLEEP_PATH=/proc/bluetooth/sleep/proto


#BLUETOOTH_HCD_PATH=/system/etc/bluetooth/BCM4329B1_002.002.023.0313.0390.hcd
BLUETOOTH_HCD_PATH=/system/etc/bluetooth/BCM4329B1_37.4M.hcd


LOG_TAG="bcm-bluetooth"
LOG_NAME="${0}:"

hciattach_pid=""

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

start_hciattach ()
{

  # Begin:DTS2012022202733 modifed by j00165480 for bluetooth on/off 2012/02/22
  #/* sleep 1 second to ensure bt is powered on successfully*/
  #sleep 1
  /system/bin/brcm_patchram_plus -d --enable_hci --enable_lpm --pcm 1 --baudrate 3000000 --patchram $BLUETOOTH_HCD_PATH /dev/ttyHS0 &
  hciattach_pid=$!

  # echo 1 > ${BLUETOOTH_SLEEP_PATH}
  loge "start_hciattach: pid = $hciattach_pid"
  # End:DTS2012022202733 modifed by j00165480 for bluetooth on/off 2012/02/22
}

kill_hciattach ()
{
  # Begin:DTS2012022202733 modifed by j00165480 for bluetooth on/off 2012/02/22
  loge "kill_hciattach: pid = $hciattach_pid"
  ## careful not to kill zero or null!
  kill -TERM $hciattach_pid
  # echo 0 > ${BLUETOOTH_SLEEP_PATH}

  # this shell doesn't exit now -- wait returns for normal exit
  # End:DTS2012022202733 modifed by j00165480 for bluetooth on/off 2012/02/22
}


# init does SIGTERM on ctl.stop for service
trap "kill_hciattach" TERM INT

start_hciattach

wait $hciattach_pid

logi "Bluetooth stopped"
exit 0
#End:DTS2011121403930 modified by j00165480 for bluetooth 2012/01/11