; Tiltfile syntax highlighting for Zed
; Extends Python syntax with Tilt-specific functions and keywords

; Inherit from Python
; @inherits python

; Tilt-specific built-in functions - match function calls
(call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm|kustomize|port_forward|dc_resource|local|read_file|blob|fail|warn|watch_file|helm_resource|docker_build_with_restart)$"))

; Tilt configuration functions - match dotted function calls
(call
  function: (attribute
    object: (identifier) @_config
    attribute: (identifier) @function.builtin)
  (#eq? @_config "config")
  (#match? @function.builtin "^(define_string|define_bool|define_string_list|parse)$"))

; Load statement - highlight as import keyword
(call
  function: (identifier) @keyword.import
  (#eq? @keyword.import "load"))

; Tilt-specific keywords in function arguments
(keyword_argument
  name: (identifier) @keyword
  (#match? @keyword "^(live_update|sync|run|restart_container|fall_back_on|context|dockerfile|target|deps|resource_deps|port_forwards|flags|namespace|trigger|cmd)$"))

; Highlight Tilt-specific string patterns
; Docker image names (registry/image:tag format)
(string
  (string_content) @string.special
  (#match? @string.special "^[a-zA-Z0-9][a-zA-Z0-9/_.-]*:[a-zA-Z0-9._-]+$"))

; YAML/Kubernetes manifest file paths
(string
  (string_content) @string.special
  (#match? @string.special "\\.(ya?ml|json)$"))

; Dockerfile paths
(string
  (string_content) @string.special
  (#match? @string.special "(D|d)ockerfile"))

; Port forwarding specifications (8080:8080 format)
(string
  (string_content) @number
  (#match? @number "^[0-9]+:[0-9]+$"))

; Kubernetes resource paths
(string
  (string_content) @string.special
  (#match? @string.special "^(k8s|kubernetes)/"))

; Helm chart references
(string
  (string_content) @string.special
  (#match? @string.special "^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$"))

; Environment variable references
(string
  (string_content) @variable
  (#match? @variable "\\$\\{[A-Z_][A-Z0-9_]*\\}"))
