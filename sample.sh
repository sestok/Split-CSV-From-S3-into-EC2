#!/bin/bash
yum update -y
yum install httpd -y
systemctl start hhtpd
systemctl enable httpd
cd /var/www/html
aws s3 cp s3://bucket_name/names.csv ./
aws s3 cp s3://bucket_name/index.txt ./
EC2NAME=`cat ./names.csv|sort -R|head -n 1|xargs`
sed "s/INSTANCE/$EC2NAME/" index.txt > index.html
