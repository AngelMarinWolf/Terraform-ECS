# Virtual Private Network - Instance
The Target Group Module creates targets for Frontend and Backend and configure the health checks.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name      | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment       | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| aws_region        | String | Yes | Select your Amazon Region. |
| server_ami        | Map    | Yes | Define a group of possibles AMIs for the VPN server. |
| public_key        | String | Yes | Public SSH Key, this key will be used to access in the server. |
| availability_zone | String | Yes | Define the availability zone of your preference. |
| subnet_id         | String | Yes | The list of all the subnets in which can be launched the RDS. |
| security_groups   | List   | Yes | This variable receive a list with the security groups that will be attached. |
