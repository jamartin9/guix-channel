(define-module (jam packages lite-farmer)
  #:use-module (jam packages)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages python)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crates-graphics)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils))

(define rust-dg-xch-puzzles-1
  (package
    (name "rust-dg-xch-puzzles")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_puzzles" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1lng4dl95kd737mzxj66kgzz7m9h95cd22d4ng1zfirgmx2n7ldx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-blst" ,rust-blst-0.3)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-serialize" ,rust-dg-xch-serialize-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "Core library for working with CLVM puzzles")
    (description "Core library for working with CLVM puzzles")
    (license license:asl2.0)))

(define rust-dg-xch-keys-1
  (package
    (name "rust-dg-xch-keys")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_keys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0h38q8q0c4m9wwg0v8vf60krdpx49dq9da4djz2v2ai2pki3sa1g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bech32" ,rust-bech32-0.9)
                       ("rust-bip39" ,rust-bip39-2)
                       ("rust-blst" ,rust-blst-0.3)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-puzzles" ,rust-dg-xch-puzzles-1)
                       ("rust-hkdf" ,rust-hkdf-0.12)
                       ("rust-sha2" ,rust-sha2-0.10))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "Key Management Utils the Chia Blockchain")
    (description "Key Management Utils the Chia Blockchain")
    (license license:asl2.0)))

(define rust-urlencoding-2
  (package
    (name "rust-urlencoding")
    (version "2.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "urlencoding" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nj99jp37k47n0hvaz5fvz7z6jd0sb4ppvfy3nphr1zbnyixpy6s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://lib.rs/urlencoding")
    (synopsis "A Rust library for doing URL percentage encoding.")
    (description
     "This package provides a Rust library for doing URL percentage encoding.")
    (license license:expat)))

(define rust-webpki-roots-0.24
  (package
    (name "rust-webpki-roots")
    (version "0.24.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "webpki-roots" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "120q85pvzpckvvrg085a5jhh91fby94pgiv9y1san7lxbmnm94dj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustls-webpki" ,rust-rustls-webpki-0.101))))
    (home-page "https://github.com/rustls/webpki-roots")
    (synopsis "Mozilla's CA root certificates for use with webpki")
    (description "Mozilla's CA root certificates for use with webpki")
    (license license:mpl2.0)))

(define rust-tungstenite-0.20
  (package
    (name "rust-tungstenite")
    (version "0.20.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jg6b3ys6da89fp3j2x85cqv9g1lr7amrx95nqm13w4d2b2a2qp8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-data-encoding" ,rust-data-encoding-2)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rustls" ,rust-rustls-0.21)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-sha1" ,rust-sha1-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-utf-8" ,rust-utf-8-0.7)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.24))))
    (home-page "https://github.com/snapview/tungstenite-rs")
    (synopsis "Lightweight stream-based WebSocket implementation")
    (description "Lightweight stream-based @code{WebSocket} implementation")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-native-tls-0.3
  (package
    (name "rust-tokio-native-tls")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-native-tls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wkfg6zn85zckmv4im7mv20ca6b1vmlib5xwz9p7g19wjfmpdbmv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://tokio.rs")
    (synopsis
     "An implementation of TLS/SSL streams for Tokio using native-tls giving an implementation of TLS
for nonblocking I/O streams.
")
    (description
     "An implementation of TLS/SSL streams for Tokio using native-tls giving an
implementation of TLS for nonblocking I/O streams.")
    (license license:expat)))

(define rust-rustls-native-certs-0.6
  (package
    (name "rust-rustls-native-certs")
    (version "0.6.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustls-native-certs" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "007zind70rd5rfsrkdcfm8vn09j8sg02phg9334kark6rdscxam9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-openssl-probe" ,rust-openssl-probe-0.1)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                       ("rust-schannel" ,rust-schannel-0.1)
                       ("rust-security-framework" ,rust-security-framework-2))))
    (home-page "https://github.com/ctz/rustls-native-certs")
    (synopsis
     "rustls-native-certs allows rustls to use the platform native certificate store")
    (description
     "rustls-native-certs allows rustls to use the platform native certificate store")
    (license (list license:asl2.0 license:isc license:expat))))

(define rust-tokio-tungstenite-0.20
  (package
    (name "rust-tokio-tungstenite")
    (version "0.20.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18ny5l0fqg92mn20z1jpd1yrml0mxw39cla493bh0sy20g3vwb9b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rustls" ,rust-rustls-0.21)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
                       ("rust-tungstenite" ,rust-tungstenite-0.20)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.23))))
    (home-page "https://github.com/snapview/tokio-tungstenite")
    (synopsis
     "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
     "Tokio binding for Tungstenite, the Lightweight stream-based @code{WebSocket}
implementation")
    (license license:expat)))

(define rust-time-macros-0.2
  (package
    (name "rust-time-macros")
    (version "0.2.14")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wn52hwaq1hy4r5yijzkdi4j40zvqapbpcjsjdkyyy4l6d22z50s"))))
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

(define rust-syn-2
  (package
    (name "rust-syn")
    (version "2.0.29")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12jign09ic81k0nj1805fxm8zrw1yxnjxvziwq1jbnd9xfac8963"))))
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
    (version "1.0.188")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wjaclvsfxgqnnnykllvb5gffsxynk66x6h4c1ds6anq8b37mjjf"))))
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
    (version "1.0.188")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17jlqzfhimsk8w37ifjwnm86nwjzawlbgwmwc7nhwdwslv5hz7ng"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://serde.rs")
    (synopsis "A generic serialization/deserialization framework")
    (description
     "This package provides a generic serialization/deserialization framework")
    (license (list license:expat license:asl2.0))))

(define rust-deranged-0.3
  (package
    (name "rust-deranged")
    (version "0.3.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "deranged" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ikrhil2621rz9haakphdzrx035qwr175f639p8qyrazjj56wsgj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/jhpratt/deranged")
    (synopsis "Ranged integers")
    (description "Ranged integers")
    (license (list license:expat license:asl2.0))))

(define rust-time-0.3
  (package
    (name "rust-time")
    (version "0.3.28")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "time" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0j3yl5q4w9vcw55hxxb1a3crls1w82v5dahicj7c4ifjgxavpxhp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-deranged" ,rust-deranged-0.3)
                       ("rust-itoa" ,rust-itoa-1)
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

(define rust-constant-time-eq-0.3
  (package
    (name "rust-constant-time-eq")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "constant_time_eq" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hl0y8frzlhpr58rh8rlg4bm53ax09ikj2i5fk7gpyphvhq4s57p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/cesarb/constant_time_eq")
    (synopsis "Compares two equal-sized byte strings in constant time.")
    (description "Compares two equal-sized byte strings in constant time.")
    (license (list license:cc0 license:expat-0 license:asl2.0))))

(define rust-blake3-1
  (package
    (name "rust-blake3")
    (version "1.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "blake3" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19avs9916p26pbpzr8djyz02zi157lkqdw4mi6gjrnbjd6ml570r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayref" ,rust-arrayref-0.3)
                       ("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-constant-time-eq" ,rust-constant-time-eq-0.3)
                       ("rust-digest" ,rust-digest-0.10)
                       ("rust-rayon" ,rust-rayon-1))))
    (home-page "https://github.com/BLAKE3-team/BLAKE3")
    (synopsis "the BLAKE3 hash function")
    (description "the BLAKE3 hash function")
    (license (list license:cc0 license:asl2.0))))

(define rust-dg-xch-pos-1
  (package
    (name "rust-dg-xch-pos")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_pos" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nvjn82p4myjq90ihaqvc08blgwqncm3jdr057jrjxc5gf0r0nq9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-blake3" ,rust-blake3-1)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-serialize" ,rust-dg-xch-serialize-1)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nix" ,rust-nix-0.26)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-simple-logger" ,rust-simple-logger-4))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "Proof of Space library for the Chia Blockchain")
    (description "Proof of Space library for the Chia Blockchain")
    (license license:asl2.0)))

(define rust-simple-logger-4
  (package
    (name "rust-simple-logger")
    (version "4.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "simple_logger" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0cwkcbd8ba73ic8g1n896n7mhrgdlm4hnqgvk6vcj5dq55fcsc12"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-colored" ,rust-colored-2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-windows-sys" ,rust-windows-sys-0.42))))
    (home-page "https://github.com/borntyping/rust-simple_logger")
    (synopsis
     "A logger that prints all messages with a readable output format")
    (description
     "This package provides a logger that prints all messages with a readable output
format")
    (license license:expat)))

(define rust-strum-macros-0.24
  (package
    (name "rust-strum-macros")
    (version "0.24.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum_macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0naxz2y38kwq5wgirmia64vvf6qhwy8j367rw966n62gsbh5nf0y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define rust-strum-0.24
  (package
    (name "rust-strum")
    (version "0.24.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "strum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gz6cjhlps5idwasznklxdh2zsas6mxf99vr0n27j876q12n0gh6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.24))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description "Helpful macros for working with enums and strings")
    (license license:expat)))

(define rust-paperclip-macros-0.6
  (package
    (name "rust-paperclip-macros")
    (version "0.6.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "paperclip-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "037rvynzbkckspq09ggaq7vhgmbnl2f0z7n8ipachqjk5k72avnf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-strum" ,rust-strum-0.24)
                       ("rust-strum-macros" ,rust-strum-macros-0.24)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/paperclip-rs/paperclip")
    (synopsis "Macros for paperclip OpenAPI tooling library")
    (description "Macros for paperclip @code{OpenAPI} tooling library")
    (license (list license:expat license:asl2.0))))

(define rust-validator-types-0.14
  (package
    (name "rust-validator-types")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator_types" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14d2lqqxksyy8bpn2qh3wcnnx2047i0fdfpkylr7ccj23mzdknfy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/Keats/validator")
    (synopsis "Basic type for validator and validator_derive")
    (description "Basic type for validator and validator_derive")
    (license license:expat)))

(define rust-validator-derive-0.14
  (package
    (name "rust-validator-derive")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vky5f6cn6ifbvzy7x3vjww1lvr6d50p9c9y1fys24ds9mqkalfq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-if-chain" ,rust-if-chain-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-syn" ,rust-syn-1)
                       ("rust-validator-types" ,rust-validator-types-0.14))))
    (home-page "https://github.com/Keats/validator")
    (synopsis "Macros 1.1 implementation of #[derive(Validate)]")
    (description "Macros 1.1 implementation of #[derive(Validate)]")
    (license license:expat)))

(define rust-validator-0.14
  (package
    (name "rust-validator")
    (version "0.14.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0piyrhxhrnj559li1pjpxsc8i1ps2m3g104m032y5zmh3a8hh3vd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-card-validate" ,rust-card-validate-2)
                       ("rust-idna" ,rust-idna-0.2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-phonenumber" ,rust-phonenumber-0.3)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-unic-ucd-common" ,rust-unic-ucd-common-0.9)
                       ("rust-url" ,rust-url-2)
                       ("rust-validator-derive" ,rust-validator-derive-0.14)
                       ("rust-validator-types" ,rust-validator-types-0.14))))
    (home-page "https://github.com/Keats/validator")
    (synopsis
     "Common validation functions (email, url, length, ...) and trait - to be used with `validator_derive`")
    (description
     "Common validation functions (email, url, length, ...) and trait - to be used
with `validator_derive`")
    (license license:expat)))

(define rust-iri-string-0.4
  (package
    (name "rust-iri-string")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "iri-string" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0y2z4f5y87hnff2d5lcl811hp7iv2f5qri7x3fgm48z2q4w7c3wg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-nom" ,rust-nom-7)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/lo48576/iri-string")
    (synopsis "IRI as string types")
    (description "IRI as string types")
    (license (list license:expat license:asl2.0))))

(define rust-http-range-header-0.3
  (package
    (name "rust-http-range-header")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "http-range-header" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13vm511vq3bhschkw2xi9nhxzkw53m55gn9vxg7qigfxc29spl5d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/MarcusGrass/parse-range-headers")
    (synopsis "No-dep range header parser")
    (description "No-dep range header parser")
    (license license:expat)))

(define rust-tower-http-0.3
  (package
    (name "rust-tower-http")
    (version "0.3.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tower-http" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0n6qr26ivwqv19fih5pcjk2nvmys77m964lwkqiyil9dy15h8wzq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-compression" ,rust-async-compression-0.3)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-http-body" ,rust-http-body-0.4)
                       ("rust-http-range-header" ,rust-http-range-header-0.3)
                       ("rust-httpdate" ,rust-httpdate-1)
                       ("rust-iri-string" ,rust-iri-string-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tower" ,rust-tower-0.4)
                       ("rust-tower-layer" ,rust-tower-layer-0.3)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/tower-rs/tower-http")
    (synopsis "Tower middleware and utilities for HTTP clients and servers")
    (description "Tower middleware and utilities for HTTP clients and servers")
    (license license:expat)))

(define rust-tower-service-0.3
  (package
    (name "rust-tower-service")
    (version "0.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tower-service" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lmfzmmvid2yp2l36mbavhmqgsvzqf7r2wiwz73ml4xmwaf1rg5n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/tower-rs/tower")
    (synopsis
     "Trait representing an asynchronous, request / response based, client or server.
")
    (description
     "Trait representing an asynchronous, request / response based, client or server.")
    (license license:expat)))

(define rust-hdrhistogram-7
  (package
    (name "rust-hdrhistogram")
    (version "7.5.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hdrhistogram" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1a1al1rfxcqmx0n9h100ggvg036f4rv69fq12kimazvw9zsvj6bz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-nom" ,rust-nom-7)
                       ("rust-num-traits" ,rust-num-traits-0.2))))
    (home-page "https://github.com/HdrHistogram/HdrHistogram_rust")
    (synopsis "A port of HdrHistogram to Rust")
    (description "This package provides a port of @code{HdrHistogram} to Rust")
    (license (list license:expat license:asl2.0))))

(define rust-tower-0.4
  (package
    (name "rust-tower")
    (version "0.4.13")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tower" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "073wncyqav4sak1p755hf6vl66njgfc1z1g1di9rxx3cvvh9pymq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-hdrhistogram" ,rust-hdrhistogram-7)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-pin-project" ,rust-pin-project-1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-slab" ,rust-slab-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-stream" ,rust-tokio-stream-0.1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tower-layer" ,rust-tower-layer-0.3)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/tower-rs/tower")
    (synopsis
     "Tower is a library of modular and reusable components for building robust
clients and servers.
")
    (description
     "Tower is a library of modular and reusable components for building robust
clients and servers.")
    (license license:expat)))

(define rust-tungstenite-0.17
  (package
    (name "rust-tungstenite")
    (version "0.17.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1q2czb80xb7hp7ipqi5d21716i52k8s7iz18xxzfwaccdbyr4yg2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-sha-1" ,rust-sha-1-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-utf-8" ,rust-utf-8-0.7)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/snapview/tungstenite-rs")
    (synopsis "Lightweight stream-based WebSocket implementation")
    (description "Lightweight stream-based @code{WebSocket} implementation")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-tungstenite-0.17
  (package
    (name "rust-tokio-tungstenite")
    (version "0.17.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10dingfgq7ch65dzv2j0q8k3ghdf3ihl6hp0fwfl145dpqaxs57p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-tungstenite" ,rust-tungstenite-0.17)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/snapview/tokio-tungstenite")
    (synopsis
     "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
     "Tokio binding for Tungstenite, the Lightweight stream-based @code{WebSocket}
implementation")
    (license license:expat)))

(define rust-sync-wrapper-0.1
  (package
    (name "rust-sync-wrapper")
    (version "0.1.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sync_wrapper" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0q01lyj0gr9a93n10nxsn8lwbzq97jqd6b768x17c8f7v7gccir0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3))))
    (home-page "https://docs.rs/sync_wrapper")
    (synopsis
     "A tool for enlisting the compilerâs help in proving the absence of concurrency")
    (description
     "This package provides a tool for enlisting the compilerâs help in proving the
absence of concurrency")
    (license license:asl2.0)))

(define rust-matchit-0.5
  (package
    (name "rust-matchit")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "matchit" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1swbyfxyz6nh8df514dqgds6al8lrrcxynhpbbgn5dvijrwvmjvk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/ibraheemdev/matchit")
    (synopsis "A blazing fast URL router.")
    (description "This package provides a blazing fast URL router.")
    (license license:expat)))

(define rust-headers-0.3
  (package
    (name "rust-headers")
    (version "0.3.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "headers" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11258p6q2md68sfhmqrgrx23vjiapqcbxffh1hz223awivdp5qzk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-headers-core" ,rust-headers-core-0.2)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httpdate" ,rust-httpdate-1)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-sha1" ,rust-sha1-0.10))))
    (home-page "https://hyper.rs")
    (synopsis "typed HTTP headers")
    (description "typed HTTP headers")
    (license license:expat)))

(define rust-axum-macros-0.2
  (package
    (name "rust-axum-macros")
    (version "0.2.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "axum-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1f182rj15717707r74lf4ppqca2kz1y8avkklsfng3khxkidm4v2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis "Macros for axum")
    (description "Macros for axum")
    (license license:expat)))

(define rust-http-body-0.4
  (package
    (name "rust-http-body")
    (version "0.4.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "http-body" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1l967qwwlvhp198xdrnc0p5d7jwfcp6q2lm510j6zqw4s4b8zwym"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/hyperium/http-body")
    (synopsis
     "Trait representing an asynchronous, streaming, HTTP request or response body.
")
    (description
     "Trait representing an asynchronous, streaming, HTTP request or response body.")
    (license license:expat)))

(define rust-axum-core-0.2
  (package
    (name "rust-axum-core")
    (version "0.2.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "axum-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1k41s57q1yvyvnn9fzvblygq62lc4gs7vhqpq3ayqvy50ag97r9p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-http-body" ,rust-http-body-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-tower-layer" ,rust-tower-layer-0.3)
                       ("rust-tower-service" ,rust-tower-service-0.3))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis "Core types and traits for axum")
    (description "Core types and traits for axum")
    (license license:expat)))

(define rust-axum-0.5
  (package
    (name "rust-axum")
    (version "0.5.17")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "axum" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0hxsinslg88432r9q8c50v4kdpb3q44ygcvml92v1dis0zarzvmc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-axum-core" ,rust-axum-core-0.2)
                       ("rust-axum-macros" ,rust-axum-macros-0.2)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-headers" ,rust-headers-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-http-body" ,rust-http-body-0.4)
                       ("rust-hyper" ,rust-hyper-0.14)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-matchit" ,rust-matchit-0.5)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-multer" ,rust-multer-2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-sha-1" ,rust-sha-1-0.10)
                       ("rust-sync-wrapper" ,rust-sync-wrapper-0.1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.17)
                       ("rust-tower" ,rust-tower-0.4)
                       ("rust-tower-http" ,rust-tower-http-0.3)
                       ("rust-tower-layer" ,rust-tower-layer-0.3)
                       ("rust-tower-service" ,rust-tower-service-0.3))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis "Web framework that focuses on ergonomics and modularity")
    (description "Web framework that focuses on ergonomics and modularity")
    (license license:expat)))

(define rust-serde-qs-0.9
  (package
    (name "rust-serde-qs")
    (version "0.9.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_qs" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09fp3q2hhc1bgim33qz73l9liizmk8g0s589cxgb88sbrpkcxx3a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-web" ,rust-actix-web-2)
                       ("rust-actix-web" ,rust-actix-web-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-axum" ,rust-axum-0.5)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-warp" ,rust-warp-0.3))))
    (home-page "https://github.com/samscott89/serde_qs")
    (synopsis "Querystrings for Serde")
    (description "Querystrings for Serde")
    (license (list license:expat license:asl2.0))))

(define rust-actix-web-validator-3
  (package
    (name "rust-actix-web-validator")
    (version "3.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-web-validator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "035yd703vlyhyz2q7lqdqf8nqkz2dkrb049w35c924pcavs9k5py"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-http" ,rust-actix-http-3)
                       ("rust-actix-router" ,rust-actix-router-0.5)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-qs" ,rust-serde-qs-0.9)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-validator" ,rust-validator-0.14))))
    (home-page
     "https://github.com/rambler-digital-solutions/actix-web-validator")
    (synopsis "Validation mechanism for actix-web")
    (description "Validation mechanism for actix-web")
    (license license:expat)))

(define rust-validator-types-0.12
  (package
    (name "rust-validator-types")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator_types" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "02j7b8v5hr1jxya19ibb3gb607g9vhfsypnx3lnaycziimh815md"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/Keats/validator")
    (synopsis "Basic type for validator and validator_derive")
    (description "Basic type for validator and validator_derive")
    (license license:expat)))

(define rust-validator-derive-0.12
  (package
    (name "rust-validator-derive")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0k8cvfm024mn4bxy64xnd66g3y6m178hmbl9d8kmj3r7gx4v91j2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-if-chain" ,rust-if-chain-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-proc-macro-error" ,rust-proc-macro-error-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-syn" ,rust-syn-1)
                       ("rust-validator-types" ,rust-validator-types-0.12))))
    (home-page "https://github.com/Keats/validator")
    (synopsis "Macros 1.1 implementation of #[derive(Validate)]")
    (description "Macros 1.1 implementation of #[derive(Validate)]")
    (license license:expat)))

(define rust-unic-ucd-common-0.9
  (package
    (name "rust-unic-ucd-common")
    (version "0.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unic-ucd-common" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bglvzn6rs01v0d29898vg2y3v3cgj3h1gsrbjp1mypa1f8qpdz9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-unic-char-property" ,rust-unic-char-property-0.9)
                       ("rust-unic-char-range" ,rust-unic-char-range-0.9)
                       ("rust-unic-ucd-version" ,rust-unic-ucd-version-0.9))))
    (home-page "https://github.com/open-i18n/rust-unic/")
    (synopsis "UNIC â Unicode Character Database â Common Properties")
    (description "UNIC â Unicode Character Database â Common Properties")
    (license (list license:expat license:asl2.0))))

(define rust-oncemutex-0.1
  (package
    (name "rust-oncemutex")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "oncemutex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qmzibgx46k3xfh0mbljp46cfy9vx62frrx5x1ph18zlcvj1vla4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/reem/rust-once-mutex.git")
    (synopsis
     "A mutex providing one-time synchronized access, then safe unsynchronized access.")
    (description
     "This package provides a mutex providing one-time synchronized access, then safe
unsynchronized access.")
    (license (list license:expat license:asl2.0))))

(define rust-regex-cache-0.2
  (package
    (name "rust-regex-cache")
    (version "0.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex-cache" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14w7h1rl68fzzvavig18hf184macxcypqsrv6m7vkf23jzb64yrg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lru-cache" ,rust-lru-cache-0.1)
                       ("rust-oncemutex" ,rust-oncemutex-0.1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.6))))
    (home-page "https://github.com/1aim/rust-regex-cache")
    (synopsis "Lazy and cached regular expressions.")
    (description "Lazy and cached regular expressions.")
    (license license:expat)))

(define rust-quick-xml-0.28
  (package
    (name "rust-quick-xml")
    (version "0.28.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "quick-xml" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1lfr3512x0s0i9kbyglyzn0rq0i1bvd2mqqfi8gs685808rfgr8c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-document-features" ,rust-document-features-0.2)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/tafia/quick-xml")
    (synopsis "High performance xml reader and writer")
    (description "High performance xml reader and writer")
    (license license:expat)))

(define rust-phonenumber-0.3
  (package
    (name "rust-phonenumber")
    (version "0.3.2+8.13.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phonenumber" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vrdk1ibs86n8kvr3pf7fy8zaxbpnn49b1cavh6g2xlxx9j9yx1l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bincode" ,rust-bincode-1)
                       ("rust-bincode" ,rust-bincode-1)
                       ("rust-either" ,rust-either-1)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-itertools" ,rust-itertools-0.10)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-nom" ,rust-nom-7)
                       ("rust-quick-xml" ,rust-quick-xml-0.28)
                       ("rust-quick-xml" ,rust-quick-xml-0.28)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-regex-cache" ,rust-regex-cache-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/whisperfish/rust-phonenumber")
    (synopsis
     "Library for parsing, formatting and validating international phone numbers.")
    (description
     "Library for parsing, formatting and validating international phone numbers.")
    (license license:asl2.0)))

(define rust-card-validate-2
  (package
    (name "rust-card-validate")
    (version "2.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "card-validate" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "075kamy7wcmsn5fshs6b78lqvihk3bm0i9awjrlci60wnrp71538"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/valeriansaliou/rs-card-validate")
    (synopsis "Rust card validate detects and validates credit card numbers")
    (description
     "Rust card validate detects and validates credit card numbers")
    (license license:expat)))

(define rust-validator-0.12
  (package
    (name "rust-validator")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "validator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jd2qazxmnlvln7msr4d6yz5nsql6clzgg3ih2fh7iiyqcvnj7c4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-card-validate" ,rust-card-validate-2)
                       ("rust-idna" ,rust-idna-0.2)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-phonenumber" ,rust-phonenumber-0.3)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-unic-ucd-common" ,rust-unic-ucd-common-0.9)
                       ("rust-url" ,rust-url-2)
                       ("rust-validator-derive" ,rust-validator-derive-0.12)
                       ("rust-validator-types" ,rust-validator-types-0.12))))
    (home-page "https://github.com/Keats/validator")
    (synopsis
     "Common validation functions (email, url, length, ...) and trait - to be used with `validator_derive`")
    (description
     "Common validation functions (email, url, length, ...) and trait - to be used
with `validator_derive`")
    (license license:expat)))

(define rust-tungstenite-0.18
  (package
    (name "rust-tungstenite")
    (version "0.18.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1207jv8ciklgnqwjhxc1c1xhplrfab231191apyz0k6d56vnmvih"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-sha1" ,rust-sha1-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-utf-8" ,rust-utf-8-0.7)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/snapview/tungstenite-rs")
    (synopsis "Lightweight stream-based WebSocket implementation")
    (description "Lightweight stream-based @code{WebSocket} implementation")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-tungstenite-0.18
  (package
    (name "rust-tokio-tungstenite")
    (version "0.18.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1z8bxhq6d1ndh4x914wwk72l93ha1sl0jmnb6knvqiqi869rqcal"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-tungstenite" ,rust-tungstenite-0.18)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/snapview/tokio-tungstenite")
    (synopsis
     "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
     "Tokio binding for Tungstenite, the Lightweight stream-based @code{WebSocket}
implementation")
    (license license:expat)))

(define rust-multer-2
  (package
    (name "rust-multer")
    (version "2.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "multer" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hjiphaypj3phqaj5igrzcia9xfmf4rr4ddigbh8zzb96k1bvb01"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-spin" ,rust-spin-0.9)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-version-check" ,rust-version-check-0.9))))
    (home-page "https://github.com/rousan/multer-rs")
    (synopsis
     "An async parser for `multipart/form-data` content-type in Rust.")
    (description
     "An async parser for `multipart/form-data` content-type in Rust.")
    (license license:expat)))

(define rust-warp-0.3
  (package
    (name "rust-warp")
    (version "0.3.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "warp" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0s8zirqy2cbj8a4k8ixc4r6zhm5dj5j3fzmhz3vqf4nzf3siwhxs"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-compression" ,rust-async-compression-0.3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-headers" ,rust-headers-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-hyper" ,rust-hyper-0.14)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-multer" ,rust-multer-2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project" ,rust-pin-project-1)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                       ("rust-scoped-tls" ,rust-scoped-tls-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-tokio-stream" ,rust-tokio-stream-0.1)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.18)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/seanmonstar/warp")
    (synopsis "serve the web at warp speeds")
    (description "serve the web at warp speeds")
    (license license:expat)))

(define rust-serde-qs-0.8
  (package
    (name "rust-serde-qs")
    (version "0.8.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_qs" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19pngnlga4xnap85kdvn661662hf42lkkppp9sd04py7xs056wf7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-web" ,rust-actix-web-3)
                       ("rust-actix-web" ,rust-actix-web-2)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-warp" ,rust-warp-0.3))))
    (home-page "https://github.com/samscott89/serde_qs")
    (synopsis "Querystrings for Serde")
    (description "Querystrings for Serde")
    (license (list license:expat license:asl2.0))))

(define rust-actix-web-validator-2
  (package
    (name "rust-actix-web-validator")
    (version "2.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-web-validator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0w33scj7n3f5m4fjwwy1d1wzkzmmfffjnn5vyhy606n8qkkfxf0b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-http" ,rust-actix-http-2)
                       ("rust-actix-router" ,rust-actix-router-0.2)
                       ("rust-actix-web" ,rust-actix-web-3)
                       ("rust-bytes" ,rust-bytes-0.5)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-qs" ,rust-serde-qs-0.8)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-validator" ,rust-validator-0.12))))
    (home-page
     "https://github.com/rambler-digital-solutions/actix-web-validator")
    (synopsis "Validation mechanism for actix-web")
    (description "Validation mechanism for actix-web")
    (license license:expat)))

(define rust-serde-plain-1
  (package
    (name "rust-serde-plain")
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_plain" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0l4d4nbw00pz6n43icrc605bhgynfmlyq39sn8i10qasnrnzrqcw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://docs.rs/serde_plain")
    (synopsis "A restricted plain text serializer for serde")
    (description
     "This package provides a restricted plain text serializer for serde")
    (license (list license:expat license:asl2.0))))

(define rust-parse-size-1
  (package
    (name "rust-parse-size")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "parse-size" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1bmpc70ax31f4q714diq01lvhn4h88b9h7qnb6ama0n8b7fm6icl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/kennytm/parse-size")
    (synopsis "Parse byte size into integer accurately.")
    (description "Parse byte size into integer accurately.")
    (license license:expat)))

(define rust-darling-macro-0.20
  (package
    (name "rust-darling-macro")
    (version "0.20.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "darling_macro" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1mg2k1f0v33s271lpn4m5mxcfjqnmg61bf77svb44cyngay9nsl3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-darling-core" ,rust-darling-core-0.20)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/TedDriggs/darling")
    (synopsis
     "Internal support for a proc-macro library for reading attributes into structs when
implementing custom derives. Use https://crates.io/crates/darling in your code.
")
    (description
     "Internal support for a proc-macro library for reading attributes into structs
when implementing custom derives.  Use https://crates.io/crates/darling in your
code.")
    (license license:expat)))

(define rust-darling-core-0.20
  (package
    (name "rust-darling-core")
    (version "0.20.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "darling_core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "08g6afi3z9jgcqx7g41s1mzr6q3dj2z56vz7v1bv6941h51k8zhp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-fnv" ,rust-fnv-1)
                       ("rust-ident-case" ,rust-ident-case-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-strsim" ,rust-strsim-0.10)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/TedDriggs/darling")
    (synopsis
     "Helper crate for proc-macro library for reading attributes into structs when
implementing custom derives. Use https://crates.io/crates/darling in your code.
")
    (description
     "Helper crate for proc-macro library for reading attributes into structs when
implementing custom derives.  Use https://crates.io/crates/darling in your code.")
    (license license:expat)))

(define rust-darling-0.20
  (package
    (name "rust-darling")
    (version "0.20.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "darling" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pjwwadwgnvvgn5qm3glpv7hjl7siaqqpw6cvh2mdar7lr6xj282"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-darling-core" ,rust-darling-core-0.20)
                       ("rust-darling-macro" ,rust-darling-macro-0.20))))
    (home-page "https://github.com/TedDriggs/darling")
    (synopsis "A proc-macro library for reading attributes into structs when
implementing custom derives.
")
    (description
     "This package provides a proc-macro library for reading attributes into structs
when implementing custom derives.")
    (license license:expat)))

(define rust-actix-multipart-derive-0.6
  (package
    (name "rust-actix-multipart-derive")
    (version "0.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-multipart-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0kdx7vpap6319jan3j5fwj1brj5rr31wfymlwl0gfsfq6vw7f2ha"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-darling" ,rust-darling-0.20)
                       ("rust-parse-size" ,rust-parse-size-1)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://actix.rs")
    (synopsis "Multipart form derive macro for Actix Web")
    (description "Multipart form derive macro for Actix Web")
    (license (list license:expat license:asl2.0))))

(define rust-actix-multipart-0.6
  (package
    (name "rust-actix-multipart")
    (version "0.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-multipart" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bcdj7asjlkmzinph2xnr2gk53d428yhc24i0s7rrx3mx8m0x5iv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-multipart-derive" ,rust-actix-multipart-derive-0.6)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-local-waker" ,rust-local-waker-0.1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-plain" ,rust-serde-plain-1)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://actix.rs")
    (synopsis "Multipart form support for Actix Web")
    (description "Multipart form support for Actix Web")
    (license (list license:expat license:asl2.0))))

(define rust-crc16-0.4
  (package
    (name "rust-crc16")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crc16" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1zzwb5iv51wnh96532cxkk4aa8ys47rhzrjy98wqcys25ks8k01k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/blackbeam/rust-crc16")
    (synopsis "A CRC16 implementation")
    (description "This package provides a CRC16 implementation")
    (license license:expat)))

(define rust-async-native-tls-0.4
  (package
    (name "rust-async-native-tls")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "async-native-tls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1zhkka5azpr03wg2bswabmwcwcqbdia17h2d17hk4wk47kn4qzfm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://docs.rs/crate/async-native-tls/")
    (synopsis "Native TLS using futures
")
    (description "Native TLS using futures")
    (license (list license:expat license:asl2.0))))

(define rust-redis-0.21
  (package
    (name "rust-redis")
    (version "0.21.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "redis" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1dj60f25dpm7m7hn085dr73050q9h5bq8iy27fvpdfswcdikhbqm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arc-swap" ,rust-arc-swap-1)
                       ("rust-async-native-tls" ,rust-async-native-tls-0.4)
                       ("rust-async-std" ,rust-async-std-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-combine" ,rust-combine-4)
                       ("rust-crc16" ,rust-crc16-0.4)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-r2d2" ,rust-r2d2-0.8)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-ryu" ,rust-ryu-1)
                       ("rust-sha1" ,rust-sha1-0.6)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/redis-rs/redis-rs")
    (synopsis "Redis driver for Rust.")
    (description "Redis driver for Rust.")
    (license license:bsd-3)))

(define rust-redis-async-0.13
  (package
    (name "rust-redis-async")
    (version "0.13.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "redis-async" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gxs0w5bglsb73vgkvlmhxd3nmf2rm7ikh6xdj5w4x3c80716xr7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7))))
    (home-page "https://github.com/benashford/redis-async-rs")
    (synopsis
     "An asynchronous futures based Redis client for Rust using Tokio")
    (description
     "An asynchronous futures based Redis client for Rust using Tokio")
    (license (list license:expat license:asl2.0))))

(define rust-backoff-0.4
  (package
    (name "rust-backoff")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "backoff" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1h80d9xn5wngxdgza2m8w4x1kyhk0x6k9ydvsj50j2pcn6fdnbdn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-std" ,rust-async-std-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-instant" ,rust-instant-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/ihrwein/backoff")
    (synopsis "Retry operations with exponential backoff policy.
")
    (description "Retry operations with exponential backoff policy.")
    (license (list license:expat license:asl2.0))))

(define rust-actix-redis-0.12
  (package
    (name "rust-actix-redis")
    (version "0.12.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-redis" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ycj0px3akij7ccimqqq8kr4h9cgzdy7q1mi4c04ygvl3k0nsi1q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix" ,rust-actix-0.13)
                       ("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-tls" ,rust-actix-tls-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-backoff" ,rust-backoff-0.4)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-redis-async" ,rust-redis-async-0.13)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7))))
    (home-page "https://actix.rs")
    (synopsis "Redis integration for Actix")
    (description "Redis integration for Actix")
    (license (list license:expat license:asl2.0))))

(define rust-actix-derive-0.6
  (package
    (name "rust-actix-derive")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19rp2xcwqf5p4q5h6xxzb44xsfgpvvnnsis3l0dngnffw7zbhi3d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/actix/actix")
    (synopsis "Derive macros for `actix` actors")
    (description "Derive macros for `actix` actors")
    (license (list license:expat license:asl2.0))))

(define rust-actix-0.13
  (package
    (name "rust-actix")
    (version "0.13.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ljyg7b5h3zj6l26v55s7myqwiavilfg2750shcpg41bj896d9fb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-macros" ,rust-actix-macros-0.2)
                       ("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-derive" ,rust-actix-derive-0.6)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-task" ,rust-futures-task-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7))))
    (home-page "https://github.com/actix/actix")
    (synopsis "Actor framework for Rust")
    (description "Actor framework for Rust")
    (license (list license:expat license:asl2.0))))

(define rust-actix-session-0.7
  (package
    (name "rust-actix-session")
    (version "0.7.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-session" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11qfz1gzzg1ajwgw34jzbb75d3py8m9rf66jli4i1wg1ia0qpnj3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix" ,rust-actix-0.13)
                       ("rust-actix-redis" ,rust-actix-redis-0.12)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-anyhow" ,rust-anyhow-1)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-redis" ,rust-redis-0.21)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://actix.rs")
    (synopsis "Session management for Actix We")
    (description "Session management for Actix We")
    (license (list license:expat license:asl2.0))))

(define rust-actix-identity-0.5
  (package
    (name "rust-actix-identity")
    (version "0.5.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-identity" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1v0b33gj8g7aafgywdgwpkzdghgdml2cwcxjfy87rhixb7wwj90j"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-session" ,rust-actix-session-0.7)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-anyhow" ,rust-anyhow-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://actix.rs")
    (synopsis "Identity service for Actix Web")
    (description "Identity service for Actix Web")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-uring-0.3
  (package
    (name "rust-tokio-uring")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-uring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1j22wyryp8ami8gq9cgh3wqd7g5gklqzdrxdj3cq8jc7757lkbfk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-io-uring" ,rust-io-uring-0.5)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-scoped-tls" ,rust-scoped-tls-1)
                       ("rust-slab" ,rust-slab-0.4)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://tokio.rs")
    (synopsis "io-uring support for the Tokio asynchronous runtime.
")
    (description "io-uring support for the Tokio asynchronous runtime.")
    (license license:expat)))

(define rust-http-range-0.1
  (package
    (name "rust-http-range")
    (version "0.1.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "http-range" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wvm2p9jhbj6f9fbl1i7a0iz85nga37kx739v4p8fpqg27dwkpi1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/bancek/rust-http-range.git")
    (synopsis "HTTP Range header parser")
    (description "HTTP Range header parser")
    (license license:expat)))

(define rust-actix-files-0.6
  (package
    (name "rust-actix-files")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-files" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12gn3kmfp00p2nnr1qbn3kjwa8s6alh9mvn9f2d3d9vcmhpphcnq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-http" ,rust-actix-http-3)
                       ("rust-actix-server" ,rust-actix-server-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-askama-escape" ,rust-askama-escape-0.10)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-http-range" ,rust-http-range-0.1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-tokio-uring" ,rust-tokio-uring-0.3))))
    (home-page "https://actix.rs")
    (synopsis "Static file serving for Actix Web")
    (description "Static file serving for Actix Web")
    (license (list license:expat license:asl2.0))))

(define rust-paperclip-core-0.6
  (package
    (name "rust-paperclip-core")
    (version "0.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "paperclip-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16q6mi9nszw6yczgvbs4zyzpg5lp9hdv2fqbk8vb6x14y0y67mxg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-files" ,rust-actix-files-0.6)
                       ("rust-actix-identity" ,rust-actix-identity-0.5)
                       ("rust-actix-multipart" ,rust-actix-multipart-0.6)
                       ("rust-actix-session" ,rust-actix-session-0.7)
                       ("rust-actix-web" ,rust-actix-web-2)
                       ("rust-actix-web" ,rust-actix-web-3)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-actix-web-validator" ,rust-actix-web-validator-2)
                       ("rust-actix-web-validator" ,rust-actix-web-validator-3)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-heck" ,rust-heck-0.4)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-openapiv3" ,rust-openapiv3-1)
                       ("rust-paperclip-macros" ,rust-paperclip-macros-0.6)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rust-decimal" ,rust-rust-decimal-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-qs" ,rust-serde-qs-0.7)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.9)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-uuid" ,rust-uuid-0.8)
                       ("rust-validator" ,rust-validator-0.12)
                       ("rust-validator" ,rust-validator-0.14))))
    (home-page "https://github.com/paperclip-rs/paperclip")
    (synopsis "Core types and traits for paperclip OpenAPI tooling library")
    (description
     "Core types and traits for paperclip @code{OpenAPI} tooling library")
    (license (list license:expat license:asl2.0))))

(define rust-mime-guess-2
  (package
    (name "rust-mime-guess")
    (version "2.0.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "mime_guess" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vs28rxnbfwil6f48hh58lfcx90klcvg68gxdc60spwa4cy2d4j1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-mime" ,rust-mime-0.3)
                       ("rust-unicase" ,rust-unicase-2)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/abonander/mime_guess")
    (synopsis
     "A simple crate for detection of a file's MIME type by its extension.")
    (description
     "This package provides a simple crate for detection of a file's MIME type by its
extension.")
    (license license:expat)))

(define rust-actix-web-codegen-4
  (package
    (name "rust-actix-web-codegen")
    (version "4.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-web-codegen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xalrv1s7imzfgxyql6zii5bpxxkk11rlcc8n4ia3v1hpgmm07zb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-router" ,rust-actix-router-0.5)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://actix.rs")
    (synopsis "Routing and runtime macros for Actix Web")
    (description "Routing and runtime macros for Actix Web")
    (license (list license:expat license:asl2.0))))

(define rust-socket2-0.5
  (package
    (name "rust-socket2")
    (version "0.5.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "socket2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xzq0mkg3x345wbjzrp2i19s6lrjdlbh48ra6bh805kl063v2f15"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/rust-lang/socket2")
    (synopsis
     "Utilities for handling networking sockets with a maximal amount of configuration
possible intended.
")
    (description
     "Utilities for handling networking sockets with a maximal amount of configuration
possible intended.")
    (license (list license:expat license:asl2.0))))

(define rust-actix-server-2
  (package
    (name "rust-actix-server")
    (version "2.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-server" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1m62qbg7vl1wddr6mm8sd4rnvd3w5v3zcn8fmdpfl8q4xxz3xc9y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-mio" ,rust-mio-0.8)
                       ("rust-socket2" ,rust-socket2-0.5)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-uring" ,rust-tokio-uring-0.4)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://actix.rs")
    (synopsis "General purpose TCP server built for the Actix ecosystem")
    (description "General purpose TCP server built for the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define rust-actix-router-0.5
  (package
    (name "rust-actix-router")
    (version "0.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-router" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16c7lcis96plz0rl23l44wsq61jpx1bn91m23y361cfj8z9g8vyn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytestring" ,rust-bytestring-0.1)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/actix/actix-web.git")
    (synopsis "Resource path matching and router")
    (description "Resource path matching and router")
    (license (list license:expat license:asl2.0))))

(define rust-zstd-safe-6
  (package
    (name "rust-zstd-safe")
    (version "6.0.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zstd-safe" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10cm0v8sw3jz3pi0wlwx9mbb2l25lm28w638a5n5xscfnk8gz67f"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-zstd-sys" ,rust-zstd-sys-2))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis "Safe low-level bindings for the zstd compression library.")
    (description "Safe low-level bindings for the zstd compression library.")
    (license (list license:expat license:asl2.0))))

(define rust-zstd-0.12
  (package
    (name "rust-zstd")
    (version "0.12.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "zstd" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0g654jj8z25rvzli2b1231pcp9y7n6vk44jaqwgifh9n2xg5j9qs"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-zstd-safe" ,rust-zstd-safe-6))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis "Binding for the zstd compression library.")
    (description "Binding for the zstd compression library.")
    (license license:expat)))

(define rust-local-channel-0.1
  (package
    (name "rust-local-channel")
    (version "0.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "local-channel" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "177wqgadrlw6m7r6xxafkj58asgpgbpv1ww4gx258v2cx703wc3z"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-local-waker" ,rust-local-waker-0.1))))
    (home-page "https://github.com/actix/actix-net.git")
    (synopsis
     "A non-threadsafe multi-producer, single-consumer, futures-aware, FIFO queue")
    (description
     "This package provides a non-threadsafe multi-producer, single-consumer,
futures-aware, FIFO queue")
    (license (list license:expat license:asl2.0))))

(define rust-h2-0.3
  (package
    (name "rust-h2")
    (version "0.3.21")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "h2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0cq8g5bgk3fihnqicy3g8gc3dpsalzqjg4bjyip9g4my26m27z4i"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-slab" ,rust-slab-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/hyperium/h2")
    (synopsis "An HTTP/2 client and server")
    (description "An HTTP/2 client and server")
    (license license:expat)))

(define rust-bytestring-1
  (package
    (name "rust-bytestring")
    (version "1.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bytestring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1blscywg9gaw6zdc5hqsf9zwyqiym57q631nk7wc960dfs34i3i3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://actix.rs")
    (synopsis "An immutable UTF-8 encoded string using Bytes as storage")
    (description "An immutable UTF-8 encoded string using Bytes as storage")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-rustls-0.24
  (package
    (name "rust-tokio-rustls")
    (version "0.24.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-rustls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10bhibg57mqir7xjhb2xmf24xgfpx6fzpyw720a4ih8a737jg0y2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-rustls" ,rust-rustls-0.21)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/rustls/tokio-rustls")
    (synopsis "Asynchronous TLS/SSL streams for Tokio using Rustls.")
    (description "Asynchronous TLS/SSL streams for Tokio using Rustls.")
    (license (list license:expat license:asl2.0))))

(define rust-rustls-webpki-0.101
  (package
    (name "rust-rustls-webpki")
    (version "0.101.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustls-webpki" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03dz752a0n8yw3iqf6qn8d376gv5syzjnlrsipzjya1dmwdr74vx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ring" ,rust-ring-0.16)
                       ("rust-untrusted" ,rust-untrusted-0.7))))
    (home-page "https://github.com/rustls/webpki")
    (synopsis "Web PKI X.509 Certificate Verification.")
    (description "Web PKI X.509 Certificate Verification.")
    (license license:isc)))

(define rust-openssl-src-111
  (package
    (name "rust-openssl-src")
    (version "111.27.0+1.1.1v")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "openssl-src" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "00izwsjj8dgdrss277grspbl1npy3sdhq0qln32i2x9dr2bz3s06"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1))))
    (home-page "https://github.com/alexcrichton/openssl-src-rs")
    (synopsis "Source of OpenSSL and logic to build it.
")
    (description "Source of @code{OpenSSL} and logic to build it.")
    (license (list license:expat license:asl2.0))))

(define rust-bssl-sys-0.1
  (package
    (name "rust-bssl-sys")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bssl-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0p5v3ad1paf12db4hmwq4j8dvcrppsscf57dwvr880q67hwi4b9i"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "")
    (synopsis "Placeholder package for boringssl bindings")
    (description "Placeholder package for boringssl bindings")
    (license license:expat)))

(define rust-openssl-sys-0.9
  (package
    (name "rust-openssl-sys")
    (version "0.9.92")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "openssl-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16w6ipkzkxgiqy3lf15wnchgbvvp0443gprg5ldidfib5hf9fznv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.64)
                       ("rust-bssl-sys" ,rust-bssl-sys-0.1)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-openssl-src" ,rust-openssl-src-111)
                       ("rust-pkg-config" ,rust-pkg-config-0.3)
                       ("rust-vcpkg" ,rust-vcpkg-0.2))))
    (home-page "https://github.com/sfackler/rust-openssl")
    (synopsis "FFI bindings to OpenSSL")
    (description "FFI bindings to @code{OpenSSL}")
    (license license:expat)))

(define rust-openssl-0.10.57
  (package
    (name "rust-openssl")
    (version "0.10.57")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "openssl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0z0f8g84y0lvnbc60586ibjpf8r1q1dv672vfqan5d5bk7imxhms"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-foreign-types" ,rust-foreign-types-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-openssl-macros" ,rust-openssl-macros-0.1)
                       ("rust-openssl-sys" ,rust-openssl-sys-0.9))))
    (home-page "https://github.com/sfackler/rust-openssl")
    (synopsis "OpenSSL bindings")
    (description "@code{OpenSSL} bindings")
    (license license:asl2.0)))

(define rust-impl-more-0.1
  (package
    (name "rust-impl-more")
    (version "0.1.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "impl-more" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bdv06br4p766rcgihhjwqyz8fcz31xyaq14rr53vfh3kifafv10"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/robjtede/impl-more")
    (synopsis "Concise, declarative trait implementation macros")
    (description "Concise, declarative trait implementation macros")
    (license (list license:expat license:asl2.0))))

(define rust-local-waker-0.1
  (package
    (name "rust-local-waker")
    (version "0.1.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "local-waker" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1w9zqlh18mymvb82ya0sailiy5d3wsjamaakgl70x50i6vmpckz3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/actix/actix-net.git")
    (synopsis "A synchronization primitive for thread-local task wakeup")
    (description
     "This package provides a synchronization primitive for thread-local task wakeup")
    (license (list license:expat license:asl2.0))))

(define rust-actix-utils-3
  (package
    (name "rust-actix-utils")
    (version "3.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-utils" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1n05nzwdkx6jhmzr6f9qsh57a8hqlwv5rjz1i0j3qvj6y7gxr8c8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-local-waker" ,rust-local-waker-0.1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis "Various utilities used in the Actix ecosystem")
    (description "Various utilities used in the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define rust-actix-tls-3
  (package
    (name "rust-actix-tls")
    (version "3.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-tls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1hzgw3rl8jl9mf6ck687dl1n0npz93x7fihnyg39kan0prznwqbj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-impl-more" ,rust-impl-more-0.1)
                       ("rust-openssl" ,rust-openssl-0.10.57)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rustls" ,rust-rustls-0.21)
                       ("rust-rustls-webpki" ,rust-rustls-webpki-0.101)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.25)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://github.com/actix/actix-net.git")
    (synopsis "TLS acceptor and connector services for Actix ecosystem")
    (description "TLS acceptor and connector services for Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define rust-sc-0.2
  (package
    (name "rust-sc")
    (version "0.2.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12x3c3mn36am3jfamswqfsd0vpr0hz3kdck6wskla7gx7fyih3h1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/japaric/syscall.rs")
    (synopsis "Raw system calls")
    (description "Raw system calls")
    (license (list license:expat license:asl2.0))))

(define rust-io-uring-0.5
  (package
    (name "rust-io-uring")
    (version "0.5.13")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "io-uring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0k4qrzhnc8j50g79ki8n79d4yffvcmwq5dj3bj6gs95rrw0il7nx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bindgen" ,rust-bindgen-0.61)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-sc" ,rust-sc-0.2))))
    (home-page "https://github.com/tokio-rs/io-uring")
    (synopsis "The low-level `io_uring` userspace interface for Rust")
    (description "The low-level `io_uring` userspace interface for Rust")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-uring-0.4
  (package
    (name "rust-tokio-uring")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio-uring" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vsmw482n01lj33dr7rnjxmdcdhq5yys6rbwahx0n0vy2fxh4phd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-io-uring" ,rust-io-uring-0.5)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-scoped-tls" ,rust-scoped-tls-1)
                       ("rust-slab" ,rust-slab-0.4)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://tokio.rs")
    (synopsis "io-uring support for the Tokio asynchronous runtime.
")
    (description "io-uring support for the Tokio asynchronous runtime.")
    (license license:expat)))

(define rust-actix-macros-0.2
  (package
    (name "rust-actix-macros")
    (version "0.2.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1jsmhq9k5nsms8sci2lqkihym5nrhlpfv8dgd0n4539g1cad67p0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/actix/actix-net.git")
    (synopsis "Macros for Actix system and runtime")
    (description "Macros for Actix system and runtime")
    (license (list license:expat license:asl2.0))))

(define rust-actix-rt-2
  (package
    (name "rust-actix-rt")
    (version "2.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-rt" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "078mjccgha4xlqk2hjb9hxfg26pmpra9v2h2w0m40gvx5102vwr8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-macros" ,rust-actix-macros-0.2)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-uring" ,rust-tokio-uring-0.4))))
    (home-page "https://actix.rs")
    (synopsis
     "Tokio-based single-threaded async runtime for the Actix ecosystem")
    (description
     "Tokio-based single-threaded async runtime for the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define rust-actix-http-3
  (package
    (name "rust-actix-http")
    (version "3.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-http" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1j8v6pc0l0093wwz6mbhgsd7rn367r9hzhgpwiv3z86bk5bzhbm9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-codec" ,rust-actix-codec-0.5)
                       ("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-tls" ,rust-actix-tls-3)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-ahash" ,rust-ahash-0.8)
                       ("rust-base64" ,rust-base64-0.21)
                       ("rust-bitflags" ,rust-bitflags-2)
                       ("rust-brotli" ,rust-brotli-3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-bytestring" ,rust-bytestring-1)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-h2" ,rust-h2-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-httpdate" ,rust-httpdate-1)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-language-tags" ,rust-language-tags-0.3)
                       ("rust-local-channel" ,rust-local-channel-0.1)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-sha1" ,rust-sha1-0.10)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-zstd" ,rust-zstd-0.12))))
    (home-page "https://actix.rs")
    (synopsis "HTTP primitives for the Actix ecosystem")
    (description "HTTP primitives for the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define rust-actix-codec-0.5
  (package
    (name "rust-actix-codec")
    (version "0.5.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-codec" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1f749khww3p9a1kw4yzf4w4l1xlylky2bngar7cf2zskwdl84yk1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis "Codec utilities for working with framed protocols")
    (description "Codec utilities for working with framed protocols")
    (license (list license:expat license:asl2.0))))

(define rust-actix-web-4
  (package
    (name "rust-actix-web")
    (version "4.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-web" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1fb2yhd09kjabwz5qnic55hfp33ifkw5rikp9b4shg3055g5njhf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-codec" ,rust-actix-codec-0.5)
                       ("rust-actix-http" ,rust-actix-http-3)
                       ("rust-actix-macros" ,rust-actix-macros-0.2)
                       ("rust-actix-router" ,rust-actix-router-0.5)
                       ("rust-actix-rt" ,rust-actix-rt-2)
                       ("rust-actix-server" ,rust-actix-server-2)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-tls" ,rust-actix-tls-3)
                       ("rust-actix-utils" ,rust-actix-utils-3)
                       ("rust-actix-web-codegen" ,rust-actix-web-codegen-4)
                       ("rust-ahash" ,rust-ahash-0.8)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-bytestring" ,rust-bytestring-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-cookie" ,rust-cookie-0.16)
                       ("rust-derive-more" ,rust-derive-more-0.99)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-language-tags" ,rust-language-tags-0.3)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-socket2" ,rust-socket2-0.5)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://actix.rs")
    (synopsis
     "Actix Web is a powerful, pragmatic, and extremely fast web framework for Rust")
    (description
     "Actix Web is a powerful, pragmatic, and extremely fast web framework for Rust")
    (license (list license:expat license:asl2.0))))

(define rust-actix-service-2
  (package
    (name "rust-actix-service")
    (version "2.0.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "actix-service" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0fipjcc5kma7j47jfrw55qm09dakgvx617jbriydrkqqz10lk29v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-paste" ,rust-paste-1)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
     "Service trait and combinators for representing asynchronous request/response operations.")
    (description
     "Service trait and combinators for representing asynchronous request/response
operations.")
    (license (list license:expat license:asl2.0))))

(define rust-paperclip-actix-0.6
  (package
    (name "rust-paperclip-actix")
    (version "0.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "paperclip-actix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1gqizkj4g3md0hg16abpzmpznsfq0i9jsqi2aax4hffp5rd1j61g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-actix-service" ,rust-actix-service-1)
                       ("rust-actix-service" ,rust-actix-service-2)
                       ("rust-actix-web" ,rust-actix-web-4)
                       ("rust-actix-web" ,rust-actix-web-2)
                       ("rust-actix-web" ,rust-actix-web-3)
                       ("rust-futures" ,rust-futures-0.3)
                       ("rust-include-dir" ,rust-include-dir-0.7)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-openapiv3" ,rust-openapiv3-1)
                       ("rust-paperclip-core" ,rust-paperclip-core-0.6)
                       ("rust-paperclip-macros" ,rust-paperclip-macros-0.6)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-tinytemplate" ,rust-tinytemplate-1))))
    (home-page "https://github.com/paperclip-rs/paperclip")
    (synopsis "Paperclip OpenAPI plugin for actix-web framework")
    (description "Paperclip @code{OpenAPI} plugin for actix-web framework")
    (license (list license:expat license:asl2.0))))

(define rust-openapiv3-1
  (package
    (name "rust-openapiv3")
    (version "1.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "openapiv3" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04sgvkws25v8g2saix1lk13clcy97hif7dv5a51bcr8r8if6vrbm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/glademiller/openapiv3")
    (synopsis
     "This crate provides data structures that represent the OpenAPI v3.0.x specification easily deserializable with serde.")
    (description
     "This crate provides data structures that represent the @code{OpenAPI} v3.0.x
specification easily deserializable with serde.")
    (license (list license:expat license:asl2.0))))

(define rust-paperclip-0.8
  (package
    (name "rust-paperclip")
    (version "0.8.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "paperclip" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01v5dvrw1xf4az9afb98v4gvmhd7qszqjdipqnylya9a422lhj98"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-env-logger" ,rust-env-logger-0.8)
                       ("rust-git2" ,rust-git2-0.15)
                       ("rust-heck" ,rust-heck-0.4)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-itertools" ,rust-itertools-0.10)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-openapiv3" ,rust-openapiv3-1)
                       ("rust-paperclip-actix" ,rust-paperclip-actix-0.6)
                       ("rust-paperclip-core" ,rust-paperclip-core-0.6)
                       ("rust-paperclip-macros" ,rust-paperclip-macros-0.6)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-reqwest" ,rust-reqwest-0.10)
                       ("rust-semver" ,rust-semver-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.9)
                       ("rust-structopt" ,rust-structopt-0.3)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tinytemplate" ,rust-tinytemplate-1)
                       ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/paperclip-rs/paperclip")
    (synopsis
     "OpenAPI tooling library for type-safe compile-time checked HTTP APIs")
    (description
     "@code{OpenAPI} tooling library for type-safe compile-time checked HTTP APIs")
    (license (list license:expat license:asl2.0))))

(define rust-num-traits-0.2
  (package
    (name "rust-num-traits")
    (version "0.2.14")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-traits" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "144j176s2p76azy2ngk2vkdzgwdc0bc8c93jhki8c9fsbknb2r4s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-libm" ,rust-libm-0.2))))
    (home-page "https://github.com/rust-num/num-traits")
    (synopsis "Numeric traits for generic mathematics")
    (description "Numeric traits for generic mathematics")
    (license (list license:expat license:asl2.0))))

(define rust-num-integer-0.1
  (package
    (name "rust-num-integer")
    (version "0.1.45")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-integer" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ncwavvwdmsqzxnn65phv6c6nn72pnv9xhpmjd6a429mzf4k6p92"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-num-traits" ,rust-num-traits-0.2))))
    (home-page "https://github.com/rust-num/num-integer")
    (synopsis "Integer traits and functions")
    (description "Integer traits and functions")
    (license (list license:expat license:asl2.0))))

(define rust-num-bigint-0.4
  (package
    (name "rust-num-bigint")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "num-bigint" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04k5xh7d0nxay4yfb02rj841y9g5jh45d320avi53ak221y083af"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-autocfg" ,rust-autocfg-1)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-num/num-bigint")
    (synopsis "Big integer implementation for Rust")
    (description "Big integer implementation for Rust")
    (license (list license:expat license:asl2.0))))

(define rust-dg-xch-serialize-1
  (package
    (name "rust-dg-xch-serialize")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_serialize" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17f38ysl5ylpy6vx5ifb0m58w9nn5zb9krjvj6kxpkhn6z4gkdl8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-sha2" ,rust-sha2-0.10))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "Low Level Support Package for dg_xch_utils")
    (description "Low Level Support Package for dg_xch_utils")
    (license license:asl2.0)))

(define rust-dg-xch-macros-1
  (package
    (name "rust-dg-xch-macros")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13wrh8p2y5pfr72lrz6kf5mh6vbffhvw489yfpmngzyjj1iz7pf8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "Derive Marcos for Chia Serialization")
    (description "Derive Marcos for Chia Serialization")
    (license license:asl2.0)))

(define rust-pairing-0.23
  (package
    (name "rust-pairing")
    (version "0.23.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pairing" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vwr2c500jkw81ga8as4bx93ciyllspnr15n9gpl3kvkbric9zl1"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-group" ,rust-group-0.13))))
    (home-page "https://github.com/zkcrypto/pairing")
    (synopsis "Pairing-friendly elliptic curve library")
    (description "Pairing-friendly elliptic curve library")
    (license (list license:expat license:asl2.0))))

(define rust-bls12-381-0.8
  (package
    (name "rust-bls12-381")
    (version "0.8.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bls12_381" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "00zl6c2bhjh6wfxixdavba3falgm034dm1lp6zk1jfmyj9i6vg6p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-digest" ,rust-digest-0.9)
                       ("rust-ff" ,rust-ff-0.13)
                       ("rust-group" ,rust-group-0.13)
                       ("rust-pairing" ,rust-pairing-0.23)
                       ("rust-rand-core" ,rust-rand-core-0.6)
                       ("rust-subtle" ,rust-subtle-2)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/zkcrypto/bls12_381")
    (synopsis
     "Implementation of the BLS12-381 pairing-friendly elliptic curve construction")
    (description
     "Implementation of the BLS12-381 pairing-friendly elliptic curve construction")
    (license (list license:expat license:asl2.0))))

(define rust-bech32-0.9
  (package
    (name "rust-bech32")
    (version "0.9.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bech32" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0igl565rfpxwbh0g36cb7469sjkiap8yd21kcr0ppi2jfbwr6syq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-bitcoin/rust-bech32")
    (synopsis
     "Encodes and decodes the Bech32 format and implements the bech32 and bech32m checksums")
    (description
     "Encodes and decodes the Bech32 format and implements the bech32 and bech32m
checksums")
    (license license:expat)))

(define rust-dg-xch-core-1
  (package
    (name "rust-dg-xch-core")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1i19jpy0crzhhcarvqj68025caccp9fyw8wh1hjggm6zfvp8gvf6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bech32" ,rust-bech32-0.9)
                       ("rust-bip39" ,rust-bip39-2)
                       ("rust-bls12-381" ,rust-bls12-381-0.8)
                       ("rust-blst" ,rust-blst-0.3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-dg-xch-macros" ,rust-dg-xch-macros-1)
                       ("rust-dg-xch-serialize" ,rust-dg-xch-serialize-1)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-hkdf" ,rust-hkdf-0.12)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-openssl" ,rust-openssl-0.10.57)
                       ("rust-paperclip" ,rust-paperclip-0.8)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-simple-logger" ,rust-simple-logger-4)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis
     "Core library containing type/error definitions, CLVM tools, Consensus and Pool definitions")
    (description
     "Core library containing type/error definitions, CLVM tools, Consensus and Pool
definitions")
    (license license:asl2.0)))

(define rust-dg-xch-clients-1
  (package
    (name "rust-dg-xch-clients")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_clients" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mwncwmjahs4kh9r1pzfxsznl53g8sndc72ry86486q8qjwypk4x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-macros" ,rust-dg-xch-macros-1)
                       ("rust-dg-xch-pos" ,rust-dg-xch-pos-1)
                       ("rust-dg-xch-serialize" ,rust-dg-xch-serialize-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-hyper" ,rust-hyper-0.14)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-reqwest" ,rust-reqwest-0.11)
                       ("rust-rustls" ,rust-rustls-0.21)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.20)
                       ("rust-urlencoding" ,rust-urlencoding-2)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "RPC and Websocket Clients the Chia Blockchain")
    (description "RPC and Websocket Clients the Chia Blockchain")
    (license license:asl2.0)))

(define rust-blst-0.3
  (package
    (name "rust-blst")
    (version "0.3.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "blst" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jv07smgcxca8x7gv87d86hiw1djsad9iaci6afr88m86nwqfh69"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1)
                       ("rust-glob" ,rust-glob-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-threadpool" ,rust-threadpool-1)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/supranational/blst")
    (synopsis "Bindings for blst BLS12-381 library")
    (description "Bindings for blst BLS12-381 library")
    (license license:asl2.0)))

(define rust-schemars-derive-0.8
  (package
    (name "rust-schemars-derive")
    (version "0.8.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "schemars_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mhksgh3nzkq2nlk57gn12yamp85b70b5x6x7djqzbkiz2ydybwh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-serde-derive-internals" ,rust-serde-derive-internals-0.25)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://graham.cool/schemars/")
    (synopsis "Macros for #[derive(JsonSchema)], for use with schemars")
    (description
     "Macros for #[derive(@code{JsonSchema})], for use with schemars")
    (license license:expat)))

(define rust-schemars-0.8
  (package
    (name "rust-schemars")
    (version "0.8.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "schemars" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0y6bcsrc2sigri8612r8gmwpn9c5r6200v56rfswrb1mmriv8smw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.5)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-dyn-clone" ,rust-dyn-clone-1)
                       ("rust-either" ,rust-either-1)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-schemars-derive" ,rust-schemars-derive-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-0.8))))
    (home-page "https://graham.cool/schemars/")
    (synopsis "Generate JSON Schemas from Rust code")
    (description "Generate JSON Schemas from Rust code")
    (license license:expat)))

(define rust-bitcoin-hashes-0.11
  (package
    (name "rust-bitcoin-hashes")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bitcoin_hashes" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1i3v3fh92cps71qif11dw708bs5fpdxx1fk01m3sc5b8xs6ln1lh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-core2" ,rust-core2-0.3)
                       ("rust-schemars" ,rust-schemars-0.8)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-bitcoin/rust-bitcoin")
    (synopsis "Hash functions used by the rust-bitcoin eccosystem")
    (description "Hash functions used by the rust-bitcoin eccosystem")
    (license license:cc0)))

(define rust-bip39-2
  (package
    (name "rust-bip39")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bip39" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0br1kyk12ndjjjlnzlh52aypipsmiaivjyzbfr2rs2xz41b67wlk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitcoin-hashes" ,rust-bitcoin-hashes-0.11)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rand-core" ,rust-rand-core-0.6)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-unicode-normalization" ,rust-unicode-normalization-0.1)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/rust-bitcoin/rust-bip39/")
    (synopsis "Library for BIP-39 Bitcoin mnemonic codes")
    (description "Library for BIP-39 Bitcoin mnemonic codes")
    (license license:cc0)))

(define rust-dg-xch-cli-1
  (package
    (name "rust-dg-xch-cli")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dg_xch_cli" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yxdhxj9y888bxlxi1b9sfqqd60sksxfv296s592wb34jljvwwyy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bip39" ,rust-bip39-2)
                       ("rust-blst" ,rust-blst-0.3)
                       ("rust-clap" ,rust-clap-4)
                       ("rust-dg-xch-clients" ,rust-dg-xch-clients-1)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-keys" ,rust-dg-xch-keys-1)
                       ("rust-dg-xch-pos" ,rust-dg-xch-pos-1)
                       ("rust-dg-xch-puzzles" ,rust-dg-xch-puzzles-1)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-simple-logger" ,rust-simple-logger-4)
                       ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/GalactechsLLC/dg_xch_utils")
    (synopsis "CLI Utilities for the Chia Blockchain")
    (description "CLI Utilities for the Chia Blockchain")
    (license license:asl2.0)))

(define rust-clap-derive-4
  (package
    (name "rust-clap-derive")
    (version "4.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1s4c4005xsdw5zlq8z5h02mgjcsqgcd1ydxg6iird49fcxyjfjk8"))))
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

(define rust-clap-4
  (package
    (name "rust-clap")
    (version "4.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cn1imij7n7f9gq5m14zj0vc4rpy3lfsql77xzg8ihb3i09a9isf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-clap-derive" ,rust-clap-derive-4)
                       ("rust-clap-lex" ,rust-clap-lex-0.3)
                       ("rust-is-terminal" ,rust-is-terminal-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-strsim" ,rust-strsim-0.10)
                       ("rust-termcolor" ,rust-termcolor-1)
                       ("rust-terminal-size" ,rust-terminal-size-0.2)
                       ("rust-unicase" ,rust-unicase-2)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/clap-rs/clap")
    (synopsis
     "A simple to use, efficient, and full-featured Command Line Argument Parser")
    (description
     "This package provides a simple to use, efficient, and full-featured Command Line
Argument Parser")
    (license (list license:expat license:asl2.0))))

(define rust-dialoguer-0.10
  (package
    (name "rust-dialoguer")
    (version "0.10.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dialoguer" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wlisvi5n6iw7aw419jap3y22245z93inqc1sngqsh0b7dppjg5g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-console" ,rust-console-0.15)
                       ("rust-fuzzy-matcher" ,rust-fuzzy-matcher-0.3)
                       ("rust-shell-words" ,rust-shell-words-1)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/mitsuhiko/dialoguer")
    (synopsis "A command line prompting library.")
    (description "This package provides a command line prompting library.")
    (license license:expat)))

(define rust-async-trait-0.1
  (package
    (name "rust-async-trait")
    (version "0.1.58")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "async-trait" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "031n0jlf07gn8k3bbfi7klqmzaxi8va4rkr62ijin05mwsa5v00y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))
       #:cargo-development-inputs (("rust-futures" ,rust-futures-0.3)
                                   ("rust-rustversion" ,rust-rustversion-1)
                                   ("rust-tracing" ,rust-tracing-0.1)
                                   ("rust-tracing-attributes" ,rust-tracing-attributes-0.1)
                                   ("rust-trybuild" ,rust-trybuild-1))))
    (home-page "https://github.com/dtolnay/async-trait")
    (synopsis "Type erasure for async trait methods")
    (description "Type erasure for async trait methods")
    (license (list license:expat license:asl2.0))))

(define rust-futures-macro-0.3
  (package
    (name "rust-futures-macro")
    (version "0.3.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "futures-macro" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pc3c5mydmwy50f0whcljcd41f0z1ci0r65dka8r2syqagh8ryxx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://rust-lang.github.io/futures-rs")
    (synopsis "The futures-rs procedural macro implementations.
")
    (description "The futures-rs procedural macro implementations.")
    (license (list license:expat license:asl2.0))))

(define rust-futures-util-0.3
  (package
    (name "rust-futures-util")
    (version "0.3.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "futures-util" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1mk5vh8q5bkkvxji8r1nimh87hgi190nz4l4zynrqbxxgac7cxhr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-futures" ,rust-futures-0.1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-io" ,rust-futures-io-0.3)
                       ("rust-futures-macro" ,rust-futures-macro-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-task" ,rust-futures-task-0.3)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-pin-utils" ,rust-pin-utils-0.1)
                       ("rust-slab" ,rust-slab-0.4)
                       ("rust-tokio-io" ,rust-tokio-io-0.1))
       #:cargo-development-inputs (("rust-tokio" ,rust-tokio-0.1))))
    (home-page "https://rust-lang.github.io/futures-rs")
    (synopsis
     "Common utilities and extension traits for the futures-rs library.
")
    (description
     "Common utilities and extension traits for the futures-rs library.")
    (license (list license:expat license:asl2.0))))

(define rust-pnet-sys-0.27
  (package
    (name "rust-pnet-sys")
    (version "0.27.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pnet_sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05gz5xixzvs5iw7a3l0r7sic7s44x8xmv9pqvzzs6wpdwz2f92bm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/libpnet/libpnet")
    (synopsis "Access to network related system function and calls.")
    (description "Access to network related system function and calls.")
    (license (list license:expat license:asl2.0))))

(define rust-pnet-base-0.27
  (package
    (name "rust-pnet-base")
    (version "0.27.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pnet_base" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1v8bcbv9jh581ill77qjzzw2ay76pl781982yclj3xky96m8hijf"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/libpnet/libpnet")
    (synopsis "Fundamental base types and code used by pnet.")
    (description "Fundamental base types and code used by pnet.")
    (license (list license:expat license:asl2.0))))

(define rust-pcap-0.7
  (package
    (name "rust-pcap")
    (version "0.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pcap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14blflnbj87z3ajlj1hszsl6k7rwa338y4aw2yjm2j0xdpjvj4pr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clippy" ,rust-clippy-0.0.302)
                       ("rust-futures" ,rust-futures-0.1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mio" ,rust-mio-0.6)
                       ("rust-tokio-core" ,rust-tokio-core-0.1))))
    (home-page "https://github.com/rust-pcap/pcap")
    (synopsis "A packet capture API around pcap/wpcap")
    (description
     "This package provides a packet capture API around pcap/wpcap")
    (license (list license:expat license:asl2.0))))

(define rust-netmap-sys-0.1
  (package
    (name "rust-netmap-sys")
    (version "0.1.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "netmap_sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wgwjx2hdqbjvdpccqb0cg4gjxazgxfz8s966bq5g8z56xik95a5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1)
                       ("rust-libc" ,rust-libc-0.2))))
    (home-page "http://info.iet.unipi.it/~luigi/netmap/")
    (synopsis "Bindings to netmap - the fast packet I/O framework")
    (description "Bindings to netmap - the fast packet I/O framework")
    (license license:bsd-2)))

(define rust-pnet-datalink-0.27
  (package
    (name "rust-pnet-datalink")
    (version "0.27.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "pnet_datalink" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1iws7c2mf88ip43ccmr5p8r6kzb6lwsg3amgc4pvy8wx9nf1q02r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ipnetwork" ,rust-ipnetwork-0.17)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-netmap-sys" ,rust-netmap-sys-0.1)
                       ("rust-pcap" ,rust-pcap-0.7)
                       ("rust-pnet-base" ,rust-pnet-base-0.27)
                       ("rust-pnet-sys" ,rust-pnet-sys-0.27)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/libpnet/libpnet")
    (synopsis "Cross-platform, datalink layer networking.")
    (description "Cross-platform, datalink layer networking.")
    (license (list license:expat license:asl2.0))))

(define rust-hyper-0.14
  (package
    (name "rust-hyper")
    (version "0.14.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hyper" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0g5x39g53wqpdhbp5zcjhizjf7qbnsq2y6mg3g5nc8cxmkx12iq3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-bytes" ,rust-bytes-1)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-h2" ,rust-h2-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-http-body" ,rust-http-body-0.4)
                       ("rust-httparse" ,rust-httparse-1)
                       ("rust-httpdate" ,rust-httpdate-1)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-want" ,rust-want-0.3))
       #:cargo-development-inputs (("rust-futures-util" ,rust-futures-util-0.3)
                                   ("rust-matches" ,rust-matches-0.1)
                                   ("rust-num-cpus" ,rust-num-cpus-1)
                                   ("rust-pnet-datalink" ,rust-pnet-datalink-0.27)
                                   ("rust-pretty-env-logger" ,rust-pretty-env-logger-0.4)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-spmc" ,rust-spmc-0.3)
                                   ("rust-tokio" ,rust-tokio-1)
                                   ("rust-tokio-test" ,rust-tokio-test-0.4)
                                   ("rust-tokio-util" ,rust-tokio-util-0.7)
                                   ("rust-tower" ,rust-tower-0.4)
                                   ("rust-url" ,rust-url-2))))
    (home-page "https://hyper.rs")
    (synopsis "A fast and correct HTTP library.")
    (description "This package provides a fast and correct HTTP library.")
    (license license:expat)))

(define rust-regex-1
  (package
    (name "rust-regex")
    (version "1.5.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1wczbykw6fas7359j9lhkkv13dplhiphzrf2ii6dmg5xjiyi4gyq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-aho-corasick" ,rust-aho-corasick-0.7)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-regex-syntax" ,rust-regex-syntax-0.6))
       #:cargo-development-inputs (("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-quickcheck" ,rust-quickcheck-1)
                                   ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://github.com/rust-lang/regex")
    (synopsis
     "An implementation of regular expressions for Rust. This implementation uses
finite automata and guarantees linear time matching on all inputs.
")
    (description
     "An implementation of regular expressions for Rust.  This implementation uses
finite automata and guarantees linear time matching on all inputs.")
    (license (list license:expat license:asl2.0))))

(define rust-rustls-pemfile-0.3
  (package
    (name "rust-rustls-pemfile")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustls-pemfile" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0q3k136sna6yhq98js7n7lf341w47j6gxzin2lfncz1ajxinvs0y"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-base64" ,rust-base64-0.13))))
    (home-page "https://github.com/rustls/pemfile")
    (synopsis "Basic .pem file parser for keys and certificates")
    (description "Basic .pem file parser for keys and certificates")
    (license (list license:asl2.0 license:isc license:expat))))

(define rust-enum-as-inner-0.4
  (package
    (name "rust-enum-as-inner")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "enum-as-inner" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0wwvjmy2bvqqc3pyylsmlqpkswxrzsg40xva7z27szva8j0svk91"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/bluejekyll/enum-as-inner")
    (synopsis
     "A proc-macro for deriving inner field accessor functions on enums.
")
    (description
     "This package provides a proc-macro for deriving inner field accessor functions
on enums.")
    (license (list license:expat license:asl2.0))))

(define rust-trust-dns-proto-0.21
  (package
    (name "rust-trust-dns-proto")
    (version "0.21.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "trust-dns-proto" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0p95ig8dfp30ga6gz01m683zy33abbna0givpgac6xwqym0g4ccw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-data-encoding" ,rust-data-encoding-2)
                       ("rust-enum-as-inner" ,rust-enum-as-inner-0.4)
                       ("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-io" ,rust-futures-io-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-h2" ,rust-h2-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-idna" ,rust-idna-0.2)
                       ("rust-ipnet" ,rust-ipnet-2)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-ring" ,rust-ring-0.16)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tinyvec" ,rust-tinyvec-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-url" ,rust-url-2)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-webpki" ,rust-webpki-0.22)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://trust-dns.org/")
    (synopsis
     "Trust-DNS is a safe and secure DNS library. This is the foundational DNS protocol library for all Trust-DNS projects.
")
    (description
     "Trust-DNS is a safe and secure DNS library.  This is the foundational DNS
protocol library for all Trust-DNS projects.")
    (license (list license:expat license:asl2.0))))

(define rust-trust-dns-resolver-0.21
  (package
    (name "rust-trust-dns-resolver")
    (version "0.21.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "trust-dns-resolver" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0n6m9yvhaip8dml5247d6qqdzf8bcrn4rvzwr685clc4xb175fp4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-ipconfig" ,rust-ipconfig-0.3)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-lru-cache" ,rust-lru-cache-0.1)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-resolv-conf" ,rust-resolv-conf-0.7)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-trust-dns-proto" ,rust-trust-dns-proto-0.21)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page "https://trust-dns.org/")
    (synopsis
     "Trust-DNS is a safe and secure DNS library. This Resolver library  uses the Client library to perform all DNS queries. The Resolver is intended to be a high-level library for any DNS record resolution see Resolver and AsyncResolver for supported resolution types. The Client can be used for other queries.
")
    (description
     "Trust-DNS is a safe and secure DNS library.  This Resolver library uses the
Client library to perform all DNS queries.  The Resolver is intended to be a
high-level library for any DNS record resolution see Resolver and
@code{AsyncResolver} for supported resolution types.  The Client can be used for
other queries.")
    (license (list license:expat license:asl2.0))))

(define rust-reqwest-0.11.11
  (package
    (name "rust-reqwest")
    (version "0.11.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "reqwest" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14mz9w3jf2jq1kv3606an637lvrw4npz4fp3xmkcrfq67ydacnmp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-async-compression" ,rust-async-compression-0.3)
                       ("rust-base64" ,rust-base64-0.13)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-cookie" ,rust-cookie-0.16)
                       ("rust-cookie-store" ,rust-cookie-store-0.16)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-h2" ,rust-h2-0.3)
                       ("rust-http" ,rust-http-0.2)
                       ("rust-http-body" ,rust-http-body-0.4)
                       ("rust-hyper" ,rust-hyper-0.14)
                       ("rust-hyper-rustls" ,rust-hyper-rustls-0.23)
                       ("rust-hyper-tls" ,rust-hyper-tls-0.5)
                       ("rust-ipnet" ,rust-ipnet-2)
                       ("rust-js-sys" ,rust-js-sys-0.3)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-proc-macro-hack" ,rust-proc-macro-hack-0.5)
                       ("rust-rustls" ,rust-rustls-0.20)
                       ("rust-rustls-native-certs" ,rust-rustls-native-certs-0.6)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-native-tls" ,rust-tokio-native-tls-0.3)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
                       ("rust-tokio-socks" ,rust-tokio-socks-0.5)
                       ("rust-tokio-util" ,rust-tokio-util-0.7)
                       ("rust-tower-service" ,rust-tower-service-0.3)
                       ("rust-trust-dns-resolver" ,rust-trust-dns-resolver-0.21)
                       ("rust-url" ,rust-url-2)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-wasm-bindgen-futures" ,rust-wasm-bindgen-futures-0.4)
                       ("rust-web-sys" ,rust-web-sys-0.3)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22)
                       ("rust-winreg" ,rust-winreg-0.10))
       #:cargo-development-inputs (("rust-brotli" ,rust-brotli-3)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-env-logger" ,rust-env-logger-0.8)
                                   ("rust-hyper" ,rust-hyper-0.14)
                                   ("rust-libflate" ,rust-libflate-1)
                                   ("rust-serde" ,rust-serde-1)
                                   ("rust-tokio" ,rust-tokio-1)
                                   ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                                   ("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3))))
    (home-page "https://github.com/seanmonstar/reqwest")
    (synopsis "higher level HTTP client library")
    (description "higher level HTTP client library")
    (license (list license:expat license:asl2.0))))

(define rust-rustls-0.21.2
  (package
    (name "rust-rustls")
    (version "0.21.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustls" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pvz4ji4m0sgq8mkrcla1c4r076zvcbaacww76zipg4lys5a4b73"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-ring" ,rust-ring-0.16)
                       ("rust-rustls-webpki" ,rust-rustls-webpki-0.100)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-sct" ,rust-sct-0.7))
       #:cargo-development-inputs (("rust-base64" ,rust-base64-0.21)
                                   ("rust-bencher" ,rust-bencher-0.1)
                                   ("rust-env-logger" ,rust-env-logger-0.10)
                                   ("rust-log" ,rust-log-0.4)
                                   ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
                                   ("rust-webpki-roots" ,rust-webpki-roots-0.23))))
    (home-page "https://github.com/rustls/rustls")
    (synopsis "Rustls is a modern TLS library written in Rust.")
    (description "Rustls is a modern TLS library written in Rust.")
    (license (list license:asl2.0 license:isc license:expat))))

(define rust-uuid-1
  (package
    (name "rust-uuid")
    (version "1.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uuid" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0k6fchay62ryjhkxsbbj38030lm3797c13vsp54bkd9ij3gf0bj2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-atomic" ,rust-atomic-0.5)
                       ("rust-getrandom" ,rust-getrandom-0.2)
                       ("rust-md-5" ,rust-md-5-0.10)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-sha1-smol" ,rust-sha1-smol-1)
                       ("rust-slog" ,rust-slog-2)
                       ("rust-uuid-macro-internal" ,rust-uuid-macro-internal-1)
                       ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                       ("rust-zerocopy" ,rust-zerocopy-0.6))
       #:cargo-development-inputs (("rust-bincode" ,rust-bincode-1)
                                   ("rust-rustversion" ,rust-rustversion-1)
                                   ("rust-serde-derive" ,rust-serde-derive-1)
                                   ("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-serde-test" ,rust-serde-test-1)
                                   ("rust-trybuild" ,rust-trybuild-1)
                                   ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
                                   ("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3)
                                   ("rust-windows-sys" ,rust-windows-sys-0.42))))
    (home-page "https://github.com/uuid-rs/uuid")
    (synopsis "A library to generate and parse UUIDs.")
    (description
     "This package provides a library to generate and parse UUIDs.")
    (license (list license:asl2.0 license:expat))))

(define rust-rustls-pemfile-1.01
  (package
    (name "rust-rustls-pemfile")
    (version "1.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustls-pemfile" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mdxhxp73vxh5pqk5nx2xdxg1z1xkn1yzrc6inh5mh7qagzswr08"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-base64" ,rust-base64-0.13))
       #:cargo-development-inputs (("rust-criterion" ,rust-criterion-0.3))))
    (home-page "https://github.com/rustls/pemfile")
    (synopsis "Basic .pem file parser for keys and certificates")
    (description "Basic .pem file parser for keys and certificates")
    (license (list license:asl2.0 license:isc license:expat))))

(define rust-webpki-roots-0.22.6
  (package
    (name "rust-webpki-roots")
    (version "0.22.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "webpki-roots" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11rd1aj73qzcvdj3x78crm1758sc4wrbc7rh0r8lmhyjsx01xixn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-webpki" ,rust-webpki-0.22))))
    (home-page "https://github.com/rustls/webpki-roots")
    (synopsis "Mozilla's CA root certificates for use with webpki")
    (description "Mozilla's CA root certificates for use with webpki")
    (license license:mpl2.0)))

(define rust-futures-0.3.25
  (package
    (name "rust-futures")
    (version "0.3.25")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "futures" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c0v0lv6fgr95k1nw26n2v9vb40j7k32jg558m8pmhrxfq202f9q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-futures-channel" ,rust-futures-channel-0.3)
                       ("rust-futures-core" ,rust-futures-core-0.3)
                       ("rust-futures-executor" ,rust-futures-executor-0.3)
                       ("rust-futures-io" ,rust-futures-io-0.3)
                       ("rust-futures-sink" ,rust-futures-sink-0.3)
                       ("rust-futures-task" ,rust-futures-task-0.3)
                       ("rust-futures-util" ,rust-futures-util-0.3))
       #:cargo-development-inputs (("rust-assert-matches" ,rust-assert-matches-1)
                                   ("rust-pin-project" ,rust-pin-project-1)
                                   ("rust-pin-utils" ,rust-pin-utils-0.1)
                                   ("rust-static-assertions" ,rust-static-assertions-1)
                                   ("rust-tokio" ,rust-tokio-0.1))))
    (home-page "https://rust-lang.github.io/futures-rs")
    (synopsis
     "An implementation of futures and streams featuring zero allocations,
composability, and iterator-like interfaces.
")
    (description
     "An implementation of futures and streams featuring zero allocations,
composability, and iterator-like interfaces.")
    (license (list license:expat license:asl2.0))))

(define rust-mio-aio-0.6
  (package
    (name "rust-mio-aio")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "mio-aio" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1z7s0swv1pgvzmn8gaj7cdgid75y3bcklcyqc2b9ihsvxpc6wcca"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-mio" ,rust-mio-0.7)
                       ("rust-nix" ,rust-nix-0.22))))
    (home-page "https://github.com/asomers/mio-aio")
    (synopsis "POSIX AIO bindings for mio
")
    (description "POSIX AIO bindings for mio")
    (license (list license:expat license:asl2.0))))

(define rust-tokio-1.21
  (package
    (name "rust-tokio")
    (version "1.21.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tokio" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16chkl1wabwinnqya4zrjz7a1wn6mb20s699lwmp0mf9gm4krq59"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-mio" ,rust-mio-0.8)
                       ("rust-num-cpus" ,rust-num-cpus-1)
                       ("rust-parking-lot" ,rust-parking-lot-0.12)
                       ("rust-pin-project-lite" ,rust-pin-project-lite-0.2)
                       ("rust-signal-hook-registry" ,rust-signal-hook-registry-1)
                       ("rust-socket2" ,rust-socket2-0.4)
                       ("rust-tokio-macros" ,rust-tokio-macros-1)
                       ("rust-tracing" ,rust-tracing-0.1)
                       ("rust-winapi" ,rust-winapi-0.3))
       #:cargo-development-inputs (("rust-async-stream" ,rust-async-stream-0.3)
                                   ("rust-futures" ,rust-futures-0.3)
                                   ("rust-libc" ,rust-libc-0.2)
                                   ("rust-loom" ,rust-loom-0.5)
                                   ("rust-mio-aio" ,rust-mio-aio-0.6)
                                   ("rust-mockall" ,rust-mockall-0.11)
                                   ("rust-nix" ,rust-nix-0.24)
                                   ("rust-ntapi" ,rust-ntapi-0.3)
                                   ("rust-proptest" ,rust-proptest-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-socket2" ,rust-socket2-0.4)
                                   ("rust-tempfile" ,rust-tempfile-3)
                                   ("rust-tokio-stream" ,rust-tokio-stream-0.1)
                                   ("rust-tokio-test" ,rust-tokio-test-0.4)
                                   ("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3))))
    (home-page "https://tokio.rs")
    (synopsis
     "An event-driven, non-blocking I/O platform for writing asynchronous I/O
backed applications.
")
    (description
     "An event-driven, non-blocking I/O platform for writing asynchronous I/O backed
applications.")
    (license license:expat)))

(define rust-hyper-tungstenite-0.11
  (package
    (name "rust-hyper-tungstenite")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hyper-tungstenite" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1sb7pb5wh2znk1dsfyz526djgbvf362yglx7jclrsrqfxzp1s7j3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-hyper" ,rust-hyper-0.14)
                       ("rust-pin-project" ,rust-pin-project-1)
                       ("rust-tokio" ,rust-tokio-1)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.20)
                       ("rust-tungstenite" ,rust-tungstenite-0.20))
;       #:cargo-development-inputs (("rust-assert2" ,rust-assert2-0.3)
;                                   ("rust-futures" ,rust-futures-0.3)
;                                   ("rust-hyper" ,rust-hyper-0.14)
;                                   ("rust-tokio" ,rust-tokio-1))
       ))
    (home-page "https://github.com/de-vri-es/hyper-tungstenite-rs")
    (synopsis "websockets for hyper servers using tungstenite")
    (description "websockets for hyper servers using tungstenite")
    (license license:bsd-2)))


(define-public rust-lite-farmer
  (package
    (name "rust-lite-farmer")
    (version "1.0.0")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/jamartin9/cult-lite-farmer")
            (commit "3fd841f9def05e16d0bc3368d4e8c8e2f8e479bc")
            (recursive? #true)
            ))
      (file-name (git-file-name name version))
      (sha256
       (base32 "0ndad1g7jcx3s62s0s8bp1h9lz6cx0nh48qh53cxwq8qgkf5j0y4"))
      (patches (search-patches "lite-farmer-workspace.patch"))))
    (build-system cargo-build-system)
    (arguments
     `(#:tests? #f
       #:install-source? #f
       #:phases (modify-phases %standard-phases
                               (replace 'install
                                        (lambda* (#:key inputs outputs skip-build? install-source? features #:allow-other-keys)
                                          (let* ((out      (assoc-ref outputs "out"))
                                                 (registry (string-append out "/share/cargo/registry"))
                                                 (sources  (string-append out "/share/cargo/src")))
                                            (mkdir-p out) ;; reuse artifacts and install path for workspace
                                            (setenv "CARGO_TARGET_DIR" "./target")
                                            (invoke "cargo" "install" "--no-track" "--path" "./lite-farmer/" "--root" out "--features" (string-join features))
                                            #t))))
       #:cargo-inputs (("rust-dialoguer" ,rust-dialoguer-0.10)
                       ("rust-clap" ,rust-clap-4)
                       ("rust-async-trait" ,rust-async-trait-0.1)
                       ("rust-bech32" ,rust-bech32-0.9)
                       ("rust-bip39" ,rust-bip39-2)
                       ("rust-blst" ,rust-blst-0.3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-dg-xch-cli" ,rust-dg-xch-cli-1)
                       ("rust-dg-xch-clients" ,rust-dg-xch-clients-1)
                       ("rust-dg-xch-core" ,rust-dg-xch-core-1)
                       ("rust-dg-xch-keys" ,rust-dg-xch-keys-1)
                       ("rust-dg-xch-pos" ,rust-dg-xch-pos-1)
                       ("rust-dg-xch-puzzles" ,rust-dg-xch-puzzles-1)
                       ("rust-dg-xch-serialize" ,rust-dg-xch-serialize-1)
                       ("rust-futures-util" ,rust-futures-util-0.3)
                       ("rust-futures" ,rust-futures-0.3.25)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-hkdf" ,rust-hkdf-0.12)
                       ("rust-hyper" ,rust-hyper-0.14)
                       ("rust-hyper-tungstenite" ,rust-hyper-tungstenite-0.11)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nix" ,rust-nix-0.26)
                       ("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-integer" ,rust-num-integer-0.1)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-openssl" ,rust-openssl-0.10)
                       ("rust-paperclip" ,rust-paperclip-0.8)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-reqwest" ,rust-reqwest-0.11.11)
                       ("rust-rustls" ,rust-rustls-0.21.2)
                       ("rust-rustls-pemfile" ,rust-rustls-pemfile-1.01)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.9)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-simple-logger" ,rust-simple-logger-4)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tokio" ,rust-tokio-1.21)
                       ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
                       ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.20)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-webpki-roots" ,rust-webpki-roots-0.22.6)
                       )))
    (native-inputs ; rust-ring needs perl ; maybe prop openssl
     (list perl pkg-config openssl)); python-2 clang
    ;(propagated-inputs
    ; (list openssl))
    (home-page "https://github.com/jamartin9/cult-lite-farmer")
    (synopsis
     "Lite Farmer and Harvester for the Chia Blockchain")
    (description
     "Lite Farmer and Harvester for the Chia Blockchain")
    (license license:asl2.0)))

;rust-lite-farmer ;; TODO debug SSL cert issues
