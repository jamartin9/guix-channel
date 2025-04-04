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
    (version "1.2.0-nzbget-20250213")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nzbgetcom/par2cmdline-turbo")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0i62b9xk9h3i1dqv9y7z5sk2pbyv758f6pdwbl8i6asvdyyi4yi0"))))
    (arguments
     (append (list #:configure-flags '(list "-DBUILD_LIB=ON" "-DBUILD_TOOL=ON"))
     (list #:phases #~(modify-phases %standard-phases ; TODO readd install and -Dbuild_lib to configure flags
                               (delete 'check); skip tests and skip install until build with BUILD_LIB or BUILD_TOOL (only need src atm)
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
                                              (install-file "libhasher.a" (string-append out "/lib"))
                                              )
                                            )
                                          )
                               ;(add-after 'install 'ree
                               ;           (lambda* (#:key outputs #:allow-other-keys)
                               ;             (exit 1)
                               ;             )
                               ;           )
                               )
           )
     ))
    (outputs '("out" "src"))
    ;(native-inputs (list automake autoconf))
    (build-system cmake-build-system)
    (synopsis "File verification and repair tools")
    (description "This is a simple fork of par2cmdline which replaces core computation routines with ParPar’s processing backend, improving par2cmdline’s performance on x86/ARM platforms.")
    (home-page "https://github.com/animetosho/par2cmdline-turbo")
    (license license:gpl3+)))

(define-public nzbget-next
  (package
   (inherit nzbget)
   (name "nzbget-next")
   (version "24.8")
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nzbgetcom/nzbget")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "18bl8bz8i722ila0iv97r5zkazkvh1c35ph7527jybirjj4s7h4f"))
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


(define-public parpar
 (package
   (name "parpar")
   (version "0.4.5")
   (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/animetosho/ParPar/releases/download/v" version "/parpar-v" version "-linux-static-amd64.xz"))
             (sha256
              (base32
               "0v8m09r74cnr74246zgqr4b25faf1lrhw6ffrh1rlm81dvmj9k6b"))))
   (build-system copy-build-system)
   (arguments
    (append
     (list #:install-plan `'(("./parpar-v0.4.5-linux-static-amd64" "/bin/"))
           #:phases
           #~(modify-phases %standard-phases
                            (add-after 'unpack 'chmod
                                       (lambda _
                                         (chmod "parpar-v0.4.5-linux-static-amd64" #o755)))))))
   (native-inputs
    (list xz))
   ;(inputs (list `(,gcc "lib") zlib))
   (supported-systems '("x86_64-linux"))
   (home-page "https://github.com/animetosho/ParPar")
   (synopsis  "PAR2 create client")
   (description "High performance PAR2 create client for NodeJS")
   (license license:epl1.0)))

(define-public nyuu
 (package
   (name "nyuu")
   (version "0.4.2")
   (source (origin
             (method url-fetch)
             (uri (string-append "https://github.com/Antidote2151/Nyuu-Obfuscation/releases/download/v" version"-Obfuscate1.3/nyuu-v" version "-Obfuscate1.3-linux-amd64.tar.xz"))
             (sha256
              (base32
               "194cglzs6aail9imzddmy12gd9l3b2ch1q5jzykllp8i36skk474"))))
   (build-system copy-build-system)
   (arguments
      (append
       (list #:install-plan `'(("./nyuu" "/bin/"))
             #:phases #~(modify-phases %standard-phases
                                       (replace 'unpack
                                                (lambda* (#:key source #:allow-other-keys)
                                                  (invoke "tar" "xvf" source)
                                                  (chmod "nyuu" #o755)))))))
   (native-inputs
    (list tar xz))
   ;(inputs (list `(,gcc "lib") zlib))
   (supported-systems '("x86_64-linux"))
   (home-page "https://github.com/Antidote2151/Nyuu-Obfuscation")
   (synopsis  "Flexible usenet binary posting tool")
   (description "A small variation of Nyuu with article Obfuscation")
   (license license:epl1.0)))



;par2cmdline-turbo
;nyuu
;parpar
;nzbget-next
