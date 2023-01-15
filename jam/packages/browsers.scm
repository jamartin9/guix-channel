(define-module (jam packages browsers)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  ) ; BUG non cli grafts seem to be undefined for 'nvda'

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
  (replace-mesa ff-nvda))

(define-public chromeium-nvda
  (replace-mesa chrome-nvda))
