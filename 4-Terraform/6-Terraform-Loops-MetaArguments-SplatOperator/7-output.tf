output "for_output_list" {
  description = "For loop with list"
  value = [
  for i in aws_instance.myinstance:
    i.public_dns  # print out i.public dns

  ]
}

output "for_output_map" {
  description = "For loop with map"
  value = {
    for i in aws_instance.my_instance_2:  # this a list(my_instance_2)
        i.id => i.public_dns # this out put is a dictionary

  }

}

output "for_output_map_advance" {
  description = "For loop with map"
  value = {
  for c, i  in aws_instance.my_instance_2:  # this a list
  c  => i.public_dns # this output is a dictionary but this output is a map

  }


}

output "for_output_splat" {
  description = "For loop"
  value = aws_instance.myinstance[*].public_dns # this output brings out a list

}