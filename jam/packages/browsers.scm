(define-module (jam packages browsers)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages chromium)
  )

;; TODO use grafts to split packages that avoid recompiling

(define ff-nvda
  (package
   (inherit firefox)
   (name "firefox-nvda")))

(define chrome-nvda
  (package
   (inherit ungoogled-chromium)
   (name "ungoogled-chromium-nvda")))

(define-public firefox-nvda
  (replace-mesa ff-nvda))

(define-public chromeium-nvda
  (replace-mesa chrome-nvda))
