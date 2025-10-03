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
    (version "1.3.0-20250808")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nzbgetcom/par2cmdline-turbo")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1w87mqnfp4nj0msi937y2ahqvjj3bhl82vqb84qlg63dk0ih1zv4"))))
    (arguments
     (append (list #:configure-flags '(list "-DBUILD_LIB=ON" "-DBUILD_TOOL=ON"))
             (list #:phases #~(modify-phases %standard-phases
                                             (delete 'check); skip tests despite make check and WITH_TESTS
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

(define-public nzbget-next
  (package
   (inherit nzbget)
   (name "nzbget-next")
   (version "25.3")
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nzbgetcom/nzbget")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1182xfxsljh5n4z54snv68kgca8ica2fq8jcgd8yjg3amkwz7i3r"))))
   (arguments
    (append (list #:configure-flags `(list "-DCMAKE_CXX_FLAGS=-DPARPAR_ENABLE_HASHER_MD5CRC -DHAVE_CONFIG_H" "-DCMAKE_C_FLAGS=-DPARPAR_ENABLE_HASHER_MD5CRC -DHAVE_CONFIG_H")); cmake/par2-turbo.cmake: add_compile_definitions(HAVE_CONFIG_H PARPAR_ENABLE_HASHER_MD5CRC)

            (list #:tests? #f) ; skip tests due to errors
            (list #:phases
                  #~(modify-phases %standard-phases
                                   (add-after 'unpack 'sub-tests
                                              (lambda* (#:key inputs #:allow-other-keys)
                                                (substitute* "cmake/posix.cmake"
                                                             (("include\\(\\$\\{CMAKE_SOURCE_DIR}/cmake/par2-turbo.cmake)") "set(LIBS ${LIBS} libpar2-turbo.a gf16.a hasher.a)\n")
                                                             (("set\\(DEPENDENCIES.*par2-turbo)") "\n"))))))))
   (inputs `(("par2cmdline-turbo" ,par2cmdline-turbo)
             ,@(package-inputs nzbget)))))


;par2cmdline-turbo
nzbget-next
