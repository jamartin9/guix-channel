(define-module (jam packages nvidia)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ; package-keyword-arguments
  #:use-module (jam packages) ; for search-patches
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu packages mozilla)
  ;#:use-module (gnu packages zig-xyz); river; needs multiple updates for 0.4
  #:use-module (gnu packages emacs) ; emacs-pgtk
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  #:use-module ((guix licenses) #:prefix license:))

;(define-public nvidia-driver-575.64.05
;  (package
;   (inherit nvidia-driver)
;   (version "575.64.05")
;   (source ((@@ (nongnu packages nvidia) nvidia-source) version "0bah9mvkymnmyh4z5h7x138gyfklz7hzfb0bga8w2q92j47vbwl5"))))

;(define-public emacs-nvda
;  (replace-mesa emacs-next-pgtk #:driver nvidia-driver-575.64.05))


(define ff-nvda
  (package
   (inherit firefox)
   (name "ff-nvda")
   (replacement firefox)))

(define chrome-nvda
  (package
   (inherit ungoogled-chromium)
   (name "ungoogled-chr-nvda")
   (replacement ungoogled-chromium)))

(define-public firefox-nvda
  (replace-mesa ff-nvda ));#:driver nvidia-driver-575.64.05))

(define-public chromeium-nvda
  (replace-mesa chrome-nvda ));#:driver nvidia-driver-575.64.05))

;nvidia-driver-575.64.05
;emacs-nvda
