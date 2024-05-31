(define-module (jam system services)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:use-module (nongnu packages linux)
;  #:use-module (gnu)
 ; #:use-module (gnu services shepherd)
 ; #:use-module (gnu services file-sharing)
 ; #:use-module (gnu services networking)
 ; #:use-module (gnu services sysctl)
 ; #:use-module (gnu services vpn)
 ; #:use-module (gnu services desktop)
 ; #:use-module (gnu services mcron)
 ; #:use-module (gnu services spice)
 ; #:use-module (gnu services xorg)
 ; #:use-module (gnu services ssdm)
 ; #:use-module (gnu services cuirass)
 ; #:use-module (gnu packages networking)
 ; #:use-module (gnu packages containers)
 ; #:use-module (gnu packages ssh)
 ; #:use-module (gnu packages linux)
 ; #:use-module (gnu packages admin)
 ; #:use-module (gnu packages bootloaders)
 ; #:use-module (gnu packages certs)
 ; #:use-module (gnu packages fonts)
 ; #:use-module (gnu packages nvi)
 ; #:use-module (gnu packages package-management)
 ; #:use-module (gnu packages wget)
 ; #:use-module (gnu packages xorg)
 ; #:use-module (guix)
 ; #:use-module (guix gexp)
 ; #:use-module (guix packages)
 ; #:use-module (guix transformations)
 ; #:use-module (srfi srfi-1)
 ; #:use-module (nongnu packages nvidia)
;  #:use-module (nongnu services nvidia)
;  #:use-module (nongnu system linux-initrd)
;  #:use-module (jam system channels)
  )


(define-public %nvidia-xorg-config ;; nvidia xorg configuration
    "Section \"Device\"
	Identifier     \"Device0\"
	Driver         \"nvidia\"
	VendorName     \"NVIDIA Corporation\"
	BoardName      \"GeForce GTX 980\"
    EndSection")

(define-public %broadcom-service-type
    (service-type
     (name 'broadcom)
     (extensions
      (list
       ;; add kernel module
       (service-extension linux-loadable-module-service-type
                                 (const (list broadcom-sta)))
        ;; load kernel module
       (service-extension kernel-module-loader-service-type
                                 (const '("wl")))))
     (default-value '())
     (description "Install broadcom kernel module and service")))
