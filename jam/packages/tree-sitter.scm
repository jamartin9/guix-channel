(define-module (jam packages tree-sitter)
  #:use-module (guix git-download)
  #:use-module (gnu packages tree-sitter)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define tree-sit-yaml
  (let ((commit "0e36bed171768908f331ff7dff9d956bae016efb")
        (revision "0"))
    ((@@ (gnu packages tree-sitter) tree-sitter-grammar)
       "yaml" "Yaml"
       "0wyvjh62zdp5bhd2y8k7k7x4wz952l55i1c8d94rhffsbbf9763f"
       (git-version "0.5.0" revision commit)
       #:repository-url "https://github.com/ikatyang/tree-sitter-yaml"
       #:commit commit)))


(define-public tree-sitter-yaml
  (package
   (inherit tree-sit-yaml)
   (arguments `(#:phases
                (modify-phases %standard-phases
                               (delete 'check))))))
