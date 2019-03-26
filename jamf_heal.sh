#!/bin/sh
#
# Author: N8
#
# Description: JAMF Mac client health check

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "+++++++++++++ collecting jamf manage status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf manage | sudo tee -a /library/logs/jamfhealth_`hostname`.log 

echo "+++++++++++++ collecting jamf mdm status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf mdm | sudo tee -a /library/logs/jamfhealth_`hostname`.log 

echo "+++++++++++++ collecting jamf recon status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf recon | sudo tee -a /library/logs/jamfhealth_`hostname`.log 