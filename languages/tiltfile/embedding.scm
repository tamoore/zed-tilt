; Embedding queries for Tiltfile - simplified
; Support for basic embedded language detection

; YAML content in strings with YAML patterns
(string
  (string_content) @content
  (#match? @content "apiVersion|kind|metadata")
  (#set! "language" "yaml"))

; Dockerfile content in strings with Dockerfile patterns
(string
  (string_content) @content
  (#match? @content "FROM|RUN|COPY|WORKDIR")
  (#set! "language" "dockerfile"))

; Shell commands in strings with shell patterns
(string
  (string_content) @content
  (#match? @content "^(cd|ls|echo|mkdir|rm|cp|mv)")
  (#set! "language" "bash"))
