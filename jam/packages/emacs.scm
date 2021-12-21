(define-module (jam packages emacs)
  #:use-module (jam packages gcc)
  #:use-module (guix packages)
  #:use-module (guix memoization)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module ((gnu packages) #:prefix gnu:)
  #:use-module (guix diagnostics)
  #:use-module (guix i18n)
  #:use-module (gnu packages base)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gcc)
  #:use-module (ice-9 regex)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26))


(define (search-patch file-name)
  "Search the patch FILE-NAME.  Raise an error if not found."
  (or (search-path (%patch-path) file-name)
      (raise (formatted-message (G_ "~a: patch not found")
                                file-name))))

(define-syntax-rule (search-patches file-name ...)
  "Return the list of absolute file names corresponding to each FILE-NAME found in %PATCH-PATH."
  (list (search-patch file-name) ...))

(define %channel-root
  (find (lambda (path)
          (file-exists? (string-append path "/jam/packages/emacs.scm")))
        %load-path))

(define %patch-path
  (make-parameter
   (append
    (list (string-append %channel-root "/jam/packages/patches"))
    (gnu:%patch-path))))

(define emacs-with-native-comp
  (lambda* (emacs gcc #:optional full-aot)
    (let ((libgccjit (libgccjit-for-gcc gcc)))
      (package
        (inherit emacs)
        (source
         (origin
           (inherit (package-source emacs))
           (patches
            (append (search-patches "emacs-native-comp-exec-path.patch")
                    (filter
                     (lambda (f)
                       (not (any (cut string-match <> f)
                                 '("/emacs-exec-path\\.patch$"
                                   "/emacs-ignore-empty-xim-styles\\.patch$"))))
                     (origin-patches (package-source emacs)))))))
        (arguments
         (substitute-keyword-arguments (package-arguments emacs)
           ((#:make-flags flags ''())
            (if full-aot
                `(cons* "NATIVE_FULL_AOT=1" ,flags)
                flags))
           ((#:configure-flags flags)
            `(cons* "--with-native-compilation" ,flags))
           ((#:phases phases)
            `(modify-phases ,phases
               ;; Add build-time library paths for libgccjit.
               (add-before 'configure 'set-libgccjit-path
                 (lambda* (#:key inputs #:allow-other-keys)
                   (let ((libgccjit-libdir
                          (string-append (assoc-ref inputs "libgccjit")
                                         "/lib/gcc/" %host-type "/"
                                         ,(package-version libgccjit) "/")))
                     (setenv "LIBRARY_PATH"
                             (string-append libgccjit-libdir ":"
                                            (getenv "LIBRARY_PATH"))))
                   #t))
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
                        "-B" (assoc-ref inputs "libgccjit") "/lib/gcc/"))))
                   #t))))))
        (native-inputs
         (modify-inputs (package-native-inputs emacs)
                        (prepend gcc)))
        (inputs
         (modify-inputs (package-inputs emacs)
                        (prepend glibc)
                        (prepend libgccjit)))))))

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
   (emacs-with-native-comp emacs-next gcc-11 'full-aot)
   #:pkg-name "emacs-native-comp"
   #:pkg-version "29.0.50"
   #:pkg-revision "196"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "1a923e5ac642a914e8c789f95733dda5d64c4f14"
   #:checksum "1r36cp5l09fv0g36ap8ph4s8zjaqbyw9n8jil6dir2zfbdzxlhwq"))

(define-public emacs-pgtk
  (package
   (inherit emacs-next-pgtk)
   (arguments
    (substitute-keyword-arguments
     `(#:modules
       ((guix build glib-or-gtk-build-system)
        (guix build utils)
        (ice-9 regex)
        (srfi srfi-1)
        (srfi srfi-26))
        ,@(package-arguments emacs-next-pgtk))
     ((#:configure-flags flags) `(remove (cut string-match "--with-xwidgets" <>) ,flags))))))

(define-public emacs-pgtk-native-comp 
  (emacs-from-git
   (emacs-with-native-comp emacs-pgtk gcc-11 'full-aot)
   #:pkg-name "emacs-pgtk-native-comp"
   #:pkg-version "29.0.50"
   #:pkg-revision "196"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "1a923e5ac642a914e8c789f95733dda5d64c4f14"
   #:checksum "1r36cp5l09fv0g36ap8ph4s8zjaqbyw9n8jil6dir2zfbdzxlhwq"))
