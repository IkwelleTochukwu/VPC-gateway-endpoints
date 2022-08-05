resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.aws_s3_bucket
  tags   = local.tags

}

resource "aws_s3_bucket_versioning" "s3-versioning" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow-access-to-bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = <<POLICY
{    
    "Version": "2012-10-17",    
    "Statement": [        
      {                       
          "Effect": "Allow",            
          "Principal": "*",            
          "Action": "*",      
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"            
          ]        
      }    
    ]
}
POLICY
}

