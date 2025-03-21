provider "aws" {
  region = "YOUR_AWS_REGION"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_ecs_cluster" "zsoftly_cluster" {
  name = "zsoftly-cluster"
}

resource "aws_ecs_task_definition" "zsoftly_task" {
  family                   = "zsoftly-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([{
    name      = "zsoftly-container"
    image     = "YOUR_AWS_ACCOUNT_ID.dkr.ecr.YOUR_AWS_REGION.amazonaws.com/zsoftly-web-app:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_service" "zsoftly_service" {
  name            = "zsoftly-service"
  cluster         = aws_ecs_cluster.zsoftly_cluster.id
  task_definition = aws_ecs_task_definition.zsoftly_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet1.id]
    assign_public_ip = true
  }
}
