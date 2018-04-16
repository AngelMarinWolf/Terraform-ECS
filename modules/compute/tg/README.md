# Target Groups
The Target Group Module creates targets for Frontend and Backend and configure the health checks.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| project_name       | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| environment        | String | Yes | A logical name that will be used as prefix and tag for the created resources. |
| vpc_id             | String | Yes | Define in which VPC will be created the TG. |

### Output

| Output       | Type         |  Description  |
| ------------ | :----------: |  ------------ |
| alb_tg_be_id   | String | Application Load Balancer - Target Group - Frontend - ID |
| alb_tg_be_arn  | String | Application Load Balancer - Target Group - Frontend - ARN |
| alb_tg_fe_id   | String | Application Load Balancer - Target Group - Backend - ID |
| alb_tg_fe_arn  | String | Application Load Balancer - Target Group - Backend - ARN |
