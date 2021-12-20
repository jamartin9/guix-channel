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
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages xorg)
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
         `(("gcc" ,gcc)
           ,@(package-native-inputs emacs)))
        (inputs
         `(("glibc" ,glibc)
           ("libgccjit" ,libgccjit)
           ("libxcomposite" ,libxcomposite) ;; FIXME belongs upstream
           ,@(package-inputs emacs)))))))

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
   #:pkg-revision "195"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "21ef1740f0fe9424f2a079440d070f725b2ca558"
   #:checksum "0svdxcg1z84h03rydd4hg2mp046m3lacssg2b6r94597jznca7j0"))

(define-public emacs-next-pgtk-noxwidgets
  (let ((commit "ae18c8ec4f0ef37c8c9cda473770ff47e41291e2")
        (revision "1"))
    (package
      (inherit emacs-next)
      (name "emacs-next-pgtk-noxwidgets")
      (version (git-version "28.0.50" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://git.savannah.gnu.org/git/emacs.git/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "07hgfqh965zmra0rbmnf63p3lsinpv5hn5payqcrjx25pl75xnaf"))))
      (arguments
       (substitute-keyword-arguments (package-arguments emacs-next)
         ((#:configure-flags flags ''())
          `(cons* "--with-pgtk" ,flags)))) ;; TODO: upstream remove xwidgets
      (propagated-inputs
       (list gsettings-desktop-schemas glib-networking))
      (inputs
       `(("webkitgtk" ,webkitgtk-with-libsoup2)
         ,@(package-inputs emacs-next)))
      (home-page "https://github.com/masm11/emacs")
      (synopsis "Emacs text editor with @code{pgtk} and @code{xwidgets} support")
      (description "This is an unofficial Emacs fork build with a pure-GTK
graphical toolkit to work natively on Wayland.  In addition to that, xwidgets
also enabled and works without glitches even on X server."))))


(define-public emacs-pgtk-native-comp 
  (emacs-from-git
   (emacs-with-native-comp emacs-next-pgtk-noxwidgets gcc-11 'full-aot)
   #:pkg-name "emacs-pgtk-native-comp"
   #:pkg-version "29.0.50"
   #:pkg-revision "195"
   #:git-repo "https://git.savannah.gnu.org/git/emacs.git"
   #:git-commit "21ef1740f0fe9424f2a079440d070f725b2ca558"
   #:checksum "0svdxcg1z84h03rydd4hg2mp046m3lacssg2b6r94597jznca7j0"))
