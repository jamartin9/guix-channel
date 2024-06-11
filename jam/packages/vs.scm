(define-module (jam packages vs)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix utils) ; substutite keyword cython
  #:use-module (guix build-system gnu) ; zimg for vapoursynth
  #:use-module (guix build-system python) ; cython for vapoursynth
  #:use-module (gnu packages python-xyz) ; cython for vapoursynth
  #:use-module (gnu packages python) ; python-3.12 for vapoursynth
  #:use-module (gnu packages ocr) ; terreract for vapoursynth
  #:use-module (gnu packages assembly) ; nasm for vapoursynth
  #:use-module (guix build-system cargo) ; rust-dolby-vision-3 for vs-placebo and vs-nlq
  #:use-module (gnu packages rust) ; rust-cargo-c for rust-dolby-vision-3
  #:use-module (gnu packages rust-apps) ; for vs-nlq
  #:use-module (gnu packages crates-io) ; for vs-nlq
  #:use-module (guix build-system meson)
  #:use-module (gnu packages video) ; libplacebo for vs-placebo
  #:use-module (gnu packages ghostscript) ; lcms for vs-placebo
  #:use-module (gnu packages vulkan) ; shaderc for vs-placebo, vulkan-headers/vulkan-loader for vs-placebo
  #:use-module (gnu packages pkg-config) ; pkg-config for libs
  #:use-module (gnu packages opencl) ; opencl for vs-eedi3m
  #:use-module (gnu packages boost) ; boost for vs-eedi3m
  #:use-module (gnu packages image) ; zimg for vapoursynth, libass for vs-subtext, ffmpeg (libavcodec, libavformat, libavutil) for vs-subtext,
  #:use-module (gnu packages autotools) ; for ffms2-git
  #:use-module (gnu packages gettext) ; for ffms2-git
  #:use-module (jam packages) ; for search-patches
  #:use-module ((guix licenses) #:prefix license:))

(define-public vs-placebo
  (package
    (name "vs-placebo")
    (version "1.4.4-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Lypheo/vs-placebo")
             (commit "701d72126b58ccfb64f81ed19cacac93bd7fb2a0")
             (recursive? #true)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1s31gs8l0hh4h2ic2y4jxq7qdc8xx11hqpx0m6g3w7cdpl6i6pml"))
       (patches (search-patches "vs-placebo.patch"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg libplacebo shaderc vulkan-headers vulkan-loader lcms rust-dolby-vision-3)) ; check libdovi
    (arguments `(#:tests? #f
                 #:phases
                 (modify-phases %standard-phases
                                (add-after 'install 'move-library
                                           (lambda* (#:key outputs #:allow-other-keys)
                                             (let* ((out (assoc-ref outputs "out"))
                                                    (lib (string-append out "/lib"))
                                                    (vs-lib (string-append lib "/vapoursynth")))
                                               (mkdir-p vs-lib)
                                               (rename-file
                                                (string-append lib "/libvs_placebo.so")
                                                (string-append vs-lib "/libvs_placebo.so"))))))))
    (home-page "https://github.com/Lypheo/vs-placebo")
    (synopsis "placebo vapoursynth plugin")
    (description "libplacebo-based debanding, scaling and color mapping plugin for VapourSynth")
    (license license:lgpl2.1+)))

(define-public vs-eedi3m
  (package
    (name "vs-eedi3m")
    (version "R4-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3")
             (commit "d11bdb37c7a7118cd095b53d9f8fbbac02a06ac0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1j4rk04pwvvdnsqanhb4n6ag6a6ny90w9qhd3fm6n9x7qgm1z19h"))
       (patches (search-patches "vs-eedi3m.patch"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg opencl-icd-loader opencl-headers boost))
    (arguments `(#:tests? #f
                 #:phases
                 (modify-phases %standard-phases
                                (add-after 'install 'move-library
                                           (lambda* (#:key outputs #:allow-other-keys)
                                             (let* ((out (assoc-ref outputs "out"))
                                                    (lib (string-append out "/lib"))
                                                    (vs-lib (string-append lib "/vapoursynth")))
                                               (mkdir-p vs-lib)
                                               (rename-file
                                                (string-append lib "/libeedi3m.so")
                                                (string-append vs-lib "/libeedi3m.so"))))))))
    (home-page "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3")
    (synopsis "eedi3 vapoursynth plugin")
    (description "Renewed EEDI3 filter for VapourSynth")
    (license license:lgpl2.1+)))

(define-public vs-subtext
  (package
    (name "vs-subtext")
    (version "R5-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vapoursynth/subtext")
             (commit "ee915bcaa31d2106d5156e602a470d0b4964321f")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0wax8wj4rwgy3kbrfc23y1vicfs5pf9dra3fk2w46zxc3p4sr0jk"))
       (patches (search-patches "vs-subtext.patch"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg libass ffmpeg))
    (arguments `(#:tests? #f
                 #:phases
                 (modify-phases %standard-phases
                                (add-after 'install 'move-library
                                           (lambda* (#:key outputs #:allow-other-keys)
                                             (let* ((out (assoc-ref outputs "out"))
                                                    (lib (string-append out "/lib"))
                                                    (vs-lib (string-append lib "/vapoursynth")))
                                               (mkdir-p vs-lib)
                                               (rename-file
                                                (string-append lib "/libsubtext.so")
                                                (string-append vs-lib "/libsubtext.so"))))))))
    (home-page "https://github.com/vapoursynth/subtext")
    (synopsis "subtext vapoursynth plugin")
    (description "Subtitle plugin for VapourSynth based on libass")
    (license license:lgpl2.1+)))

(define-public vs-fillborders
  (package
    (name "vs-fillborders")
    (version "2-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/dubhater/vapoursynth-fillborders")
             (commit "78fe68044fe3414ce8061bf811a235e29c8f7d9d")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1qpaks4sf5librcbxlckg6sm31r49546lpdlp44b12scdxa8a1wq"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments `(#:tests? #f
                 #:phases
                 (modify-phases %standard-phases
                                (add-after 'install 'move-library
                                           (lambda* (#:key outputs #:allow-other-keys)
                                             (let* ((out (assoc-ref outputs "out"))
                                                    (lib (string-append out "/lib"))
                                                    (vs-lib (string-append lib "/vapoursynth")))
                                               (mkdir-p vs-lib)
                                               (rename-file
                                                (string-append lib "/libfillborders.so")
                                                (string-append vs-lib "/libfillborders.so"))))))))
    (home-page "https://github.com/dubhater/vapoursynth-fillborders")
    (synopsis "fillborders vapoursynth plugin")
    (description "Fills the borders of a clip")
    (license license:lgpl2.1+)))

(define-public vs-vivtc
  (package
    (name "vs-vivtc")
    (version "R1-git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vapoursynth/vivtc")
             (commit "4ac661d78eaf8b5ab7c5dd2d05c81234fe9aaca8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1w8psk51cxr3c9y13bdrvxglhjy0zq1sa4rmdyfp32zs0s6wlkpc"))
       (patches (search-patches "vs-vivtc.patch"))))
    (build-system meson-build-system)
    (native-inputs (list pkg-config))
    (inputs (list vapoursynth zimg))
    (arguments `(#:tests? #f
                 #:phases
                 (modify-phases %standard-phases
                                (add-after 'install 'move-library
                                           (lambda* (#:key outputs #:allow-other-keys)
                                             (let* ((out (assoc-ref outputs "out"))
                                                    (lib (string-append out "/lib"))
                                                    (vs-lib (string-append lib "/vapoursynth")))
                                               (mkdir-p vs-lib)
                                               (rename-file
                                                (string-append lib "/libvivtc.so")
                                                (string-append vs-lib "/libvivtc.so"))))))))
    (home-page "https://github.com/vapoursynth/vivtc")
    (synopsis "vivtc vapoursynth plugin")
    (description "Field matcher and decimation filter for VapourSynth similar to TIVTC")
    (license license:lgpl2.1+)))

(define rust-zerocopy-derive-0.7
  (package
    (name "rust-zerocopy-derive")
    (version "0.7.34")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zerocopy-derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0fqvglw01w3hp7xj9gdk1800x9j7v58s9w8ijiyiz2a7krb39s8m"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/google/zerocopy")
    (synopsis "Custom derive for traits from the zerocopy crate")
    (description "Custom derive for traits from the zerocopy crate")
    (license (list license:bsd-2 license:asl2.0 license:expat))))

(define rust-zerocopy-0.7
  (package
    (name "rust-zerocopy")
    (version "0.7.34")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zerocopy" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11xhrwixm78m6ca1jdxf584wdwvpgg7q00vg21fhwl0psvyf71xf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-zerocopy-derive" ,rust-zerocopy-derive-0.7))))
    (home-page "https://github.com/google/zerocopy")
    (synopsis "Utilities for zero-copy parsing and serialization")
    (description "Utilities for zero-copy parsing and serialization")
    (license (list license:bsd-2 license:asl2.0 license:expat))))

(define rust-const-random-macro-0.1
  (package
    (name "rust-const-random-macro")
    (version "0.1.16")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "const-random-macro" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "03iram4ijjjq9j5a7hbnmdngj8935wbsd0f5bm8yw2hblbr3kn7r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-tiny-keccak" ,rust-tiny-keccak-2))))
    (home-page "https://github.com/tkaitchuck/constrandom")
    (synopsis "Provides the procedural macro used by const-random")
    (description
     "This package provides the procedural macro used by const-random")
    (license (list license:expat license:asl2.0))))

(define rust-const-random-0.1
  (package
    (name "rust-const-random")
    (version "0.1.18")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "const-random" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0n8kqz3y82ks8znvz1mxn3a9hadca3amzf33gmi6dc3lzs103q47"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-const-random-macro" ,rust-const-random-macro-0.1))))
    (home-page "https://github.com/tkaitchuck/constrandom")
    (synopsis "Provides compile time random number generation.")
    (description
     "This package provides compile time random number generation.")
    (license (list license:expat license:asl2.0))))

(define rust-ahash-0.8
  (package
    (name "rust-ahash")
    (version "0.8.11")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ahash" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "04chdfkls5xmhp1d48gnjsmglbqibizs3bpbj6rsj604m10si7g8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-atomic-polyfill" ,rust-atomic-polyfill-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-const-random" ,rust-const-random-0.1)
                       ("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-version-check" ,rust-version-check-0.9)
                       ("rust-zerocopy" ,rust-zerocopy-0.7))))
    (home-page "https://github.com/tkaitchuck/ahash")
    (synopsis
     "A non-cryptographic hash function using AES-NI for high performance")
    (description
     "This package provides a non-cryptographic hash function using AES-NI for high
performance")
    (license (list license:expat license:asl2.0))))

(define rust-hashbrown-0.14
  (package
    (name "rust-hashbrown")
    (version "0.14.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "hashbrown" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-ahash" ,rust-ahash-0.8)
                       ("rust-allocator-api2" ,rust-allocator-api2-0.2)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rkyv" ,rust-rkyv-0.7)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-lang/hashbrown")
    (synopsis "A Rust port of Google's SwissTable hash map")
    (description
     "This package provides a Rust port of Google's @code{SwissTable} hash map")
    (license (list license:expat license:asl2.0))))

(define rust-syn-derive-0.1
  (package
    (name "rust-syn-derive")
    (version "0.1.8")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "syn_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0yxydi22apcisjg0hff6dfm5x8hd6cqicav56sblx67z0af1ha8k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/Kyuuhachi/syn_derive")
    (synopsis "Derive macros for `syn::Parse` and `quote::ToTokens`")
    (description "Derive macros for `syn::Parse` and `quote::@code{ToTokens`}")
    (license (list license:expat license:asl2.0))))

(define rust-serde-spanned-0.6
  (package
    (name "rust-serde-spanned")
    (version "0.6.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde_spanned" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1839b6m5p9ijjmcwamiya2r612ks2vg6w2pp95yg76lr3zh79rkr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis "Serde-compatible spanned Value")
    (description "Serde-compatible spanned Value")
    (license (list license:expat license:asl2.0))))

(define rust-toml-edit-0.21
  (package
    (name "rust-toml-edit")
    (version "0.21.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "toml_edit" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1qch02syrd9c8krcimfl72gyjz11fmjssh03hrg41dbqgzyk91ba"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-kstring" ,rust-kstring-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-spanned" ,rust-serde-spanned-0.6)
                       ("rust-toml-datetime" ,rust-toml-datetime-0.6)
                       ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis "Yet another format-preserving TOML parser.")
    (description "Yet another format-preserving TOML parser.")
    (license (list license:expat license:asl2.0))))

(define rust-proc-macro-crate-3
  (package
    (name "rust-proc-macro-crate")
    (version "3.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "proc-macro-crate" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "110jcl9vnj92ihbhjqmkp19m8rzxc14a7i60knlmv99qlwfcadvd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-toml-edit" ,rust-toml-edit-0.21))))
    (home-page "https://github.com/bkchr/proc-macro-crate")
    (synopsis "Replacement for crate (macro_rules keyword) in proc-macros
")
    (description "Replacement for crate (macro_rules keyword) in proc-macros")
    (license (list license:expat license:asl2.0))))

(define rust-borsh-derive-1
  (package
    (name "rust-borsh-derive")
    (version "1.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "borsh-derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vglcfa3qvj52mfrrq3yp4lfsjv2n5c2anmkx11kwfdbjipn9a6p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-once-cell" ,rust-once-cell-1)
                       ("rust-proc-macro-crate" ,rust-proc-macro-crate-3)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-syn-derive" ,rust-syn-derive-0.1))))
    (home-page "https://borsh.io")
    (synopsis "Binary Object Representation Serializer for Hashing
")
    (description "Binary Object Representation Serializer for Hashing")
    (license license:asl2.0)))

(define rust-ascii-1
  (package
    (name "rust-ascii")
    (version "1.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ascii" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "05nyyp39x4wzc1959kv7ckwqpkdzjd9dw4slzyjh73qbhjcfqayr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/tomprogrammer/rust-ascii")
    (synopsis "ASCII-only equivalents to `char`, `str` and `String`.")
    (description "ASCII-only equivalents to `char`, `str` and `String`.")
    (license (list license:asl2.0 license:expat))))

(define rust-borsh-1
  (package
    (name "rust-borsh")
    (version "1.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "borsh" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0xqdla3s5kn7plrj10vckvlqyq52l4hbv7ywn5zifm29447b3rfv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-ascii" ,rust-ascii-1)
                       ("rust-borsh-derive" ,rust-borsh-derive-1)
                       ("rust-bson" ,rust-bson-2)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cfg-aliases" ,rust-cfg-aliases-0.1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14))))
    (home-page "https://borsh.io")
    (synopsis "Binary Object Representation Serializer for Hashing
")
    (description "Binary Object Representation Serializer for Hashing")
    (license (list license:expat license:asl2.0))))

(define rust-indexmap-2
  (package
    (name "rust-indexmap")
    (version "2.2.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "indexmap" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "09hgwi2ig0wyj5rjziia76zmhgfj95k0jb4ic3iiawm4vlavg3qn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-borsh" ,rust-borsh-1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustc-rayon" ,rust-rustc-rayon-0.5)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/indexmap-rs/indexmap")
    (synopsis "A hash table with consistent order and fast iteration.")
    (description
     "This package provides a hash table with consistent order and fast iteration.")
    (license (list license:asl2.0 license:expat))))

(define rust-serde-json-1
  (package
    (name "rust-serde-json")
    (version "1.0.117")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde_json" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1hxziifjlc0kn1cci9d4crmjc7qwnfi20lxwyj9lzca2c7m84la5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-ryu" ,rust-ryu-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/serde-rs/json")
    (synopsis "A JSON serialization file format")
    (description "This package provides a JSON serialization file format")
    (license (list license:expat license:asl2.0))))

(define rust-syn-2
  (package
    (name "rust-syn")
    (version "2.0.64")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "syn" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "07xinwkdjcdx7q8kgfw79a7ds6hd41636x1haxsri19n3zjdxlvs"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-unicode-ident" ,rust-unicode-ident-1))))
    (home-page "https://github.com/dtolnay/syn")
    (synopsis "Parser for Rust source code")
    (description "Parser for Rust source code")
    (license (list license:expat license:asl2.0))))

(define rust-quote-1
  (package
    (name "rust-quote")
    (version "1.0.36")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "quote" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19xcmh445bg6simirnnd4fvkmp6v2qiwxh5f6rw4a70h76pnm9qg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1))))
    (home-page "https://github.com/dtolnay/quote")
    (synopsis "Quasi-quoting macro quote!(...)")
    (description "Quasi-quoting macro quote!(...)")
    (license (list license:expat license:asl2.0))))

(define rust-proc-macro2-1
  (package
    (name "rust-proc-macro2")
    (version "1.0.82")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "proc-macro2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "06qk88hbf6wg4v1i961zibhjz512873jwkz3myx1z82ip6dd9lwa"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-unicode-ident" ,rust-unicode-ident-1))))
    (home-page "https://github.com/dtolnay/proc-macro2")
    (synopsis
     "A substitute implementation of the compiler's `proc_macro` API to decouple token-based libraries from the procedural macro use case.")
    (description
     "This package provides a substitute implementation of the compiler's `proc_macro`
API to decouple token-based libraries from the procedural macro use case.")
    (license (list license:expat license:asl2.0))))

(define rust-serde-derive-1
  (package
    (name "rust-serde-derive")
    (version "1.0.202")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0f28ghhyilpfn8bggs9vpm9z2015ld0fswnr9h4nkzxw0j08aj30"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://serde.rs")
    (synopsis "Macros 1.1 implementation of #[derive(Serialize, Deserialize)]")
    (description
     "Macros 1.1 implementation of #[derive(Serialize, Deserialize)]")
    (license (list license:expat license:asl2.0))))

(define rust-serde-1
  (package
    (name "rust-serde")
    (version "1.0.202")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "15d3if1151db1z89qibk0f8bpy64d93kmxypyrgvmchisjh62sr2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://serde.rs")
    (synopsis "A generic serialization/deserialization framework")
    (description
     "This package provides a generic serialization/deserialization framework")
    (license (list license:expat license:asl2.0))))

(define rust-roxmltree-0.19
  (package
    (name "rust-roxmltree")
    (version "0.19.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "roxmltree" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zs0q8hg5nnh91s1ib6r0fky7xm8ay63ayfa5i1afxxpwgalzl9w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f))
    (home-page "https://github.com/RazrFalcon/roxmltree")
    (synopsis "Represent an XML as a read-only tree.")
    (description "Represent an XML as a read-only tree.")
    (license (list license:expat license:asl2.0))))

(define rust-crc-catalog-2
  (package
    (name "rust-crc-catalog")
    (version "2.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "crc-catalog" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1xg7sz82w3nxp1jfn425fvn1clvbzb3zgblmxsyqpys0dckp9lqr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f))
    (home-page "https://github.com/akhilles/crc-catalog.git")
    (synopsis
     "Catalog of CRC algorithms (generated from http://reveng.sourceforge.net/crc-catalogue) expressed as simple Rust structs.")
    (description
     "Catalog of CRC algorithms (generated from
http://reveng.sourceforge.net/crc-catalogue) expressed as simple Rust structs.")
    (license (list license:expat license:asl2.0))))

(define rust-crc-3
  (package
    (name "rust-crc")
    (version "3.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "crc" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0dnn23x68qakzc429s1y9k9y3g8fn5v9jwi63jcz151sngby9rk9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-crc-catalog" ,rust-crc-catalog-2))))
    (home-page "https://github.com/mrhooray/crc-rs.git")
    (synopsis "Rust implementation of CRC with support of various standards")
    (description
     "Rust implementation of CRC with support of various standards")
    (license (list license:expat license:asl2.0))))

(define rust-bitstream-io-2
  (package
    (name "rust-bitstream-io")
    (version "2.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "bitstream-io" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vj4f4kg3ls3j41180a7ia65rj2p762mbzimm0bxiw22ds2x24kw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-core2" ,rust-core2-0.4))))
    (home-page "https://github.com/tuffy/bitstream-io")
    (synopsis
     "Library for reading/writing un-aligned values from/to streams in big-endian and little-endian formats.")
    (description
     "Library for reading/writing un-aligned values from/to streams in big-endian and
little-endian formats.")
    (license (list license:expat license:asl2.0))))

(define rust-bitvec-helpers-3
  (package
    (name "rust-bitvec-helpers")
    (version "3.1.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "bitvec_helpers" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "16h9kj4p0j9bpad73dyi9j03rwm7snq0gwnpvs3bpap8044fl468"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-bitstream-io" ,rust-bitstream-io-2)
                       ("rust-bitvec" ,rust-bitvec-1)
                       ("rust-funty" ,rust-funty-2))))
    (home-page "https://github.com/quietvoid/bitvec_helpers")
    (synopsis "BitVec based bitstream reader and writer")
    (description "@code{BitVec} based bitstream reader and writer")
    (license license:expat)))

(define rust-anyhow-1
  (package
    (name "rust-anyhow")
    (version "1.0.86")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "anyhow" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1nk301x8qhpdaks6a9zvcp7yakjqnczjmqndbg7vk4494d3d1ldk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3))))
    (home-page "https://github.com/dtolnay/anyhow")
    (synopsis "Flexible concrete Error type built on std::error::Error")
    (description "Flexible concrete Error type built on std::error::Error")
    (license (list license:expat license:asl2.0))))

(define-public rust-dolby-vision-3
  (package
    (name "rust-dolby-vision")
    (version "3.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dolby_vision" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13g5rhzp5grzxrscxqzd5z626ir63m8rgsj7a8pv09clnyk2727y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-bitvec" ,rust-bitvec-1)
                       ("rust-bitvec-helpers" ,rust-bitvec-helpers-3)
                       ("rust-crc" ,rust-crc-3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-roxmltree" ,rust-roxmltree-0.19)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.5))
       #:phases
       (modify-phases %standard-phases
                      (replace 'build
                               (lambda* (#:key outputs #:allow-other-keys)
                                 (let ((out (assoc-ref outputs "out")))
                                   (invoke "cargo" "cinstall" "--release"
                                           (string-append "--prefix=" out))))))
       ))
    (native-inputs `(("cargo-c" ,rust-cargo-c)))
    (home-page "https://github.com/quietvoid/dovi_tool/tree/main/dolby_vision")
    (synopsis "Dolby Vision metadata parsing and writing")
    (description "Dolby Vision metadata parsing and writing")
    (license license:expat)))

(define rust-vapoursynth-sys-0.4
  (package
    (name "rust-vapoursynth-sys")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "vapoursynth-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "171ack82jv44why2f73v9cbaq9xz2viv7iavwkn23kl0g6xrpi9g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:install-source? #f
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1))))
    (home-page "https://github.com/YaLTeR/vapoursynth-rs")
    (synopsis "Rust bindings for vapoursynth and vsscript.")
    (description "Rust bindings for vapoursynth and vsscript.")
    (license (list license:expat license:asl2.0))))

(define rust-vapoursynth-0.4
  (package
    (name "rust-vapoursynth")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "vapoursynth" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0mig50a74ggljqjp52mchbdhynwdwnhj9y4k7gx1rv2xqq1gfz8c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-half" ,rust-half-2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-vapoursynth-sys" ,rust-vapoursynth-sys-0.4))
       #:cargo-development-inputs (("rust-clap" ,rust-clap-3)
                                   ("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-num-rational" ,rust-num-rational-0.4))))
    (home-page "https://github.com/YaLTeR/vapoursynth-rs")
    (synopsis "Safe Rust wrapper for VapourSynth and VSScript.")
    (description "Safe Rust wrapper for @code{VapourSynth} and VSScript.")
    (license (list license:expat license:asl2.0))))


(define-public rust-vs-nlq
  (package
    (name "rust-vs-nlq")
    (version "git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference (url "https://github.com/quietvoid/vs-nlq")
                           (commit "d23952bb66d28cf1f565c897181c20bc640fb7fd")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1f2gbwlrkflzq1v1kbmcmpziw2hpf3phc2nw7aahf9ikh26gq9aq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1) ; 1.0.77
                       ("rust-dolby_vision" ,rust-dolby-vision-3) ; 3.2.0
                       ("rust-itertools" ,rust-itertools-0.12)
                       ("rust-vapoursynth" ,rust-vapoursynth-0.4))
       #:phases
       (modify-phases %standard-phases
                      (add-after 'install 'install-library
                                 (lambda* (#:key outputs #:allow-other-keys)
                                   (let ((out (assoc-ref outputs "out")))
                                   (install-file
                                    (car (find-files "." "^libvs_nlq\\.so$"))
                                    (string-append out "/lib/vapoursynth"))))))))
    (inputs (list vapoursynth))
    (home-page "https://github.com/quietvoid/vs-nlq/")
    (synopsis "vs-nlq plugin for vapoursynth")
    (description "Dolby Vision FEL mapping plugin for vapoursynth")
    (license license:expat)))

(define-public ffms2-git
  (package
   (inherit ffms2)
   (name "ffms2-git")
   (version "5.0")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/FFMS/ffms2")
                  (commit version)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "10fbhs3205phfj6d9x23wsn070xr7kljn0f5w2hm2j6a2vr6amr2"))))
   (arguments
    '(#:configure-flags
      (list "--enable-avresample")
      #:phases
      (modify-phases %standard-phases
                     (add-before 'bootstrap 'patch-autogen
                                 (lambda* (#:key inputs #:allow-other-keys)
                                   (delete-file "autogen.sh")
                                   (mkdir-p "src/config")
                                   #t))
                     (add-after 'install 'install-vs-library
                                (lambda* (#:key outputs #:allow-other-keys)
                                  (let* ((out (assoc-ref outputs "out"))
                                        (lib (string-append out "/lib"))
                                        (vs-lib (string-append lib "/vapoursynth")))
                                    (mkdir-p vs-lib)
                                    (symlink
                                     (string-append lib "/libffms2.so")
                                     (string-append vs-lib "/libffms2.so"))))))))
   (propagated-inputs
    (list ffmpeg))
   (native-inputs
    (list autoconf automake gettext-minimal pkg-config libtool))))

(define zimg-3.0.5
  (package
    (name "zimg")
    (version "3.0.5")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/sekrit-twc/zimg")
              (commit (string-append "release-" version))
              (recursive? #true)))
        (file-name (git-file-name name version))
        (sha256
         (base32 "1j7c4z06kdkdxdl0ikas1a9xw9ghc5lsi89nnbg6dv7k75v327y5"))))
    (build-system gnu-build-system)
    (native-inputs
     (list autoconf automake libtool))
    (synopsis "Scaling, colorspace conversion, and dithering library")
    (description "Zimg implements the commonly required image processing basics
of scaling, colorspace conversion, and depth conversion.  A simple API enables
conversion between any supported formats to operate with minimal knowledge from
the programmer.")
    (home-page "https://github.com/sekrit-twc/zimg")
    (license license:wtfpl2)))

(define python-cython-3.0.10
  (package
    (inherit python-cython)
    (name "python-cython-next")
    (version "3.0.10")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Cython" version))
              (sha256
               (base32
                "16fy6bqkcn6mvx8clqbc0s489zkcaw3ldy83ypf59f0z6cwngjfw"))))
   (arguments
    (substitute-keyword-arguments (package-arguments python-cython)
                                  ((#:tests? flags #f) #f)))
    (properties '())))

(define-public vapoursynth-git ; MAYBE add wrap-program from (guix build utils) to set the plugin directory
  (package
   (inherit vapoursynth)
   (name "vapoursynth-git")
   (version "68")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/vapoursynth/vapoursynth")
                  (commit (string-append "R" version))))
            (file-name (git-file-name name version))
            (sha256
             (base32 "116pp88a1mld6ys7q8hdv0j3lscwb8w1yyj0fk8418vc99llmdrw"))
            (patches (search-patches "vs.patch"))))
    (inputs
     (list ffmpeg libass python-3.12 tesseract-ocr zimg-3.0.5))
    (native-inputs
     (list autoconf
           automake
           python-cython-3.0.10 ; 3+ after R63
           libtool
           pkg-config
           yasm))))

;;; maybe remove patches for snippets/phases
;;; vendored zimg, cython, some rust crates and patches for issues
;vs-fillborders
;vs-vivtc
;vs-subtext
;vs-eedi3m
;vs-placebo
;rust-vs-nlq
;ffms2-git
;vapoursynth-git
