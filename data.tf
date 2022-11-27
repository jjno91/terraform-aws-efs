data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["backup.amazonaws.com"]
      type        = "Service"
    }
  }
}
