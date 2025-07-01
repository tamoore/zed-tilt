; Tiltfile outline/symbols configuration - simplified for Python grammar compatibility

; Function definitions
(function_definition
  name: (identifier) @name) @item

; Class definitions (rare in Tiltfiles but possible)
(class_definition
  name: (identifier) @name) @item

; Variable assignments at module level
(assignment
  left: (identifier) @name) @item

; Tilt-specific function calls that define resources
(expression_statement
  (call
    function: (identifier) @name
    (#match? @name "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm|kustomize|port_forward|dc_resource|helm_resource|local)$"))) @item

; Configuration function calls
(expression_statement
  (call
    function: (attribute
      object: (identifier) @_config
      attribute: (identifier) @name)
    (#eq? @_config "config")
    (#match? @name "^(define_string|define_bool|define_string_list|parse)$"))) @item

; Load statements (imports)
(expression_statement
  (call
    function: (identifier) @_load
    arguments: (argument_list
      (string) @name)
    (#eq? @_load "load"))) @item
