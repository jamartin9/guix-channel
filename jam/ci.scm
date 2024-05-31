(define-module (jam ci)
  #:use-module (gnu ci)
  #:use-module (gnu image)
  #:use-module (gnu system image)
  #:use-module (gnu system install)
  #:use-module (gnu packages base)
  #:use-module (gnu packages finance)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu compression)
  #:use-module ((guix scripts pack) #:select (self-contained-tarball docker-image))
  #:use-module (guix gexp)
  #:use-module (guix store)
  #:use-module (guix monads)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (jam system installer)
  #:use-module (gnu packages package-management)
  #:use-module (guix channels)
  #:use-module (guix config)
  #:use-module (guix derivations)
  #:use-module (guix memoization)
  #:use-module (guix build-system channel)
  #:use-module (guix config)
  #:use-module (jam system vm)
  #:use-module (jam packages guile-static)
  #:use-module (jam packages gcc)
  #:use-module (srfi srfi-26)
;  #:use-module (guix scripts pack)
  #:export (cuirass-jobs))

(define-public (cuirass-jobs store arguments)
  (define systems
    (arguments->systems arguments))
  (define channels
    (let ((channels (assq-ref arguments 'channels)))
      (map sexp->channel channels)))
  (define guix
    (find guix-channel? channels))
  (define commit
    (channel-commit guix))
  (define source
    (channel-url guix))
  (parameterize ((current-guix-package
                  (channel-source->package source #:commit commit)))
  (append-map
   (lambda (system)
     (define (->job name drv)
       (let ((name (string-append name "." system)))
         (parameterize ((%graft? #f))
           (derivation->job name drv))))
     (list
      (->job "binary-tarball"
             (run-with-store store
                             (mbegin %store-monad
                                     (set-guile-for-build (default-guile))
                                     (>>= (profile-derivation (packages->manifest (list guile-next-static)) #:relative-symlinks? #t) ; MAYBE add relocatable wrapped-package (map-manifest-entries (cut (@@ (guix scripts pack) wrapped-manifest-entry) <> #:proot? #t) (packages->manifest (list hello)))
                                          (lambda (profile)
                                            (self-contained-tarball "binary-guile" profile
                                                                    #:profile-name "default-guile"
                                                                    #:localstatedir? #t ; allows package to be updated by guix
                                                                    #:symlinks '(("/bin" -> "bin"))
                                                                    #:compressor (lookup-compressor "gzip")))))
                             #:system system))
;      (->job "binary-qemu-tarball"
;             (run-with-store store
;                             (mbegin %store-monad
;                                     (set-guile-for-build (default-guile))
;                                     (>>= (profile-derivation (packages->manifest (list qemu:static)) #:relative-symlinks? #t)
;                                          (lambda (profile)
;                                            (self-contained-tarball "binary-qemu" profile
;                                                                    #:profile-name "default-qemu"
;                                                                    #:symlinks '(("/bin" -> "bin"))
;                                                                    #:compressor (lookup-compressor "gzip")))))
;                             #:system system))
      (->job "binary-container"
             (run-with-store store
                             (mbegin %store-monad
                                     (set-guile-for-build (default-guile))
                                     (>>= (profile-derivation (packages->manifest (list monero p2pool)))
                                          (lambda (profile)
                                            (docker-image "binary-container" profile
                                                                    #:profile-name "default-container"
                                                                    #:symlinks '(("/bin" -> "bin"))
                                                                    #:compressor (lookup-compressor "gzip")))))
                             #:system system))
      (image->job store (os->image %jam-vm #:type qcow2-image-type) #:name "binary-vm" #:system system); qemu-image; (image (inherit mbr-hybrid-disk-image) (operating-system %jam-vm)) ; usb image
      (image->job store
                  (image-with-os iso9660-image
                                 installation-os-nonfree)
                  #:name "binary-installer"
                  #:system system)
      ))
   systems)))
