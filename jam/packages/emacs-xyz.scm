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
