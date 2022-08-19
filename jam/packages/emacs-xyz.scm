(define-module (jam packages emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:))


(define-public emacs-cfrs
  (package
    (name "emacs-cfrs")
    (version "20220129.1149")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Alexander-Miller/cfrs")
             (commit "f3a21f237b2a54e6b9f8a420a9da42b4f0a63121")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1vf5zm82sx3m1yvq73km8ajapv6rnz41b1jrsif7kh0ijh9vk3qi"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-dash emacs-s emacs-posframe))
    (home-page "https://github.com/Alexander-Miller/cfrs")
    (synopsis "Emacs library for reading input via child frame at cursor.")
    (description
     "cfrs.el is a simple alternative to read-string that allows reading input via a small child-frame spawned at the position of the cursor. Its goal is to make the string input interface closer to those used in modern GUI programs and to help the user with having to switch focus from whatever they are doing currently to look at the minibuffer.")
    (license license:gpl3+)))

(define-public emacs-macrostep-geiser
  (package
    (name "emacs-macrostep-geiser")
    (version "20210717.801")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nbfalcon/macrostep-geiser")
             (commit "f6a2d5bb96ade4f23df557649af87ebd0cc45125")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0dykvwcvg8n24z3fkx6rv3l1mhzmca4cxj0gsvvqsg9wp0az1fc7"))))
    (build-system emacs-build-system)
    (propagated-inputs
     (list emacs-geiser emacs-macrostep))
    (home-page "https://github.com/nbfalcon/macrostep-geiser")
    (synopsis "A macrostep back-end powered by geiser.")
    (description "Provides macrostep support for geiser and cider.")
    (license license:gpl3+)))


(define-public emacs-drag-stuff
  (package
    (name "emacs-drag-stuff")
    (version "20161108.749")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rejeep/drag-stuff.el")
             (commit "6d06d846cd37c052d79acd0f372c13006aa7e7c8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1fsj88n1j50cxjzx62khzxrajsvf33si8iwgbaz6z7z8pwh91qcd"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/rejeep/drag-stuff.el")
    (synopsis "A minor mode for dragging text in Emacs.")
    (description "Drag Stuff is a minor mode for Emacs that makes it possible to drag stuff (words, region, lines) around in Emacs.")
    (license license:gpl3+)))


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
