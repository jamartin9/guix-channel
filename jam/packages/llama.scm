(define-module (jam packages llama)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils) ; package-keyword-arguments
  #:use-module (gnu packages machine-learning); llama-cpp
  #:use-module (jam packages) ; for search-patches
  #:use-module (guix-science-nonfree packages cuda) ; cuda-12 for the 580 driver series (13 requires cc 7.5+)
  #:use-module ((guix licenses) #:prefix license:))


(define-public ik-llama
  (package
   (inherit llama-cpp)
   (name "ik-llama-cpp")
   (version "git-54bcafe") ; add commit to version to avoid false base32 hash passing on reinstall
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "54bcafee1682847ea8884319e752803ea8ff17d7")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "00ylj8nzhdl6f6avzbbq7afnlshy5ma80wxzdif3haj1v66wxw0x"))))
   (arguments
    (substitute-keyword-arguments (package-arguments llama-cpp)
                                  ((#:configure-flags flags) ''("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON"))
                                  ((#:tests? _ #t) #f)
                                  ((#:phases phases) #~(modify-phases #$phases (delete 'patch-paths)))))
   (inputs
    (modify-inputs (package-inputs llama-cpp)
                   (delete "ggml"))) ; use ggml fork
   (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

(define-public ik-llama-cu ; maybe switch to 'cuda-enabled-package' from guix-science-nonfree
  (package
   (inherit llama-cpp)
   (name "ik-llama-cpp-cu")
   (version "git-54bcafe") ; bug: forward compatibility was attempted on non supported HW
   (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ikawrakow/ik_llama.cpp")
             (commit "54bcafee1682847ea8884319e752803ea8ff17d7")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "00ylj8nzhdl6f6avzbbq7afnlshy5ma80wxzdif3haj1v66wxw0x"))))
   (arguments
    (substitute-keyword-arguments (package-arguments llama-cpp) ; maybe add wrapper for LD_LIBRARY_PATH for cuda lib
                                  ((#:validate-runpath? _ #t) #f); RUNPATH validation fails cuda libs are stubs. patchelf populate DT_RPATH not DT_RUNPATH.
                                  ((#:configure-flags flags) ''("-DGGML_IQK_FA_ALL_QUANTS=ON" "-DGGML_NATIVE=ON" "-DGGML_CUDA=ON"))
                                  ((#:tests? _ #t) #f)
                                  ((#:phases phases) #~(modify-phases #$phases (delete 'patch-paths)))))
   (inputs
    (modify-inputs (package-inputs llama-cpp)
                   (append cuda-12); maybe add NCCL with -DGGML_USE_NCCL=ON ? maybe shorten compile for only arch(s) needed -DCMAKE_CUDA_ARCHITECTURES=52
                   (delete "ggml"))) ; use ggml fork
   (home-page "https://github.com/ikawrakow/ik_llama.cpp")))

ik-llama-cu; tune for cpu when builder is different(we removed the portable binary configure flags). guix package --tune=native -f ./jam/packages/llama.scm
