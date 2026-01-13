variable "TAG" {
  default = "snapshot"
}

variable "REGISTRY" {
  default = "mjarvy"
}

variable "REGISTRY_PREFIX" {
    default = "scoring-engine"
}

variable "HTTP_PROXY" {
  default = ""
}

variable "HTTPS_PROXY" {
  default = ""
}

variable "NO_PROXY" {
  default = ""
}

target "base-base" {
    dockerfile = "./docker/base/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-base:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-base:latest"
    ]
}

target "bootstrap-base" {
    dockerfile = "./docker/bootstrap/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-bootstrap:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-bootstrap:latest"
    ]
}

target "engine-base" {
    dockerfile = "./docker/engine/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-engine:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-engine:latest"
    ]
}

target "nginx-base" {
    dockerfile = "./docker/nginx/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-nginx:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-nginx:latest"
    ]
}

target "web-base" {
    dockerfile = "./docker/web/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-web:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-web:latest"
    ]
}

target "worker-base" {
    dockerfile = "./docker/worker/Dockerfile"
    context = "."
    args = {
        HTTP_PROXY = "${HTTP_PROXY}"
        HTTPS_PROXY = "${HTTPS_PROXY}"
        NO_PROXY = "${NO_PROXY}"
    }
    tags = [
        "${REGISTRY}/${REGISTRY_PREFIX}-worker:${TAG}",
        "${REGISTRY}/${REGISTRY_PREFIX}-worker:latest"
    ]
}

target "base-local" {
    inherits = ["base-base"]
    output = ["type=docker"]
}

target "bootstrap-local" {
    inherits = ["bootstrap-base"]
    output = ["type=docker"]
}

target "engine-local" {
    inherits = ["engine-base"]
    output = ["type=docker"]
}

target "nginx-local" {
    inherits = ["nginx-base"]
    output = ["type=docker"]
}

target "web-local" {
    inherits = ["web-base"]
    output = ["type=docker"]
}

target "worker-local" {
    inherits = ["worker-base"]
    output = ["type=docker"]
}

target "base-release" {
    inherits = ["base-base"]
    output = ["type=registry"]
}

target "bootstrap-release" {
    inherits = ["bootstrap-base"]
    output = ["type=registry"]
}

target "engine-release" {
    inherits = ["engine-base"]
    output = ["type=registry"]
}

target "nginx-release" {
    inherits = ["nginx-base"]
    output = ["type=registry"]
}

target "web-release" {
    inherits = ["web-base"]
    output = ["type=registry"]
}

target "worker-release" {
    inherits = ["worker-base"]
    output = ["type=registry"]
}

group "local" {
    targets = [ "base-local", "bootstrap-local", "engine-local", "nginx-local", "web-local", "worker-local" ]
}

group "release" {
    targets = [ "base-release", "bootstrap-release", "engine-local", "nginx-release", "web-release", "worker-release" ]
}