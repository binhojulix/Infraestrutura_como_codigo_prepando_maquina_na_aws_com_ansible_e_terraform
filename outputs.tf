output "ips" {
  value = "${aws_instance.dev.public_ip}"
   description = "The public IP address of the web server" 
}