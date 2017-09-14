job "helloworld" {
  datacenters = ["dc1"]
  type = "service"

  update {
    stagger = "10s"
    max_parallel = 1
    canary = 2
  }
  group "hello-group" {
    count = 2
    task "hello-task" {
      driver = "exec"
      vault {
        policies = ["secret"]
      }
      config {
        command = "/usr/bin/python"
        args = ["/usr/local/bin/app.py", "v1"]
      }
      resources {
        cpu = 100
        memory = 200
        network {
          mbits = 1
          port "http" {}
        }
      }
      service {
        name = "helloworld"
        port = "http"
        check {
          type = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
          port = "http"
        }
      }
    }
  }
}
