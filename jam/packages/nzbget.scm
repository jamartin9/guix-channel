(define-module (jam packages nzbget)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system cmake); cmake-build-system
  #:use-module (guix build-system gnu); gnu-build-system
  #:use-module (guix build-system copy); gnu-build-system
  #:use-module (gnu packages autotools) ; automake
  #:use-module (gnu packages networking)
  #:use-module (gnu packages base); tar
  #:use-module (gnu packages compression); xz
  ;#:use-module (nonguix build-system binary) ; binary-build-system
  #:use-module (jam packages) ; for search-patches
  #:use-module ((guix licenses) #:prefix license:))

(define-public par2cmdline-turbo
  (package
    (name "par2cmdline-turbo")
    (version "1.4.0-20260323")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nzbgetcom/par2cmdline-turbo")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "08n4p56v9s58apw6nd9cwsmmyniwq2c2wh522aqljs34cbn1ir51"))))
    (arguments
     (append (list #:configure-flags '(list "-DBUILD_LIB=ON" "-DBUILD_TOOL=ON" "-DCMAKE_CXX_FLAGS=-DPARPAR_ENABLE_HASHER_MD5CRC -DHAVE_CONFIG_H -DPARPAR_INVERT_SUPPORT -DPARPAR_SLIM_GF16"))
             (list #:phases #~(modify-phases %standard-phases
                                             (delete 'check); skip tests despite make check and WITH_TESTS. MAYBE add native inputs for replacing ctest with make check
                                             (add-after 'install 'really-install ;(add-after 'install 'fail (lambda* (#:key outputs #:allow-other-keys) (exit 1)))
                                                        (lambda* (#:key outputs #:allow-other-keys)
                                                          (let ((out (assoc-ref outputs "out")))
                                                            (install-file "par2" (string-append out "/bin"))
                                                            (install-file "libpar2-turbo.a" (string-append out "/lib"))
                                                            (install-file "libgf16.a" (string-append out "/lib"))
                                                            (install-file "libhasher.a" (string-append out "/lib")); add includes after configure for version.h
                                                            (copy-recursively "../source/include" (string-append (assoc-ref outputs "out") "/include")))))))))
    (outputs '("out"))
    (build-system cmake-build-system)
    (synopsis "File verification and repair tools")
    (description "This is a simple fork of par2cmdline which replaces core computation routines with ParPar’s processing backend, improving par2cmdline’s performance on x86/ARM platforms.")
    (home-page "https://github.com/nzbgetcom/par2cmdline-turbo")
    (license license:gpl3+)))

(define-public rapidyenc
  (package
    (name "rapidyenc")
    (version "1.1.1-20260217")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nzbgetcom/rapidyenc")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256 (base32 "0caw4fda519a7hmmalc8zv0400dxzqlphy7y9ccag1a03nn0pbfl"))))
    (arguments
     (append (list #:configure-flags '(list "-DDISABLE_ENCODE=ON" "-DDISABLE_SHARED_LIB=ON" "-DDISABLE_CLI=ON" "-DDISABLE_BENCH_CLI=ON" "-DDISABLE_DECODE=OFF" "-DBUILD_NATIVE=ON"))
             (list #:phases #~(modify-phases %standard-phases
                                             (delete 'check); no tests
                                             (add-after 'install 'really-install
                                                        (lambda* (#:key outputs #:allow-other-keys)
                                                          (let ((out (assoc-ref outputs "out"))) ;(exit 1)
                                                            (install-file "../source/rapidyenc.h" (string-append out "/include"))
                                                            (install-file "rapidyenc_static/librapidyenc.a" (string-append out "/lib")))))))))
    (outputs '("out"))
    (build-system cmake-build-system)
    (synopsis "C compatible library provides functions for implementing yenc")
    (description "C compatible library provides functions for implementing yenc")
    (home-page "https://github.com/nzbgetcom/rapidyenc")
    (license license:gpl3+)))

(define-public nzbget-next
  (package
   (inherit nzbget)
   (name "nzbget-next")
   (version "26.1-488e50d")
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nzbgetcom/nzbget")
             (commit "488e50d3fddb95d108b0a3e9d2bf3d447673f149")));(string-append "v" version)
       (file-name (git-file-name name version))
       (sha256
        (base32 "141rz7s44qv87czj8rbbnd2708d9j9prkkvy9glacc34l57k8nsh"))))
   (arguments
    (append (list #:configure-flags `(list "-DCMAKE_CXX_FLAGS=-DPARPAR_ENABLE_HASHER_MD5CRC -DHAVE_CONFIG_H -DPARPAR_INVERT_SUPPORT -DPARPAR_SLIM_GF16" "-DENABLE_TESTS=1")) ; add par2turbo definitions and enable tests
            (list #:phases
                  #~(modify-phases %standard-phases
                                   (add-after 'unpack 'unbundle-par2-rapidyenc
                                              (lambda _
                                                (substitute* "cmake/posix.cmake"
                                                             (("include\\(\\$\\{CMAKE_SOURCE_DIR}/cmake/par2-turbo.cmake)") "set(LIBS ${LIBS} libpar2-turbo.a gf16.a hasher.a)\n")
                                                             (("include\\(\\$\\{CMAKE_SOURCE_DIR}/cmake/rapidyenc.cmake)") "set(LIBS ${LIBS} librapidyenc.a)\n")
                                                             (("list\\(APPEND EXTERNAL_DEPS par2-turbo)") "\n")
                                                             (("list\\(APPEND EXTERNAL_DEPS rapidyenc)") "\n"))))))))
   (inputs (modify-inputs (package-inputs nzbget)
                          (append par2cmdline-turbo)
                          (append rapidyenc)))
   (home-page "https://github.com/nzbgetcom/nzbget")))


;par2cmdline-turbo
;rapidyenc
nzbget-next
