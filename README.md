# jchome
# This is the home for jc test
My goal is to have minimal requirements and maximum automation  
## Required:
Terraform installed on workstation  
AWS account, a free account is good enough  
AWS credentials already setup on workstation, these credentials need to be able to create ec2 instances and create security groups.  
## Optional: 
if you wish to ssh to the created ec2 instance, you need to have the ssh keys on your workstation also  
This ssh key must be the key used to setup the created ec2 instance  
## Steps: 
Clone the repo  
cd into the jchome directory  
terraform init  
terraform plan  
terraform apply  
## This terraform plan will   
setup httpd  
setup python  
configure httpd  
configure cgi  
place index.html into place  
place the python cgi manage_file into place  
run a yum update ( this slows the creation by a great deal )  
reboot the instance  
## Testing
A shell script is placed in the /home/centos directory named sitetest.sh   
use this to test the setup:  
example:  
./sitetest.sh ipaddressofinstance  
## Monitoring
if this was a real site I would set it up in whatever site monitor tool was in use , preferably via the tools api  