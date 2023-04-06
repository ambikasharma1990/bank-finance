resource "aws_instance" "prod-server" {
  ami           = "ami-00c39f71452c08778" 
  instance_type = "t2.micro"
  key_name = "project2"
  vpc_security_group_ids= ["sg-0d164277c163559c2"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./project2.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "prod-server"
  }
 provisioner "local-exec" {

        command = " echo ${aws_instance.prod-server.public_ip} > inventory "
 }
 
 provisioner "local-exec" {
 command = "ansible-playbook /var/lib/jenkins/workspace/project-02-banking/prod-server/prod-bank-playbook.yml "
  } 
}

output "prod-server_public_ip" {

  value = aws_instance.prod-server.public_ip
  
}