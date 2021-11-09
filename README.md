# jchome
This is the home for jc test  
My goal is to have minimal requirements and maximum automation  
Required:    
Terraform installed on workstation  
AWS credentials already setup on workstation, these credentials need to be able to create ec2 instances and create security groups.  
OPtional:  
if you wish to ssh to the created ec2 instance, you need to have the ssh keys on your workstation also  
This ssh key must be the key used to setup the created ec2 instance  
Steps:  
Clone the repo  
cd into the jchome directory  
terraform init  
terraform plan  
terraform apply  
this terraform plan will   
setup httpd  
setup python  
configure httpd  
configure cgi  
run a yum update   
reboot the instance  
