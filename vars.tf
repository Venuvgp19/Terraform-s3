variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "ap-south-1"
}
variable "prefix" {
    description = "Add prefix for naming your bucket"
}
variable "userids" {
    description = "List of 12 Digit Account IDs to share bucket with ex - ["123456789012"]
    type = list(string)
}
variable "log-bucket-id" {
    description = "Logs of your bucket goes here"
}
