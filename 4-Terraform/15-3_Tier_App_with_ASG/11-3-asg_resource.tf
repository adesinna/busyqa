
resource "aws_autoscaling_group" "my_asg_app1" {
  name_prefix = "myasgapp1-"
  desired_capacity = 2
  max_size = 3
  min_size = 1
  vpc_zone_identifier = module.vpc.private_subnets # let it be in the private subnet
  
  target_group_arns = [module.application-lb.target_groups["my_target_group_1"].arn] # the target group where the load balance would route to
  
  health_check_type = "EC2"
  health_check_grace_period = 300 
  launch_template {
    id = aws_launch_template.my_launch_template_app1.id
    version = aws_launch_template.my_launch_template_app1.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = 300 # Default behavior is to use the Auto Scaling Groups health check grace period value
      min_healthy_percentage = 50            
    }
    # this will refresh the instance when this attribute changes
    triggers = [ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger 
      
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "my_asg_app2" {
  name_prefix = "myasgapp2-"
  desired_capacity = 2
  max_size = 3
  min_size = 1
  vpc_zone_identifier = module.vpc.private_subnets # let it be in the private subnet
  
  target_group_arns = [module.application-lb.target_groups["my_target_group_2"].arn] # the target group where the load balance would route to
  
  health_check_type = "EC2"
  health_check_grace_period = 300 
  launch_template {
    id = aws_launch_template.my_launch_template_app2.id
    version = aws_launch_template.my_launch_template_app2.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = 300 # Default behavior is to use the Auto Scaling Groups health check grace period value
      min_healthy_percentage = 50            
    }
    # this will refresh the instance when this attribute changes
    triggers = [ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger 
      
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "my_asg_app3" {
  name_prefix = "myasgapp3-"
  desired_capacity = 2
  max_size = 3
  min_size = 1
  vpc_zone_identifier = module.vpc.private_subnets # let it be in the private subnet
  
  target_group_arns = [module.application-lb.target_groups["my_target_group_3"].arn] # the target group where the load balance would route to
  
  health_check_type = "EC2"
  health_check_grace_period = 300 
  launch_template {
    id = aws_launch_template.my_launch_template_app3.id
    version = aws_launch_template.my_launch_template_app3.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = 300 # Default behavior is to use the Auto Scaling Groups health check grace period value
      min_healthy_percentage = 50            
    }
    # this will refresh the instance when this attribute changes
    triggers = [ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger 
      
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}

