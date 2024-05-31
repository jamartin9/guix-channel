(define-module (jam system channels)
  #:use-module (guix)
  #:use-module (guix ci)
  #:use-module (guix channels))

(define-public %jam-channels
  (list (channel ;; custom guix override
         (name 'guix)
         (url "https://git.savannah.gnu.org/git/guix.git")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
        (channel ;; GUIX_PACKAGE_PATH and (url "file:///home/.../guix-channel")
         (name 'mychannel)
         (url "https://github.com/jamartin9/guix-channel")
         (introduction
          (make-channel-introduction
           "a8de09ac62260319e6376f21c995f713c1b09279"
           (openpgp-fingerprint
            "34AF BE87 8193 580F F441  AB3F 95AF 699C 293E 302B"))))))

%jam-channels
