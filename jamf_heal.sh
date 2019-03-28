#!/bin/sh
#
# Author: N8
#
# Description: JAMF Mac client health check

#ze variables
date=`date`
hostname=`hostname`
manage=`echo "+++++++++++++ collecting jamf manage status: \$date +++++++++++++\n" | sudo tee -a /library/logs/jamfhealth_\$hostname.log && sudo jamf manage | sudo tee -a /library/logs/jamfhealth_\$hostname.log `
mdm=`echo "+++++++++++++ collecting jamf mdm status: \$date +++++++++++++\n" | sudo tee -a /library/logs/jamfhealth_\$hostname.log && sudo jamf mdm | sudo tee -a /library/logs/jamfhealth_\$hostname.log`
recon=`echo "+++++++++++++ collecting jamf recon status: \$date +++++++++++++\n" | sudo tee -a /library/logs/jamfhealth_\$hostname.log && sudo jamf recon | sudo tee -a /library/logs/jamfhealth_\$hostname.log`

#check if root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#collect ze data
echo $manage
echo $mdm
echo $recon
echo "Would you like to re-install & re-enroll the client? (Have QuickAdd pkg in Downloads folder. Doesn't delete JSS record)..."
select yn in "Yes" "No"; do
	case $yn in
		Yes ) sudo jamf removeframework | sudo tee -a /library/logs/jamfhealth_\$hostname.log;
			  read -p "Pause for removing JSS record [Press Enter]..."
			  sudo installer -verbose -pkg ~/Downloads/QuickAdd_10_9.pkg -target / | sudo tee -a /library/logs/jamfhealth_\$hostname.log;;

		No ) exit ;;
	esac
done
