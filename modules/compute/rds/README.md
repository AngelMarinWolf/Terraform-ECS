# Regional Database - RDS
This module will create RDS as well as custom parameter groups and subnet groups for each environment.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name            | String  | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment             | String  | Yes | A logical name that will be used as prefix and tag for the created resources. |
| subnet_ids              | List    | Yes | The list of all the subnets in which can be launched the RDS. |
| engine                  | String  | No  | Select the engine for the Database [mysql, aurora-mysql]. |
| engine_family           | Map     | No  | If you want to use a custom family for the Database Engines, set a map for the options. |
| storage                 | String  | No  | This variable define the Storage allocated for the RDS instance. |
| instance_tier           | String  | No  | This variable define the type of instance that will be launched. |
| db_username             | String  | No  | Master username for the RDS instance. |
| db_password             | String  | Yes | Master password for the RDS instance. |
| vpc_security_group_ids  | List    | Yes | This variable receive a list with the security groups that will be attached. |
| apply_immediately       | Boolean | No  | Define the method to be used on for the changes [immediately could cause downtime for several minutes]. |
| multi_az                | Boolean | No  | Multi-AZ option could include extra charges. |
| availability_zone       | String  | Yes | Define the availability zone of your preference. |
| final_snapshot          | Boolean | No  | Option for skip the final final_snapshot. |
| retention               | String  | No  | Define the number of days for Backup retention. |




### Output

| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| subnet_group_id      | String | Get the ID of for the Subnet Group. |
| parameter_group_id   | String | Get the ID of for the Parameter Group. |
| subnet_group_arn     | String | Get the ARN of for the Subnet Group. |
| parameter_group_arn  | String | Get the ARN of for the Parameter Group. |
| instance_id          | String | Get the ID of for the RDS instance. |
| endpoint             | String | Get the Endpoint of for the RDS instance. |
| status               | String | Get the Status of for the RDS instance. |
