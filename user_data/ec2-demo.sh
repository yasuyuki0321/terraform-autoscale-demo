#!/bin/bash
yum update -y

### JST
sed -ie 's/ZONE=\"UTC\"/ZONE=\"Asia\/Tokyo\"/g' /etc/sysconfig/clock
sed -ie 's/UTC=true/UTC=false/g' /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

### httpd
yum install -y httpd
hostname > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd.service
