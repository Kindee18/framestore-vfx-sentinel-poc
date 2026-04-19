provider "aws" {
  region = "eu-west-1" # London (Framestore HQ)
}

# 🎬 VFX Render Node Infrastructure
resource "aws_eks_cluster" "render_cluster" {
  name     = "vfx-render-pipeline-eks"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = ["subnet-12345678", "subnet-87654321"]
  }
}

# 📂 High-Performance Asset Storage
resource "aws_s3_bucket" "vfx_assets" {
  bucket = "framestore-vfx-render-assets-demo"
}

resource "aws_s3_bucket_lifecycle_configuration" "asset_cleanup" {
  bucket = aws_s3_bucket.vfx_assets.id

  rule {
    id      = "cleanup-tmp-renders"
    status  = "Enabled"
    expiration {
      days = 7 # Automatically clear temporary render frames
    }
  }
}

# 📊 VFX Observability: Render Node Health Alarm
resource "aws_cloudwatch_metric_alarm" "render_node_failure" {
  alarm_name          = "vfx-render-node-stalled"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "VFX Alert: Render node is stalled or failed to report health."
}

# IAM Role for EKS
resource "aws_iam_role" "eks_role" {
  name = "framestore_eks_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}
