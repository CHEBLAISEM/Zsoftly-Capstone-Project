resource "aws_ecs_service" "zsoftly_service" {
  name            = "zsoftly-service"
  cluster         = aws_ecs_cluster.zsoftly_cluster.id
  task_definition = aws_ecs_task_definition.zsoftly_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.public_subnet.id]
    security_groups = [aws_security_group.web_sg.id]
    assign_public_ip = true
  }
  
  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:253490765215:targetgroup/zsoftly-target-group/d3a3296ec245e345"
    container_name   = "zsoftly-container"
    container_port   = 80
  }
}
