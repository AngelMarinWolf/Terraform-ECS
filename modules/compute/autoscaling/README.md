# Auto Scaling
The Autoscaling Module will register a Launch Configuration, IAM Roles and the SSH Key after create the Auto Scaling Group.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name       | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment        | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| aws_region         | String | No  | Describe the Amazon region in which you will work. |
| server_ami         | Map    | No  | It is a map with a list of AMIs used for each region, minimum is Required one for you region. |
| subnet_ids         | List   | Yes | The list of all the subnets in which can be launched the New EC2 Instances. |
| security_groups    | List   | Yes | This variable receive a list with the security groups that will be attached. |
| user_data          | String | Yes | This variable receive the user-data script that will be executed at the launch time. |
| desired_capacity   | String | Yes | The number of instances to start the Autoscaling. |
| max_size           | String | Yes | The max number of instances to scale the Autoscaling. |
| min_size           | String | Yes | The min number of instances to scale the Autoscaling. |
| instance_type      | String | Yes | Define the tier level or class of the EC2 Instances. |
| availability_zones | List   | Yes | Define the availability zone of your preference. |
| public_key         | String | Yes | Public SSH Key, this key will be used to access in the server. |




### Output

| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| autoscaling_id             | String | Returns the ID of the Auto Scaling Group created. |
| autoscaling_arn            | String | Returns the ARN of the Auto Scaling Group created. |
| autoscaling_name           | String | Returns the Name of the Auto Scaling Group created. |
| autoscaling_lc             | String | Returns the Name of the Launch Configuration used to configure the Autoscaling Group. |
| autoscaling_lbs            | List   | Returns a List with the IDs of the Load Balancers assigned for the Autoscaling Group. |
| launch_configuration_id    | String | Returns the ID of the Launch Configuration created. |
| launch_configuration_name  | String | Returns the ID of the Launch Configuration created. |
