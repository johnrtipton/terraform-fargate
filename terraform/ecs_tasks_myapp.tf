# -- PROD --
data "template_file" "myapp" {
  template = "${file("templates/ecs/myapp.json.tpl")}"
  vars {
    REPOSITORY_URL = "${var.ECR_REPO_URL}"
    AWS_REGION = "${var.AWS_REGION}"
    LOGS_GROUP = "${aws_cloudwatch_log_group.myapp.name}"
  }
}

data "aws_ecs_task_definition" "myapp" {
  task_definition = "${aws_ecs_task_definition.myapp.family}"
}

resource "aws_ecs_task_definition" "myapp" {
  family                = "myapp"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.myapp.rendered}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
}

resource "aws_ecs_service" "myapp" {
  name            = "myapp"
  cluster         = "${aws_ecs_cluster.fargate.id}"
  launch_type     = "FARGATE"
  # task_definition = "${aws_ecs_task_definition.myapp.arn}"
  task_definition = "${replace(aws_ecs_task_definition.myapp.arn, "/:\\d*$/", "")}:${max("${aws_ecs_task_definition.myapp.revision}", "${data.aws_ecs_task_definition.myapp.revision}")}"

  desired_count   = 2

  network_configuration = {
    subnets = ["${module.base_vpc.private_subnets}"]
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.myapp.arn}"
   container_name = "myapp"
   container_port = 5000
  }

  depends_on = [
    "aws_alb_listener.myapp"
  ]
}

# -- DEV --
data "template_file" "myapp_dev" {
  template = "${file("templates/ecs/myapp_dev.json.tpl")}"
  vars {
    REPOSITORY_URL = "${var.ECR_REPO_URL}"
    AWS_REGION = "${var.AWS_REGION}"
    LOGS_GROUP = "${aws_cloudwatch_log_group.myapp_dev.name}"
  }
}

data "aws_ecs_task_definition" "myapp_dev" {
  task_definition = "${aws_ecs_task_definition.myapp_dev.family}"
}

resource "aws_ecs_task_definition" "myapp_dev" {
  family                = "myapp_dev"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.myapp_dev.rendered}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
}

resource "aws_ecs_service" "myapp_dev" {
  name            = "myapp_dev"
  cluster         = "${aws_ecs_cluster.fargate.id}"
  launch_type     = "FARGATE"
  # task_definition = "${aws_ecs_task_definition.myapp.arn}"
  task_definition = "${replace(aws_ecs_task_definition.myapp_dev.arn, "/:\\d*$/", "")}:${max("${aws_ecs_task_definition.myapp_dev.revision}", "${data.aws_ecs_task_definition.myapp_dev.revision}")}"

  desired_count   = 1

  network_configuration = {
    subnets = ["${module.base_vpc.private_subnets}"]
    security_groups = ["${aws_security_group.ecs.id}"]
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.myapp_dev.arn}"
   container_name = "myapp_dev"
   container_port = 5000
  }

  depends_on = [
    "aws_alb_listener.myapp_dev"
  ]
}
