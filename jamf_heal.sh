#!/bin/sh
#
# Author: N8
#
# Description: JAMF Mac client health check

#ze variables
date=`date`
hostname=`hostname`
manage=`echo "+++++++++++++ collecting jamf manage status: \$date +++++++++++++\n" | sudo tee -a /library/logs/jamfhealth_\$hostname.logsudo jamf manage | sudo tee -a /library/logs/jamfhealth_\$hostname.log `
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