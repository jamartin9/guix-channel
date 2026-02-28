(define-module (jam packages llama)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ; package-keyword-arguments
  #:use-module (gnu packages machine-learning); llama-cpp
  #:use-module (jam packages) ; for search-patches
  #:use-module ((guix licenses) #:prefix license:))


(define-public ik-llama
  (package
   (inherit llama-cpp)
   (name "ik-llama-cpp")
   (version "git")
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "1e6d36b1b4a4c99fac8e00b3a91deb3bd5ab601f"))); commit before fused deltanet3 (qwen3.5 rambles after)
       (file-name (git-file-name name version))
       (sha256
        (base32 "18iyk9lkbdlw91r2nwc95g75nq6c5z76il70hq0g2n6vrvr83nls"))))
   (arguments
    (substitute-keyword-arguments (package-arguments llama-cpp)
                                  ((#:configure-flags flags '("-DGGML_IQK_FA_ALL_QUANTS=ON")) ''("-DGGML_IQK_FA_ALL_QUANTS=ON"))
                                  ((#:tests? _ #t) #f)
                                  ((#:phases phases) #~(modify-phases #$phases (delete 'patch-paths)))))
   (inputs
    (modify-inputs (package-inputs llama-cpp)
                   (delete "ggml"))) ; use ggml fork
   (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

ik-llama; tune for cpu when builder is different(we removed the portable binary configure flags). guix package --tune=native -f ./jam/packages/llama.scm
