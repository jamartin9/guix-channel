(define-module (jam packages searx)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system python)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages check)
  #:use-module (gnu packages time)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-compression)
  #:use-module ((guix licenses) #:prefix license:)
  )

;; TODO: write python importer for pinning versions from requirements.txt on a per package basis

(define python-dateutil-2.8.1
  (package
   (inherit python-dateutil)
    (version "2.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "python-dateutil" version))
       (sha256
        (base32
         "0g42w7k5007iv9dam6gnja2ry8ydwirh99mgdll35s12pyfzxsvk"))))
    (arguments
     (substitute-keyword-arguments (package-arguments python-dateutil)
                                   ((#:phases phases) `(modify-phases ,phases (delete 'check)))
                                   ((#:tests? _ #f) #f)
                                   ))
    ))
(define python-pygments-2.8.0
  (package
   (inherit python-pygments)
    (version "2.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "Pygments" version))
       (sha256
        (base32
         "1h256kbsda1ycgxbgpbanrckwczcraql46l9qm6caam0d2hkp89p"))))))

(define python-lxml-4.6.3
  (package
   (inherit python-lxml)
   (version "4.6.3")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "lxml" version))
     (sha256
      (base32
       "0s14r1w2x9sdlcsw8mxiqgw4rz5zs5lpqpxrfyn4a1mkndqqbdrr"))))
       (arguments
   (substitute-keyword-arguments (package-arguments python-lxml)
                                 ((#:phases phases) `(modify-phases ,phases (delete 'check)))
                                 ((#:tests? _ #f) #f)
                                 ))
       ))

(define python-jinja2-2.11.3
  (package
   (inherit python-jinja2)
   (version "2.11.3")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "Jinja2" version))
     (sha256
      (base32
       "1iiklf3wns67y5lfcacxma5vxfpb7h2a67xbghs01s0avqrq9md6"))))
   ))
(define jinja2-instead
  (package-input-rewriting/spec `(("python-jinja2" . ,(const python-jinja2-2.11.3) ))))

(define python-babel-2.9.0
  (package
   (inherit python-babel)
   (version "2.9.0")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "Babel" version))
     (sha256
      (base32
       "018yg7g2pa6vjixx1nx41cfispgfi0azzp0a1chlycbj8jsil0ys"))))))

(define babel-instead
  (package-input-rewriting/spec `(("python-babel" . ,(const python-babel-2.9.0) ))))

(define python-flask-babel-2
  (package
   (inherit python-flask-babel)
   (version "2.0.0")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "Flask-Babel" version))
     (sha256
      (base32
       "0z95v77vib5il8hphyh16n7i15a2gmc06i615vm346ifvdfg9ypr"))))
   (arguments
     '(#:phases (modify-phases %standard-phases
                  (delete 'check))))
   ))

(define python-requests-2.25.1
  (package
   (inherit python-requests)
   (version "2.25.1")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "requests" version))
     (sha256
      (base32
       "015qflyqsgsz09gnar69s6ga74ivq5kch69s4qxz3904m7a3v5r7"))))
   ))
(define requests-instead
  (package-input-rewriting/spec `(("python-requests" . ,(const python-requests-2.25.1) ))))

(define python-pyyaml-5.4.1
  (package
   (inherit python-pyyaml)
   (version "5.4.1")
   (source
   (origin
     (method url-fetch)
     (uri (pypi-uri "PyYAML" version))
     (sha256
      (base32
       "0pm440pmpvgv5rbbnm8hk4qga5a292kvlm1bh3x2nwr8pb5p8xv0"))))
   ))

(define python-langdetect-1.0.8
  (package
  (name "python-langdetect")
  (version "1.0.8")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "langdetect" version))
      (sha256
        (base32
          "10zsnak5z32qj7x9lp02vjmlz0axmifj8lz9b34l64jz03m9adrn"))))
  (build-system python-build-system)
  (propagated-inputs `(("python-six" ,python-six)))
  (home-page
    "https://github.com/Mimino666/langdetect")
  (synopsis
    "Language detection library ported from Google's language-detection.")
  (description
    "Language detection library ported from Google's language-detection.")
  (license license:expat)))

(define searx
(package
  (name "python-searx")
  (version (git-version "1.0.0" "1" "ae122ea943f77600fd97556503c483dcd92e1e63"))
  (source
    (origin
      (method git-fetch)
      (uri (git-reference (url "https://github.com/asciimoo/searx")
                          (commit "ae122ea943f77600fd97556503c483dcd92e1e63")))
      (file-name (git-file-name name version))
      (sha256
        (base32
         "0ghkx8g8jnh8yd46p4mlbjn2zm12nx27v7qflr4c8xhlgi0px0mh"))
      ))
  (build-system python-build-system)
  (propagated-inputs
    `(("python-babel" ,python-babel-2.9.0)
      ("python-certifi" ,python-certifi) ;; 2020.12.05
      ("python-dateutil" ,python-dateutil-2.8.1)
      ("python-flask" ,python-flask) ; 1.1.2
      ("python-flask-babel" ,python-flask-babel-2) ;; 1.0.0 TODO
      ("python-idna" ,python-idna) ;; 2.10
      ("python-jinja2" ,python-jinja2-2.11.3)
      ("python-lxml" ,python-lxml-4.6.3)
      ("python-pygments" ,python-pygments-2.8.0)
      ("python-pyopenssl" ,python-pyopenssl) ;; 19.1.0
      ("python-pyyaml" ,python-pyyaml-5.4.1) ;; 5.3.1
      ("python-requests" ,python-requests-2.25.1) ;; 2.24.0
      ("python-pysocks" ,python-pysocks) ;; needed for requests
      ("python-langdetect" ,python-langdetect-1.0.8)
      ))
  (native-inputs
    `(("python-cov-core" ,python-cov-core)
      ;;("python-linuxdoc" ,python-linuxdoc)
      ("python-mock" ,python-mock)
      ("python-nose2" ,python-nose2)
      ;;("python-pallets-sphinx-themes" ,python-pallets-sphinx-themes)
      ("python-pep8" ,python-pep8)
     ;;("python-plone.testing" ,python-plone.testing)
      ("python-selenium" ,python-selenium)
      ("python-sphinx" ,python-sphinx)
      ;;("python-sphinx-issues" ,python-sphinx-issues)
      ;;("python-sphinx-jinja" ,python-sphinx-jinja)
      ;;("python-sphinx-tabs" ,python-sphinx-tabs)
      ;;("python-splinter" ,python-splinter)
      ;;("python-transifex-client" ,python-transifex-client)
      ;;("python-unittest2" ,python-unittest2)
      ;;("python-zope.testrunner" ,python-zope.testrunner)
      ))
  (arguments `(#:tests? #f)) ;; TODO: linuxdoc breaks recursive deps
  (home-page "https://github.com/asciimoo/searx")
  (synopsis
    "A privacy-respecting, hackable metasearch engine")
  (description
    "A privacy-respecting, hackable metasearch engine")
  (license license:agpl3))
)

(define-public python-searx
  (package
   (inherit (requests-instead (babel-instead (jinja2-instead searx))))))

;; python-vanguards pypi and git
(define-public python-vanguards
  (package
   (name "python-vanguards")
   (version "0.3.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "vanguards" version))
     (sha256
      (base32
       "1dv74lcw5apb3pccav0fbqfl96z07i0h9d17przp9frksjpry104"))))
   (build-system python-build-system)
   (arguments `(#:phases (modify-phases %standard-phases (delete 'check))))
   (propagated-inputs
    `(("python-ipaddress" ,python-ipaddress)
      ("python-setuptools" ,python-setuptools)
      ("python-stem" ,python-stem)))
   (home-page
    "https://github.com/mikeperry-tor/vanguards")
   (synopsis
    "Vanguards help guard you from getting vanned...")
   (description
    "Vanguards help guard you from getting vanned...")
   (license #f)))

(define-public python-vanguards-git
  (package
   (inherit python-vanguards)
   (name "python-vanguards-git")
   (version (git-version "0.3.1" "1" "26a317461ef9b25f72c1843cee55ba03e59ebbe9"))
   (source (origin
            (method git-fetch)
            (uri (git-reference (url "https://github.com/mikeperry-tor/vanguards")
                                (commit "26a317461ef9b25f72c1843cee55ba03e59ebbe9")))
            (file-name (git-file-name name version))
            (sha256
                 (base32 "0m1hm3apcj10i3jf4bjzd26bzdcgp9zmardy6isnh4nk92lamy9k"))
                   ))))

(define-public python-onionbalance
  (package
  (name "python-onionbalance")
  (version "0.2.1")
  (source


    (origin
      (method url-fetch)
      (uri (pypi-uri "OnionBalance" version))
      (sha256
        (base32
          "1sikic2jq88bc4z1y49cxik7zzwhqxj52q0w08r48rr4xzyya89l"))))
  (build-system python-build-system)
  (propagated-inputs
    `(("python-cryptography" ,python-cryptography)
      ("python-future" ,python-future)
      ("python-pycryptodomex" ,python-pycryptodomex)
      ("python-pyyaml" ,python-pyyaml-5.4.1)
      ("python-setproctitle" ,python-setproctitle)
      ("python-setuptools" ,python-setuptools)
      ("python-stem" ,python-stem)
      ;("python-pexpect" ,python-pexpect) ; tests
      ;("python-mock" ,python-mock) ; tests
      ;("python-pytest" ,python-pytest) ; tests
      ;("python-pytest-mock" ,python-pytest-mock) ; tests                                       ;
      ))
   (arguments `(#:tests? #f)) ;; TODO: tests to native inputs
  (home-page
    "https://github.com/asn-d6/onionbalance")
  (synopsis
    "OnionBalance provides load-balancing and redundancy for Tor hidden services by distributing requests to multiple backend Tor instances.")
  (description
    "OnionBalance provides load-balancing and redundancy for Tor hidden services by distributing requests to multiple backend Tor instances.")
  (license license:gpl3)))
