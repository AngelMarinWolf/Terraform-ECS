# Application Load Balancer - Rules
Through this module you could add Backend and Frontend rules in any ALB listener for routing the request based on the `PATH` or the `Host`.

### Variables

| Variable     | Type         | Required     | Description  |
| ------------ | :----------: | :----------: | ------------ |
| listener_arn | String | Yes | The ARN from the listener inside of the ALB in which will be added the routing rules. |
| priority_rules | String | Yes | This is an arbitrary value in order to specify the priority of the rules in the case that you have to add multiples rule groups in the same listener. |
| target_group_backend_arn | String | Yes | This variable is the target ARN in order to forward the matches at this Backend point. |
| target_group_frontend_arn | String | Yes | This variable is the target ARN in order to forward the matches at this Frontend point. |
| load_balancer_rules_back | Map | No | You have to specify which rules will be added in the LoadBalancer. |
| load_balancer_rules_front | Map | No | You have to specify which rules will be added in the LoadBalancer. |
