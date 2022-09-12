(define-module (jam packages emacs)
  #:use-module (guix transformations)
  #:use-module (gnu packages emacs))

;; aot compile transformation for packages
(define-public transform-emacs-build
  (options->transformation '((with-input . "emacs-minimal=emacs"))))
