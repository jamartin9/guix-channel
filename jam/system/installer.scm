(define-module (jam system installer)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu system image) ;image
  #:use-module (gnu ci) ;image
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages mtools)
  #:use-module (gnu packages ntp)
  #:use-module (gnu packages package-management)
  #:use-module (gnu system)
  #:use-module (gnu system image)
  #:use-module (gnu services base)
  #:use-module (nongnu packages linux)
  #:use-module (guix)
  #:use-module (guix ci)
  #:use-module (guix channels)
  #:use-module (jam system services)
  #:export (installation-os-nonfree))

(define-public installation-os-nonfree
  (operating-system
    (inherit installation-os)
    (kernel linux)
    (firmware (list linux-firmware))

    ;; Add the 'net.ifnames' argument to prevent network interfaces
    ;; from having really long names.  This can cause an issue with
    ;; wpa_supplicant when you try to connect to a wifi network.
    (kernel-arguments '("quiet" "modprobe.blacklist=radeon" "net.ifnames=0"))

    (services
     (append (list (simple-service 'channel-file etc-service-type ;Include the channel file so that it can be used during installation
                                   (list `("channels.scm" ,(local-file
                                                            "channels.scm")))))

             (modify-services (operating-system-user-services installation-os)
               (guix-service-type config =>
                                  (guix-configuration (inherit config)
                                                      (guix (current-guix))
                                                      (channels   (list (channel
           ;custom guix override
          (name 'guix)
          (url "https://codeberg.org/guix/guix.git")
          ;; (commit "b416322c05d769d637979ad4ef7287aefbccb4bd")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
        (channel
           ;GUIX_PACKAGE_PATH and (url "file:///home/.../guix-channel")
          (name 'mychannel)
          (url "https://codeberg.org/jamartin9/guix-channel")
          (introduction
           (make-channel-introduction
            "a8de09ac62260319e6376f21c995f713c1b09279"
            (openpgp-fingerprint
             "34AF BE87 8193 580F F441  AB3F 95AF 699C 293E 302B"))))))
                                                      (substitute-urls (append
                                                                        (list
                                                                         "https://substitutes.nonguix.org/"
                                                                         "https://cuirass.genenetwork.org/")
                                                                        %default-substitute-urls))
                                                      (authorized-keys (append
                                                                        (list (local-file
                                                                               "./nonguix.pub")
                                                                              
                                                                              (local-file
                                                                               "./gene.pub"))
                                                                        %default-authorized-guix-keys)))))))

    (packages ;Add some extra packages useful for the installation process
              (append (list git curl emacs-no-x-toolkit ntp)
                      (operating-system-packages installation-os)))))

installation-os-nonfree
