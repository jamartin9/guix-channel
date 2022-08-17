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
