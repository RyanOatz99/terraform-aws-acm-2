# Terraform AWS ACM

Terraform module which creates ACM certificates and validates them using Route53 DNS.

- see https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html
- see https://aws.amazon.com/certificate-manager/pricing/

## Usage

```hcl
module "aws_acm" {
  source  = "button-inc/acm/aws"
  hosted_zone_name = "example.com."
  subdomain_names   = ["sub1", "sub2"]
}
```

## Authors

Module is maintained by [Junmin Ahn](https://github.com/junminahn).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/LICENSE) for full details.
