# variables.tf

variable "prefix" {
  description = "Prefix for all envirnoments"
  default     = "webcore"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ap-southeast-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "WebCoreEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "3"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

####  Define ECR Location Path
variable "webcore_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "XXXXXXXXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/test-app-repo:1.0.0"
}

#  Make sure Health Check Path
variable "webcore_health_check_path" {
  default = "/index"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "webcore_container_name" {
  description = "Ops Reader container name"
  default     = "test-app"
}
