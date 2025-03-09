(define-module (jam system laptop)
  #:use-module (gnu)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu services avahi)
  #:use-module (gnu services linux)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services file-sharing)
  #:use-module (gnu services networking)
  #:use-module (gnu services sysctl)
  #:use-module (gnu services vpn)
  #:use-module (gnu services desktop)
  #:use-module (gnu services mcron)
  #:use-module (gnu services spice)
  #:use-module (gnu services xorg)
  #:use-module (gnu services sddm)
  #:use-module (gnu services cuirass)
  #:use-module (gnu services guix)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages bootloaders)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages nvi)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages xorg)
  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix transformations)
  #:use-module (guix ci)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1)
  #:use-module (nongnu packages linux)
  #:use-module (jam system home)
  #:use-module (jam system channels))

(define-public %jam-laptop
  (operating-system
  (host-name "jam-laptop")
  (timezone "Etc/UTC")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  (kernel linux)

  (label (string-append "GNU Guix " (package-version guix)))

  (firmware (list linux-firmware))

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets '("/boot/efi"))))

  (swap-devices (list (swap-space (target (uuid "739db872-a920-4caf-a661-76d1236da594")))))

  (file-systems (cons*
                 (file-system
                        (mount-point "/boot/efi")
                        (device (uuid "5B38-FA4C" 'fat32)) ; blkid output
                        (type "vfat"))
                 (file-system
                        (mount-point "/")
                        (device (uuid "376ff986-6a68-451a-a949-de7c8bd116e5" 'ext4))
                        (type "ext4"))
                      %base-file-systems))

  (users (cons (user-account
                (name "jam")
                (comment "Jam")
                (password "") ; no password
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  (packages (append (list blueman gvfs); podman flatpak gvfs
                    %base-packages))

  (services
   (append (list (service xfce-desktop-service-type)
                 (service slim-service-type)
                 (service bluetooth-service-type
                          (bluetooth-configuration
                           (auto-enable? #f)))
                 (simple-service 'os-file etc-service-type
                                 (list `("laptop.scm" ,(local-file "laptop.scm"))))
                 (simple-service 'os-file etc-service-type
                                 (list `("home.scm" ,(local-file "home.scm"))))
                 (simple-service 'channel-file etc-service-type ; link to ~/.config/guix/channels.scm
                                 (list `("channels.scm" ,(local-file "channels.scm"))))
                 (simple-service 'channel-file etc-service-type
                                 (list `("nonguix.pub" ,(local-file "nonguix.pub"))))
                 (simple-service 'jam-home-service guix-home-service-type
                                  `(("jam" ,%jam-home))))
           (remove (lambda (service)
                     (let ((type (service-kind service)))
                       (memq type
                             (list gdm-service-type
                                   sddm-service-type
                                   avahi-service-type
                                   cups-pk-helper-service-type
                                   modem-manager-service-type))))
                   (modify-services %desktop-services
                                    (sysctl-service-type config =>
                                                         (sysctl-configuration
                                                          (settings (append `(;("net.ipv6.conf.all.forwarding" . "1")
                                                                              ("net.ipv4.ip_forward" . "1"))
                                                                            %default-sysctl-settings))))
                                    (guix-service-type config =>
                                                       (guix-configuration
                                                        (inherit config)
                                                        (channels %jam-channels)
                                                        (guix (current-guix))
                                                        (substitute-urls
                                                         (append (list "https://substitutes.nonguix.org/"); 4zwzi66wwdaalbhgnix55ea3ab4pvvw66ll2ow53kjub6se4q2bclcyd.onion
                                                                 %default-substitute-urls)) ;(http-proxy) with tor config HTTPTunnelPort
                                                        (authorized-keys
                                                         (append (list (local-file "./nonguix.pub"))
                                                                 %default-authorized-guix-keys))))))))))
%jam-laptop
