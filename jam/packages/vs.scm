(define-module (jam packages vs)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (nongnu packages nvidia) ;for mesa to nvda graft
  #:use-module (guix utils) ;version-major+minor
  #:use-module (guix build-system gnu) ;zimg for vapoursynth
  #:use-module (guix build-system pyproject) ;for vs-rekt and awsmfunc
  #:use-module (gnu packages python-build) ;python-tomil for awsmfunc
  #:use-module (gnu packages python-xyz) ;cython for vapoursynth
  #:use-module (gnu packages python) ;python
  #:use-module (gnu packages ocr) ;terreract for vapoursynth
  #:use-module (gnu packages assembly) ;nasm for vapoursynth
  #:use-module (gnu packages rust-apps) ;for vs-nlq
  #:use-module (gnu packages rust-crates) ;for vs-nlq
  #:use-module (gnu packages rust-sources) ;for vs-nlq (criterion)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages check) ;pylint for awsmfunc
  #:use-module (gnu packages video) ;libplacebo for vs-placebo
  #:use-module (gnu packages ghostscript) ;lcms for vs-placebo
  #:use-module (gnu packages vulkan) ;shaderc for vs-placebo, vulkan-headers/vulkan-loader for vs-placebo
  #:use-module (gnu packages pkg-config) ;pkg-config for libs
  #:use-module (gnu packages opencl) ;opencl for eedi3m
  #:use-module (gnu packages boost) ;boost for eedi3m
  #:use-module (gnu packages image) ;zimg for vapoursynth, libass for subtext, ffmpeg (libavcodec, libavformat, libavutil) for subtext,
  #:use-module (gnu packages autotools) ;for ffms2
  #:use-module (gnu packages gettext) ;for ffms2
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
    (build-system pyproject-build-system)
    (inputs (list vapoursynth))
    (native-inputs (list python-setuptools))
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
    (build-system pyproject-build-system)
    (native-inputs (list python-setuptools))
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
    (build-system pyproject-build-system)
    (inputs (list python-numpy vapoursynth vs-rekt vsutil))
    (native-inputs (list python-pylint python-toml python-yapf python-setuptools))
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

(define-public libp2p
  (package
    (name "libp2p")
    (version "git-f50288")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/sekrit-twc/libp2p")
             (commit "f50288b0c8db2cb14bb98fc25a5f056609d03652")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ah4mi3gcmm4kqjml2rzyjigyk0mglsqzdm6xk3jff1v8v14pffv"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                               (delete 'configure)
                               (delete 'check)
                               (replace 'install
                                  (lambda* (#:key outputs #:allow-other-keys)
                                    (let ((out (assoc-ref outputs "out")))
                                      (invoke "make" "all")
                                      (install-file "libp2p.a" (string-append out "/lib")); install lib/headers
                                      (install-file "p2p_api.h" (string-append out "/include"))))))))
    (home-page "https://github.com/sekrit-twc/libp2p")
    (synopsis "Pack/unpack pixels.")
    (description "Pack/unpack pixels.")
    (license license:lgpl2.1+)))

(define-public vs-placebo ; maybe use pypi package?
  (package
    (name "vs-placebo")
    (version "2.0.2-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Lypheo/vs-placebo")
             (commit "ccb4beac9080510f2eb830d948449392e2e5c34a")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0nbvbb55wjzhgfhpr47l5hsylk5w9d8srpkzr0hm969r8j44dh6k"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth
                  libp2p
                  zimg
                  libplacebo
                  shaderc
                  vulkan-headers
                  vulkan-loader
                  lcms
                  rust-dolby-vision-3)) ;check libdovi
    (arguments
     (let ((python-version (version-major+minor (package-version python))))
       (append
        (list #:tests? `(list #f))
        (list #:phases #~(modify-phases %standard-phases
                  (add-after 'unpack 'remove-install-dir
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "meson.build"
                        (("py.*false)") ; remove include dirs from python execution
                         "vapoursynth_dep = dependency\('vapoursynth', version: '>=55').partial_dependency\(compile_args : true, includes : true)\n  messy = '''\n"))
                      (substitute* "meson.build"
                        ((".*install_dir.*'vapoursynth/plugins'")
                         "'''\n  deps += vapoursynth_dep\n"))
                      (substitute* "meson.build" ; add libp2p
                        (("libp2p.*subproject.*libp2p')")
                         "\nmyp2p = cc.find_library\('libp2p', static: true, has_headers: ['p2p_api.h'])\np2pdep = declare_dependency\(dependencies: [myp2p])\ndeps += p2pdep\nree = '''\n"))
                      (substitute* "meson.build"
                        (("sources.*]")
                         "'''\nsources = []\n"))
                      (substitute* "meson.build"
                        (("link_with.*link_with_list,")
                         ""))
                      (substitute* "meson.build"
                        ((".*include_directories.*p2p_inc_dirs],")
                         ""))
                      (substitute* "meson.build"
                        ((".*install_dir.*install_dir,")
                         ""))
                        ))
                  (add-after 'install 'move-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/python" #$python-version "/site-packages/vapoursynth/plugins")))
                        (mkdir-p vs-lib)
                        (rename-file (string-append lib "/libvs_placebo.so")
                                     (string-append vs-lib "/libvs_placebo.so")))))))
       ))
     )
    (home-page "https://github.com/Lypheo/vs-placebo")
    (synopsis "placebo vapoursynth plugin")
    (description
     "libplacebo-based debanding, scaling and color mapping plugin for VapourSynth")
    (license license:lgpl2.1+)))

(define-public vapoursynth-eedi3
  (package
    (name "vapoursynth-eedi3")
    (version "10.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vapoursynth_eedi3" version))
       (sha256
        (base32 "1hcqcqcwmnic0igjma03z220gpm50icmhdm0gxmia2ilc0izl8q0"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-meson python-pytest pkg-config))
    (inputs (list vapoursynth zimg opencl-icd-loader opencl-headers boost))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3")
    (synopsis "eedi3 vapoursynth plugin")
    (description "Renewed EEDI3 filter for VapourSynth")
    (license license:lgpl2.1+)))

(define-public vapoursynth-subtext
  (package
    (name "vapoursynth-subtext")
    (version "6.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vapoursynth_subtext" version))
       (sha256
        (base32 "0gr1dklxifsrj49srivjs589h1a6y1scs994w3vlqcgrbzjg3wzy"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-meson python-pytest pkg-config))
    (inputs (list vapoursynth zimg libass ffmpeg))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/vapoursynth/subtext")
    (synopsis "subtext vapoursynth plugin")
    (description "Subtitle plugin for VapourSynth based on libass")
    (license license:lgpl2.1+)))

(define-public vapoursynth-fillborders
  (package
    (name "vapoursynth-fillborders")
    (version "3.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vapoursynth_fillborders" version))
       (sha256
        (base32 "0r7il15wj5ji875w7r8s0dizl7fb9l8wkydldriz6j8xm7lz3987"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-meson python-pytest pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/dubhater/vapoursynth-fillborders")
    (synopsis "fillborders vapoursynth plugin")
    (description "Fills the borders of a clip")
    (license license:lgpl2.1+)))

(define-public vapoursynth-vivtc
  (package
    (name "vapoursynth-vivtc")
    (version "2.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vapoursynth_vivtc" version))
       (sha256
        (base32 "0cnx4y9gsvgpbgnm0jp56fdd774v2c8ha0y85y869ms3ps34vkhy"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-meson python-pytest pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/vapoursynth/vivtc")
    (synopsis "vivtc vapoursynth plugin")
    (description
     "Field matcher and decimation filter for VapourSynth similar to TIVTC")
    (license license:lgpl2.1+)))

(define-public vapoursynth-ffms2 ; maybe use pypi package
  (package
    (inherit ffms2)
    (name "vapoursynth-ffms2")
    (version "5.1.2-3af2ef2")
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
     (let ((python-version (version-major+minor (package-version python))))
     (append
      (list #:configure-flags `(list "--enable-avresample"))
      (list #:phases #~(modify-phases %standard-phases
                  (add-before 'bootstrap 'patch-autogen
                    (lambda* (#:key inputs #:allow-other-keys)
                      (delete-file "autogen.sh")
                      (mkdir-p "src/config") #t))
                  (add-after 'install 'install-vs-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let* ((out (assoc-ref outputs "out"))
                             (lib (string-append out "/lib"))
                             (vs-lib (string-append lib "/python" #$python-version "/site-packages/vapoursynth/plugins")))
                        (mkdir-p vs-lib)
                        (symlink (string-append lib "/libffms2.so")
                                 (string-append vs-lib "/libffms2.so")))))))
      ))
     )
    (propagated-inputs (list ffmpeg))
    (native-inputs (list autoconf automake gettext-minimal pkg-config libtool))))

;python
;python-numpy
;vapoursynth
;vapoursynth-vivtc
;vapoursynth-fillborders
;vapoursynth-subtext
;vapoursynth-ffms2
;vapoursynth-eedi3
;vs-placebo
;awsmfunc
;vs-rekt
;vsutil
