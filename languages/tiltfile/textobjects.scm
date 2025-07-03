; Text objects for Tiltfile editing
; These define logical text boundaries for selection and navigation

; Function definitions
(function_definition) @function.around
(function_definition
  body: (_) @function.inside)



; Function calls
(call) @call.around

; Dictionary literals
(dictionary) @object.around

; List literals
(list) @array.around

; Parenthesized expressions
(parenthesized_expression) @grouping.around
(parenthesized_expression
  (_) @grouping.inside)

; String literals
(string) @string.around
(string
  (string_content) @string.inside)

; Comments
(comment) @comment.around

; Control flow blocks
(if_statement) @conditional.around
(if_statement
  consequence: (_) @conditional.inside)

(for_statement) @loop.around
(for_statement
  body: (_) @loop.inside)

(while_statement) @loop.around
(while_statement
  body: (_) @loop.inside)



; Function parameters
(parameters) @parameter.around

; Assignment statements
(assignment) @assignment.around

; Tilt-specific function calls
(call
  function: (identifier) @_name
  (#match? @_name "^(k8s_yaml|docker_build|local_resource|k8s_resource|helm_resource|dc_resource|local|port_forward)$")) @resource.around
