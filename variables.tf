variable "hosted_zone_name" {
  description = "The name of the desired Hosted Zone"
}

variable "subdomain_names" {
  description = "The names of the sub-domains for the new Route53 Record"
  type        = list(string)
}
