(define-module (jam packages pyrescene)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system pyproject)
  #:use-module (nongnu packages compression)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages python-build)
  #:use-module (jam packages)
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public python-pyrescene
  (package
    (name "python-pyrescene")
    (version "0.7-git-04da2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/srrDB/pyrescene")
             (commit "04da213cef6765ed98e0d1735683822a41ea0103")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "193663rrq46ifai6nz225nhk67n9zi6k3hx9s0x5855y6s99l43n"))
       (patches (search-patches "pyrescene-locale.patch"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-setuptools))
    (propagated-inputs (list unrar chromaprint))
    (arguments
     (list #:tests? #f))
    (home-page "https://github.com/srrDB/pyrescene")
    (synopsis "Backup and restore scene release metadata")
    (description "Backup and restore scene release metadata")
    (license license:expat)))

python-pyrescene
