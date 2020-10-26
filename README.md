# aws_vpc_terraform
AWS VPC with Terraform

HOW TO RUN:
------------

--> clone this repo

--> create terraform workspace before run scripts
 
    Ex: terraform workspace new prod
    
--> Now create provider file with your region and credentials details

--> Run below commands one by one

    Ex: terraform init
        terraform apply --auto-approve
        
--> This will create VPC in your provided region

--> To destroy 

    Ex: terraform destroy --auto-approve

Git Module
-----------

--> you can create VPC using git_module file as well. 

--> All you have to do is clone the repo

--> update main.tf file with your credentials and region

--> create workspace like above

--> Then run init and apply commands one by one.

Note: If you want to save money, destroy resource once you tested VPC connections properly.
-----
