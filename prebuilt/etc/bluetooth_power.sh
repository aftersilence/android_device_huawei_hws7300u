#/* <DTS2011051003183 wangxiaobo change for S7pro BT consumption, begin 2011/5/10 */
# add this file to correct rfkill state after system init
echo 0 > /sys/class/rfkill/rfkill0/state
#/* DTS2011051003183 wangxiaobo change for S7pro BT consumption, end 2011/5/10> */
