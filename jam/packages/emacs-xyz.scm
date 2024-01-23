(define-module (jam packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (jam packages)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-code-review
  (package
    (name "emacs-code-review")
    (version "20221209.1215")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/wandersoncferreira/code-review/")
             (commit "26f426e99221a1f9356aabf874513e9105b68140")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1031sq40kysbkvl0cl4lq39ls13n0y3kafbmf4c30grbydljbd52"))
       (patches (search-patches "emacs-code-review-closql-uuidgen.patch"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-closql emacs-magit emacs-transient emacs-a emacs-ghub emacs-deferred emacs-markdown-mode emacs-forge emacs-emojify))
    (home-page "https://github.com/wandersoncferreira/code-review/")
    (synopsis "Package to help you perform code reviews from your VC provider.")
    (description "Currently supports Github and basic Gitlab and Bitbucket workflows.")
    (license license:gpl3+)))


(define-public emacs-dape
  (package
   (name "emacs-dape")
   (version "0.4.0")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://elpa.gnu.org/packages/dape-" version
                                ".tar"))
            (sha256 (base32
                     "1yfv7mgr9jdw3i3a684fjvcb18asa92iy41f8xpn4qi36i1dbvyg"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/svaante/dape")
   (synopsis "Debug Adapter Protocol for Emacs")
   (description "Debug adapter protocol for emacs. Extract adapter https://github.com/vadimcn/codelldb/releases unzip codelldb-<platform>-<os>.vsix -d ~/.emacs.d/.local/debug-adapters/codelldb")
   (license license:gpl3+)))
