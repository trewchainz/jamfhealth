#!/bin/sh
#
# Author: N8
#
# Description: JAMF client health check


echo "+++++++++++++ collecting jamf manage status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf manage | sudo tee -a /library/logs/jamfhealth_`hostname`.log 

echo "+++++++++++++ collecting jamf mdm status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf mdm | sudo tee -a /library/logs/jamfhealth_`hostname`.log 

echo "+++++++++++++ collecting jamf recon status: `date` +++++++++++++\n"| sudo tee -a /library/logs/jamfhealth_`hostname`.log 
sudo jamf recon | sudo tee -a /library/logs/jamfhealth_`hostname`.log 