#!/bin/bash

# Automate the creation of vpc and subnets on gcp

# Functions:

vpc() {

echo "creating vpc network..."
sudo gcloud config set project snappy-meridian-304118 
sudo gcloud compute networks create uloma1vpcnetwork --subnet-mode=custom

}
                                                                                                                        
subnet1() {

echo "creating public subnet"
sudo gcloud compute networks subnets create subneta-us --network=uloma1vpcnetwork --region=us-central1 --range=172.16.0.0/24

}

subnet2() {

echo "creating private subnet"
gcloud compute networks subnets create subnetb-eu --network=uloma1vpcnetwork --region=us-central1 --range=172.20.0.0/20

}


firewallrule() {

echo "creating firewall rule"
gcloud compute firewall-rules create uloma1vpcnetwork-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=uloma1vpcnetwork --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

}

completed() {
echo "Network created..."
exit

}


# Execution
# Update, upgrade and clean
var="vpc"

if [ "$var" == "vpc" ]; then
    vpc
    subnet1
    subnet2
    firewallrule 
    completed

fi

if [  -n "$var"  ]; then
echo  "Error Invalid argument"

fi

    vpc
    subnet1
    subnet2
    firewallrule 
    completed