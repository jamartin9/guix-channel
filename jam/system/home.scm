(define-module (jam system home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
;  #:use-module (gnu home services sound)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services shepherd)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (srfi srfi-9 gnu)
  #:use-module (guix channels)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (jam packages emacs)
  #:use-module (jam packages tree-sitter)
  #:use-module (jam system services)
  #:use-module (jam system channels)
  #:use-module (guix gexp)
  #:export (%jam-home))

  (define emacs-service
    (shepherd-service
     (provision '(emacs))
     (start #~(make-system-constructor "emacs --daemon"))
     (stop #~(make-system-destructor "emacsclient --eval '(kill-emacs)'"))
     (auto-start? #f)))

  (define guix-service ; add type for portable guix package
    (shepherd-service
     (provision '(guix))
     (start #~(make-forkexec-constructor `("guix-daemon" ,(string-append "--listen=" (if (getenv "XDG_DATA_HOME") (getenv "XDG_DATA_HOME")
                                                                                         (string-append (getenv "HOME")
                                                                                                        file-name-separator-string
                                                                                                        ".local"
                                                                                                        file-name-separator-string
                                                                                                        "share"))
                                                                         file-name-separator-string
                                                                         "guix"
                                                                         file-name-separator-string
                                                                         "var"
                                                                         file-name-separator-string
                                                                         "guix"
                                                                         file-name-separator-string
                                                                         "daemon-socket"
                                                                         file-name-separator-string
                                                                         "socket") ;;"--build-users-group=guixbuild"
                                           "--disable-chroot")
                                         #:environment-variables `(,(string-append "NIX_STORE=" (if (getenv "XDG_DATA_HOME")
                                                                                                   (getenv "XDG_DATA_HOME")
                                                                                                    (string-append (getenv "HOME")
                                                                                                                   file-name-separator-string
                                                                                                                   ".local"
                                                                                                                   file-name-separator-string
                                                                                                                   "share"))
                                                                                   file-name-separator-string
                                                                                   "guix"
                                                                                   file-name-separator-string
                                                                                   "gnu"
                                                                                   file-name-separator-string
                                                                                   "store")
                                                                   ,@(environ))))
     (stop #~(make-kill-destructor))
     (auto-start? #f)))

  (define ssh-service ; writes to /etc/dropbear for keys
    (set-fields       ; least-authority-wrapper or fork+exec-command/container or run-container to contain
     (car ((@@ (gnu services ssh) dropbear-shepherd-service) (dropbear-configuration (port-number 2222)
                                                                                     (syslog-output? #f)
                                                                                     (password-authentication? #f)
                                                                                     (pid-file "/tmp/dropbear.pid"))))
     ((shepherd-service-requirement) '())
     ((shepherd-service-auto-start?) #f)))

(define %jam-home
  (home-environment
   (packages (append
            (list tree-sitter-yaml)
            ;(map transform-emacs-build-git (list emacs-fd))
            (map specification->package (list "guile"
                                              "emacs-pgtk" ; managed by default profile
                                              "git"
                                              "nss-certs"
                                              "aspell" "aspell-dict-en"
                                              ;"ungoogled-chromium" "ublock-origin-chromium"
                                              ;"ripgrep" ;"fd"
                                              ;"mpv"; MAYBE add guix package for mpv with libvdpau-nvidia from nvidia-libs nonguix
                                              ;"virt-viewer" ; "qemu"; for spice remote-viewer
                                              ;"alacritty"; "xterm"
                                              ;"screen"
                                              ;"xdg-utils" "xdg-dbus-proxy" "shared-mime-info"; "xorg-server-wayland" ;(list glib "bin")
                                              "gnupg"
                                              "curl"; emacs-osm needs for CA's
                                              "tree-sitter-rust" "tree-sitter-python"
                                              "emacs-gptel" "emacs-eat" "emacs-debbugs" "emacs-org-roam" "emacs-guix" "emacs-osm" "emacs-minions" "emacs-transmission" "emacs-undo-tree" "emacs-company" "emacs-dape" "emacs-which-key" "emacs-macrostep-geiser" "emacs-geiser-guile" "emacs-flymake-guile" "emacs-pyvenv"))))
   (services
    (append
     (list
     ;(service home-pipewire-service-type)
     (simple-service 'my-channel-services
                     home-channels-service-type
                     %jam-channels
                     )
     (service home-shepherd-service-type (home-shepherd-configuration
                                          (shepherd (specification->package "shepherd"))
                                          ;(auto-start? #f)
                                          (services (list emacs-service
                                                          ;transmission-service
                                                          ;ssh-service
                                                          ;guix-service
                                                          ))))

     (service home-bash-service-type
              (home-bash-configuration
               (package (specification->package "bash"))
               (guix-defaults? #f)
               ;(environment-variables (list '("EDITOR" . "emacs")))
               (bashrc (list (plain-file "guix.alias" "\

  _guix_opts default"))))))
     %base-home-services))))
%jam-home
