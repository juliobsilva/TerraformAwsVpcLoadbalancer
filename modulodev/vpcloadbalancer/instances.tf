resource "aws_instance" "webservers" {
	count = "${length(var.subnets_cidr)}" 
	ami = "${var.webservers_ami}"
	instance_type = "${var.instance_type}"
	security_groups = ["${aws_security_group.webservers.id}"]
	subnet_id = "${element(aws_subnet.public.*.id,count.index)}"

	user_data = <<-EOF
					#! /bin/bash
					sudo yum update
					sudo yum install -y httpd
					sudo chkconfig httpd on
					sudo service httpd start
					echo "<h1>Deployed via Terraform wih ELB - ${var.instance_name}-$HOSTNAME</h1>" | sudo tee /var/www/html/index.html
				EOF
	
	#user_data = "${file("install_httpd.sh")}"

    tags = {
	  Name = "${var.instance_name}-${count.index}"
	}
}