(define-module (jam packages emacs)
  #:use-module (guix transformations)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix utils))

;; aot compile transformation for packages
(define-public transform-emacs-build
  (options->transformation '((with-input . "emacs-minimal=emacs"))))

;; create a procedure that applies transformations options "with-branch=master" to an emacs package
(define-public (transform-emacs-build-git pkg)
  (define xform (options->transformation `((with-branch . ,(string-append (package-name pkg) "=master"))
                                           (with-input . "emacs-minimal=emacs"))))
  (xform pkg))

;; transform emacs package configure flags for ~5% perf in emacs-30+
(define-public (transform-emacs-configure pkg)
  (define xform (options->transformation `((with-configure-flag . ,(string-append (package-name pkg) "=--disable-gc-mark-trace")))))
  (xform pkg))


(define-public emacs-scala-ts-mode
  (package
    (name "emacs-scala-ts-mode")
    (version "20241027.701")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/KaranAhlawat/scala-ts-mode.git")
             (commit "039af6d4e353726245e60756667f0b7378840f6c")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0b4f9zax2rgg3zrlsg40mgiz7f5z9dq52adg7xrgwrc1k65mlxlf"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/KaranAhlawat/scala-ts-mode")
    (synopsis "An tree-sitter based major-mode for Scala")
    (description
     "This package provides a tree-sitter based major mode for the Scala programming
language.  Currently, the supported features and their statuses are 1.
font-locking (complete, looking for bugs and maintainance) 2.  imenu (basic
support, needs work) 3.  indentation.")
    (license #f)))
