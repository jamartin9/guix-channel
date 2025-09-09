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
                               (delete 'check); skip tests
                               (add-after 'unpack 'pre-install-source ; copy source
                                          (lambda* (#:key outputs #:allow-other-keys)
                                            (copy-recursively
                                             "."
                                             (string-append (assoc-ref outputs "src") "/src"))))
                               (add-after 'install 'really-install
                                          (lambda* (#:key outputs #:allow-other-keys)
                                            (let ((out (assoc-ref outputs "out")))
                                              (install-file "par2" (string-append out "/bin"))
                                              (install-file "libpar2-turbo.a" (string-append out "/lib"))
                                              (install-file "libgf16.a" (string-append out "/lib"))
                                              (install-file "libhasher.a" (string-append out "/lib")))))
                               )
           )
     ))
    (outputs '("out" "src"))
    ;(native-inputs (list automake autoconf))
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
        (base32 "1182xfxsljh5n4z54snv68kgca8ica2fq8jcgd8yjg3amkwz7i3r"))
       (patches (search-patches "nzbget.patch")) ; patch SOURCE_DIR to PAR2_ROOT unlike nixos
       ))
   (arguments
    (append ;(list #:configure-flags `(list (string-append "-DCMAKE_LIBRARY_PATH=" (assoc-ref %build-inputs "par2cmdline-turbo") "/lib")))
            (list #:tests? #f) ; skip tests due to errors
             (list #:phases
                   #~(modify-phases %standard-phases
                                    (add-after 'unpack 'sub-tests
                                               (lambda* (#:key inputs #:allow-other-keys)
                                                 (let ((par-root (assoc-ref inputs "par2cmdline-turbo:src"))
                                                       (par-lib (assoc-ref inputs "par2cmdline-turbo"))
                                                       )
                                                   (copy-recursively (string-append par-root "/src") "./par2-turbo-src") ; copy external projects src for includes
                                                   (substitute* "cmake/par2-turbo.cmake"
                                                                (("set\\(PAR2_ROOT.*") "set\(PAR2_ROOT ${CMAKE_SOURCE_DIR}/par2-turbo-src)\n") ; set root to copied src
                                                                (("set\\(INCLUDES.*") "set\(INCLUDES ${INCLUDES} ${CMAKE_SOURCE_DIR}/par2-turbo-src/include)"); set include to copied src
                                                                ;(("PREFIX.*par2-turbo") (string-append "PREFIX " (getcwd) "/../build/par2-turbo\n" ))
                                                                ;(("set\\(LIBS.*") (string-append "set(LIBS ${LIBS} " par-lib "/lib/libpar2-turbo.a " par-lib "/lib/gf16.a " par-lib "/lib/hasher.a)\n"))
                                                                ;(("ExternalProject_add\\(") "message(\n")
                                                                (("set\\(LIBS.*") "find_library(par2-turbo libpar2-turbo.a gf16.a hasher.a)\ntarget_link_libraries(${PACKAGE} PRIVATE libpar2-turbo.a gf16.a hasher.a )\n"); TODO unbundle ExternalProject_add
                                                                ))
                                                 ))))
             ))
   (inputs `(("par2cmdline-turbo" ,par2cmdline-turbo) ; lib output?
             ("par2cmdline-turbo:src" ,par2cmdline-turbo "src") ;; add src output for include headers
             ,@(package-inputs nzbget)))
   )
  )


;par2cmdline-turbo
nzbget-next
