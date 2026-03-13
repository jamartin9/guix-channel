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
   (version "git-714329f4ca633a2962d3813210a73384e416bd0a") ; add commit to version to avoid false base32 hash passing on reinstall
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "714329f4ca633a2962d3813210a73384e416bd0a")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ksrahn981f9dpvv5svmgs89ak31jbdsj4fnllcki53063mq28gr"))))
   (arguments
    (substitute-keyword-arguments (package-arguments llama-cpp)
                                  ((#:configure-flags flags '("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON")) ''("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON"))
                                  ((#:tests? _ #t) #f)
                                  ((#:phases phases) #~(modify-phases #$phases (delete 'patch-paths)))))
   (inputs
    (modify-inputs (package-inputs llama-cpp)
                   (delete "ggml"))) ; use ggml fork
   (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

ik-llama; tune for cpu when builder is different(we removed the portable binary configure flags). guix package --tune=native -f ./jam/packages/llama.scm
