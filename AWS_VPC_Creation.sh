
#!/bin/bash
######################################
# Authour : Prathap Kumar Darla
# Version : v0.0.1
# Description : Script to create a VPC in AWS
########################################
#     route53)
#       aws route53 list-hosted-zones
# Function to create a VPC

create_vpc() {
  local region=$1
  local cidr_block=$2
  local vpc_name=$3

  # Create the VPC
  vpc_id=$(aws ec2 create-vpc --region "$region" --cidr-block "$cidr_block" --query "Vpc.VpcId" --output text)

  # Tag the VPC with the provided name
  aws ec2 create-tags --resources "$vpc_i
  d" --tags Key=Name,Value="$vpc_name"

  echo "VPC created with ID: $vpc_id"
}