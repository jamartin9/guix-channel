(define-module (jam packages pyrescene)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system python)
  #:use-module (nongnu packages compression)
  #:use-module (gnu packages mp3)
  #:use-module (jam packages)
  #:use-module ((guix licenses) #:prefix license:))

(define-public python-pyrescene
  (package
    (name "python-pyrescene")
    (version "0.7-git")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/srrDB/pyrescene")
            (commit "5a7cdda60020511927341165d8d4711c897a2246")))
      (file-name (git-file-name name version))
      (sha256
       (base32 "0v9j5jjffwym9n4ifg4kk53n14llpzpl21vbx3vb2ymz6w1pn3b0"))
       (patches (search-patches "pyrescene-locale.patch"))))
    (build-system python-build-system)
    (propagated-inputs
     (list unrar chromaprint))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/srrDB/pyrescene")
    (synopsis "Backup and restore scene release metadata")
    (description "Backup and restore scene release metadata")
    (license license:expat)))


;python-pyrescene
