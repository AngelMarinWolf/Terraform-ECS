# Virtual Private Cloud - VPC
One of the most important modules, inside of this module is defined the way to build a VPC with Public and Private Subnets, Routing tables and Gateways.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name         | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment          | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| aws_region           | String | Yes | Select your Amazon Region. |
| vpc_cidr             | String | Yes | The CDIR block used for the VPC. |
| availability_zones   | Map    | No  | Define which and how many zones will be launched. |

### Output

| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| vpc_id                   | String | The id of the VPC. |
| vpc_cidr                 | String | The CDIR block used for the VPC. |
| public_subnets           | List   | A list of the public subnets. |
| private_subnets          | List   | A list of the private subnets. |
| public_routing_table_id  | String | The id of the public routing table. |
| private_routing_table_id | List   | A list of the private routing tables. |
| availability_zones       | List   | List of the availability zones. |
