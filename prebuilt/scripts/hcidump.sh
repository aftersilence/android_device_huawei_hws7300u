#!/system/bin/sh
# Copyright (c) 2011, Code Aurora Forum. All rights reserved.
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

#Begin : DTS2012030104892 modified by mkf38213 2012-3-19 for the hcidump switch
#LOG_DIR="/data/hcidump/"
#LOG_TAG="hcidump"
#LOG_FILE=`date +%Y%m%d%H%M%S`.cfa
LOG_DIR="/sdcard/HuaweiLog/hcidump/"
LOG_TAG="hcidump"
LOG_FILE=hcidump_`date +%Y%m%d%H%M`.txt
LOG_FILE_HEX=hcidump_`date +%Y%m%d%H%M`.cfa
#End : DTS2012030104892 modified by mkf38213 2012-3-19 for the hcidump switch

logv ()
{
  /system/bin/log -t $LOG_TAG -p v "$LOG_NAME $@"
}

logv_stdin ()
{
  /system/bin/log -t $LOG_TAG -p v -s
}

#Begin : DTS2012030104892 modified by mkf38213 2012-3-19 for the hcidump switch
#mkdir $LOG_DIR
#logv "Starting hcidump to $LOG_DIR$LOG_FILE"
#/system/xbin/hcidump -xtw $LOG_DIR$LOG_FILE &
mkdir -p $LOG_DIR
logv "Starting hcidump to $LOG_DIR$LOG_FILE"
/system/xbin/hcidump -xtw $LOG_DIR$LOG_FILE_HEX &
/system/xbin/hcidump -Xt >> $LOG_DIR$LOG_FILE &
#End : DTS2012030104892 modified by mkf38213 2012-3-19 for the hcidump switch
/system/xbin/hcidump -xt | logv_stdin
