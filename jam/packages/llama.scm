(define-module (jam packages llama)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ; package-keyword-arguments
  #:use-module (gnu packages machine-learning); llama-cpp
  #:use-module (jam packages) ; for search-patches
;  #:use-module (guix-science-nonfree packages cuda) ; cuda-12 for the 580 driver series (13 requires cc 7.5+)
  #:use-module ((guix licenses) #:prefix license:))

(define-public ik-llama
  (package
   (inherit llama-cpp)
   (name "ik-llama-cpp")
   (version "git-08ae48c") ; add commit to version to avoid false base32 hash passing on reinstall w/o tag
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "08ae48c667e3dcd3025821a8585190b4a46c2f7c")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1lpsfh33wnm8c6y72zsrs6r0f2mqklbrk7xh2m7yv78kniy1d7yk"))))
   (arguments
    (substitute-keyword-arguments (package-arguments llama-cpp)
                                  ((#:configure-flags flags) ''("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON"))
                                  ((#:tests? _ #t) #f)
                                  ((#:phases phases) #~(modify-phases #$phases (delete 'patch-paths)))))
   (inputs
    (modify-inputs (package-inputs llama-cpp)
                   (delete "ggml"))) ; use ggml fork
   (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

;(define-public ik-llama-cuda ; maybe add NCCL with -DGGML_USE_NCCL=ON, add wrapper for LD_LIBRARY_PATH for cuda lib
;  (cuda-enabled-package ik-llama #:cuda-package cuda-12 #:extra-configure-flags ''("-DGGML_CUDA=ON" "-DCMAKE_CUDA_ARCHITECTURES=52"))) ;shorten compile for only arch(s) needed

ik-llama

