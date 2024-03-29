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
   (version "0.9.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://elpa.gnu.org/packages/dape-" version
                                ".tar"))
            (sha256 (base32
                     "13xvl24l8lr64ndc8rk1dxdgsbvwxhn90844xkdzl7qs8i3hyw1l"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/svaante/dape")
   (synopsis "Debug Adapter Protocol for Emacs")
   (description "Debug adapter protocol for emacs. Extract adapter https://github.com/vadimcn/codelldb/releases unzip codelldb-<platform>-<os>.vsix -d ~/.emacs.d/.local/debug-adapters/codelldb")
   (license license:gpl3+)))
