(define-module (jam packages vs)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (nongnu packages nvidia) ;for mesa to nvda graft
  #:use-module (guix utils) ;substutite keyword cython
  #:use-module (guix build-system gnu) ;zimg for vapoursynth
  #:use-module (guix build-system python) ;cython for vapoursynth
  #:use-module (guix build-system pyproject) ;for vs-rekt and awsmfunc
  #:use-module (gnu packages python-build) ;python-tomil for awsmfunc
  #:use-module (gnu packages python-xyz) ;cython for vapoursynth
  #:use-module (gnu packages python) ;python-3.12 for vapoursynth
  #:use-module (gnu packages ocr) ;terreract for vapoursynth
  #:use-module (gnu packages assembly) ;nasm for vapoursynth
  ;; #:use-module (guix build-system cargo) ; rust-dolby-vision-3 for vs-placebo and vs-nlq
  ;; #:use-module (gnu packages rust) ; rust-cargo-c for rust-dolby-vision-3
  #:use-module (gnu packages rust-apps) ;for vs-nlq
  #:use-module (gnu packages rust-crates) ;for vs-nlq
  #:use-module (gnu packages rust-sources) ;for vs-nlq (criterion)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages check) ;pylint for awsmfunc
  #:use-module (gnu packages video) ;libplacebo for vs-placebo
  #:use-module (gnu packages ghostscript) ;lcms for vs-placebo
  #:use-module (gnu packages vulkan) ;shaderc for vs-placebo, vulkan-headers/vulkan-loader for vs-placebo
  #:use-module (gnu packages pkg-config) ;pkg-config for libs
  #:use-module (gnu packages opencl) ;opencl for vs-eedi3m
  #:use-module (gnu packages boost) ;boost for vs-eedi3m
  #:use-module (gnu packages image) ;zimg for vapoursynth, libass for vs-subtext, ffmpeg (libavcodec, libavformat, libavutil) for vs-subtext,
  #:use-module (gnu packages autotools) ;for ffms2-git
  #:use-module (gnu packages gettext) ;for ffms2-git
  #:use-module (jam packages) ;for search-patches
  #:use-module (jam packages dolby) ;rust package for rust-dolby-vision-3
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public vsutil
  (package
    (name "vsutil")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vsutil" version))
       (sha256
        (base32 "0s47r623x9vw0nrlpjfypn33ckp0gxgbl7qhdbw3m77v7lh32670"))))
    (build-system python-build-system)
    (inputs (list vapoursynth))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  ;; This package only has a Python script, not a Python module, so the
                  ;; sanity-check phase can't work.
                  (delete 'sanity-check))))
    (home-page "https://encode.moe/vsutil")
    (synopsis
     "A collection of general-purpose Vapoursynth functions to be reused in modules and scripts.")
    (description
     "This package provides a collection of general-purpose Vapoursynth functions to
be reused in modules and scripts.")
    (license license:expat)))

(define-public vs-rekt
  (package
    (name "vs-rekt")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vs-rekt" version))
       (sha256
        (base32 "0cdf16hnn3akx9yx6xijf1f1m368n9x2pl67h0dq8kh7fysw1yr4"))))
    (build-system python-build-system)
    (inputs (list vapoursynth vsutil))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  ;; This package only has a Python script, not a Python module, so the
                  ;; sanity-check phase can't work.
                  (delete 'sanity-check))))
    (home-page "https://github.com/OpusGang/rekt")
    (synopsis "VapourSynth wrapper for Cropping and Stacking clips.")
    (description "@code{VapourSynth} wrapper for Cropping and Stacking clips.")
    (license license:expat)))

(define-public awsmfunc
  (package
    (name "awsmfunc")
    (version "1.3.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "awsmfunc" version))
       (sha256
        (base32 "1f0id0bswjf9l0warlkp13lpdsh6ixcb0k307j5w5p56w8l946w5"))))
    (build-system python-build-system)
    (inputs (list python-numpy vapoursynth vs-rekt vsutil))
    (native-inputs (list python-pylint python-toml python-yapf))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  ;; This package only has a Python script, not a Python module, so the
                  ;; sanity-check phase can't work.
                  (delete 'sanity-check))))
    (home-page "https://github.com/OpusGang/awsmfunc")
    (synopsis "awesome VapourSynth functions")
    (description "awesome @code{VapourSynth} functions")
    (license license:expat)))

(define-public vs-placebo
  (package
    (name "vs-placebo")
    (version "2.0.0-git"); r73 for newer versions
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Lypheo/vs-placebo")
             (commit "c51c432bd996d5ad953477bef1f754794e9ab6cb")
             (recursive? #t))) ; MAYBE unbundle libp2p
       (file-name (git-file-name name version))
       (sha256
        (base32 "1gi22qmvc8l3s7qqbf87ng9nbx5xv14x9zilph4m6ya3fzgv1qdp"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth
                  zimg
                  libplacebo
                  shaderc
                  vulkan-headers
                  vulkan-loader
                  lcms
                  rust-dolby-vision-3)) ;check libdovi
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth'),")
                         "\n"))))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/libvs_placebo.so")
                                     (string-append vs-lib "/libvs_placebo.so"))))))))
    (home-page "https://github.com/Lypheo/vs-placebo")
    (synopsis "placebo vapoursynth plugin")
    (description
     "libplacebo-based debanding, scaling and color mapping plugin for VapourSynth")
    (license license:lgpl2.1+)))

(define vs-nvda
  (package
    (inherit vs-placebo)
    (name "vs-placebo-nvda")))

(define-public vs-placebo-nvda
   ;graft nvda for mesa
  (replace-mesa vs-nvda))

(define-public vs-eedi3m
  (package
    (name "vs-eedi3m")
    (version "R10")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url
              "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3")
             (commit "11bb8f7eca7769ff3417c9d0be574f73e4b03426")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1mkdipvv5w3q83hizrcnvngfxj3hqsda6k81pgq0951kn402aa3y"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg opencl-icd-loader opencl-headers boost))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        (("py.*false)") ; remove include dirs from python execution
                         "vapoursynth_dep = dependency\('vapoursynth', version: '>=55').partial_dependency\(compile_args : true, includes : true)\nmessy = '''\n"))
                      (substitute* "meson.build"
                        ((".*libs.*]")
                         "'''\nlibs = []\n"))
                      (substitute* "meson.build"
                        ((".*include_directories: incdir,")
                         "        dependencies: [vapoursynth_dep],\n"))
                      (substitute* "meson.build"
                        ((".*include_directories.*incdir,")
                         "    dependencies: [vapoursynth_dep],\n"))
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth/plugins',")
                         "\n"))
                        ))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/eedi3m.so")
                                     (string-append vs-lib "/eedi3m.so"))))))))
    (home-page
     "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3")
    (synopsis "eedi3 vapoursynth plugin")
    (description "Renewed EEDI3 filter for VapourSynth")
    (license license:lgpl2.1+)))

(define-public vs-subtext
  (package
    (name "vs-subtext")
    (version "R6-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vapoursynth/subtext")
             (commit "ef0e4c54f27ce2a427ac5096c403bce3354dc3a4")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ycc6a4yfgl0x81bbn7b266qixfnj04d0cd6r3iiv7g1ydjdpc29"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg libass ffmpeg))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        (("py.*false)") ; remove include dirs from python execution
                         "vapoursynth_dep = dependency\('vapoursynth', version: '>=55').partial_dependency\(compile_args : true, includes : true)\ndeps += vapoursynth_dep\nmessy = '''\n"))
                      (substitute* "meson.build"
                        (("link_args.*]")
                         "'''\nlink_args = []\n"))
                      (substitute* "meson.build"
                        ((".*include_directories: incdir,")
                         "\n"))
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth/plugins',")
                         "\n"))
                      ))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/subtext.so")
                                     (string-append vs-lib "/subtext.so"))))))))
    (home-page "https://github.com/vapoursynth/subtext")
    (synopsis "subtext vapoursynth plugin")
    (description "Subtitle plugin for VapourSynth based on libass")
    (license license:lgpl2.1+)))

(define-public vs-fillborders
  (package
    (name "vs-fillborders")
    (version "3-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/dubhater/vapoursynth-fillborders")
             (commit "60adc9774dd715e1a11d348354f4cb468309a6d7")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0s3ss6yjrc0dppbp6jxfr4s59ivqgwgc58g7yp6yrwfhgjm6nrfc"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth/plugins',")
                         "\n"))
                      (substitute* "meson.build"; remove include dirs from python execution
                        (("incdir = include_directories")
                         "messy = '''\n"))
                      (substitute* "meson.build"
                        (("py.*false)")
                         "'''\nvapoursynth_dep = dependency\('vapoursynth', version: '>=55').partial_dependency\(compile_args : true, includes : true)\n"))
                      (substitute* "meson.build"
                        ((".*include_directories.*incdir,")
                         "    dependencies: [vapoursynth_dep],\n"))
                      ))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/fillborders.so")
                                     (string-append vs-lib
                                                    "/fillborders.so"))))))))
    (home-page "https://github.com/dubhater/vapoursynth-fillborders")
    (synopsis "fillborders vapoursynth plugin")
    (description "Fills the borders of a clip")
    (license license:lgpl2.1+)))

(define-public vs-vivtc
  (package
    (name "vs-vivtc")
    (version "R2-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vapoursynth/vivtc")
             (commit "4734c8b8526998b11bb2f313dfd0b4ecf760cfae")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1yd7lc6c90ha72fhv5jzlaz59ckz5yngc64v30kdlm49946cyc9f"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments
     `(#:tests? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth/plugins',")
                         "\n"))
                      (substitute* "meson.build"; remove include dirs from python execution
                        (("incdir = include_directories")
                         "messy = '''\n"))
                      (substitute* "meson.build"
                        (("py.*false)")
                         "'''\nvapoursynth_dep = dependency\('vapoursynth', version: '>=55').partial_dependency\(compile_args : true, includes : true)\n"))
                      (substitute* "meson.build"
                        ((".*include_directories.*incdir,")
                         "    dependencies: [vapoursynth_dep],\n"))
                      ))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/vivtc.so")
                                     (string-append vs-lib "/vivtc.so"))))))))
    (home-page "https://github.com/vapoursynth/vivtc")
    (synopsis "vivtc vapoursynth plugin")
    (description
     "Field matcher and decimation filter for VapourSynth similar to TIVTC")
    (license license:lgpl2.1+)))

(define-public ffms2-git
  (package
    (inherit ffms2)
    (name "ffms2-git")
    (version "5.12-3af2ef2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FFMS/ffms2")
             (commit "3af2ef2ae47bc30b64597c9e419e5b19c4bda7d8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1gib85jpk714pn024zd0pfxs2vqiwg578xlwmskxyh0wkj8qfz1v"))))
    (arguments
     '(#:configure-flags (list "--enable-avresample")
       #:phases (modify-phases %standard-phases
                  (add-before 'bootstrap 'patch-autogen
                    (lambda* (#:key inputs #:allow-other-keys)
                      (delete-file "autogen.sh")
                      (mkdir-p "src/config") #t))
                  (add-after 'install 'install-vs-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/vapoursynth")))
                        (mkdir-p vs-lib)
                        (symlink (string-append lib "/libffms2.so")
                                 (string-append vs-lib "/libffms2.so"))))))))
    (propagated-inputs (list ffmpeg))
    (native-inputs (list autoconf automake gettext-minimal pkg-config libtool))))

(define zimg-3.0.5
  (package
    (name "zimg")
    (version "3.0.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/sekrit-twc/zimg")
             (commit (string-append "release-" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1j7c4z06kdkdxdl0ikas1a9xw9ghc5lsi89nnbg6dv7k75v327y5"))))
    (build-system gnu-build-system)
    (native-inputs (list autoconf automake libtool))
    (synopsis "Scaling, colorspace conversion, and dithering library")
    (description
     "Zimg implements the commonly required image processing basics
of scaling, colorspace conversion, and depth conversion.  A simple API enables
conversion between any supported formats to operate with minimal knowledge from
the programmer.")
    (home-page "https://github.com/sekrit-twc/zimg")
    (license license:wtfpl2)))

(define python-cython-3.0.10
  (package
    (inherit python-cython)
    (name "python-cython-next")
    (version "3.0.10")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "Cython" version))
       (sha256
        (base32 "16fy6bqkcn6mvx8clqbc0s489zkcaw3ldy83ypf59f0z6cwngjfw"))))
    (arguments
     (substitute-keyword-arguments (package-arguments python-cython)
       ((#:tests? flags #f)
        #f)))
    (properties '())))

(define-public vapoursynth-git
  ;; MAYBE add wrap-program from (guix build utils) to set the plugin directory
  (package
    (inherit vapoursynth)
    (name "vapoursynth-git")
    (version "68")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vapoursynth/vapoursynth")
             (commit (string-append "R" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "116pp88a1mld6ys7q8hdv0j3lscwb8w1yyj0fk8418vc99llmdrw"))
       (patches (search-patches "vs.patch"))))
    (inputs (list ffmpeg libass python-3.12 tesseract-ocr zimg-3.0.5))
    (native-inputs (list autoconf
                         automake
                         python-cython-3.0.10 ;3+ after R63
                         libtool
                         pkg-config
                         yasm))))

;;; vendored zimg, cython
;vsutil
;vs-rekt
;vs-vivtc; pypi package requires vapoursynth 74+
;vs-fillborders; pypi package requires vapoursynth 74+
;vs-eedi3m ; pypi package requires  vapoursynth 74+
;vs-subtext ; pypi package requires  vapoursynth 74+
;awsmfunc
;ffms2-git
;vapoursynth ;vapoursynth-git
;python-numpy
;python
;vs-placebo; ; pypi package require vapoursynth 74+
