; Tiltfile indentation rules - simplified for Python grammar compatibility

; Basic block structures
[
  (function_definition)
  (class_definition)
  (if_statement)
  (elif_clause)
  (else_clause)
  (for_statement)
  (while_statement)
  (try_statement)
  (except_clause)
  (finally_clause)
  (with_statement)
] @indent

; Bracket pairs
[
  "("
  "["
  "{"
] @indent

[
  ")"
  "]"
  "}"
] @outdent

; Function calls and arguments
(argument_list) @indent
(parameters) @indent

; Data structures
(dictionary) @indent
(list) @indent
(set) @indent

; Comprehensions
(list_comprehension) @indent
(dictionary_comprehension) @indent
(set_comprehension) @indent

; Function calls
(call) @indent
