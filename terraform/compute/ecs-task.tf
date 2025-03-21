resource "aws_ecs_task_definition" "zsoftly_task" {
  family                   = "zsoftly-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "zsoftly-container"
      image = "253490765215.dkr.ecr.us-east-1.amazonaws.com/zsoftly-app:latest"
      cpu   = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/zsoftly-task"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

