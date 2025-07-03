; Tiltfile outline/symbols configuration
; Show useful symbols for navigation in the outline view

; Function definitions
(function_definition
  name: (identifier) @name) @item

; Variable assignments at module level
(assignment
  left: (identifier) @name) @item

; Tilt resource function calls that define infrastructure
(call
  function: (identifier) @name
  (#match? @name "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm_resource|dc_resource|local|helm|kustomize|port_forward)$")) @item
