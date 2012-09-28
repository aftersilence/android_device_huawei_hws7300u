#!/system/bin/sh
#/* <DTS2012020901832 added by liyaobing 00169718 for optimizing of power on time ,begin 20120203>*/
      # insmod /system/lib/modules/mt9p111.ko
      # insmod /system/lib/modules/mt9p111_liteon.ko
       insmod /system/lib/modules/mt9m114.ko
      # insmod /system/lib/modules/bs300.ko
      #/* <DTS2012040701327 modify by w00196206 for handset no irq problem ,begin 201200412>*/
      # insmod /system/lib/modules/version_s7pro.ko
      #/* <DTS2012040701327 modify by w00196206 for handset no irq problem ,end 201200412>*/

       exit 0
#/* <DTS2012020901832 added by liyaobing 00169718 for optimizing of power on time ,end 20120203>*/

