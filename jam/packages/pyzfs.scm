(define-module (jam packages pyzfs)
  #:use-module (jam packages) ; for search-patches
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix platform)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix build-system linux-module)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system trivial)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages digest)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-crypto)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libunwind)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages man)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages nfs)
  #:use-module (gnu packages onc-rpc)
  #:use-module (gnu packages openldap)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages sssd)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages valgrind)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xml)
   #:use-module ((guix licenses) #:prefix license:))


(define-public zfs
  (package
    (name "zfs")
    (version "2.3.4")
    (outputs '("out" "module" "src")); TODO add py/pam?
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/openzfs/zfs/releases"
                           "/download/zfs-" version
                           "/zfs-" version ".tar.gz"))
       (sha256
        (base32 "15d47y4alicdl99pjidks9p1hqk9glz5y0w024d1ccq16v7rghwy"))))
    (build-system linux-module-build-system)
    (arguments
     (list
      ;; The ZFS kernel module should not be downloaded since the license
      ;; terms don't allow for distributing it, only building it locally.
      #:substitutable? #f
      ;; Tests cannot run in an unprivileged build environment.
      #:tests? #f
      #:phases
      (let ((python-version (version-major+minor (package-version python)))); ADDED
      #~(modify-phases %standard-phases
          (add-after 'configure 'really-configure
            (lambda* (#:key inputs #:allow-other-keys)
              (substitute* "configure"
                (("-/bin/sh") (string-append "-" (which "sh"))))
              (invoke "./configure"
                      "--with-config=all"
                      "--enable-pyzfs"; ADDED
                      "--enable-pam"; ADDED
                      (string-append "--with-pammoduledir=" #$output "/lib/security/"); ADDED (output to pam?)
                      (string-append "--with-pamconfigsdir=" #$output "/etc/pam.d/"); ADDED (output to pam?)
                      (string-append "--prefix=" #$output)
                      (string-append "--with-dracutdir=" #$output
                                     "/lib/dracut")
                      (string-append "--with-udevdir=" #$output
                                     "/lib/udev")
                      (string-append "--with-mounthelperdir=" #$output
                                     "/sbin")
                      (string-append "--with-linux="
                                     (search-input-directory
                                      inputs
                                      "lib/modules/build")))))
          (add-after 'unpack 'patch-source
            (lambda* (#:key inputs #:allow-other-keys)
              ;; New feature "compatibility=" in 2.1.0.
              ;; This feature looks up in two locations:
              ;;   /etc/zfs/compatibility.d/
              ;;   /usr/share/zfs/compatibility.d/
              ;; The first is intended for system-specific compatibility
              ;; sets, while the second is what is installed with the
              ;; OpenZFS package, so use the absolute path for the first
              ;; (which requires patching in the file) and the store path
              ;; for the second (which it gets by default).
              (substitute* "include/sys/fs/zfs.h"
                (("#define\tZPOOL_SYSCONF_COMPAT_D.*$")
                 ;; Use absolute path.
                 "#define\tZPOOL_SYSCONF_COMPAT_D\t\"/etc/zfs/compatibility.d\"\n"))
              ;; Also update the manual, which uses absolute paths, so that
              ;; /usr/share/zfs/compatibility.d/ is referred via the store.
              (substitute* '("man/man7/zpoolprops.7"
                             "man/man7/zpool-features.7")
                (("/usr/share/zfs/compatibility.d")
                 (string-append #$output "/share/zfs/compatibility.d")))
              (substitute* "lib/libzfs/os/linux/libzfs_util_os.c"
                ;; Use path to /gnu/store/*-kmod in actual path that is
                ;; exec'ed.
                (("\"/sbin/modprobe\"")
                 (string-append "\""
                                (search-input-file inputs "/bin/modprobe")
                                "\""))
                ;; Just use 'modprobe' in message to user, since Guix
                ;; does not have a traditional /sbin/
                (("'/sbin/modprobe ") "'modprobe "))
              (substitute* "configure"
                (("/etc/default")
                 (string-append #$output "/etc/default"))
                (("/etc/bash_completion.d")
                 (string-append #$output "/etc/bash_completion.d")))
              (substitute* "Makefile.in"
                (("/usr/share/initramfs-tools")
                 (string-append #$output "/usr/share/initramfs-tools")))
              (substitute* "contrib/initramfs/Makefile.am"
                (("/usr/share/initramfs-tools")
                 (string-append #$output "/usr/share/initramfs-tools")))
              (substitute* "module/os/linux/zfs/zfs_ctldir.c"
                (("/usr/bin/env\", \"umount")
                 (string-append (search-input-file inputs "/bin/umount")
                                "\", \"-n"))
                (("/usr/bin/env\", \"mount")
                 (string-append (search-input-file inputs "/bin/mount")
                                "\", \"-n")))
              (substitute* "lib/libzfs/os/linux/libzfs_mount_os.c"
                (("/bin/mount") (search-input-file inputs "/bin/mount"))
                (("/bin/umount") (search-input-file inputs "/bin/umount")))
              (substitute* "lib/libshare/os/linux/nfs.c"
                (("/usr/sbin/exportfs")
                 (search-input-file inputs "/sbin/exportfs")))
              (substitute* "config/zfs-build.m4"
                (("\\$sysconfdir/init.d")
                 (string-append #$output "/etc/init.d")))
              (substitute* '("cmd/zed/Makefile.am")
                (("\\$\\(sysconfdir)") (string-append #$output "/etc")))
              (substitute* "udev/vdev_id"
                (("PATH=/bin:/sbin:/usr/bin:/usr/sbin")
                 (string-append "PATH="
                                (dirname (which "chmod")) ":"
                                (dirname (which "grep")) ":"
                                (dirname (which "sed")) ":"
                                (dirname (which "gawk")))))
              (substitute* '("Makefile.am" "Makefile.in")
                (("\\$\\(prefix)/src") (string-append #$output:src "/src")))
              (substitute* (find-files "udev/rules.d/" ".rules.in$")
                (("/sbin/modprobe")
                 (search-input-file inputs "/bin/modprobe")))))
          (replace 'build
            (lambda* (#:key make-flags parallel-build? #:allow-other-keys)
              (apply invoke "make"
                     `(,@(if parallel-build?
                             `("-j" ,(number->string (parallel-job-count)))
                             '())
                       ,@make-flags))))
          (replace 'install
            (lambda* (#:key inputs native-inputs
                      make-flags parallel-build? #:allow-other-keys)
              (apply invoke "make" "install"
                     (string-append "DEFAULT_INITCONF_DIR="
                                    #$output "/etc/default")
                     (string-append "DEPMOD="
                                    (search-input-file
                                     (or native-inputs inputs)
                                     "/bin/depmod"))
                     (string-append "INSTALL_PATH=" #$output)
                     (string-append "INSTALL_MOD_PATH=" #$output:module)
                     "INSTALL_MOD_STRIP=1"
                     `(,@(if parallel-build?
                             `("-j" ,(number->string (parallel-job-count)))
                             '())
                       ,@make-flags))
              (copy-recursively "contrib/pyzfs/build/lib" (string-append #$output "/lib/python" #$python-version "/site-packages")) ; ADDED (output to py ?)
              ;(install-file "contrib/pam_zfs_key/zfs_key" (string-append #$output:pam "/lib/security")); ADDED
              (install-file
               "contrib/bash_completion.d/zfs"
               (string-append #$output
                              "/share/bash-completion/completions"))))
          ))
      ))
          ;(add-after 'install 'fail (lambda* (#:key outputs #:allow-other-keys) (exit 1)))
    (native-inputs
     (list attr kmod pkg-config python-distlib))
    (inputs (list linux-pam ; ADDED
                  eudev
                  kmod
                  libaio
                  libtirpc
                  nfs-utils
                  openssl
                  python
                  python-cffi
                  util-linux
                  `(,util-linux "lib")
                  zlib))
    (home-page "https://zfsonlinux.org/")
    (synopsis "OpenZFS on Linux")
    (description
     "OpenZFS is an advanced file system and volume manager which was
originally developed for Solaris and is now maintained by the OpenZFS
community.")
    (license license:cddl1.0)))

zfs
