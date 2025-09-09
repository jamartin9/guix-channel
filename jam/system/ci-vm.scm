(define-module (jam system ci-vm)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system shadow)
  #:use-module (gnu services)
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
;  #:use-module (gnu packages databases)
  #:use-module (gnu services databases); for cuirass
  #:use-module (gnu services cuirass)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services guix) ; guix-home-service-type
  #:use-module (gnu packages bootloaders)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages nvi)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg) ; SPICE dynamic resizing for xfce
  #:use-module (gnu packages networking)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages nss)
;  #:use-module (gnu packages freedesktop); waypipe
;  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix transformations)
  #:use-module (guix ci)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1)
  #:use-module (jam packages nzbget)
  #:use-module (nongnu packages compression) ; unrar
;  #:use-module (nongnu packages linux)
;  #:use-module (nongnu system linux-initrd)
;  #:use-module (jam packages zfs) ; zfs
  #:use-module (jam system channels)
  #:use-module (jam system home)
  #:use-module (jam system services) ; kicksecure sysctl and kernel args
  )


(define my-kernel linux-libre)

(define-public %ci-vm
  (operating-system
    (host-name "gnu")
    (timezone "Etc/UTC")
    (locale "en_US.utf8")
    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    (kernel my-kernel)
    ;(initrd microcode-initrd)
    (kernel-arguments %kicksecure-kernel-arguments)

    (label (string-append "GNU Guix " (package-version guix)))

    ;(firmware (list linux-firmware))

    (bootloader (bootloader-configuration
                 (bootloader grub-bootloader)
                 ;(terminal-outputs '(console))
                 (targets '("/dev/vda"))))

    (file-systems (cons (file-system
                          (mount-point "/")
                          (device "/dev/vda2");(device (file-system-label "root"))
                          ;(options "compress=zstd,space_cache=v2"); ssd_spread,discard
                          (type "ext4")); "btrfs"
                        %base-file-systems))

    (users (cons (user-account
                  (name "guest")
                  (comment "GNU Guix Live")
                  (password "") ; no password
                  (group "users")
                  (supplementary-groups '("wheel" "netdev"
                                          "audio" "video")))
                 %base-user-accounts))

    ;; Our /etc/sudoers file.  Since 'guest' initially has an empty password; allow for password-less sudo.
    (sudoers-file (plain-file "sudoers" "\
  root ALL=(ALL) ALL
  %wheel ALL=NOPASSWD: ALL\n"))

    (packages (append (list ;x-resize ; xfce spice resizing https://gitlab.xfce.org/xfce/xfce4-settings/-/issues/142
                       isc-dhcp nss-certs
                       sudo
                       cloud-utils); cloud-utils for growpart with resize2fs after img resize
                      %base-packages-utils
                      %base-packages-linux)) ;wget man-db guix-icons; podman flatpak gvfs waypipe
    ;(name-service-switch %mdns-host-lookup-nss) ;; Allow resolution of '.local' host names with mDNS.
    (services
     (append (list ;(service xfce-desktop-service-type) ; keep commented configs for later serving/subs
                   ;(service slim-service-type ;; Choose SLiM, which is lighter than the default GDM.
                   ;         (slim-configuration
                   ;          (auto-login? #t)
                   ;          (default-user "guest")
                   ;          (xorg-configuration
                   ;           (xorg-configuration
                   ;            (modules (cons* xf86-video-qxl;; QXL virtual GPU driver for SPICE
                   ;                            %default-xorg-modules))
                   ;            (keyboard-layout keyboard-layout)))))
                   ;(service spice-vdagent-service-type);; Enables dynamic resizing of the guest screen resolution, clipboard and integration with the host SPICE protocol
                   ;(service plasma-desktop-service-type) ; plasma and sddm login for KDE(wayland)
                   ;(service sddm-service-type
                   ;          (sddm-configuration
                   ;           (theme "breeze")))
                   ;(service zfs-service-type ; maybe snapshot sync from existing when on root?
                   ;         (zfs-configuration
                   ;          (kernel my-kernel)))
              (service cuirass-service-type
                            (cuirass-configuration (specifications #~(list (specification
                                                                            (name "binary")
                                                                            (build '(custom (jam ci)))
                                                                            (channels (list (channel ;; custom guix override
                                                                                             (name 'guix)
                                                                                             (url "https://git.savannah.gnu.org/git/guix.git")
                                                                                             (introduction
                                                                                              (make-channel-introduction
                                                                                               "9edb3f66fd807b096b48283debdcddccfea34bad"
                                                                                               (openpgp-fingerprint
                                                                                                "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
                                                                                            (channel ;; GUIX_PACKAGE_PATH and (url "file:///home/.../guix-channel")
                                                                                             (name 'mychannel)
                                                                                             (url "https://codeberg.org/jamartin9/guix-channel")
                                                                                             (introduction
                                                                                              (make-channel-introduction
                                                                                               "a8de09ac62260319e6376f21c995f713c1b09279"
                                                                                               (openpgp-fingerprint
                                                                                                "34AF BE87 8193 580F F441  AB3F 95AF 699C 293E 302B"))))))
                                                                            ;(notifications (list (rss-feed))); add import for (cuirass rss) for https://127.0.0.1/events/rss/?specification=my-channel-packages
                                                                            (build-outputs (list
                                                                                            (build-output
                                                                                             (job "binary*")
                                                                                             (type "archive")
                                                                                             (output "out")
                                                                                             (path ""))))
                                                                            (period 86400))
                                                                           (specification
                                                                            (name "packages")
                                                                            (build '(channels mychannel))
                                                                            (channels (list (channel
                                                                                             (name 'guix)
                                                                                             (url "https://git.savannah.gnu.org/git/guix.git")
                                                                                             (introduction
                                                                                              (make-channel-introduction
                                                                                               "9edb3f66fd807b096b48283debdcddccfea34bad"
                                                                                               (openpgp-fingerprint
                                                                                                "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
                                                                                            (channel
                                                                                             (name 'mychannel)
                                                                                             (url "https://codeberg.org/jamartin9/guix-channel")
                                                                                             (introduction
                                                                                              (make-channel-introduction
                                                                                               "a8de09ac62260319e6376f21c995f713c1b09279"
                                                                                               (openpgp-fingerprint
                                                                                                "34AF BE87 8193 580F F441  AB3F 95AF 699C 293E 302B"))))))
                                                                            (period 86400))))
                                                   (ttl 172800); two days before clearing gc roots
                                                   (host "0.0.0.0")))
                   (service postgresql-service-type
                            (postgresql-configuration
                             (postgresql (@ (gnu packages databases) postgresql-15))))
                   (service dhcpcd-service-type) ;; Use the DHCP client service rather than NetworkManager.
                   (service ntp-service-type); time without %desktop-services

                   (service openssh-service-type
                            (openssh-configuration ;(%auto-start? #f)
                                                   (openssh openssh-sans-x)
                                                   (port-number 8080)
                                                   (password-authentication? #f)
                                                   (authorized-keys `(("guest" ,(plain-file "jam.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjfouQY9m8opK3Sq5G81FuqlMEa5no1Jy1UywweZY3u jam@jam-pc"))
                                                                      ("guest" ,(plain-file "jaming.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+JSxpOM9X8rM6bS0VEfmBeOaQi98o0+aDzYaWIhTBp jam@jam-workstation"))))))

                   (simple-service 'vm-file etc-service-type
                                   (list `("ci-vm.scm" ,(local-file "ci-vm.scm"))))
                   (simple-service 'home-file etc-service-type
                                   (list `("home.scm" ,(local-file "home.scm"))))
                   (simple-service 'channel-file etc-service-type ; link to ~/.config/guix/channels.scm
                                   (list `("channels.scm" ,(local-file "channels.scm"))))
                   (simple-service 'channel-pub etc-service-type
                                   (list `("nonguix.pub" ,(local-file "nonguix.pub"))))
                   (simple-service 'gene-channel-pub etc-service-type
                                   (list `("gene.pub" ,(local-file "gene.pub"))))
                   (simple-service 'guest-home-service guix-home-service-type
                                  `(("guest" ,%jam-home)))

                   (service nftables-service-type
                            (nftables-configuration
                             (ruleset (plain-file "nftables.conf" "# Firewall hook order is: prerouting -> input/output/forward -> postrouting
                   # flush all the rules.
                   flush ruleset
                   # Define vars.
                   #define wan = eno1
                   define wan = eth0
                   define vpn = wg0
                   define vpn_net = 10.0.0.0/24
                   define router = 192.168.50.1 # 192.168.1.1

                   #table inet nat {
                   #  chain prerouting {
                   #    type nat hook prerouting priority -100;
                   #  }
                   #  chain postrouting {
                   #    type nat hook postrouting priority 100;
                   #    oifname $wan ip saddr $vpn_net masquerade
                   #  }
                   #}
                   table inet filter {
                     chain input {
                       type filter hook input priority 0; policy drop;

                       # early drop of invalid connections
                       ct state invalid drop

                       # allow established/related connections
                       ct state { established, related } accept

                       # allow from loopback
                       iifname lo accept

                       # drop icmp
                       ip protocol icmp drop
                       ip6 nexthdr icmpv6 drop

                       # allow ssh
                       tcp dport 8080 accept

                       # allow spice
                       #tcp dport 5930 accept

                       # allow ssdp, pcp and nat-pmp port mapping
                       #udp sport 1900 udp dport >= 1024 meta pkttype unicast limit rate 4/second burst 20 packets accept comment \"Accept UPnP IGD port mapping reply\"
                       #udp sport 1900 ip saddr $router accept
                       #udp sport 5350 ip saddr $router accept
                       #udp sport 5351 ip saddr $router accept

                       # allow cuirass
                       tcp dport 8081 accept

                       # allow wireguard peers to connect to each other
                       #iifname $vpn accept
                       #udp dport 51820 accept
                       #iifname $vpn oifname $vpn ct state new accept

                       # allow dhcp
                       udp sport bootpc udp dport bootps ip saddr 0.0.0.0 ip daddr 255.255.255.255 accept comment \"Accept DHCPDISCOVER (for DHCP-Proxy)\"

                       # allow mdns
                       #udp dport mdns ip6 daddr ff02::fb accept comment \"Accept mDNS\"
                       #udp dport mdns ip daddr 224.0.0.251 accept comment \"Accept mDNS\"

                       # reject everything else
                       reject with icmpx type port-unreachable
                     }
                     #chain forward {
                     #  type filter hook forward priority 0; policy drop;

                       # drop invalid packets
                     #  ct state invalid drop

                       # forward established connections
                     #  ct state established,related accept

                       # forward wireguard to wan
                     #  iifname $vpn oifname $wan ct state new accept
                     #}
                     chain output {
                       type filter hook output priority 0; policy accept;
                     }
                   }")))))
             (remove (lambda (service) ;; Remove some services that don't make sense in a desktop VM.
                       (let ((type (service-kind service)))
                         (or (memq type
                                   (list gdm-service-type
                                         sddm-service-type
                                         wpa-supplicant-service-type
                                         cups-pk-helper-service-type
                                         network-manager-service-type
                                         modem-manager-service-type))
                             (eq? 'network-manager-applet
                                  (service-type-name type)))))
                     (modify-services %base-services; %desktop-services
                                      (sysctl-service-type config =>
                                                           (sysctl-configuration
                                                            (settings (append `(,@%kicksecure-sysctl-rules
                                                                                ("net.ipv6.conf.all.forwarding" . "1")
                                                                                ("net.ipv4.ip_forward" . "1")
                                                                                )
                                                                              %default-sysctl-settings))))
                                      (guix-service-type config =>
                                                         (guix-configuration
                                                          (inherit config)
                                                          (channels %jam-channels)
                                                          ;(log-compression 'none); use btrfs compression
                                                          (guix (current-guix))
                                                          (privileged? #t); https://issues.guix.gnu.org/77862 overflow id causes test suites to fail
                                                          (substitute-urls
                                                           (append (list "https://substitutes.nonguix.org/" "https://cuirass.genenetwork.org/"); 4zwzi66wwdaalbhgnix55ea3ab4pvvw66ll2ow53kjub6se4q2bclcyd.onion
                                                                   %default-substitute-urls)) ;(http-proxy) with tor config HTTPTunnelPort
                                                          (authorized-keys
                                                           (append (list (local-file "./nonguix.pub") (local-file "./gene.pub"))
                                                                   %default-authorized-guix-keys))))))))))
%ci-vm
