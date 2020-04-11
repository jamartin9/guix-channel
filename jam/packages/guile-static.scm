(define-module (jam packages guile-static)
  #:use-module (jam packages gcc)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages libunistring)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages bdw-gc)
  #:use-module (srfi srfi-1)
  )


;;  "enable flags in libunistring for PIC"
(define-public libunistring-pic
  (package
   (inherit libunistring)
   (name "libunistring-pic")
   (arguments
    (substitute-keyword-arguments (package-arguments libunistring)
                                  ((#:make-flags flags '("CFLAGS=-fPIC")) ''("CFLAGS=-fPIC"))
                                  ((#:configure-flags flags '("CFLAGS=-fPIC")) ''("CFLAGS=-fPIC"))))))

;; static libatomic-ops for libgc
(define-public libatomic-ops-static
  (package
   (inherit libatomic-ops)
   (arguments (substitute-keyword-arguments (package-arguments libatomic-ops)
                                            ((#:configure-flags flags ''()) `(cons "--enable-static" ,flags))))))
;; static gc until 'rebuild'
(define-public libgc-static
  (package
   (inherit libgc)
   (propagated-inputs
    (if (%current-target-system)
        ;; The build system refuses to check for compiler intrinsics when
        ;; cross-compiling, and demands using libatomic-ops instead.
        `(("libatomic-ops" ,libatomic-ops-static))
        '()))
   (arguments (substitute-keyword-arguments (package-arguments libgc)
                                            ((#:configure-flags flags ''()) `(cons "--enable-static" ,flags))))))


;;  "relocatable statically linked guile-3.0 with libs"
(define guile-stat-next
  (package
   (inherit guile-3.0)
   (name "guile-stat-next")
   (source (origin (inherit (package-source guile-3.0))
                   (patches (cons*
                                  (search-patch "guile-3.0-relocatable.patch")
                                  (search-patch "guile-2.2-default-utf8.patch")
                                  (search-patch "guile-3.0-linux-syscalls.patch")
                                  (origin-patches (package-source guile-3.0))))))
   (outputs (delete "debug" (package-outputs guile-3.0))) ;; repro see make-bootstrap
   (inputs ;; build libs
    `(("gcc-toolchain" ,gcc-glibc-pie-toolchain)
      ("gcc-toolchain:static" ,gcc-glibc-pie-toolchain "static")
      ("libunistring:static" ,libunistring-pic "static") ;; regular libunistring will be rewrote
      ("glibc:static" ,glibc-pie "static")
      ("glibc" ,glibc-pie)
      ,@(package-inputs guile-3.0)))
   (native-inputs ;; build tools
    `(
      ,@(package-native-inputs guile-3.0)
      ))
   (propagated-inputs ;; propagated needed libs
    `(("libunistring:static" ,libunistring-pic "static")
      ("libunistring" ,libunistring-pic)
      ("glibc:static" ,glibc-pie "static")
      ("glibc" ,glibc-pie)
      ("libffi" ,libffi)
      ("bdw-gc" ,libgc-static) ;; add static gc and remove old
      ,@(alist-delete "bdw-gc" (package-propagated-inputs guile-3.0)))
    )
   (arguments
    (substitute-keyword-arguments (package-arguments guile-3.0)
                                  ((#:strip-flags flags) ''()) ; remove strip flags
                                  ((#:configure-flags flags) ''("LDFLAGS=-ldl")) ; remove config flags
                                  ((#:phases '%standard-phases) ; remove static phase
                                   `(modify-phases ,phases
                                                   (delete 'pre-configure)
                                                   (add-before 'configure 'static-guile
                                                               (lambda _
                                                                 (substitute* "libguile/Makefile.in"
                                                                              ;; Create a statically-linked `guile'
                                                                              ;; executable.
                                                                              (("^guile_LDFLAGS =")
                                                                               "guile_LDFLAGS = -all-static")

                                                                              ;; Add `-ldl' *after* libguile-*.la.
                                                                              (("^guile_LDADD =(.*)$" _ ldadd)
                                                                               (string-append "guile_LDADD = " (string-trim-right ldadd) " -ldl\n")))))
                                                   ))


                                  ((#:tests? _ #f)
                                   ;; There are uses of `dynamic-link' in
                                   ;; {foreign,coverage}.test that don't fly here.
                                   #f)
                                  ;;((#:parallel-build? _ #f)
                                   ;; Work around the fact that the Guile build system is
                                   ;; not deterministic when parallel-build is enabled.
                                  ;;#f)
                                  ))))

(define-public guile-next-static
  (package
   (inherit guile-stat-next)
   (name "guile-next-static"))
  )

;; guile-next-static
