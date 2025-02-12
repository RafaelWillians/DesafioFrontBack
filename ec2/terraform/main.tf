resource "aws_instance" "InstanciaTeste" {
    count = 2
    ami = "ami-0c614dee691cbbf37"
    instance_type = "t2.micro"

    tags = {
        Name = "demo-${count.index}"
    }
}