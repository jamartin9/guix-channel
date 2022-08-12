(define-module (jam packages emacs)
  #:use-module (jam packages gcc)
  #:use-module (guix packages)
  #:use-module (guix memoization)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix build utils)
  #:use-module ((gnu packages) #:prefix gnu:)
  #:use-module (guix diagnostics)
  #:use-module (guix i18n)
  #:use-module (gnu packages base)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gcc)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26))

(define emacs-with-native-comp
  (lambda* (emacs gcc #:optional full-aot)
    (let ((libgccjit (libgccjit-for-gcc gcc)))
      (package
        (inherit emacs)
        (source
         (origin
           (inherit (package-source emacs))
           (patches
            (if (string=? "emacs-next-pgtk" (package-name emacs))
                (filter
                 (lambda (f)
                   (not (any (cut string-match <> f)
                             '("/emacs-source-date-epoch\\.patch$")))); emacs-29
                 (origin-patches (package-source emacs)))
             (origin-patches (package-source emacs))))))
        (arguments
         (substitute-keyword-arguments (package-arguments emacs)
           ((#:make-flags flags #~'())
            (if full-aot
                #~(cons* "NATIVE_FULL_AOT=1" #$flags)
                flags))
           ((#:configure-flags flags)
            #~(cons* "--with-native-compilation" #$flags))
           ((#:phases phases)
            #~(modify-phases #$phases
               ;; Add build-time library paths for libgccjit.
               (add-before 'configure 'set-libgccjit-path
                 (lambda* (#:key inputs #:allow-other-keys)
                   (let ((libgccjit-libdir
                          (string-append (assoc-ref inputs "libgccjit")
                                         "/lib/gcc/" %host-type "/"
                                         #$(package-version libgccjit) "/")))
                     (setenv "LIBRARY_PATH"
                             (string-append libgccjit-libdir ":"
                                            (getenv "LIBRARY_PATH"))))))
               ;; Add runtime library paths for libgccjit.
               (add-after 'unpack 'patch-driver-options
                 (lambda* (#:key inputs #:allow-other-keys)
                   (substitute* "lisp/emacs-lisp/comp.el"
                     (("\\(defcustom native-comp-driver-options nil")
                      (format
                       #f "(defcustom native-comp-driver-options '(~s ~s ~s ~s)"
                       (string-append
                        "-B" (assoc-ref inputs "binutils") "/bin/")
                       (string-append
                        "-B" (assoc-ref inputs "glibc") "/lib/")
                       (string-append
                        "-B" (assoc-ref inputs "libgccjit") "/lib/")
                       (string-append
                        "-B" (assoc-ref inputs "libgccjit") "/lib/gcc/"))))))))))
        (native-inputs
         (modify-inputs (package-native-inputs emacs)
                        (prepend gcc)))
        (inputs
         (modify-inputs (package-inputs emacs)
                        (prepend glibc libgccjit)))))))

(define emacs-from-git
  (lambda* (emacs #:key pkg-name pkg-version pkg-revision git-repo git-commit checksum)
    (package
      (inherit emacs)
      (name pkg-name)
      (version (git-version pkg-version pkg-revision git-commit))
      (source
       (origin
         (inherit (package-source emacs))
         (method git-fetch)
         (uri (git-reference
               (url git-repo)
               (commit git-commit)))
         (sha256 (base32 checksum))
         (file-name (git-file-name pkg-name pkg-version))))
      (outputs
       '("out" "debug")))))

(define-public emacs-native-comp
  (emacs-from-git
   (emacs-with-native-comp emacs-next gcc-12 'full-aot)
   #:pkg-name "emacs-native-comp"
   #:pkg-version "28.1.91"
   #:pkg-revision "206"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "e6af4968f947a3e536fbd80e74fea44ca18e22ac"
   #:checksum "0qh598zzwh2vnplp9h33rx7nk311adzpnhzkp2yp1yhqlxqzx3wj"))

(define-public emacs-pgtk-native-comp 
  (emacs-from-git
   (emacs-with-native-comp emacs-next-pgtk gcc-12 'full-aot)
   #:pkg-name "emacs-pgtk-native-comp"
   #:pkg-version "29.0.50"
   #:pkg-revision "206"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "c0d761bf7f441f8ab9792351a493dc6bd5525dc1"
   #:checksum "1i4rx2c530mqw2wyjhck461c3xra2pxhsa030cm4c8a33b1q8g7v"))
