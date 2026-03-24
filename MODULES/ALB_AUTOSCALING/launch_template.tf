resource "aws_launch_template" "asg" {
  name_prefix            = "asg-launch-template-"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = base64encode(
    templatefile("${path.module}/userdata/user_data.sh.tpl", {
      environment = var.environment
    })
  )

  tags = {
    Name = "web-${var.environment}"
  }
}


