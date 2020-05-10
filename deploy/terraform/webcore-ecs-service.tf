data "template_file" "webcore_app" {
  template = file("./templates/webcore_app.json.tpl")

  vars = {
    app_image = var.webcore_image
    app_port = var.app_port
    fargate_cpu = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region = var.aws_region
    prefix = var.prefix
    container_name = var.webcore_container_name
  }
}


resource "aws_ecs_task_definition" "webcore_task_def" {
  family = "webcore-task"
  execution_role_arn = aws_iam_role.webcore_ecs_task_execution_role.arn
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE"]
  cpu = var.fargate_cpu
  memory = var.fargate_memory
  container_definitions = data.template_file.webcore_app.rendered
}


resource "aws_ecs_service" "webcore_main" {
  name = "webcore-service"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.webcore_task_def.arn
  desired_count = var.app_count
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [
      aws_security_group.ecs_tasks.id]
    subnets = [
      data.aws_subnet.public_1a.id,
      data.aws_subnet.public_1b.id,
      data.aws_subnet.public_1c.id
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.webcore_target.id
    container_name = var.webcore_container_name
    container_port = var.app_port
  }

  depends_on = [
    aws_alb_listener.front_end_webcore,
    aws_iam_role_policy_attachment.webcore_task_execution_role]
}
