
# awesome-envvars

An end-to-end example of using AWS stored key-value pairs as docker environment variables and consuming them in applications therein.

## Pre-requisites

**Note**: If running locally, you can skip these steps and jump to "Usage"

Create your AWS resources:

- A Secrets Manager secret, EG: `your/aws/secret/id`
- A role for the ECS task (Or use the default AWS ECS role)
- IAM policy granting the ECS task role permission to decrypt the secret (_This is important!_)
- Resource policy granting ECS permission to create CloudWatch events (If using custom ECS roles)
- A task definition, with container definitions as specified in "Usage", mapping the id of the secret you created to the `env` environment variable

## Usage

1. Implement the secrets/parameters and relevant IAM policies in "Pre-requisites"
2. Choose a method from "Image options" below to run the image
3. Either:
   - View the console log output to see the vars at the O/S level
   - View the web app output on http/80 to see them passed to nginx/php
4. Profit!

### Image options

Build and run it locally (Mapping port 8080 on the host to 80 in the container):
```shell
$ git clone https://github.com/davidsuart/awesome-envvars.git
$ docker build --no-cache --tag awesome-envvars github.com/davidsuart/awesome-envvars
$ docker run --env-file=env_file --publish 8080:80 awesome-envvars env
```

AWS Fargate it (Including these parameters within your task definition):
```json
container_definitions = [
  {
    "image":             "davidsuart/awesome-envvars:latest",
    "portMappings":      [{ "containerPort": 80, "hostPort": null, "protocol": "tcp" }],
    "logConfiguration":  { "logDriver": "awslogs" },
    "secrets":           [{ "name": "env", "valueFrom": "<your/aws/secret/id>" }]
  }
]
```

## Troubleshooting

- If you are not using AWS defaults for ECS task role and task execution role, ensure that your roles have the appropriate privilege assignments to run tasks, access secrets and write to cloudwatch logs
- Ensure that the subnet you place the ECS cluster/service in has internet access so it can download the image
- Ensure that the security group you assign to the task permits traffic to/from it to access the web application

## Contributing

Spotted an error? Something functional to add value? Send me a pull request!

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/foo`)
3. Commit your changes (`git commit -am 'Add some foo'`)
4. Push to the branch (`git push origin feature/foo`)
5. Create a new Pull Request

## License

MIT license. See [LICENSE](LICENSE) for full details.
