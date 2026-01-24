project_name = "uniforum"
env          = "qa"

docker_images = {
  identity      = "andyxalarcon/identity-service:qa"
  user          = "andyxalarcon/user-service:qa"
  forum         = "andyxalarcon/forum-service:qa"
  post          = "andyxalarcon/post-service:qa"
  reply         = "andyxalarcon/reply-service:qa"
  academic      = "andyxalarcon/academic-structure-service:qa"
  reaction      = "andyxalarcon/reaction-service:qa"
  search        = "andyxalarcon/search-service:qa"
  notification  = "andyxalarcon/notification-service:qa"
  moderation    = "andyxalarcon/moderation-audit-service:qa"
}
