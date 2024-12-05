variable "env_name" {
  type        = string
  default     = null
  description = "Environment name"
}

variable "subnets" {
  type        = list(object({
                  zone = string
                  cidr = string
                }))
  description = "Information about multiple subnets"
}
