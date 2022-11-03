output "instance_id" {
  description = "ARN of the bucket"
  value       = aws_instance.confluence.arn
}

output "aws_iam_role" {
  value = "${aws_iam_role.confluence_ssm_role.arn}"
}