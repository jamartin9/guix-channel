(define-module (jam packages httm)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crates-graphics)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils))

(define rust-xattr-1
  (package
    (name "rust-xattr")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "xattr" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jn35gv7cyxjsh4ljy4vxpahlballayazpd48ql55h83r8vk89pa"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/Stebalien/xattr")
    (synopsis "unix extended filesystem attributes")
    (description "unix extended filesystem attributes")
    (license (list license:expat license:asl2.0))))

(define rust-which-4
  (package
    (name "rust-which")
    (version "4.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "which" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0sd24r17q4j3hc2yjjrg9q4qya1y4n9zq0bj9c2rla1bqn2cfh94"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-either" ,rust-either-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/harryfei/which-rs.git")
    (synopsis
     "A Rust equivalent of Unix command \"which\". Locate installed executable in cross platforms.")
    (description
     "This package provides a Rust equivalent of Unix command \"which\".  Locate
installed executable in cross platforms.")
    (license license:expat)))

(define rust-tuikit-0.5
  (package
    (name "rust-tuikit")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tuikit" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1n2kiq6kjl1g89v8f9v2dwcv5g8hp7w2zhf8a0yyxawb0fmwc6ay"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nix" ,rust-nix-0.24)
                       ("rust-term" ,rust-term-0.7)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/lotabout/tuikit")
    (synopsis "Toolkit for writing TUI applications")
    (description "Toolkit for writing TUI applications")
    (license license:expat)))

(define rust-regex-syntax-0.7
  (package
    (name "rust-regex-syntax")
    (version "0.7.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex-syntax" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qjczlc2w92kamn9ipjdr5pjql0jnccahpi9l3r6wp0rnsjr5sp5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1))))
    (home-page "https://github.com/rust-lang/regex/tree/master/regex-syntax")
    (synopsis "A regular expression parser.")
    (description "This package provides a regular expression parser.")
    (license (list license:expat license:asl2.0))))

(define rust-regex-automata-0.3
  (package
    (name "rust-regex-automata")
    (version "0.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex-automata" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bvc8xaqhcv5m76a58vc5mds8qp0l25i13w7xicbgzvcjykdmlw3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aho-corasick" ,rust-aho-corasick-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.7))))
    (home-page "https://github.com/rust-lang/regex/tree/master/regex-automata")
    (synopsis "Automata construction and matching using regular expressions.")
    (description
     "Automata construction and matching using regular expressions.")
    (license (list license:expat license:asl2.0))))

(define rust-aho-corasick-1
  (package
    (name "rust-aho-corasick")
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "aho-corasick" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0has59a3571irggpk5z8c0lpnx8kdx12qf4g2x0560i2y8dwpxj3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-memchr" ,rust-memchr-2))))
    (home-page "https://github.com/BurntSushi/aho-corasick")
    (synopsis "Fast multiple substring searching.")
    (description "Fast multiple substring searching.")
    (license (list license:unlicense license:expat))))

(define rust-regex-1
  (package
    (name "rust-regex")
    (version "1.9.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xdmrvs8fy7yw2bdk76mjbhzqibms7g4ljg468jwzxr0qa7ydsmj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-aho-corasick" ,rust-aho-corasick-1)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-regex-automata" ,rust-regex-automata-0.3)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.7))))
    (home-page "https://github.com/rust-lang/regex")
    (synopsis
     "An implementation of regular expressions for Rust. This implementation uses
finite automata and guarantees linear time matching on all inputs.
")
    (description
     "An implementation of regular expressions for Rust.  This implementation uses
finite automata and guarantees linear time matching on all inputs.")
    (license (list license:expat license:asl2.0))))

(define rust-thread-local-1
  (package
    (name "rust-thread-local")
    (version "1.1.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thread_local" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lp19jdgvp5m4l60cgxdnl00yw1hlqy8gcywg9bddwng9h36zp9z"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-once-cell" ,rust-once-cell-1))))
    (home-page "https://github.com/Amanieu/thread_local-rs")
    (synopsis "Per-object thread-local storage")
    (description "Per-object thread-local storage")
    (license (list license:expat license:asl2.0))))

(define rust-fuzzy-muff-0.3
  (package
    (name "rust-fuzzy-muff")
    (version "0.3.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fuzzy-muff" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1fnhs67wy0r3ywsi28v7f6afivx2ss2qi3mllcplmvzjikhpj49k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-thread-local" ,rust-thread-local-1))))
    (home-page "https://github.com/lotabout/fuzzy-matcher")
    (synopsis "Fuzzy Matching Library")
    (description "Fuzzy Matching Library")
    (license license:expat)))

(define rust-derive-builder-core-0.12
  (package
    (name "rust-derive-builder-core")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "derive_builder_core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03vvmw3mfg370swq0dh2h5kcjjb8va2m4asqgp9wfyy4l08xq6y1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-darling" ,rust-darling-0.14)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/colin-kiegel/rust-derive-builder")
    (synopsis "Internal helper library for the derive_builder crate.")
    (description "Internal helper library for the derive_builder crate.")
    (license (list license:expat license:asl2.0))))

(define rust-derive-builder-macro-0.12
  (package
    (name "rust-derive-builder-macro")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "derive_builder_macro" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17p71qzh7x1q2yxzz3xrg73zw3xl0h479b7ybyjm0s1rg9fa7kgb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-derive-builder-core" ,rust-derive-builder-core-0.12)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/colin-kiegel/rust-derive-builder")
    (synopsis
     "Rust macro to automatically implement the builder pattern for arbitrary structs.")
    (description
     "Rust macro to automatically implement the builder pattern for arbitrary structs.")
    (license (list license:expat license:asl2.0))))

(define rust-derive-builder-0.12
  (package
    (name "rust-derive-builder")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "derive_builder" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1y4p569zcvpmly5s5hmjp9h83drxvdp6kj6bb61h225mhj3pfrwd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-derive-builder-macro" ,rust-derive-builder-macro-0.12))))
    (home-page "https://github.com/colin-kiegel/rust-derive-builder")
    (synopsis
     "Rust macro to automatically implement the builder pattern for arbitrary structs.")
    (description
     "Rust macro to automatically implement the builder pattern for arbitrary structs.")
    (license (list license:expat license:asl2.0))))

(define rust-defer-drop-1
  (package
    (name "rust-defer-drop")
    (version "1.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "defer-drop" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mswjjksrr6fvsgxvp64mzwkjkzjmpwjfaw4n76jhsvalsgyq4zn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/Lucretiel/defer-drop")
    (synopsis "Defer dropping large types to a background thread")
    (description "Defer dropping large types to a background thread")
    (license license:mpl2.0)))

(define rust-bitflags-2
  (package
    (name "rust-bitflags")
    (version "2.3.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bitflags" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hifjw3191g3w5cwqqvbx8knrr3zchdwfc3rs6mn11p5si9yf2v3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-bytemuck" ,rust-bytemuck-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/bitflags/bitflags")
    (synopsis "A macro to generate structures which behave like bitflags.
")
    (description
     "This package provides a macro to generate structures which behave like bitflags.")
    (license (list license:expat license:asl2.0))))

(define rust-two-percent-0.10
  (package
    (name "rust-two-percent")
    (version "0.10.19")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "two_percent" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "193g43y0mxwg9f0d2rrb70v9kdwdz4nhgnir8jljnn80d4k4kbkf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-atty" ,rust-atty-0.2)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-clap" ,rust-clap-3)
                       ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-defer-drop" ,rust-defer-drop-1)
                       ("rust-derive-builder" ,rust-derive-builder-0.12)
                       ("rust-env-logger" ,rust-env-logger-0.10)
                       ("rust-fuzzy-muff" ,rust-fuzzy-muff-0.3)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nix" ,rust-nix-0.26)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-shlex" ,rust-shlex-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-timer" ,rust-timer-0.2)
                       ("rust-tuikit" ,rust-tuikit-0.5)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-vte" ,rust-vte-0.11))))
    (home-page "https://github.com/kimono-koans/two_percent")
    (synopsis "Fuzzy Finder in rust!")
    (description "Fuzzy Finder in rust!")
    (license license:expat)))

(define rust-time-macros-0.2
  (package
    (name "rust-time-macros")
    (version "0.2.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1i566vxybz24i2rdax2d0m86fk2m45rarrapnxk6gj7kjyl1bfln"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-time-core" ,rust-time-core-0.1))))
    (home-page "https://github.com/time-rs/time")
    (synopsis
     "    Procedural macros for the time crate.
    This crate is an implementation detail and should not be relied upon directly.
")
    (description
     "Procedural macros for the time crate.  This crate is an implementation detail
and should not be relied upon directly.")
    (license (list license:expat license:asl2.0))))

(define rust-time-core-0.1
  (package
    (name "rust-time-core")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yz6d246zbmx9v6wpfg1jyfjlsgagirz7km96pr1mp6snkpzn03k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/time-rs/time")
    (synopsis
     "This crate is an implementation detail and should not be relied upon directly.")
    (description
     "This crate is an implementation detail and should not be relied upon directly.")
    (license (list license:expat license:asl2.0))))

(define rust-time-0.3
  (package
    (name "rust-time")
    (version "0.3.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ihlz293f792cd7v7qhpkx8rqkzs0fr77bzddw8msfpld309kqsr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-itoa" ,rust-itoa-1)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-num-threads" ,rust-num-threads-0.1)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-time-core" ,rust-time-core-0.1)
                       ("rust-time-macros" ,rust-time-macros-0.2))))
    (home-page "https://time-rs.github.io")
    (synopsis
     "Date and time library. Fully interoperable with the standard library. Mostly compatible with #![no_std].")
    (description
     "Date and time library.  Fully interoperable with the standard library.  Mostly
compatible with #![no_std].")
    (license (list license:expat license:asl2.0))))

(define rust-linux-raw-sys-0.3
  (package
    (name "rust-linux-raw-sys")
    (version "0.3.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "linux-raw-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "068mbigb3frrxvbi5g61lx25kksy98f2qgkvc4xg8zxznwp98lzg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis "Generated bindings for Linux's userspace API")
    (description "Generated bindings for Linux's userspace API")
    (license (list license:asl2.0 license:asl2.0
                   license:expat))))

(define rust-hermit-abi-0.3
  (package
    (name "rust-hermit-abi")
    (version "0.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hermit-abi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12v66gy77sqrgmjlx01w9p054nvz4mnhbd6xaazkxnddrp448ca4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/hermitcore/rusty-hermit")
    (synopsis "Hermit system calls definitions.")
    (description "Hermit system calls definitions.")
    (license (list license:expat license:asl2.0))))

(define rust-io-lifetimes-1
  (package
    (name "rust-io-lifetimes")
    (version "1.0.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "io-lifetimes" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-std" ,rust-async-std-1)
                       ("rust-fs-err" ,rust-fs-err-2)
                       ("rust-hermit-abi" ,rust-hermit-abi-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mio" ,rust-mio-0.8)
                       ("rust-os-pipe" ,rust-os-pipe-1)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/sunfishcode/io-lifetimes")
    (synopsis "A low-level I/O ownership and borrowing library")
    (description
     "This package provides a low-level I/O ownership and borrowing library")
    (license (list license:asl2.0 license:asl2.0
                   license:expat))))

(define rust-errno-0.3
  (package
    (name "rust-errno")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "errno" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0fp7qy6fwagrnmi45msqnl01vksqwdb2qbbv60n9cz7rf0xfrksb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-errno-dragonfly" ,rust-errno-dragonfly-0.1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/lambda-fairy/rust-errno")
    (synopsis "Cross-platform interface to the `errno` variable.")
    (description "Cross-platform interface to the `errno` variable.")
    (license (list license:expat license:asl2.0))))

(define rust-rustix-0.37
  (package
    (name "rust-rustix")
    (version "0.37.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01mbsk0q93rh5ji6k27zq09r5fz88akl8kn6knj2fq8wz25p2sad"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-errno" ,rust-errno-0.3)
                       ("rust-io-lifetimes" ,rust-io-lifetimes-1)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.3)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/bytecodealliance/rustix")
    (synopsis "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (description
     "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (license (list license:asl2.0
                   license:expat))))

(define rust-terminal-size-0.2
  (package
    (name "rust-terminal-size")
    (version "0.2.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "terminal_size" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0drj7gb77kay5r1cv53ysq3g9g4f8n0jkhld0kadi3lzkvqzcswf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustix" ,rust-rustix-0.37)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/eminence/terminal-size")
    (synopsis "Gets the size of your Linux or Windows terminal")
    (description "Gets the size of your Linux or Windows terminal")
    (license (list license:expat license:asl2.0))))

(define rust-simd-adler32-0.3
  (package
    (name "rust-simd-adler32")
    (version "0.3.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "simd-adler32" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bsj39d3xrqlcxjwj8i6fzh6ks38idh6b14nml8534f1fyxvz2i3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/mcountryman/simd-adler32")
    (synopsis
     "A SIMD-accelerated Adler-32 rolling hash algorithm implementation.")
    (description
     "This package provides a SIMD-accelerated Adler-32 rolling hash algorithm
implementation.")
    (license license:expat)))

(define rust-quote-1
  (package
    (name "rust-quote")
    (version "1.0.29")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "quote" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "019ij5fwp56ydww6zr46dhmzsf078qkdq9vz6mw1cri7mgl1ac2p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1))))
    (home-page "https://github.com/dtolnay/quote")
    (synopsis "Quasi-quoting macro quote!(...)")
    (description "Quasi-quoting macro quote!(...)")
    (license (list license:expat license:asl2.0))))

(define rust-proc-macro2-1
  (package
    (name "rust-proc-macro2")
    (version "1.0.64")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "proc-macro2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nm7qw54jn9n0g1ygkw4f63vj90m241yih6ph3g6zx7irdi3p03q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-unicode-ident" ,rust-unicode-ident-1))))
    (home-page "https://github.com/dtolnay/proc-macro2")
    (synopsis
     "A substitute implementation of the compiler's `proc_macro` API to decouple token-based libraries from the procedural macro use case.")
    (description
     "This package provides a substitute implementation of the compiler's `proc_macro`
API to decouple token-based libraries from the procedural macro use case.")
    (license (list license:expat license:asl2.0))))

(define rust-syn-2
  (package
    (name "rust-syn")
    (version "2.0.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qjswb3cifay6x9l0qjpm9c42ikacpxybr9ny4npw9kl1j6grqqm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-unicode-ident" ,rust-unicode-ident-1))))
    (home-page "https://github.com/dtolnay/syn")
    (synopsis "Parser for Rust source code")
    (description "Parser for Rust source code")
    (license (list license:expat license:asl2.0))))

(define rust-serde-derive-1
  (package
    (name "rust-serde-derive")
    (version "1.0.171")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10j6s97fk7fgjiqhhrx6a44rqxr7v3w985i3avx4d36i7dh9961q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
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
    (version "1.0.171")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1a9lvibgi42mhmgafp747mvshsq6ybx6rzcjqh398rfp9wg7vqih"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://serde.rs")
    (synopsis "A generic serialization/deserialization framework")
    (description
     "This package provides a generic serialization/deserialization framework")
    (license (list license:expat license:asl2.0))))

(define rust-rayon-core-1
  (package
    (name "rust-rayon-core")
    (version "1.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rayon-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13dymrhhdilzpbfh3aylv6ariayqdfk614b3frvwixb6d6yrb3sb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-crossbeam-deque" ,rust-crossbeam-deque-0.8)
                       ("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
                       ("rust-num-cpus" ,rust-num-cpus-1))))
    (home-page "https://github.com/rayon-rs/rayon")
    (synopsis "Core APIs for Rayon")
    (description "Core APIs for Rayon")
    (license (list license:expat license:asl2.0))))

(define rust-rayon-1
  (package
    (name "rust-rayon")
    (version "1.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rayon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0fzh8w5ds1qjhilll4rkpd3kimw70zi5605wprxcig1pdqczab8x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-either" ,rust-either-1)
                       ("rust-rayon-core" ,rust-rayon-core-1))))
    (home-page "https://github.com/rayon-rs/rayon")
    (synopsis "Simple work-stealing parallelism for Rust")
    (description "Simple work-stealing parallelism for Rust")
    (license (list license:expat license:asl2.0))))

(define rust-partition-identity-0.3
  (package
    (name "rust-partition-identity")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "partition-identity" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "08cymccnyf2b0pwc7x4wj889k1knqmrb8500idsjslybpvwjbacz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/pop-os/partition-identity")
    (synopsis
     "Find the ID of a device by its path, or find a device path by its ID.")
    (description
     "Find the ID of a device by its path, or find a device path by its ID.")
    (license license:expat)))

(define rust-proc-mounts-0.3
  (package
    (name "rust-proc-mounts")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "proc-mounts" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wpw3z2qq8wm3da8d0253a1h95nma6lad41m9yzp1ayh6n22yr8d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-partition-identity" ,rust-partition-identity-0.3))))
    (home-page "https://github.com/pop-os/proc-mounts")
    (synopsis "Fetch active mounts and swaps on a Linux system")
    (description "Fetch active mounts and swaps on a Linux system")
    (license license:expat)))

(define rust-nu-ansi-term-0.47
  (package
    (name "rust-nu-ansi-term")
    (version "0.47.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nu-ansi-term" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xmghm1knrk3j4f79cwhgb0vci38fxrk3gg9cb1399mw2zhk3w0x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/nushell/nu-ansi-term")
    (synopsis "Library for ANSI terminal colors and styles (bold, underline)")
    (description
     "Library for ANSI terminal colors and styles (bold, underline)")
    (license license:expat)))

(define rust-filedescriptor-0.8
  (package
    (name "rust-filedescriptor")
    (version "0.8.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "filedescriptor" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vplyh0cw35kzq7smmp2ablq0zsknk5rkvvrywqsqfrchmjxk6bi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "More ergonomic wrappers around RawFd and RawHandle")
    (description "More ergonomic wrappers around RawFd and RawHandle")
    (license license:expat)))

(define rust-crossterm-0.26
  (package
    (name "rust-crossterm")
    (version "0.26.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crossterm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04rxvmbf3scywy0m7rhg586lf833vpb33czijxi80fakadkxlk58"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-crossterm-winapi" ,rust-crossterm-winapi-0.9)
                       ("rust-filedescriptor" ,rust-filedescriptor-0.8)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mio" ,rust-mio-0.8)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-signal-hook" ,rust-signal-hook-0.3)
                       ("rust-signal-hook-mio" ,rust-signal-hook-mio-0.2)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/crossterm-rs/crossterm")
    (synopsis "A crossplatform terminal library for manipulating terminals.")
    (description
     "This package provides a crossplatform terminal library for manipulating
terminals.")
    (license license:expat)))

(define rust-lscolors-0.14
  (package
    (name "rust-lscolors")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "lscolors" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1gx81bj1kr6igh9ybfj2np3r4s6g7sdfpsa3l0pykndn3wfxza8q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ansi-term" ,rust-ansi-term-0.12)
                       ("rust-crossterm" ,rust-crossterm-0.26)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.47))))
    (home-page "https://github.com/sharkdp/lscolors")
    (synopsis "Colorize paths using the LS_COLORS environment variable")
    (description "Colorize paths using the LS_COLORS environment variable")
    (license (list license:expat license:asl2.0))))

(define rust-libc-0.2
  (package
    (name "rust-libc")
    (version "0.2.147")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "libc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cwv2lkzk3p5lby79fm42qhsh29lvbqwayhjjkq1s746xaq8yrml"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/rust-lang/libc")
    (synopsis "Raw FFI bindings to platform libraries like libc.
")
    (description "Raw FFI bindings to platform libraries like libc.")
    (license (list license:expat license:asl2.0))))

(define rust-vte-0.11
  (package
    (name "rust-vte")
    (version "0.11.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "vte" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "15r1ff4j8ndqj9vsyil3wqwxhhl7jsz5g58f31n0h1wlpxgjn0pm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-utf8parse" ,rust-utf8parse-0.2)
                       ("rust-vte-generate-state-changes" ,rust-vte-generate-state-changes-0.1))))
    (home-page "https://github.com/alacritty/vte")
    (synopsis "Parser for implementing terminal emulators")
    (description "Parser for implementing terminal emulators")
    (license (list license:asl2.0 license:expat))))

(define rust-itoa-1
  (package
    (name "rust-itoa")
    (version "1.0.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "itoa" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jig0fmn7bdqpb1jz3ibnlw6gdm31wyn510x0k9mninch59jmc32"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-no-panic" ,rust-no-panic-0.1))))
    (home-page "https://github.com/dtolnay/itoa")
    (synopsis "Fast integer primitive to string conversion")
    (description "Fast integer primitive to string conversion")
    (license (list license:expat license:asl2.0))))

(define rust-vt100-0.15
  (package
    (name "rust-vt100")
    (version "0.15.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "vt100" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1pklc8y984axmxr0cd363srr2d27wd5rj15xlcmkjznvy0xqdkc4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-itoa" ,rust-itoa-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-vte" ,rust-vte-0.11))))
    (home-page "https://github.com/doy/vt100-rust")
    (synopsis "Library for parsing terminal data")
    (description "Library for parsing terminal data")
    (license license:expat)))

(define rust-indicatif-0.17
  (package
    (name "rust-indicatif")
    (version "0.17.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "indicatif" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0myhjp1l6c5hd2wjm4grm6mp59ybcminxxfps5z3jfirlwiwry4g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-console" ,rust-console-0.15)
                       ("rust-instant" ,rust-instant-0.1)
                       ("rust-number-prefix" ,rust-number-prefix-0.4)
                       ("rust-portable-atomic" ,rust-portable-atomic-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-vt100" ,rust-vt100-0.15))))
    (home-page "https://github.com/console-rs/indicatif")
    (synopsis "A progress bar and cli reporting library for Rust")
    (description
     "This package provides a progress bar and cli reporting library for Rust")
    (license license:expat)))

(define rust-rkyv-derive-0.7
  (package
    (name "rust-rkyv-derive")
    (version "0.7.42")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rkyv_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "07alynj16yqlyprlwqd8av157rrywvid2dm7swbhl8swbf8npq5j"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/rkyv/rkyv")
    (synopsis "Derive macro for rkyv")
    (description "Derive macro for rkyv")
    (license license:expat)))

(define rust-bytecheck-derive-0.6
  (package
    (name "rust-bytecheck-derive")
    (version "0.6.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bytecheck_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0qdgfqx23gbjp5scbc8fhqc5kd014bpxn8hc9i9ssd8r4rplrv57"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/djkoloski/bytecheck")
    (synopsis "Derive macro for bytecheck")
    (description "Derive macro for bytecheck")
    (license license:expat)))

(define rust-bytecheck-0.6
  (package
    (name "rust-bytecheck")
    (version "0.6.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bytecheck" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09xnpjfhw36a973dpdd2mcmb93rrix539j49vkkgcqf878174qwb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytecheck-derive" ,rust-bytecheck-derive-0.6)
                       ("rust-ptr-meta" ,rust-ptr-meta-0.1)
                       ("rust-simdutf8" ,rust-simdutf8-0.1)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/djkoloski/bytecheck")
    (synopsis "Derive macro for bytecheck")
    (description "Derive macro for bytecheck")
    (license license:expat)))

(define rust-rkyv-0.7
  (package
    (name "rust-rkyv")
    (version "0.7.42")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rkyv" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0n2wzwnghkr2ny16c08f5szbkljfqrp3s8fnnb096f011ciwh002"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-bitvec" ,rust-bitvec-1)
                       ("rust-bytecheck" ,rust-bytecheck-0.6)
                       ("rust-hashbrown" ,rust-hashbrown-0.12)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-ptr-meta" ,rust-ptr-meta-0.1)
                       ("rust-rend" ,rust-rend-0.4)
                       ("rust-rkyv-derive" ,rust-rkyv-derive-0.7)
                       ("rust-seahash" ,rust-seahash-4)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-tinyvec" ,rust-tinyvec-1)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/rkyv/rkyv")
    (synopsis "Zero-copy deserialization framework for Rust")
    (description "Zero-copy deserialization framework for Rust")
    (license license:expat)))

(define rust-allocator-api2-0.2
  (package
    (name "rust-allocator-api2")
    (version "0.2.15")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "allocator-api2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1sdgkqs0pyk61m4yjksl5fv8wld11s5rp7v4v3p5hhccvkw6rz2n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/zakarumych/allocator-api2")
    (synopsis "Mirror of Rust's allocator API")
    (description "Mirror of Rust's allocator API")
    (license (list license:expat license:asl2.0))))

(define rust-hashbrown-0.14
  (package
    (name "rust-hashbrown")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hashbrown" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0yj3nf0w30pf30w503kgaw4sbjnh62l5cbmc7dd0mnczzywh2qic"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ahash" ,rust-ahash-0.8)
                       ("rust-allocator-api2" ,rust-allocator-api2-0.2)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rkyv" ,rust-rkyv-0.7)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-lang/hashbrown")
    (synopsis "A Rust port of Google's SwissTable hash map")
    (description
     "This package provides a Rust port of Google's SwissTable hash map")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-msvc-0.48
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12ipr1knzj2rwjygyllfi5mkd0ihnbi3r61gag5n2jgyk5bmyl8s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-gnullvm-0.48
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lxryz3ysx0145bf3i38jkr7f9nxiym8p3syklp8f20yyk0xp5kq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-gnu-0.48
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cblz5m6a8q6ha09bz4lz233dnq5sw2hpra06k9cna3n3xk8laya"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-i686-msvc-0.48
  (package
    (name "rust-windows-i686-msvc")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "004fkyqv3if178xx9ksqc4qqv8sz8n72mpczsr2vy8ffckiwchj5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-i686-gnu-0.48
  (package
    (name "rust-windows-i686-gnu")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hd2v9kp8fss0rzl83wzhw0s5z8q1b4875m6s1phv0yvlxi1jak2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-aarch64-msvc-0.48
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wvwipchhywcjaw73h998vzachf668fpqccbhrxzrz5xszh2gvxj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-aarch64-gnullvm-0.48
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1g71yxi61c410pwzq05ld7si4p9hyx6lf5fkw21sinvr3cp5gbli"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-targets-0.48
  (package
    (name "rust-windows-targets")
    (version "0.48.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-targets" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pz9ad4mpp06h80hkmzlib78b5r9db7isycy1gr9j17pj1sb3m05"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-aarch64-gnullvm" ,rust-windows-aarch64-gnullvm-0.48)
                       ("rust-windows-aarch64-msvc" ,rust-windows-aarch64-msvc-0.48)
                       ("rust-windows-i686-gnu" ,rust-windows-i686-gnu-0.48)
                       ("rust-windows-i686-msvc" ,rust-windows-i686-msvc-0.48)
                       ("rust-windows-x86-64-gnu" ,rust-windows-x86-64-gnu-0.48)
                       ("rust-windows-x86-64-gnullvm" ,rust-windows-x86-64-gnullvm-0.48)
                       ("rust-windows-x86-64-msvc" ,rust-windows-x86-64-msvc-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Import libs for Windows")
    (description "Import libs for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-sys-0.48
  (package
    (name "rust-windows-sys")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-targets" ,rust-windows-targets-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-filetime-0.2
  (package
    (name "rust-filetime")
    (version "0.2.21")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "filetime" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lsii3b9w4ya0g5nf9ycnif4izy8i492x5ri752d9sdfxi689g2w"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-redox-syscall" ,rust-redox-syscall-0.2)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/alexcrichton/filetime")
    (synopsis "Platform-agnostic accessors of timestamps in File metadata
")
    (description "Platform-agnostic accessors of timestamps in File metadata")
    (license (list license:expat license:asl2.0))))

(define rust-exacl-0.10
  (package
    (name "rust-exacl")
    (version "0.10.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "exacl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1girsssq3lcqj34zrybiyf07307bs6pzqgy4c8r4rcnyb4mb5zhw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.63)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-scopeguard" ,rust-scopeguard-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/byllyfish/exacl")
    (synopsis
     "Manipulate file system access control lists (ACL) on macOS, Linux, and FreeBSD")
    (description
     "Manipulate file system access control lists (ACL) on macOS, Linux, and FreeBSD")
    (license license:expat)))

(define rust-crossbeam-channel-0.5
  (package
    (name "rust-crossbeam-channel")
    (version "0.5.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crossbeam-channel" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "004jz4wxp9k26z657i7rsh9s7586dklx2c5aqf1n3w1dgzvjng53"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8))))
    (home-page
     "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-channel")
    (synopsis "Multi-producer multi-consumer channels for message passing")
    (description "Multi-producer multi-consumer channels for message passing")
    (license (list license:expat license:asl2.0))))

(define rust-clap-derive-3
  (package
    (name "rust-clap-derive")
    (version "3.2.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "025hh66cyjk5xhhq8s1qw5wkxvrm8hnv5xwwksax7dy8pnw72qxf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_derive")
    (synopsis
     "Parse command line argument by defining a struct, derive crate.")
    (description
     "Parse command line argument by defining a struct, derive crate.")
    (license (list license:expat license:asl2.0))))

(define rust-clap-3
  (package
    (name "rust-clap")
    (version "3.2.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "08vi402vfqmfj9f07c4gl6082qxgf4c9x98pbndcnwbgaszq38af"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-atty" ,rust-atty-0.2)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-clap-derive" ,rust-clap-derive-3)
                       ("rust-clap-lex" ,rust-clap-lex-0.2)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-strsim" ,rust-strsim-0.10)
                       ("rust-termcolor" ,rust-termcolor-1)
                       ("rust-terminal-size" ,rust-terminal-size-0.2)
                       ("rust-textwrap" ,rust-textwrap-0.16)
                       ("rust-unicase" ,rust-unicase-2)
                       ("rust-yaml-rust" ,rust-yaml-rust-0.4))))
    (home-page "https://github.com/clap-rs/clap")
    (synopsis
     "A simple to use, efficient, and full-featured Command Line Argument Parser")
    (description
     "This package provides a simple to use, efficient, and full-featured Command Line
Argument Parser")
    (license (list license:expat license:asl2.0))))

(define-public rust-httm-0.30
  (package
    (name "rust-httm")
    (version "0.30.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "httm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0yibx88prypap1qkzm7bgn4zmfs2w0xbbbg7bgbg35bs7nbf164x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-clap" ,rust-clap-3)
                       ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-exacl" ,rust-exacl-0.10)
                       ("rust-filetime" ,rust-filetime-0.2)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-indicatif" ,rust-indicatif-0.17)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-lscolors" ,rust-lscolors-0.14)
                       ("rust-nix" ,rust-nix-0.26)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.47)
                       ("rust-number-prefix" ,rust-number-prefix-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-proc-mounts" ,rust-proc-mounts-0.3)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-simd-adler32" ,rust-simd-adler32-0.3)
                       ("rust-terminal-size" ,rust-terminal-size-0.2)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-two-percent" ,rust-two-percent-0.10)
                       ("rust-which" ,rust-which-4)
                       ("rust-xattr" ,rust-xattr-1))))
    (home-page "https://github.com/kimono-koans/httm")
    (synopsis
     "A CLI tool for viewing snapshot file versions on ZFS and btrfs datasets")
    (description
     "This package provides a CLI tool for viewing snapshot file versions on ZFS and
btrfs datasets")
    (license license:mpl2.0)))

;rust-httm-0.30
