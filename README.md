# Terraform-s3
This repo could be used to s3 bucket on aws cloud.
1) install latest version of terraform.
2) clone the repo git clone https://github.com/Venuvgp19/Terraform-s3.git
3) have terraform.tfvars created manually with your secret cloud credentials 
Commands 
  - cd Terraform-s3
  - terraform validate 
 
(venu) [root@xxxxx Terraform-s3]# terraform validate
Success! The configuration is valid.
(venu) [root@xxxxx Terraform-s3]#
  - terrafrom init
 (venu) [root@xxxxx Terraform-s3]# terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v3.65.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
(venu) [root@xxxxx Terraform-s3]#

  - terraform plan 
  - terrafrom apply 
