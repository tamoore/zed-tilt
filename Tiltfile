# Example Tiltfile for testing the Zed extension
# This demonstrates common Tilt patterns and syntax

# Load external Starlark modules
load("ext://helm_resource", "helm_resource")
load("ext://restart_process", "docker_build_with_restart")

# Configuration
config.define_string("namespace", args = True, default = "default")
config.define_bool("debug", args = True, default = False)
config.define_string_list("services", args = True, default = ["api", "web"])

cfg = config.parse()

# Docker builds
docker_build(
    "myapp/api",
    context = "./api",
    dockerfile = "./api/Dockerfile",
    live_update = [
        sync("./api/src", "/app/src"),
        run("pip install -r requirements.txt", trigger = "./api/requirements.txt"),
    ],
)

docker_build(
    "myapp/web",
    context = "./web",
    dockerfile = "./web/Dockerfile.dev" if cfg.get("debug") else "./web/Dockerfile",
    target = "development" if cfg.get("debug") else "production",
)

# Kubernetes resources
k8s_yaml([
    "k8s/namespace.yaml",
    "k8s/configmap.yaml",
    "k8s/deployment.yaml",
    "k8s/service.yaml",
])

# Helm charts
helm_resource(
    "postgres",
    chart = "bitnami/postgresql",
    flags = ["--set", "auth.postgresPassword=password"],
    namespace = cfg.get("namespace"),
)

# Kustomize
k8s_yaml(kustomize("./k8s/overlays/dev"))

# Resource configuration
k8s_resource(
    "api-deployment",
    port_forwards = "8080:8080",
    resource_deps = ["postgres"],
)

k8s_resource(
    "web-deployment",
    port_forwards = "3000:3000",
    resource_deps = ["api-deployment"],
)

# Local resources
local_resource(
    "api-test",
    cmd = "cd api && python -m pytest",
    deps = ["./api/src", "./api/tests"],
    resource_deps = ["api-deployment"],
)

local_resource(
    "db-migrate",
    cmd = "cd api && python manage.py migrate",
    resource_deps = ["postgres"],
)

local_resource(
    "db-seed",
    cmd = "cd api && python manage.py seed",
    resource_deps = ["postgres"],
)

# Conditional resources based on config
if "monitoring" in cfg.get("services"):
    k8s_yaml("k8s/monitoring.yaml")
    k8s_resource("prometheus", port_forwards = "9090:9090")

# File watching and custom commands
watch_file("./docker-compose.yml")
local('echo "Tiltfile reloaded at $(date)"')

# Custom functions
def build_service(name, port):
    """Build and configure a microservice"""
    docker_build("myapp/{}".format(name), context = "./{}".format(name))
    k8s_yaml("k8s/{}.yaml".format(name))
    k8s_resource("{}-deployment".format(name), port_forwards = "{}:{}".format(port, port))

# Use the custom function
for service in cfg.get("services"):
    if service == "api":
        build_service("api", 8080)
    elif service == "web":
        build_service("web", 3000)

# Environment-specific configuration
if os.getenv("TILT_ENV") == "prod":
    fail("This Tiltfile is not intended for production use")

# Print configuration
print("Tilt configuration:")
print("  Namespace: {}".format(cfg.get("namespace")))
print("  Debug mode: {}".format(cfg.get("debug")))
print("  Services: {}".format(cfg.get("services")))

k8s_resource("web-deployment", port_forwards = "3000:3000", resource_deps = ["api-deployment"])
