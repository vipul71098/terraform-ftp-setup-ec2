resource "aws_instance" "ec2_example" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    tags = {
        Name = "Terraform EC2"
    }

user_data = <<EOF
   sudo apt update
   sudo apt install vsftpd
   sudo cp vsftpd.conf /etc/
   sudo systemctl restart vsftpd
   sudo ufw allow 20:21/tcp
   sudo ufw allow 30000:31000/tcp
   sudo ufw disable
   sudo ufw enable
   sudo adduser newftpuser
   echo "newftpuser" | sudo tee -a /etc/vsftpd.user_list
   sudo mkdir -p /home/newftpuser/ftp/upload
   sudo chmod 550 /home/newftpuser/ftp
   sudo chmod 750 /home/newftpuser/ftp/upload
   sudo chown -R newftpuser: /home/newftpuser/ftp
   chmod a-w /home/newftpuser
   echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf && systemctl restart vsftpd

 EOF
}




