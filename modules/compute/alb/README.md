# Application Load Balancer - ALB
This module will create an Application Load Balancer and will attach an HTTP listener by default if you add the `ssl_certificate_arn` automatically will create and attach the HTTPS listener, of this variables is not defined this listener won't be created.


### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| public_subnets | List | Yes | The list of all the subnets in wich can be launched the RDS. |
| security_groups | List | Yes | This variable receive a list with the security groups that will be attached. |
| vpc_id | String | Yes | Define in which VPC will be created the SG. |
| target_group_frontend_arn | String | Yes | Define the default target group to send traffic. |
| ssl_certificate_arn | String | No | If you add this variable another linstener will be created using the protocol HTTPS with this certificate. |

### Output
| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| alb_id | String | Returns the ID from the Application Load Balancer. |
| alb_arn | String | Returns the ARN from the Application Load Balancer. |
| alb_listener_id | String | Returns the ID from the HTTP listener attached in the ALB. |
| alb_listener_arn | String | Returns the ARN from the HTTP listener attached in the ALB. |
| alb_listener_ssl_id | String | Returns the ID from the HTTPS listener attached in the ALB. (optional) |
| alb_listener_ssl_arn | String | Returns the ARN from the HTTPS listener attached in the ALB. (optional) |
