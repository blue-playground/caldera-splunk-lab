#!/bin/sh
wget -O splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.1.1/linux/splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb"
dpkg -i splunk-9.1.1-64e843ea36b1-linux-2.6-amd64.deb
sudo /opt/splunk/bin/splunk enable boot-start
/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd changeme
/opt/splunk/bin/splunk add index wineventlog -auth 'admin:changeme'
/opt/splunk/bin/splunk install app /vagrant/resources/splunk_server/splunk-add-on-for-microsoft-windows_880.tgz -auth 'admin:changeme'
/opt/splunk/bin/splunk install app /vagrant/resources/splunk_forwarder/splunk-add-on-for-sysmon_310.tgz -auth 'admin:changeme'
# cp /vagrant/resources/splunk_server/windows_ta_props.conf /opt/splunk/etc/apps/Splunk_TA_windows/default/props.conf
# cp /vagrant/resources/splunk_server/sysmon_ta_props.conf /opt/splunk/etc/apps/TA-microsoft-sysmon/default/props.conf