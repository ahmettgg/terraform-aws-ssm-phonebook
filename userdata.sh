#! /bin/bash
dnf update -y
dnf install pip -y
pip3 install flask==2.3.3
pip3 install flask_mysql
dnf install git -y
TOKEN=${user-data-git-token}
USER=${user-data-git-name}
cd /home/ec2-user && git clone https://$TOKEN@github.com/$USER/terraform-aws-ssm-phonebook.git
export MYSQL_DATABASE_HOST=${db-endpoint}
python3 /home/ec2-user/terraform-aws-ssm-phonebook/phonebook-app.py