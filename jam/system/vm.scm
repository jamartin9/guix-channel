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
  #:use-module (gnu packages xdisorg) ; SPICE dynamic resizing for xfce
  #:use-module (gnu packages networking)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages file-systems)
;  #:use-module (guix)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix transformations)
  #:use-module (guix ci)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1)
;  #:use-module (nongnu packages linux)
;  #:use-module (nongnu system linux-initrd)
;  #:use-module (nongnu packages nvidia)
;  #:use-module (nongnu services nvidia)
;  #:use-module (jam system services) ; nvidia
;  #:use-module (jam packages zfs) ; zfs
  #:use-module (jam system channels)
  #:use-module (jam system home)
  )

(define my-kernel linux-libre-6.9)

;; Source: <https://github.com/Kicksecure/security-misc> via https://github.com/rakino/Testament/blob/trunk/testament/kicksecure.scm
;; Extracted with the following command:
;; cat etc/default/grub.d/* | sed -e 's/#\+/;;/g' -e 's/GRUB.*DEFAULT /\"/g' -e 's/GRUB.*LINUX /\"/g' -e '/GRUB/d' -e 's/\(\".*[a-z0-9]\)\ \([a-z].*\"\)/\1\"\n\"\2/g' -e '/dpkg/d'
(define-public %kicksecure-kernel-arguments
  '(;; Enables all known mitigations for CPU vulnerabilities.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/index.html
    ;; https://forums.whonix.org/t/should-all-kernel-patches-for-cpu-bugs-be-unconditionally-enabled-vs-performance-vs-applicability/7647

    ;; Enable mitigations for Spectre variant 2 (indirect branch speculation).
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/spectre.html
    "spectre_v2=on"

    ;; Disable Speculative Store Bypass.
    "spec_store_bypass_disable=on"

    ;; Enable mitigations for the L1TF vulnerability through disabling SMT
    ;; and L1D flush runtime control.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html
    "l1tf=full,force"

    ;; Enable mitigations for the MDS vulnerability through clearing buffer cache
    ;; and disabling SMT.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html
    "mds=full,nosmt"

    ;; Patches the TAA vulnerability by disabling TSX and enables mitigations using
    ;; TSX Async Abort along with disabling SMT.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html
    "tsx=off"
    "tsx_async_abort=full,nosmt"

    ;; Mark all huge pages in the EPT as non-executable to mitigate iTLB multihit.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/multihit.html
    "kvm.nx_huge_pages=force"

    ;; Enables mitigations for SRBDS to prevent MDS attacks on RDRAND and RDSEED instructions.
    ;; Only mitigated through microcode updates from Intel.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/special-register-buffer-data-sampling.html
    ;; https://access.redhat.com/solutions/5142691

    ;; Force disable SMT as it has caused numerous CPU vulnerabilities.
    ;; The only full mitigation of cross-HT attacks is to disable SMT.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/core-scheduling.html
    ;; https://forums.whonix.org/t/should-all-kernel-patches-for-cpu-bugs-be-unconditionally-enabled-vs-performance-vs-applicability/7647/17
    "nosmt=force";; MAYBE disable for perf

    ;; Enables the prctl interface to prevent leaks from L1D on context switches.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1d_flush.html
    "l1d_flush=on"

    ;; Mitigates numerous MMIO Stale Data vulnerabilities and disables SMT.
    ;;
    ;; https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html
    "mmio_stale_data=full,nosmt"
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Distrusts the bootloader for initial entropy at boot.
    ;;
    ;; https://lkml.org/lkml/2022/6/5/271
    "random.trust_bootloader=off"
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Distrusts the CPU for initial entropy at boot as it is not possible to
    ;; audit, may contain weaknesses or a backdoor.
    ;;
    ;; https://en.wikipedia.org/wiki/RDRAND;;Reception
    ;; https://twitter.com/pid_eins/status/1149649806056280069
    ;; https://archive.nytimes.com/www.nytimes.com/interactive/2013/09/05/us/documents-reveal-nsa-campaign-against-encryption.html
    ;; https://forums.whonix.org/t/entropy-config-random-trust-cpu-yes-or-no-rng-core-default-quality/8566
    ;; https://lkml.org/lkml/2022/6/5/271
    "random.trust_cpu=off"
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Enables IOMMU to prevent DMA attacks.
    "intel_iommu=on"
    "amd_iommu=on"

    ;; Disable the busmaster bit on all PCI bridges during very
    ;; early boot to avoid holes in IOMMU.
    ;;
    ;; https://mjg59.dreamwidth.org/54433.html
    ;; https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4444f8541dad16fefd9b8807ad1451e806ef1d94
    "efi=disable_early_pci_dma"

    ;; Enables strict enforcement of IOMMU TLB invalidation so devices will never be able to access stale data contents
    ;; https://github.com/torvalds/linux/blob/master/drivers/iommu/Kconfig;;L97
    ;; Page 11 of https://lenovopress.lenovo.com/lp1467.pdf
    "iommu.passthrough=0"
    "iommu.strict=1"
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;;echo ";; kver: $kver"

    ;; Disables the merging of slabs of similar sizes.
    ;; Sometimes a slab can be used in a vulnerable way which an attacker can exploit.
    "slab_nomerge"

    ;; Enables sanity checks (F) and redzoning (Z).
    ;; Disabled due to kernel deciding to implicitly disable kernel pointer hashing
    ;; https://github.com/torvalds/linux/commit/792702911f581f7793962fbeb99d5c3a1b28f4c3
    ;;"slub_debug=FZ"

    ;; Zero memory at allocation and free time.
    "init_on_alloc=1"
    "init_on_free=1"

    ;; Machine check exception handler decides whether the system should panic or not based on the exception that happened.
    ;; https://forums.whonix.org/t/kernel-hardening/7296/494
    ;;"mce=0"

    ;; Enables Kernel Page Table Isolation which mitigates Meltdown and improves KASLR.
    "pti=on"

    ;; Vsyscalls are obsolete, are at fixed addresses and are a target for ROP.
    "vsyscall=none"

    ;; Enables page allocator freelist randomization.
    "page_alloc.shuffle=1"

    ;; Enables randomisation of the kernel stack offset on syscall entries (introduced in kernel 5.13).
    ;; https://lkml.org/lkml/2019/3/18/246
    "randomize_kstack_offset=on"

    ;; Enables kernel lockdown.
    ;;
    ;; Disabled for now as it enforces module signature verification which breaks
    ;; too many things.
    ;; https://forums.whonix.org/t/enforce-kernel-module-software-signature-verification-module-signing-disallow-kernel-module-loading-by-default/7880
    ;;
    ;;  "lockdown=confidentiality"
    ;;fi

    ;; Gather more entropy during boot.
    ;;
    ;; Requires linux-hardened kernel patch.
    ;; https://github.com/anthraxx/linux-hardened
    "extra_latent_entropy"

    ;; Restrict access to debugfs since it can contain a lot of sensitive information.
    ;; https://lkml.org/lkml/2020/7/16/122
    ;; https://github.com/torvalds/linux/blob/fb1201aececc59990b75ef59fca93ae4aa1e1444/Documentation/admin-guide/kernel-parameters.txt;;L835-L848
    ;"debugfs=off";; MAYBE disable as guix has debugfs on by default

    ;; Force the kernel to panic on "oopses" (which may be due to false positives)
    ;; https://forums.whonix.org/t/set-oops-panic-kernel-parameter-or-kernel-panic-on-oops-1-sysctl-for-better-security/7713
    ;; Implemented differently:
    ;; /usr/libexec/security-misc/panic-on-oops
    ;; /etc/X11/Xsession.d/50panic_on_oops
    ;; /etc/sudoers.d/security-misc
    ;;"oops=panic"
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Prevent kernel info leaks in console during boot.
    ;; https://phabricator.whonix.org/T950

    ;; LANG=C str_replace is provided by package helper-scripts.

    ;; The following command actually removed "quiet" from the kernel command line.
    ;; If verbosity is desired, the user might want to keep this line.
    ;; Remove "quiet" from "because "quiet" must be first.

    ;; If verbosity is desired, the user might want to out-comment the following line.
    "quiet"
    "loglevel=0"

    ;; NOTE:
    ;; After editing this file, running:
    ;; sudo update-grub
    ;; is required.
    ;;
    ;; If higher verbosity is desired, the user might also want to delete file
    ;; /etc/sysctl.d/30_silent-kernel-printk.conf
    ;; (or out-comment its settings).
    ;;
    ;; Alternatively, the user could consider to install the debug-misc package,
    ;; which will undo the settings found here.
    ))

;; Source <https://github.com/Kicksecure/security-misc>>
;; Extracted with the following command:
;; cat etc/sysctl.d/* | sed -e 's/#\+/;;/g' -e 's/ = /=/g' -e 's/;;\(.*\..*\)=\(.*\)/;; ("\1" . "\2")/g' -e 's/\(.*\..*\)=\(.*\)/("\1" . "\2")/g' -e 's@/bin\|/usr/bin@/run/current-system/profile/bin@g'
(define-public %kicksecure-sysctl-rules
  '(;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Disables coredumps. This setting may be overwritten by systemd so this may not be useful.
    ;; security-misc also disables coredumps in other ways.
    ("kernel.core_pattern" . "|/run/current-system/profile/bin/false")

    ;; Restricts the kernel log to root only.
    ("kernel.dmesg_restrict" . "1")

    ;; Don't allow writes to files that we don't own
    ;; in world writable sticky directories, unless
    ;; they are owned by the owner of the directory.
    ("fs.protected_fifos" . "2")
    ("fs.protected_regular" . "2")

    ;; Only allow symlinks to be followed when outside of
    ;; a world-writable sticky directory, or when the owner
    ;; of the symlink and follower match, or when the directory
    ;; owner matches the symlink's owner.
    ;;
    ;; Prevent hardlinks from being created by users that do not
    ;; have read/write access to the source file.
    ;;
    ;; These prevent many TOCTOU races.
    ("fs.protected_symlinks" . "1")
    ("fs.protected_hardlinks" . "1")

    ;; Hardens the BPF JIT compiler and restricts it to root.
    ("kernel.unprivileged_bpf_disabled" . "1")
    ("net.core.bpf_jit_harden" . "2")

    ;; Hides kernel addresses in various files in /proc.
    ;; Kernel addresses can be very useful in certain exploits.
    ;;
    ;; https://kernsec.org/wiki/index.php/Bug_Classes/Kernel_pointer_leak
    ("kernel.kptr_restrict" . "2")

    ;; Restricts the use of ptrace to root. This might break some programs running under WINE.
    ;; A workaround for WINE would be to give the wineserver and wine-preloader ptrace capabilities. This can be done by running:
    ;;
    ;; sudo apt-get install libcap2-bin
    ;; sudo setcap cap_sys_ptrace=eip /run/current-system/profile/bin/wineserver
    ;; sudo setcap cap_sys_ptrace=eip /run/current-system/profile/bin/wine-preloader
    ("kernel.yama.ptrace_scope" . "2")

    ;; Prevent setuid processes from creating coredumps.
    ("fs.suid_dumpable" . "0")

    ;; Randomize the addresses for mmap base, heap, stack, and VDSO pages
    ("kernel.randomize_va_space" . "2")

    ;; meta start
    ;; project Kicksecure
    ;; category networking and security
    ;; description
    ;; TCP/IP stack hardening

    ;; Protects against time-wait assassination.
    ;; It drops RST packets for sockets in the time-wait state.
    ("net.ipv4.tcp_rfc1337" . "1")

    ;; Disables ICMP redirect acceptance.
    ("net.ipv4.conf.all.accept_redirects" . "0")
    ("net.ipv4.conf.default.accept_redirects" . "0")
    ("net.ipv4.conf.all.secure_redirects" . "0")
    ("net.ipv4.conf.default.secure_redirects" . "0")
    ("net.ipv6.conf.all.accept_redirects" . "0")
    ("net.ipv6.conf.default.accept_redirects" . "0")

    ;; Disables ICMP redirect sending.
    ("net.ipv4.conf.all.send_redirects" . "0")
    ("net.ipv4.conf.default.send_redirects" . "0")

    ;; Ignores ICMP requests.
    ("net.ipv4.icmp_echo_ignore_all" . "1")
    ("net.ipv6.icmp.echo_ignore_all" . "1")

    ;; Ignores bogus ICMP error responses
    ("net.ipv4.icmp_ignore_bogus_error_responses" . "1")

    ;; Enables TCP syncookies.
    ("net.ipv4.tcp_syncookies" . "1")

    ;; Disable source routing.
    ("net.ipv4.conf.all.accept_source_route" . "0")
    ("net.ipv4.conf.default.accept_source_route" . "0")
    ("net.ipv6.conf.all.accept_source_route" . "0")
    ("net.ipv6.conf.default.accept_source_route" . "0")

    ;; Enable reverse path filtering to prevent IP spoofing and
    ;; mitigate vulnerabilities such as CVE-2019-14899.
    ;; https://forums.whonix.org/t/enable-reverse-path-filtering/8594
    ("net.ipv4.conf.default.rp_filter" . "1")
    ("net.ipv4.conf.all.rp_filter" . "1")

    ;; meta end


    ;; Previously disabled SACK, DSACK, and FACK.
    ;; https://forums.whonix.org/t/disabling-tcp-sack-dsack-fack/8109
    ;; ("net.ipv4.tcp_sack" . "0")
    ;; ("net.ipv4.tcp_dsack" . "0")
    ;; ("net.ipv4.tcp_fack" . "0")


    ;; meta start
    ;; project Kicksecure
    ;; category networking and security
    ;; description
    ;; disable IPv4 TCP Timestamps

    ("net.ipv4.tcp_timestamps" . "0")

    ;; meta end


    ;; Only allow the SysRq key to be used for shutdowns and the
    ;; Secure Attention Key (SAK).
    ;;
    ;; https://forums.whonix.org/t/sysrq-magic-sysrq-key/8079/
    ("kernel.sysrq" . "132")

    ;; Restrict loading TTY line disciplines to CAP_SYS_MODULE to prevent
    ;; unprivileged attackers from loading vulnerable line disciplines
    ;; with the TIOCSETD ioctl which has been used in exploits before
    ;; such as https://a13xp0p0v.github.io/2017/03/24/CVE-2017-2636.html
    ;;
    ;; https://lkml.org/lkml/2019/4/15/890
    ("dev.tty.ldisc_autoload" . "0")

    ;; Restrict the userfaultfd() syscall to root as it can make heap sprays
    ;; easier.
    ;;
    ;; https://duasynt.com/blog/linux-kernel-heap-spray
    ("vm.unprivileged_userfaultfd" . "0")

    ;; Let the kernel only swap if it is absolutely necessary.
    ;; Better not be set to zero:
    ;; - https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-memory-tunables.html
    ;; - https://en.wikipedia.org/wiki/Swappiness
    ("vm.swappiness" . "1")

    ;; Disallow kernel profiling by users without CAP_SYS_ADMIN
    ;; https://www.kernel.org/doc/Documentation/sysctl/kernel.txt
    ("kernel.perf_event_paranoid" . "3")

    ;; Do not accept router advertisments
    ("net.ipv6.conf.all.accept_ra" . "0")
    ("net.ipv6.conf.default.accept_ra" . "0")
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Quote https://www.kernel.org/doc/html/latest/admin-guide/sysctl/kernel.html
    ;;
    ;; kexec_load_disabled:
    ;;
    ;; A toggle indicating if the kexec_load syscall has been disabled. This value defaults to 0 (false: kexec_load enabled), but can be set to 1 (true: kexec_load disabled). Once true, kexec can no longer be used, and the toggle cannot be set back to false. This allows a kexec image to be loaded before disabling the syscall, allowing a system to set up (and later use) an image without it being altered. Generally used together with the "modules_disabled" sysctl.
    ;; Disables kexec which can be used to replace the running kernel.
    ("kernel.kexec_load_disabled" . "1")

    ;; Why is this in a dedicated config file?
    ;; Package ram-wipe requires kexec. However, ram-wipe could not ship a config
    ;; (" file /etc/sysctl.d/40_ram-wipe.conf which sets 'kernel.kexec_load_disabled" . "0'.")
    ;; (" This is because once systemd-sysctl.service has set 'kernel.kexec_load_disabled" . "1'")
    ;; it cannot be undone without reboot. This is a upstream Linux security feature.
    ;; Copyright (C) 2019 - 2023 ENCRYPTED SUPPORT LP <adrelanos@whonix.org>
    ;; See the file COPYING for copying conditions.

    ;; Prevent kernel info leaks in console during boot.
    ;; https://phabricator.whonix.org/T950
    ("kernel.printk" . "3 3 3 3")

    ;; NOTE:
    ;; For higher verbosity, the user might also want to delete file
    ;; /etc/default/grub.d/41_quiet.cfg
    ;; (or out-comment its settings).
    ;;
    ;; Alternatively, the user could consider to install the debug-misc package,
    ;; which will undo the settings found here.
    ))

(define-public %jam-vm
  (operating-system
    (host-name "gnu")
    (timezone "Etc/UTC")
    (locale "en_US.utf8")
    (keyboard-layout (keyboard-layout "us" "altgr-intl"))

    (kernel my-kernel)
    ;(initrd microcode-initrd)
    (kernel-arguments %kicksecure-kernel-arguments);(append %default-kernel-arguments ("modprobe.blacklist=nouveau" "nvidia_drm.modeset=1"))

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

    (packages (append (list x-resize ; xfce spice resizing https://gitlab.xfce.org/xfce/xfce4-settings/-/issues/142
                            cloud-utils); cloud-utils for growpart with resize2fs after img resize
                      %base-packages)) ; blueman podman flatpak gvfs
    ;(name-service-switch %mdns-host-lookup-nss) ;; Allow resolution of '.local' host names with mDNS.
    (services
     (append (list (service xfce-desktop-service-type)
                   ;(service nvidia-service-type)
                   (service slim-service-type ;; Choose SLiM, which is lighter than the default GDM.
                            (slim-configuration
                             (auto-login? #t)
                             (default-user "guest")
                             (xorg-configuration
                              (xorg-configuration
                               (modules (cons* xf86-video-qxl;; QXL virtual GPU driver for SPICE
                                               ;nvidia-driver ;; nvidia-xorg
                                               %default-xorg-modules))
                               ;(server (nvidia-transform xorg-server))
                               ;(drivers '("nvidia"))
                               ;(extra-config (list %nvidia-xorg-config))
                               (keyboard-layout keyboard-layout)))))

                   (service spice-vdagent-service-type);; Enables dynamic resizing of the guest screen resolution, clipboard and integration with the host SPICE protocol
                   ;(service transmission-daemon-service-type
                   ;         (transmission-daemon-configuration
                   ;          ;(peer-port 51413)
                   ;          (port-forwarding-enabled? #f)
                   ;          (dht-enabled? #f)
                   ;          (pex-enabled? #f)
                   ;          (rpc-whitelist '("127.0.0.1" "::1" "10.0.0.*"))))
                   (service cuirass-service-type
                            (cuirass-configuration (specifications #~(list (specification
                                                                            (name "binary")
                                                                            (build '(custom (jam ci)));'(channels my-channel) ; TODO try CI again
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
                                                                                             (url "https://github.com/jamartin9/guix-channel")
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
                                                                                             (path "")
                                                                                             )))
                                                                            (period 600))))
                                                   (host "0.0.0.0")))
                   ;(service plasma-desktop-service-type) ; plasma and sddm login for KDE(wayland)
                   ;(service sddm-service-type
                   ;          (sddm-configuration
                   ;           (theme "breeze")))
                   (service dhcp-client-service-type) ;; Use the DHCP client service rather than NetworkManager.
                   ;(service zfs-service-type
                   ;         (zfs-configuration
                   ;          (kernel my-kernel)))
                   (service openssh-service-type
                            (openssh-configuration ;(%auto-start? #f)
                                                   (openssh openssh-sans-x)
                                                   (port-number 8080)
                                                   (password-authentication? #f)
                                                   (authorized-keys `(("guest" ,(plain-file "jam.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjfouQY9m8opK3Sq5G81FuqlMEa5no1Jy1UywweZY3u jam@jam-pc"))
                                                                      ("guest" ,(plain-file "jaming.pub" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+JSxpOM9X8rM6bS0VEfmBeOaQi98o0+aDzYaWIhTBp jam@jam-workstation"))))))


                   (simple-service 'os-file etc-service-type
                                   (list `("vm.scm" ,(local-file "vm.scm"))))
                   (simple-service 'os-file etc-service-type
                                   (list `("home.scm" ,(local-file "home.scm"))))
                   (simple-service 'channel-file etc-service-type ; link to ~/.config/guix/channels.scm
                                   (list `("channels.scm" ,(local-file "channels.scm"))))
                   (simple-service 'channel-file etc-service-type
                                   (list `("nonguix.pub" ,(local-file "nonguix.pub"))))
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

                   table inet nat {
                     chain prerouting {
                       type nat hook prerouting priority -100;
                     }
                     chain postrouting {
                       type nat hook postrouting priority 100;
                       oifname $wan ip saddr $vpn_net masquerade
                     }
                   }
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
                       tcp dport 5930 accept

                       # allow transmission
                       #tcp dport 51413 accept

                       # allow ssdp, pcp and nat-pmp port mapping
                       udp sport 1900 udp dport >= 1024 meta pkttype unicast limit rate 4/second burst 20 packets accept comment \"Accept UPnP IGD port mapping reply\"
                       udp sport 1900 ip saddr $router accept
                       udp sport 5350 ip saddr $router accept
                       udp sport 5351 ip saddr $router accept

                       # allow monerod
                       tcp dport 18080 accept

                       # allow p2pool
                       tcp dport 37889 accept

                       # allow cuirass
                       tcp dport 8081 accept

                       # allow wireguard peers to connect to each other
                       iifname $vpn accept
                       udp dport 51820 accept
                       iifname $vpn oifname $vpn ct state new accept

                       # allow dhcp
                       udp sport bootpc udp dport bootps ip saddr 0.0.0.0 ip daddr 255.255.255.255 accept comment \"Accept DHCPDISCOVER (for DHCP-Proxy)\"

                       # allow mdns
                       #udp dport mdns ip6 daddr ff02::fb accept comment \"Accept mDNS\"
                       #udp dport mdns ip daddr 224.0.0.251 accept comment \"Accept mDNS\"

                       # reject everything else
                       reject with icmpx type port-unreachable
                     }
                     chain forward {
                       type filter hook forward priority 0; policy drop;

                       # drop invalid packets
                       ct state invalid drop

                       # forward established connections
                       ct state established,related accept

                       # forward wireguard to wan
                       iifname $vpn oifname $wan ct state new accept
                     }
                     chain output {
                       type filter hook output priority 0; policy accept;
                     }
                   }")))))
             (remove (lambda (service) ;; Remove some services that don't make sense in a VM.
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
                     (modify-services %desktop-services
                                      (sysctl-service-type config =>
                                                           (sysctl-configuration
                                                            (settings (append `(,@%kicksecure-sysctl-rules
                                                                                ;("net.ipv6.conf.all.forwarding" . "1")
                                                                                ("net.ipv4.ip_forward" . "1"))
                                                                              %default-sysctl-settings))))
                                      (guix-service-type config =>
                                                         (guix-configuration
                                                          (inherit config)
                                                          (channels %jam-channels)
                                                          ;(log-compression 'none); use btrfs compression
                                                          (guix (current-guix))
                                                          (substitute-urls
                                                           (append (list "https://substitutes.nonguix.org/"); 4zwzi66wwdaalbhgnix55ea3ab4pvvw66ll2ow53kjub6se4q2bclcyd.onion
                                                                   %default-substitute-urls)) ;(http-proxy) with tor config HTTPTunnelPort
                                                          (authorized-keys
                                                           (append (list (local-file "./nonguix.pub"))
                                                                   %default-authorized-guix-keys))))))))))
%jam-vm
