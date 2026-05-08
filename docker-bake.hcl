# Docker Bake configuration for Kali Linux images
# Supports multi-platform builds with SBOM and provenance generation

group "default" {
  targets = ["base", "systemd"]
}

# Sequential build group to ensure proper layering
group "sequential" {
  targets = ["base"]
}

group "dependent" {
  targets = ["systemd"]
}

# Common configuration for all targets
variable "TAG" {
  default = "latest"
}

variable "REGISTRY" {
  default = "gwokfun"
}

# Base Kali Linux image with essential penetration testing tools
target "base" {
  dockerfile = "Dockerfile"
  target = "base"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${REGISTRY}/kali-linux:latest"
  ]
  
  # Security and compliance features - use stable SBOM scanner
  attest = [
    "type=provenance,mode=max",
    "type=sbom,scanner=docker.io/docker/buildkit-syft-scanner:stable-1"
  ]
  
  # Build metadata
  labels = {
    "org.opencontainers.image.title" = "Kali Linux Penetration Testing Image with HexStrike AI"
    "org.opencontainers.image.description" = "AI-ready Kali Linux container with 200+ curated CLI penetration testing tools and HexStrike AI server"
    "org.opencontainers.image.url" = "https://hub.docker.com/r/gwokfun/kali-linux"
    "org.opencontainers.image.documentation" = "https://github.com/gwokfun/kali-linux-image/blob/master/README.md"
    "org.opencontainers.image.source" = "https://github.com/gwokfun/kali-linux-image"
    "org.opencontainers.image.vendor" = "gwokfun"
    "org.opencontainers.image.licenses" = "MIT"
    "org.opencontainers.image.version" = "${TAG}"
    "com.gwokfun.dockerfile.url" = "https://raw.githubusercontent.com/gwokfun/kali-linux-image/master/Dockerfile"
    "com.gwokfun.license.url" = "https://raw.githubusercontent.com/gwokfun/kali-linux-image/master/LICENSE"
  }
}

# Systemd-enabled Kali Linux image with service management support
target "systemd" {
  dockerfile = "Dockerfile"
  target = "systemd"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${REGISTRY}/kali-linux:systemd",
  ]
  
  # Build dependencies - reuse base layers
  contexts = {
    base = "target:base"
  }
  
  # Security and compliance features - use stable SBOM scanner
  attest = [
    "type=provenance,mode=max",
    "type=sbom,scanner=docker.io/docker/buildkit-syft-scanner:stable-1"
  ]
  
  # Build metadata
  labels = {
    "org.opencontainers.image.title" = "Kali Linux Penetration Testing Image with HexStrike AI (Systemd)"
    "org.opencontainers.image.description" = "AI-ready Kali Linux container with systemctl support, 200+ penetration testing tools and HexStrike AI server"
    "org.opencontainers.image.url" = "https://hub.docker.com/r/gwokfun/kali-linux"
    "org.opencontainers.image.documentation" = "https://github.com/gwokfun/kali-linux-image/blob/master/README.md"
    "org.opencontainers.image.source" = "https://github.com/gwokfun/kali-linux-image"
    "org.opencontainers.image.vendor" = "gwokfun"
    "org.opencontainers.image.licenses" = "MIT"
    "org.opencontainers.image.version" = "${TAG}"
    "com.gwokfun.dockerfile.url" = "https://raw.githubusercontent.com/gwokfun/kali-linux-image/master/Dockerfile"
    "com.gwokfun.license.url" = "https://raw.githubusercontent.com/gwokfun/kali-linux-image/master/LICENSE"
  }
}
