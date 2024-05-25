
mishare_package=com.miui.mishare.connectivity

ui_print "Unzip zip file ..."
unzip -o "$ZIPFILE" 'apk/*' -d $MODPATH >&2

ui_print "Trying to uninstall updates ..."
pm uninstall-system-updates $mishare_package

apk_installed=$(pm list packages | grep -q $mishare_package && echo true || echo false)
apk_install_path=$(pm path $mishare_package | sed 's/package://' | sed 's/^\/product\//\/system\/product\//')

ui_print "MiShare shall be installed at:"
ui_print "$apk_install_path"
apk_install_dir=$(dirname $apk_install_path)
mkdir -p $MODPATH$apk_install_dir
mv $MODPATH/apk/MiShare.apk $MODPATH$apk_install_path
set_perm_recursive $MODPATH  0  0  0755  0644
ui_print "MiShare has been down-graded to 2.10.0"

rm -rf $MODPATH/apk
ui_print " "
