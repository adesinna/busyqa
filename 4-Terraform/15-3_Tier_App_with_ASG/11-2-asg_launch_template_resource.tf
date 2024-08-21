# Launch Template Resource
resource "aws_launch_template" "my_launch_template_app1" {
  name = "my_launch_template_app1"
  description = "My Launch template for app1"
  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.sg-private-ec2.security_group_id]
  key_name = var.instance_keypair
  user_data = filebase64("${path.module}/app1-install.sh")
  ebs_optimized = true 
  #default_version = 1
  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      #volume_size = 10      
      volume_size = 20 # LT Update Testing - Version 2 of LT              
      delete_on_termination = true
      volume_type = "gp2" # default  is gp2 
    }
   }
  monitoring {
    enabled = true
  }   
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "launch_temp_app1"
    }
  }  
  
}

resource "aws_launch_template" "my_launch_template_app2" {
  name = "my_launch_template_app2"
  description = "My Launch template for app2"
  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.sg-private-ec2.security_group_id]
  key_name = var.instance_keypair
  user_data = filebase64("${path.module}/app2-install.sh")
  ebs_optimized = true 
  #default_version = 1
  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      #volume_size = 10      
      volume_size = 20 # LT Update Testing - Version 2 of LT              
      delete_on_termination = true
      volume_type = "gp2" # default  is gp2 
    }
   }
  monitoring {
    enabled = true
  }   
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "launch_temp_app2"
    }
  }  
  
}


resource "aws_launch_template" "my_launch_template_app3" {
  name = "my_launch_template_app3"
  description = "My Launch template for app3"
  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.sg-private-ec2.security_group_id]
  key_name = var.instance_keypair
  user_data = base64encode(templatefile("app3-ums-install.tmpl", { rds_db_endpoint = module.rds.db_instance_address }))
  ebs_optimized = true 
  #default_version = 1
  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      #volume_size = 10      
      volume_size = 20 # LT Update Testing - Version 2 of LT              
      delete_on_termination = true
      volume_type = "gp2" # default  is gp2 
    }
   }
  monitoring {
    enabled = true
  }   
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "launch_temp_app3"
    }
  }  
  
}


