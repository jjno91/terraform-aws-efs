resource "aws_efs_file_system" "this" {
  encrypted                       = true
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  tags                            = { Name = var.name }
}

resource "aws_backup_vault" "this" {
  name = "${var.name}-ecs-linux"
}

resource "aws_backup_plan" "this" {
  name = "${var.name}-"

  rule {
    rule_name         = "main"
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule

    lifecycle {
      cold_storage_after = var.cold_storage_after
      delete_after       = var.delete_after
    }
  }
}

resource "aws_backup_selection" "this" {
  name         = "main"
  iam_role_arn = aws_iam_role.this.arn
  plan_id      = aws_backup_plan.this.id
  resources    = [aws_efs_file_system.this.arn]
}

resource "aws_iam_role" "this" {
  name_prefix        = "${var.name}-efs-backup-"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.this.name
}
