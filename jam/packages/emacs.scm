(define-module (jam packages emacs)
  #:use-module (guix transformations)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  ; for reka
  #:use-module (gnu packages zig-xyz)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages rust-apps)
  #:use-module (jam packages) ; for search-patches
  #:use-module ((guix licenses) #:prefix license:)
  )

;; aot compile transformation for packages
(define-public transform-emacs-build
  (options->transformation '((with-input . "emacs-minimal=emacs"))))

;; create a procedure that applies transformations options "with-branch=master" to an emacs package
(define-public (transform-emacs-build-git pkg)
  (define xform (options->transformation `((with-branch . ,(string-append (package-name pkg) "=master"))
                                           (with-input . "emacs-minimal=emacs"))))
  (xform pkg))

;; transform emacs package configure flags for ~5% perf in emacs-30+
(define-public (transform-emacs-configure pkg)
  (define xform (options->transformation `((with-configure-flag . ,(string-append (package-name pkg) "=--disable-gc-mark-trace")))))
  (xform pkg))

;; rust deps for emacs-reka native module
(define rust-aho-corasick-1.1.4
  (crate-source "aho-corasick" "1.1.4"
                "00a32wb2h07im3skkikc495jvncf62jl6s96vwc7bhi70h9imlyx"))

(define rust-anstream-0.6.21
  (crate-source "anstream" "0.6.21"
                "0jjgixms4qjj58dzr846h2s29p8w7ynwr9b9x6246m1pwy0v5ma3"))

(define rust-anstyle-1.0.13
  (crate-source "anstyle" "1.0.13"
                "0y2ynjqajpny6q0amvfzzgw0gfw3l47z85km4gvx87vg02lcr4ji"))

(define rust-anstyle-parse-0.2.7
  (crate-source "anstyle-parse" "0.2.7"
                "1hhmkkfr95d462b3zf6yl2vfzdqfy5726ya572wwg8ha9y148xjf"))

(define rust-anstyle-query-1.1.5
  (crate-source "anstyle-query" "1.1.5"
                "1p6shfpnbghs6jsa0vnqd8bb8gd7pjd0jr7w0j8jikakzmr8zi20"))

(define rust-anstyle-wincon-3.0.11
  (crate-source "anstyle-wincon" "3.0.11"
                "0zblannm70sk3xny337mz7c6d8q8i24vhbqi42ld8v7q1wjnl7i9"))

(define rust-anyhow-1.0.102
  (crate-source "anyhow" "1.0.102"
                "0b447dra1v12z474c6z4jmicdmc5yxz5bakympdnij44ckw2s83z"))

(define rust-bitflags-2.11.0
  (crate-source "bitflags" "2.11.0"
                "1bwjibwry5nfwsfm9kjg2dqx5n5nja9xymwbfl6svnn8jsz6ff44"))

(define rust-cc-1.2.56
  (crate-source "cc" "1.2.56"
                "1chvh9g2izhqad7vzy4cc7xpdljdvqpsr6x6hv1hmyqv3mlkbgxf"))

(define rust-cfg-if-1.0.4
  (crate-source "cfg-if" "1.0.4"
                "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))

(define rust-cfg-aliases-0.2.1
  (crate-source "cfg_aliases" "0.2.1"
                "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))

(define rust-colorchoice-1.0.4
  (crate-source "colorchoice" "1.0.4"
                "0x8ymkz1xr77rcj1cfanhf416pc4v681gmkc9dzb3jqja7f62nxh"))

(define rust-ctor-0.1.26
  (crate-source "ctor" "0.1.26"
                "15m0wqhv12p25xkxz5dxvg23r7a6bkh7p8zi1cdhgswjhdl028vd"))

(define rust-darling-0.10.2
  (crate-source "darling" "0.10.2"
                "0n7qsp6854wm3y1q1lvylhv15zvc87ibbac1nyfmcdbyv1snww0d"))

(define rust-darling-core-0.10.2
  (crate-source "darling_core" "0.10.2"
                "16sija1jv0l754x4aa6b6fy01d1kf8m0r4id3flqipm45np61jgh"))

(define rust-darling-macro-0.10.2
  (crate-source "darling_macro" "0.10.2"
                "0wlv31cxkrjijz5gv13hvk55c9lmd781aj12c8n84sa9mksa5dfr"))

(define rust-downcast-rs-1.2.1
  (crate-source "downcast-rs" "1.2.1"
                "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))

(define rust-emacs-0.21.0
  (crate-source "emacs" "0.21.0"
                "1qdqn0bk76fq24zqlmapj2ancm0m1hwalacsxmk146gmv1mny23w"))

(define rust-emacs-macros-0.17.0
  (crate-source "emacs-macros" "0.17.0"
                "0qg1dcn5acbirq617qq2fgg9adswif2dnr292s3qnq62wzgnyrb9"))

(define rust-emacs-module-0.21.0
  (crate-source "emacs_module" "0.21.0"
                "0ykpk4fxpz193fykchb6xs8l5lbghzl6panwy79yh74hvgxj1018"))

(define rust-env-filter-1.0.0
  (crate-source "env_filter" "1.0.0"
                "13rhwy5arjn626a0z3hvvkpf9w9pnll14c35vscyqx3jwp43q73s"))

(define rust-env-logger-0.11.9
  (crate-source "env_logger" "0.11.9"
                "13913sqpnhv741z5ixmcy5j3nnml53gmsllnhajjkx2ili7fxnmj"))

(define rust-errno-0.3.14
  (crate-source "errno" "0.3.14"
                "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))

(define rust-find-msvc-tools-0.1.9
  (crate-source "find-msvc-tools" "0.1.9"
                "10nmi0qdskq6l7zwxw5g56xny7hb624iki1c39d907qmfh3vrbjv"))

(define rust-fnv-1.0.7
  (crate-source "fnv" "1.0.7"
                "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))

(define rust-ident-case-1.0.1
  (crate-source "ident_case" "1.0.1"
                "0fac21q6pwns8gh1hz3nbq15j8fi441ncl6w4vlnd1cmc55kiq5r"))

(define rust-is-terminal-polyfill-1.70.2
  (crate-source "is_terminal_polyfill" "1.70.2"
                "15anlc47sbz0jfs9q8fhwf0h3vs2w4imc030shdnq54sny5i7jx6"))

(define rust-jiff-0.2.20
  (crate-source "jiff" "0.2.20"
                "0hv59kcqj5sc0jgk4q7yrq5dp8yb3qlan98qk3s36sq9ribc6ry8"))

(define rust-jiff-static-0.2.20
  (crate-source "jiff-static" "0.2.20"
                "1rcvbp9aj8ll4ljxcgzq4l2h9idmkb0v6mdvf3r3i5r64m1np57p"))

(define rust-libc-0.2.180
  (crate-source "libc" "0.2.180"
                "1z2n7hl10fnk1xnv19ahhqxwnb4qi9aclnl6gigim2aaahw5mhxw"))

(define rust-linux-raw-sys-0.11.0
  ;; TODO: Check bundled sources.
  (crate-source "linux-raw-sys" "0.11.0"
                "0fghx0nn8nvbz5yzgizfcwd6ap2pislp68j8c1bwyr6sacxkq7fz"))

(define rust-log-0.4.29
  (crate-source "log" "0.4.29"
                "15q8j9c8g5zpkcw0hnd6cf2z7fxqnvsjh3rw5mv5q10r83i34l2y"))

(define rust-memchr-2.8.0
  (crate-source "memchr" "2.8.0"
                "0y9zzxcqxvdqg6wyag7vc3h0blhdn7hkq164bxyx2vph8zs5ijpq"))

(define rust-memmap2-0.9.10
  (crate-source "memmap2" "0.9.10"
                "1qz0n4ch68pz2mp07sdwnk27imdjjqy6aqir3hp9j4g0iw19hh3i"))

(define rust-nix-0.31.1
  (crate-source "nix" "0.31.1"
                "0rjvhqknrwgjh8acxvvs4hsl4gkjh8lxpvdsd2daf2qyf7z7qpi2"))

(define rust-once-cell-1.21.3
  (crate-source "once_cell" "1.21.3"
                "0b9x77lb9f1j6nqgf5aka4s2qj0nly176bpbrv6f9iakk5ff3xa2"))

(define rust-once-cell-polyfill-1.70.2
  (crate-source "once_cell_polyfill" "1.70.2"
                "1zmla628f0sk3fhjdjqzgxhalr2xrfna958s632z65bjsfv8ljrq"))

(define rust-pkg-config-0.3.32
  (crate-source "pkg-config" "0.3.32"
                "0k4h3gnzs94sjb2ix6jyksacs52cf1fanpwsmlhjnwrdnp8dppby"))

(define rust-portable-atomic-1.13.1
  (crate-source "portable-atomic" "1.13.1"
                "0j8vlar3n5acyigq8q6f4wjx3k3s5yz0rlpqrv76j73gi5qr8fn3"))

(define rust-portable-atomic-util-0.2.5
  (crate-source "portable-atomic-util" "0.2.5"
                "1xcm0ia8756k6hdgafx4g3lx3fw0hvz2zqswq7c2sy58gxnvk7bs"))

(define rust-proc-macro2-1.0.106
  (crate-source "proc-macro2" "1.0.106"
                "0d09nczyaj67x4ihqr5p7gxbkz38gxhk4asc0k8q23g9n85hzl4g"))

(define rust-quick-xml-0.38.4
  (crate-source "quick-xml" "0.38.4"
                "0772siy4d9vlq77842012c8cycs3y0szxkv62rh9sh2sqmc20v5n"))

(define rust-quote-1.0.44
  (crate-source "quote" "1.0.44"
                "1r7c7hxl66vz3q9qizgjhy77pdrrypqgk4ghc7260xvvfb7ypci1"))

(define rust-regex-1.12.3
  (crate-source "regex" "1.12.3"
                "0xp2q0x7ybmpa5zlgaz00p8zswcirj9h8nry3rxxsdwi9fhm81z1"))

(define rust-regex-automata-0.4.14
  (crate-source "regex-automata" "0.4.14"
                "13xf7hhn4qmgfh784llcp2kzrvljd13lb2b1ca0mwnf15w9d87bf"))

(define rust-regex-syntax-0.8.9
  (crate-source "regex-syntax" "0.8.9"
                "0k0a47r1rcl794wj8a948niakbg081s5pp5nlgcbmmr2iy3qfs59"))

(define rust-rustc-version-0.2.3
  (crate-source "rustc_version" "0.2.3"
                "02h3x57lcr8l2pm0a645s9whdh33pn5cnrwvn5cb57vcrc53x3hk"))

(define rust-rustix-1.1.3
  (crate-source "rustix" "1.1.3"
                "0d0z2zcw4rwzni1hm8snw8xdxwwrij336m31c4ghq66cghj9wv0l"))

(define rust-semver-0.9.0
  (crate-source "semver" "0.9.0"
                "00q4lkcj0rrgbhviv9sd4p6qmdsipkwkbra7rh11jrhq5kpvjzhx"))

(define rust-semver-parser-0.7.0
  (crate-source "semver-parser" "0.7.0"
                "18vhypw6zgccnrlm5ps1pwa0khz7ry927iznpr88b87cagr1v2iq"))

(define rust-serde-core-1.0.228
  (crate-source "serde_core" "1.0.228"
                "1bb7id2xwx8izq50098s5j2sqrrvk31jbbrjqygyan6ask3qbls1"))

(define rust-serde-derive-1.0.228
  (crate-source "serde_derive" "1.0.228"
                "0y8xm7fvmr2kjcd029g9fijpndh8csv5m20g4bd76w8qschg4h6m"))

(define rust-shlex-1.3.0
  (crate-source "shlex" "1.3.0"
                "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))

(define rust-smallvec-1.15.1
  (crate-source "smallvec" "1.15.1"
                "00xxdxxpgyq5vjnpljvkmy99xij5rxgh913ii1v16kzynnivgcb7"))

(define rust-strsim-0.9.3
  (crate-source "strsim" "0.9.3"
                "0k497pv882qn3q977ckznm13vxx927g8s1swvcv68j3c1pccwik4"))

(define rust-syn-1.0.109
  (crate-source "syn" "1.0.109"
                "0ds2if4600bd59wsv7jjgfkayfzy3hnazs394kz6zdkmna8l3dkj"))

(define rust-syn-2.0.117
  (crate-source "syn" "2.0.117"
                "16cv7c0wbn8amxc54n4w15kxlx5ypdmla8s0gxr2l7bv7s0bhrg6"))

(define rust-thiserror-1.0.69
  (crate-source "thiserror" "1.0.69"
                "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))

(define rust-thiserror-impl-1.0.69
  (crate-source "thiserror-impl" "1.0.69"
                "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))

(define rust-unicode-ident-1.0.24
  (crate-source "unicode-ident" "1.0.24"
                "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))

(define rust-utf8parse-0.2.2
  (crate-source "utf8parse" "0.2.2"
                "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))

(define rust-wayland-backend-0.3.12
  (crate-source "wayland-backend" "0.3.12"
                "1yb4s5mbcis3z3gcmxq2lzgrcw2li7jsfr9ayi4gcsyrrja43rpy"))

(define rust-wayland-client-0.31.12
  (crate-source "wayland-client" "0.31.12"
                "1v1b2b2s0ld41psn3v2p3c6i590iz3r427czrf3c3dpv6yjzmrmq"))

(define rust-wayland-scanner-0.31.8
  (crate-source "wayland-scanner" "0.31.8"
                "1qw971z9jcxdw8s371gx2anmwb95m59y38q3k11qxrk3d95yj8sl"))

(define rust-wayland-sys-0.31.8
  ;; TODO: Check bundled sources.
  (crate-source "wayland-sys" "0.31.8"
                "1zdxrcl8paklwir0lag1i80k6h0iq1f80d925b4p9yaymk1vyv8y"))

(define rust-windows-link-0.2.1
  (crate-source "windows-link" "0.2.1"
                "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))

(define rust-windows-sys-0.61.2
  ;; TODO: Check bundled sources.
  (crate-source "windows-sys" "0.61.2"
                "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))

(define rust-xkbcommon-0.9.0
  (crate-source "xkbcommon" "0.9.0"
                "0bd0qkapxsvblfw42x6ryhi50d63v55g40awf2alx8b0h3s79ad7"))

(define rust-xkeysym-0.2.1
  (crate-source "xkeysym" "0.2.1"
                "0mksx670cszyd7jln6s7dhkw11hdfv7blwwr3isq98k22ljh1k5r"))


(define libreka
  (package
    (name "libreka")
    (version "git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference (url "https://codeberg.org/tazjin/reka")
                           (commit "70aa8d95d96ff6ad4563fc29ed6d6ab0e9b486a1")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ww4jnksfpgrr9q9di1w3b43y3qi5xg9kmypbnqzyfrqv7zvxfbf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:phases
       (modify-phases %standard-phases
                      (add-after 'install 'install-library
                                 (lambda* (#:key outputs #:allow-other-keys)
                                   (let ((out (assoc-ref outputs "out")))
                                   (install-file
                                    (car (find-files "." "^libreka\\.so$"))
                                    (string-append out "/lib"))))))
       ))
    (inputs (list libxkbcommon ; guix import crate -f Cargo.lock reka | grep "(define" | grep -o " .*"
                  rust-aho-corasick-1.1.4
                  rust-anstream-0.6.21
                  rust-anstyle-1.0.13
                  rust-anstyle-parse-0.2.7
                  rust-anstyle-query-1.1.5
                  rust-anstyle-wincon-3.0.11
                  rust-anyhow-1.0.102
                  rust-bitflags-2.11.0
                  rust-cc-1.2.56
                  rust-cfg-if-1.0.4
                  rust-cfg-aliases-0.2.1
                  rust-colorchoice-1.0.4
                  rust-ctor-0.1.26
                  rust-darling-0.10.2
                  rust-darling-core-0.10.2
                  rust-darling-macro-0.10.2
                  rust-downcast-rs-1.2.1
                  rust-emacs-0.21.0
                  rust-emacs-macros-0.17.0
                  rust-emacs-module-0.21.0
                  rust-env-filter-1.0.0
                  rust-env-logger-0.11.9
                  rust-errno-0.3.14
                  rust-find-msvc-tools-0.1.9
                  rust-fnv-1.0.7
                  rust-ident-case-1.0.1
                  rust-is-terminal-polyfill-1.70.2
                  rust-jiff-0.2.20
                  rust-jiff-static-0.2.20
                  rust-libc-0.2.180
                  rust-linux-raw-sys-0.11.0
                  rust-log-0.4.29
                  rust-memchr-2.8.0
                  rust-memmap2-0.9.10
                  rust-nix-0.31.1
                  rust-once-cell-1.21.3
                  rust-once-cell-polyfill-1.70.2
                  rust-pkg-config-0.3.32
                  rust-portable-atomic-1.13.1
                  rust-portable-atomic-util-0.2.5
                  rust-proc-macro2-1.0.106
                  rust-quick-xml-0.38.4
                  rust-quote-1.0.44
                  rust-regex-1.12.3
                  rust-regex-automata-0.4.14
                  rust-regex-syntax-0.8.9
                  rust-rustc-version-0.2.3
                  rust-rustix-1.1.3
                  rust-semver-0.9.0
                  rust-semver-parser-0.7.0
                  rust-serde-core-1.0.228
                  rust-serde-derive-1.0.228
                  rust-shlex-1.3.0
                  rust-smallvec-1.15.1
                  rust-strsim-0.9.3
                  rust-syn-1.0.109
                  rust-syn-2.0.117
                  rust-thiserror-1.0.69
                  rust-thiserror-impl-1.0.69
                  rust-unicode-ident-1.0.24
                  rust-utf8parse-0.2.2
                  rust-wayland-backend-0.3.12
                  rust-wayland-client-0.31.12
                  rust-wayland-scanner-0.31.8
                  rust-wayland-sys-0.31.8
                  rust-windows-link-0.2.1
                  rust-windows-sys-0.61.2
                  rust-xkbcommon-0.9.0
                  rust-xkeysym-0.2.1
                  ))
      (native-inputs (list pkg-config))
      (home-page "https://codeberg.org/tazjin/reka")
      (synopsis "Emacs river WM integration")
      (description "This package implements a window manger to @code{river} to manage wayland windows as Emacs buffers.")
      (license license:gpl3+)))

(define-public emacs-reka
  (let ((commit "70aa8d95d96ff6ad4563fc29ed6d6ab0e9b486a1")
        (revision "1"))
    (package
      (name "emacs-reka")
      (version (git-version "0.0.0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://codeberg.org/tazjin/reka")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1ww4jnksfpgrr9q9di1w3b43y3qi5xg9kmypbnqzyfrqv7zvxfbf"))))
      (build-system emacs-build-system)
      (arguments
       `(#:modules ((guix build emacs-build-system)
                    (guix build emacs-utils)
                    (guix build utils))
         #:include (cons "^lisp/" %default-include)
         #:phases
         (modify-phases %standard-phases
               (add-before 'build 'install-library
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (let* ((out (assoc-ref outputs "out"))
                          (lib-dir (string-append (elpa-directory out) "/lisp")); add to load-path
                          (rust-lib (assoc-ref inputs "libreka"))
                          (source-lib (string-append rust-lib "/lib/libreka.so")))
                     (setenv "EMACSLOADPATH" (string-append lib-dir ":" (getenv "EMACSLOADPATH")))
                     (mkdir-p lib-dir)
                     (install-file source-lib lib-dir)))))))
      (inputs (list libreka))
      (home-page "https://codeberg.org/tazjin/reka")
      (synopsis "Emacs river WM integration")
      (description "This package implements a window manger to @code{river} to manage wayland windows as Emacs buffers.")
      (license license:gpl3+))))

emacs-reka; river-0.4.1
