(define-module (jam packages emacs)
  #:use-module (guix transformations)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs))

;; aot compile transformation for packages
(define-public transform-emacs-build
  (options->transformation '((with-input . "emacs-minimal=emacs"))))

;; create a procedure that applies transformations options "with-branch=master" to an emacs package
(define-public (transform-emacs-build-git pkg)
  (define xform (options->transformation `((with-branch . ,(string-append (package-name pkg) "=master"))
                                           (with-input . "emacs-minimal=emacs"))))
  (xform pkg))
