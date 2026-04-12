(define-module (jam packages nvidia)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ; package-keyword-arguments
  #:use-module (jam packages) ; for search-patches
  #:use-module (jam packages emacs) ; for transform-emacs-configure
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu packages mozilla)
  #:use-module (gnu packages emacs) ; emacs-pgtk
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-nvda ; bug: 580 driver flickers with river/reka. 575 works but is EOL...
  (replace-mesa emacs-next-pgtk #:driver nvda-580))

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
  (replace-mesa ff-nvda #:driver nvda-580))

(define-public chromeium-nvda
  (replace-mesa chrome-nvda #:driver nvda-580))

;nvda-580
emacs-nvda
