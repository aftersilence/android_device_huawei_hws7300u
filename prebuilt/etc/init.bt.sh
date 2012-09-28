#/* <DTS2011051003183 wangxiaobo change for S7pro BT consumption, begin 2011/5/10 */
#/* DTS2011051003183 replace the whole file*/
#!/system/bin/sh
#
# added by h00131430
#

LOG_TAG="bluetooth"
LOG_NAME="${0}:"
exit_code ="${1}:"

loge ()
{
	/system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
	/system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

############################
###detect bluetooth chip
############################
detectbluetooth ()
{
	## reset bluetooth
	echo 0 > /sys/class/rfkill/rfkill0/state
	logi  detecting bluetooth chip 1
	echo 1 > /sys/class/rfkill/rfkill0/state
	
	setprop persist.bt.chip bts4025
	#logi setprop persist.bt.chip bts4025 = `getprop persist.bt.chip`
	
	/system/bin/sh /system/etc/init.qcom.bt.sh
	case   $?   in 
		0)
			LOG_TAG="qcom-bluetooth"
			logi found bluetooth chip bts4025
			exit 0
	        	;;
        	*)
	        	logi chip is not bt4025
	        	;;
	esac
	
	## reset bluetooth
	echo 0 > /sys/class/rfkill/rfkill0/state
	logi  detecting bluetooth chip 2
	echo 1 > /sys/class/rfkill/rfkill0/state
	
	setprop persist.bt.chip bcm4329
	#logi  setprop persist.bt.chip bcm4329 = `getprop persist.bt.chip`
	
	/system/bin/sh /system/etc/init.brcm.bt.sh
	case   $?   in 
		0)
			LOG_TAG="bcm-bluetooth"
			logi found bluetooth chip bcm4329
			exit 0 
			;;
	        *)
	        	logi chip is not bcm4329
	        	;;
	esac
}

################################
## Main process
################################
## get buletooth chip config 
target=`getprop persist.bt.chip`
logi bluetooth chip set as "$target"

case "$target" in
    "bcm4325" | "bcm4329")
		/system/bin/sh /system/etc/init.brcm.bt.sh 
    		exit_code = "$?"
	 	;;
    "bts4025")
    		/system/bin/sh /system/etc/init.qcom.bt.sh 
		exit_code = "$?"  
    		;;
    *)
    		setprop persist.bt.chip bts4025
		/system/bin/sh /system/etc/init.qcom.bt.sh  
    		exit_code = "$?"
    		;;
esac

case   $exit_code  in 
	0)
        	LOG_TAG="bluetooth"
       		target=`getprop persist.bt.chip`
        	logi found bluetooth chip "$target"
        	exit 0   
        	;;
        *)
        	loge chip set error   
        	;;
esac

detectbluetooth
exit_code = "$?"
case   $exit_code   in 
	0)
        	LOG_TAG="bluetooth"
        	target=`getprop persist.bt.chip`
        	logi found bluetooth chip "$target"
        	exit 0   
        	;;
        *)
        	echo 0 > /sys/class/rfkill/rfkill0/state
        	loge no  bluetooth chip found
		exit 1
		;;
esac
#/* DTS2011051003183 wangxiaobo change for S7pro BT consumption, end 2011/5/10> */
