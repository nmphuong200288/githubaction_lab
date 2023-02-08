provider "aws" {

  access_key = "AKIA4FGBKUXBGE5QCUNG"

  secret_key = "6Hviii4DtqKzAS6tml6oyqHkklq5dHm+rwOHS3xl"

  region     = "ap-southeast-2"
}


# Create a bucket
resource "aws_s3_bucket" "example" {

  bucket = "gh-js1"

  tags = {

    Name        = "My bucket"

    Environment = "Dev"

  }

}
#Block bucket outside public
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

/*resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}*/

/*resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.example.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::gh-js/*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF

}*/

# Upload an object
resource "aws_s3_object" "object" {

  for_each = fileset("C:\\Users\\MJ\\Desktop\\TerraformLab", "**")
  bucket = aws_s3_bucket.example.id
  key    = each.value
  source = "C:\\Users\\MJ\\Desktop\\TerraformLab/${each.value}"
  #etag = filemd5("C:\\Users\\MJ\\Desktop\\TerraformLab\\var.tf")

}

