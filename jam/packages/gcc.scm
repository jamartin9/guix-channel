(define-module (jam packages gcc)
  #:use-module (guix packages)
  #:use-module (guix memoization)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages gcc)
  #:use-module (ice-9 regex)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (gnu packages base)
  #:use-module (gnu packages commencement)
  )

;;  "enable flags in modified glibc for PIE without nscd, and with static NSS modules "
(define-public glibc-pie
  (package
   (inherit glibc)
   (name "glibc-pie")
   (arguments
    (substitute-keyword-arguments (package-arguments glibc)
                                  ((#:configure-flags flags) `(cons* "--enable-static-pie" "--disable-nscd" "--disable-build-nscd" "--enable-static-nss" ,flags))
                                  ))))

;;  "replace all packages called glibc with glibc-pie"
;; rewrite based on string to match static outputs too
(define glibc-instead-pie
  (package-input-rewriting/spec `(("glibc" . ,(const glibc-pie) ))))

;; gcc-glibc-pie-2.35-toolchain
(define-public gcc-glibc-pie-toolchain
  (make-gcc-toolchain gcc-10 glibc-pie))
