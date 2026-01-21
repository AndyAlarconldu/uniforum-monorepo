resource "aws_lb_listener_rule" "identity" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.identity.arn
  }

  condition {
    path_pattern {
      values = ["/docs*", "/identity*"]
    }
  }
}
