(define-module (jam packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (jam packages)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-dape
  (package
   (name "emacs-dape")
   (version "0.11.1")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://elpa.gnu.org/packages/dape-" version
                                ".tar"))
            (sha256 (base32
                     "0i04wwklypzxh78gwd9zjxjm3lwi2sn7qpqnlgd6n8hhcigyzhp0"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/svaante/dape")
   (synopsis "Debug Adapter Protocol for Emacs")
   (description "Debug adapter protocol for emacs. Extract adapter https://github.com/vadimcn/codelldb/releases unzip codelldb-<platform>-<os>.vsix -d ~/.emacs.d/.local/debug-adapters/codelldb")
   (license license:gpl3+)))
