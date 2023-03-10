(define-module (jam packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-flycheck-popup-tip
  (package
    (name "emacs-flycheck-popup-tip")
    (version "20170812.2351")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/flycheck/flycheck-popup-tip")
             (commit "ef86aad907f27ca076859d8d9416f4f7727619c6")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bi6f9nm4bylsbjv4qnkar35s6xzdf2cc2cxi3g691p9527apdz6"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-popup emacs-flycheck))
    (home-page "https://github.com/flycheck/flycheck-popup-tip")
    (synopsis "This is extension for Flycheck.")
    (description "It displays Flycheck error messages in buffer using popup.el library.")
    (license license:gpl3+)))


(define-public emacs-orgit-forge
  (package
    (name "emacs-orgit-forge")
    (version "20220422.1625")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/magit/orgit-forge")
             (commit "8baf1dee795f026d4555687022487fab89c9bcdf")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0zdp3yi4vmrhpl8v0vk5d4b8kz77k0qnnhmapm7arv7719ydwzff"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-compat emacs-forge emacs-magit emacs-orgit emacs-org))
    (home-page "https://github.com/magit/orgit-forge")
    (synopsis "Adds orgit-topic link to org-mode for Forge topic buffers.")
    (description "This package defines the Org link type orgit-topic, which can be used to link to Forge topic buffers. This is similar to the orgit package, which links to various Magit buffers")
    (license license:gpl3+)))

(define-public emacs-uuidgen
  (package
    (name "emacs-uuidgen")
    (version "20220405.1345")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/kanru/uuidgen-el/")
             (commit "7b728c1d92e196c3acf87a004949335cfc18eab3")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1z7x4p1qgyginn74xapd1iq0k53m9qbfk57dzc8srg7fcn5ip1js"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/kanru/uuidgen-el/")
    (synopsis "This is a naive implementation of RFC4122 Universally Unique IDentifier generation in elisp.")
    (description "Currently implemented are UUID v1 v3, v4 and v5 generation.")
    (license license:gpl3+)))

(define-public emacs-code-review
  (package
    (name "emacs-code-review")
    (version "20220629.1215")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/wandersoncferreira/code-review/")
             (commit "95b36ec8e7935f96b2f3c6c9086d49cf4a72cbff")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1mplrc84a5qd6cqv0kcqm13zdmvn71g5pmilhjdagn36dsb1vn16"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-closql emacs-magit emacs-transient emacs-a emacs-ghub emacs-uuidgen emacs-deferred emacs-markdown-mode emacs-forge emacs-emojify))
    (home-page "https://github.com/wandersoncferreira/code-review/")
    (synopsis "Package to help you perform code reviews from your VC provider.")
    (description "Currently supports Github and basic Gitlab and Bitbucket workflows.")
    (license license:gpl3+)))
