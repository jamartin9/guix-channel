(define-module (jam packages llama)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ;package-keyword-arguments
  #:use-module (gnu packages machine-learning) ;llama-cpp
  #:use-module (gnu packages tls) ;openssl
  #:use-module (jam packages) ;for search-patches
  ;; #:use-module (guix-science-nonfree packages cuda) ; cuda-12 for the 580 driver series (13 requires cc 7.5+)
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public ik-llama
  (package
    (inherit llama-cpp)
    (name "ik-llama-cpp")
    (version "git-8960c5") ;add commit to version to avoid false base32 hash passing on reinstall w/o tag
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "8960c5ba5ee9db30ba838304373aa4dbec9f7cbd")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1vqvxc62r7m7dlkawh6537sxz4aq85z2vybqg1p8ffrxv40h5ykj"))))
    (arguments
     (substitute-keyword-arguments (package-arguments llama-cpp)
       ((#:configure-flags flags)
        ''("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON" "-DCMAKE_BUILD_TYPE=Release"))
       ((#:tests? _ #t)
        #f)
       ((#:phases phases)
        #~(modify-phases #$phases
            (delete 'get-ui)
            (delete 'patch-paths)))))
    (inputs (list openssl)) ;use ggml fork
    (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

;(define-public ik-llama-cuda ; maybe add NCCL with -DGGML_USE_NCCL=ON, add wrapper for LD_LIBRARY_PATH for cuda lib
;  (cuda-enabled-package ik-llama #:cuda-package cuda-12 #:extra-configure-flags ''("-DGGML_CUDA=ON" "-DCMAKE_CUDA_ARCHITECTURES=52"))) ;shorten compile for only arch(s) needed

ik-llama

