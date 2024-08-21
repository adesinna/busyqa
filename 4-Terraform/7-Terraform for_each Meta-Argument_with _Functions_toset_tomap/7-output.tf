output "for_output_list_public_ip" {
  description = "For loop with list"
  value = toset([
    for instance in aws_instance.myinstance:
          instance.public_ip
  ])
}

output "for_output_list_public_dns" {
  description = "For loop with list"
  value = toset([
    for instance in aws_instance.myinstance:
          instance.public_dns
  ])
}

# For maps
output "instance_publicdns2" {
  value = tomap({
    for s, instance in aws_instance.myinstance:
      s => instance.public_dns

    # S intends to be a subnet ID
  })
}

# Basic Output: All Availability Zones mapped to Supported Instance Types
output "output_v3_1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
      az => details.instance_types
  }
}

# Output-2
# Filtered Output: Exclude Unsupported Availability Zones
output "output_v3_2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
        az => details.instance_types if length(details.instance_types) != 0
  }
}

# Output-3
# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v3_3" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
      az => details.instance_types if length(details.instance_types) != 0
  })
}


# Output-4 (additional learning)
# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3_4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type:
    az => details.instance_types if length(details.instance_types) != 0 })[0]
}