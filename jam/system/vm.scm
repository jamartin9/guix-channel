(define-module (jam system vm)
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
  #:use-module (gnu packages networking)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu packages curl)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix transformations)
  #:use-module (guix ci)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1)
  #:use-module (jam packages nzbget)
  #:use-module (nongnu packages compression) ; unrar-free fails unpacking with multipart issue(.r00)/crc issues and --cpu host needs to support instructions
  #:use-module (jam system channels)
  #:use-module (jam system services) ; kicksecure sysctl and kernel args
  #:use-module (jam system home)
  )

(define my-kernel linux-libre)

(define-public %jam-vm
  (operating-system
    (host-name "gnu")
    (timezone "Etc/UTC")
    (locale "en_US.utf8")
    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    (kernel my-kernel)
    (kernel-arguments %kicksecure-kernel-arguments)

    (label (string-append "GNU Guix " (package-version guix)))


    (bootloader (bootloader-configuration
                 (bootloader grub-bootloader)
                 (targets '("/dev/vda"))))

    (file-systems (cons (file-system
                          (mount-point "/")
                          (device "/dev/vda2")
                          (type "ext4"))
                        %base-file-systems))

    (users (cons (user-account
                  (name "guest")
                  (comment "GNU Guix Live")
                  (password "") ; no password
                  (group "users")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                 %base-user-accounts))

    (sudoers-file (plain-file "sudoers" "\
  root ALL=(ALL) ALL
  %wheel ALL=NOPASSWD: ALL\n"))

    (packages (append (list
                       isc-dhcp nss-certs iproute curl; curl/iproute for debugging
                       sudo
                       cloud-utils
                       nzbget-next unrar ;MAYBE use flatpak build instead of: nzbget-next unrar p7zip python3
                       parpar nyuu)
                      %base-packages-utils
                      %base-packages-linux))
    (services
     (append (list (service dhcp-client-service-type) ;; Use the DHCP client service rather than NetworkManager.
                   (service ntp-service-type
                            (ntp-configuration (servers (list
                                                        (ntp-server
                                                         (type 'pool)
                                                         (address "1.guix.pool.ntp.org") ; default 2.guix.pool.ntp.org includes ipv6
                                                         (options '("iburst"))))))); time without %desktop-services

                   (service openssh-service-type
                            (openssh-configuration (openssh openssh-sans-x)
                                                   (port-number 8080)
                                                   (password-authentication? #f)
                                                   (authorized-keys `(("guest" ,(plain-file "jam.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjfouQY9m8opK3Sq5G81FuqlMEa5no1Jy1UywweZY3u jam@jam-pc"))
                                                                      ("guest" ,(plain-file "jaming.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+JSxpOM9X8rM6bS0VEfmBeOaQi98o0+aDzYaWIhTBp jam@jam-workstation"))))))

                   (simple-service 'vpn-key-file etc-service-type
                                   (list `("openvpn/client.key" ,(local-file "riseup.key")))); https://api.black.riseup.net/3/cert (first half is key second is cert)
                   (simple-service 'vpn-cert-file etc-service-type
                                   (list `("openvpn/client.crt" ,(local-file "riseup.cert")))); TODO startup activation script to download
                   (simple-service 'vpn-ca-file etc-service-type
                                   (list `("openvpn/ca.crt" ,(local-file "riseup.ca")))) ; CA: https://black.riseup.net/ca.crt

                   (service openvpn-client-service-type; 'redirect-gateway def1'/'dhcp-option DNS 1.1.1.1' are not needed; test with curl https://checkip.amazonaws.com
                            (openvpn-client-configuration
                              (comp-lzo? #f) ; remove 'comp-lzo'
                              (remote (list (openvpn-remote-configuration
                                             (name "185.220.103.11"); curl https://api.black.riseup.net/3/config/eip-service.json | python -m json.tool
                                             (port 1194))))))

                   (simple-service 'vm-file etc-service-type
                                   (list `("vm.scm" ,(local-file "vm.scm"))))
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
                             (ruleset (plain-file "nftables.conf" "
                   # flush all the rules.
                   flush ruleset
                   # Define vars.
                   #define wan = eno1
                   define wan = eth0
                   define vpn = tun0
                   define vpn_net = 10.0.0.0/24
                   define router = 192.168.50.1 # 192.168.1.1

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

                       # allow nzbget
                       tcp dport 6789 accept

                       # allow dhcp
                       udp sport bootpc udp dport bootps ip saddr 0.0.0.0 ip daddr 255.255.255.255 accept comment \"Accept DHCPDISCOVER (for DHCP-Proxy)\"

                       # reject everything else
                       reject with icmpx type port-unreachable
                     }
                     chain output {
                       type filter hook output priority 0; policy drop;
                       # accept from local/dhcp/ntp/dns(10.0.2.3)/vpn drop rest (dig +short 1.guix.pool.ntp.org)
                       oifname { lo, $vpn } counter accept
                       oifname $wan ip daddr { 50.205.57.38, 149.28.200.179, 65.100.46.166, 44.190.5.123 } udp dport 123 counter accept
                       oifname $wan ip daddr 185.220.103.11 counter accept
                       oifname $wan ip daddr { 198.252.153.106, 198.252.153.67 } counter accept
                       oifname $wan ip daddr 255.255.255.255 counter accept
                       oifname $wan ip daddr 10.0.2.3 counter accept
                       ct state related,established accept
                       counter drop
                     }
                   }")))))
             (remove (lambda (service) ;; Remove services
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
                     (modify-services %base-services
                                      (sysctl-service-type config =>
                                                           (sysctl-configuration
                                                            (settings (append `(,@%kicksecure-sysctl-rules)
                                                                              %default-sysctl-settings))))
                                      (guix-service-type config =>
                                                         (guix-configuration
                                                          (inherit config)
                                                          (channels %jam-channels)
                                                          (guix (current-guix))
                                                          (privileged? #t)
                                                          (substitute-urls
                                                           (append (list "https://substitutes.nonguix.org/" "https://cuirass.genenetwork.org/"); 4zwzi66wwdaalbhgnix55ea3ab4pvvw66ll2ow53kjub6se4q2bclcyd.onion
                                                                   %default-substitute-urls)) ;(http-proxy) with tor config HTTPTunnelPort
                                                          (authorized-keys
                                                           (append (list (local-file "./nonguix.pub") (local-file "./gene.pub"))
                                                                   %default-authorized-guix-keys))))))))))
%jam-vm
