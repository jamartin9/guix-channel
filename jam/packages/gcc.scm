
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


(define-public libgccjit-for-gcc
  (mlambda (gcc)
    (package
      (inherit gcc)
      (name "libgccjit")
      (outputs (delete "lib" (package-outputs gcc)))
      (properties (alist-delete 'hidden? (package-properties gcc)))
      (arguments
       (substitute-keyword-arguments `(#:modules ((guix build gnu-build-system)
                                                  (guix build utils)
                                                  (ice-9 regex)
                                                  (srfi srfi-1)
                                                  (srfi srfi-26))
                                       ,@(package-arguments gcc))
         ((#:configure-flags flags)
          `(append `("--enable-host-shared"
                     ,(string-append "--enable-languages=jit"))
                   (remove (cut string-match "--enable-languages.*" <>)
                           ,flags)))
         ((#:phases phases)
          `(modify-phases ,phases
             (add-after 'install 'remove-broken-or-conflicting-files
               (lambda* (#:key outputs #:allow-other-keys)
                 (for-each delete-file
                           (find-files (string-append (assoc-ref outputs "out") "/bin")
                                       ".*(c\\+\\+|cpp|g\\+\\+|gcov|gcc|gcc-.*)"))
                 #t)))))))))

(define-public libgccjit-11
  (libgccjit-for-gcc gcc-11))

(define-public libgccjit-10
  (libgccjit-for-gcc gcc-10))


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

;; gcc-10-jit
(define gcc-10-jit
  (package
   (inherit gcc-10)
   (outputs (delete "lib" (package-outputs gcc-10))) ;; delete http://debbugs.gnu.org/18101
   (arguments
    (substitute-keyword-arguments `(#:modules ((guix build gnu-build-system)
                                                (guix build utils)
                                                (ice-9 regex)
                                                (srfi srfi-1)
                                                (srfi srfi-26))
                                    ,@(package-arguments gcc))
                                  ((#:configure-flags flags) `(append `("--enable-host-shared" ,(string-append "--enable-languages=c,c++,jit"))
                                                                      (remove (cut string-match "--enable-languages.*" <>) ,flags)))
                                  ))))

;; gcc-glibc-pie-2.31-toolchain
(define-public gcc-glibc-pie-toolchain
  (make-gcc-toolchain gcc-10-jit glibc-pie))
