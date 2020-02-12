resource "aws_api_gateway_rest_api" "apigateway_email_app" {
  name        = var.api_gateway
  description = "api gateway exposed for lambda email app."
}
