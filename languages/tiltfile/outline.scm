(function_definition
  name: (identifier) @name) @item

(call
  function: (identifier) @name
  (#match? @name "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm|kustomize|port_forward|local|read_file|helm_resource)$")) @item
