To build:
1. Clone device tree to /path_to_your_cm_folder/device/huawei/hws7300u.
2. Connect pad to pc with working adb connection and run extract-files.sh to get vendor stuff (stored to /path_to_your_cm_folder/vendor/huawei/hws7300u).
3. Run in terminal from root of cm10 folder:
source build/envsetup.sh && brunch hws7300u
