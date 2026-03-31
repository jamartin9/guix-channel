(define-module (jam packages zfs)
   #:use-module (gnu packages)
   #:use-module (gnu packages file-systems)
   #:use-module (gnu packages linux)
   #:use-module (gnu packages python)
   #:use-module (gnu packages python-xyz)
   #:use-module (gnu packages python-build)
   #:use-module (gnu services)
   #:use-module (gnu services base)
   #:use-module (gnu services linux)
   #:use-module (gnu services mcron)
   #:use-module (gnu services shepherd)
   #:use-module (gnu system mapped-devices)
   #:use-module (gnu system pam)
   #:use-module (gnu packages package-management) ; guix
   #:use-module (jam packages) ; patches
   #:use-module (guix gexp)
   #:use-module (guix modules)
   #:use-module (guix records)
   #:use-module (guix packages)
   #:use-module (guix platform)
   #:use-module (guix utils)
   #:use-module (srfi srfi-1))

(define-public pyzfs
  (package
   (inherit zfs)
   (name "pyzfs")
   (inputs (modify-inputs (package-inputs zfs)
                          (append linux-pam)))
   (native-inputs (modify-inputs (package-native-inputs zfs)
                                 (append python-distlib)))
   (arguments
    (substitute-keyword-arguments (package-arguments zfs)
                                  ((#:phases phases)
                                   (let ((python-version (version-major+minor (package-version python))))
                                     #~(modify-phases #$phases
                                                      (add-after 'install 'pyinstall ; copy libzfs_core python lib
                                                                 (lambda* (#:key inputs native-inputs make-flags parallel-build? #:allow-other-keys)
                                                                   (copy-recursively "contrib/pyzfs/build/lib" (string-append #$output "/lib/python" #$python-version "/site-packages"))))
                                                      (replace 'really-configure
                                                               (lambda* (#:key inputs outputs #:allow-other-keys)
                                                                 (let* ((out (assoc-ref outputs "out")))
                                                                   (substitute* "configure" (("-/bin/sh") (string-append "-" (which "sh"))))
                                                                   (invoke "./configure"
                                                                           "--with-config=all"
                                                                           "--enable-pyzfs"; add python bindings
                                                                           "--enable-pam"; add pam module for mounting datasets on ssh login
                                                                           (string-append "--with-pammoduledir=" out "/lib/security"); pam
                                                                           (string-append "--with-pamconfigsdir=" out "/etc/pam.d"); pam
                                                                           (string-append "--prefix=" out)
                                                                           (string-append "--with-dracutdir=" out "/lib/dracut")
                                                                           (string-append "--with-udevdir=" out "/lib/udev")
                                                                           (string-append "--with-mounthelperdir=" out "/sbin")
                                                                           (string-append "--with-linux=" (search-input-directory inputs "lib/modules/build")))))))))))))
;pyzfs

