provider "aws" {
  region = "us-west-1"
}

variable "vpcname" {
  type = string # this is a type of
  default = "myvpc" # what it should fall back to if you dont set
}

variable "sshport" {
  type = number
  default = 22
}

variable "enable" {
  type = bool
  default = true
}

variable "mylist" {
  type = list(string) # what data type would be in the list
  default = ["Value1", "Value2"]
}

variable "mymap" { # dictionary
  type = map(string)
  default = {
    key1 = "Value1"
    key2 = "Value2"
  }
}

variable "inputuser" { # input
  type = string
  description = "Set the name of the user" # this would pop up the prompt when terraform plan is used

}

variable "mytuple" {
  type = tuple([string, number, string]) # tuples can contain different data types
  default = ["cat", 1, "dog"]

}

variable "myobject" {
  type = object({name = string, port = number, let = list(number)})
  default = {
    name = "shina"
    port = 33
    let = [22, 33, 44]
  }

}

# output gives you the result and attributes can seen using terraform.io
output "myoutput" {
  value = aws_vpc.test-vpc.id # called the terraname.namegiven.attribute
}



resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Port = var.sshport
    Name = var.vpcname
    List = var.mylist[0]
    Dict = var.mymap["key1"]
    Prompt = var.inputuser

  }
}