; Tiltfile syntax highlighting - inherits from Starlark grammar
; Tiltfiles are Starlark files with additional built-in functions

; Inherit all highlighting from Starlark grammar
; This provides proper Python-like syntax highlighting

; Tilt-specific built-in functions
(call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm|kustomize|port_forward|local|read_file|blob|fail|warn|watch_file|helm_resource|config)$"))

; Load statement (Starlark import mechanism)
(call
  function: (identifier) @keyword.import
  (#eq? @keyword.import "load"))

; String literals that look like file paths
(string
  (string_content) @string.special
  (#match? @string.special "\\.(ya?ml|json|dockerfile)$"))
