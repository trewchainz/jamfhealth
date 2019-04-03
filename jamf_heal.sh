#!/bin/sh
#
# Author: N8
#
# Description: JAMF Mac client health check
# 
# Note: Put QuickAdd package in Downloads folder. Logs go to: /library/logs/jamfhealth_HOSTNAME.log

#ze variables
date=`date`
hostname=`hostname`
manage= echo "+++++++++++++ collecting jamf manage status: ${date} +++++++++++++\n" | tee -a /library/logs/jamfhealth_${hostname}.log ; jamf manage | tee -a/library/logs/jamfhealth_${hostname}.log
mdm= echo "+++++++++++++ collecting jamf mdm status: ${date} +++++++++++++\n" | tee -a /library/logs/jamfhealth_${hostname}.log ; jamf mdm | tee -a /library/logs/jamfhealth_${hostname}.log
recon= echo "+++++++++++++ collecting jamf recon status: ${date} +++++++++++++\n" | tee -a /library/logs/jamfhealth_${hostname}.log; jamf recon | tee -a /library/logs/jamfhealth_${hostname}.log

#check if root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#collect ze data
$manage
$mdm
$recon

#re-install/re-enroll
echo "Would you like to re-install & re-enroll the client? (Have QuickAdd pkg in Downloads folder. Doesn't delete JSS record)..."
select yn in "Yes" "No"; do
	case $yn in
		Yes ) jamf removeframework | tee -a /library/logs/jamfhealth_${hostname}.log;
			  read -p "Pause for removing JSS record [Press Enter]..."
			  installer -verbose -pkg ~/Downloads/*QuickAdd*.pkg -target / | tee -a /library/logs/jamfhealth_${hostname}.log;
			  exit ;;

		No ) exit ;;
	esac
done
