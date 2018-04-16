# Security Groups
In this module are specified the rules for the basic SG in the infrastructure. 

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name       | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment        | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| vpc_id             | String | Yes | Define in which VPC will be created the SG. |
| public_ip          | List   | Yes | The IP of your Office. |

### Output

| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| sg_alb_id    | String | Returns the ID of the ELB's Security Group. |
| sg_ec2_id    | String | Returns the ID of the EC2's Security Group. |
| sg_rds_id    | String | Returns the ID of the RDS's Security Group. |
| sg_vpn_id    | String | Returns the ID of the VPN's Security Group. |
