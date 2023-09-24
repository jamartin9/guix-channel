(define-module (jam packages bottom)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crates-graphics)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  ;#:use-module (nongnu packages nvidia) ; TODO add nvml support for nvidia-libs
  )

(define rust-cargo-husky-1
  (package
    (name "rust-cargo-husky")
    (version "1.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cargo-husky" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1b9jx720dzw9s7rl82bywz4d089c9rb0j526c1jfzs1g4llvc0kv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rhysd/cargo-husky#readme")
    (synopsis "husky for cargo")
    (description "husky for cargo")
    (license license:expat)))
 
(define rust-termtree-0.4
  (package
    (name "rust-termtree")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "termtree" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xkal5l2r3r9p9j90x35qy4npbdwxz4gskvbijs6msymaangas9k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/termtree")
    (synopsis "Visualize tree-like data on the command-line")
    (description "Visualize tree-like data on the command-line")
    (license license:expat)))
 
(define rust-predicates-tree-1
  (package
    (name "rust-predicates-tree")
    (version "1.0.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "predicates-tree" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1kyfq3r0s2vg94a9r59n7ar5gv66zvpa0s1fd6mm4l4czcas72rn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-predicates-core" ,rust-predicates-core-1)
                       ("rust-termtree" ,rust-termtree-0.4))))
    (home-page
     "https://github.com/assert-rs/predicates-rs/tree/master/crates/tree")
    (synopsis "Render boolean-valued predicate functions results as a tree.")
    (description
     "Render boolean-valued predicate functions results as a tree.")
    (license (list license:expat license:asl2.0))))
 
(define rust-predicates-core-1
  (package
    (name "rust-predicates-core")
    (version "1.0.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "predicates-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0x7ij95n63mhgkyrb7hly5ngm41mwfsassfvnjz7lbk10wk0755p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page
     "https://github.com/assert-rs/predicates-rs/tree/master/crates/core")
    (synopsis "An API for boolean-valued predicate functions.")
    (description "An API for boolean-valued predicate functions.")
    (license (list license:expat license:asl2.0))))
 
(define rust-predicates-3
  (package
    (name "rust-predicates")
    (version "3.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "predicates" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1adisi9k48w8sf82cip7njy5rmx25d5fsz010i61hrzlp5ak75h9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-1)
                       ("rust-difflib" ,rust-difflib-0.4)
                       ("rust-float-cmp" ,rust-float-cmp-0.9)
                       ("rust-itertools" ,rust-itertools-0.10)
                       ("rust-normalize-line-endings" ,rust-normalize-line-endings-0.3)
                       ("rust-predicates-core" ,rust-predicates-core-1)
                       ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/assert-rs/predicates-rs")
    (synopsis "An implementation of boolean-valued predicate functions.")
    (description "An implementation of boolean-valued predicate functions.")
    (license (list license:expat license:asl2.0))))
 
(define rust-bstr-1
  (package
    (name "rust-bstr")
    (version "1.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bstr" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xafaq57fzwa38yjwdzvqlbm8h207sjm585y4kdxjv1znj5ycim2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-memchr" ,rust-memchr-2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-regex-automata" ,rust-regex-automata-0.1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/BurntSushi/bstr")
    (synopsis "A string type that is not required to be valid UTF-8.")
    (description
     "This package provides a string type that is not required to be valid UTF-8.")
    (license (list license:expat license:asl2.0))))
 
(define rust-assert-cmd-2
  (package
    (name "rust-assert-cmd")
    (version "2.0.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "assert_cmd" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1rnzd84nqijp147nld05j5j92xpj2j57zfrm6c0d9r138yqkr448"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstream" ,rust-anstream-0.3)
                       ("rust-anstyle" ,rust-anstyle-1)
                       ("rust-bstr" ,rust-bstr-1)
                       ("rust-doc-comment" ,rust-doc-comment-0.3)
                       ("rust-predicates" ,rust-predicates-3)
                       ("rust-predicates-core" ,rust-predicates-core-1)
                       ("rust-predicates-tree" ,rust-predicates-tree-1)
                       ("rust-wait-timeout" ,rust-wait-timeout-0.2))))
    (home-page "https://github.com/assert-rs/assert_cmd")
    (synopsis "Test CLI Applications.")
    (description "Test CLI Applications.")
    (license (list license:expat license:asl2.0))))
 
(define rust-windows-interface-0.48
  (package
    (name "rust-windows-interface")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-interface" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1iqcilw0hfyzwhk12xfmcy40r10406sgf4xmdansijlv1kr8vyz6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The interface macro for the windows crate")
    (description "The interface macro for the windows crate")
    (license (list license:expat license:asl2.0))))
 
(define rust-windows-implement-0.48
  (package
    (name "rust-windows-implement")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-implement" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1764n853zd7bb0wn94i0qxfs6kdy7wrz7v9qhdn7x7hvk64fabjy"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The implement macro for the windows crate")
    (description "The implement macro for the windows crate")
    (license (list license:expat license:asl2.0))))

(define rust-windows-core-0.51
  (package
    (name "rust-windows-core")
    (version "0.51.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0r1f57hsshsghjyc7ypp2s0i78f7b1vr93w68sdb8baxyf2czy7i"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-targets" ,rust-windows-targets-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-0.51
  (package
    (name "rust-windows")
    (version "0.51.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ja500kr2pdvz9lxqmcr7zclnnwpvw28z78ypkrc4f7fqlb9j8na"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-core" ,rust-windows-core-0.51)
                       ("rust-windows-implement" ,rust-windows-implement-0.51)
                       ("rust-windows-interface" ,rust-windows-interface-0.51)
                       ("rust-windows-targets" ,rust-windows-targets-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define rust-windows-0.48
  (package
    (name "rust-windows")
    (version "0.48.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03vh89ilnxdxdh0n9np4ns4m10fvm93h3b0cc05ipg3qq1mqi1p6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-implement" ,rust-windows-implement-0.48)
                       ("rust-windows-interface" ,rust-windows-interface-0.48)
                       ("rust-windows-targets" ,rust-windows-targets-0.48))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))
 
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
 
(define rust-concolor-query-0.3
  (package
    (name "rust-concolor-query")
    (version "0.3.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "concolor-query" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ks4g514kx31nnv3bxa7cj5xgg6vwkljn8a001njxjnpqd91vlc8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/rust-cli/concolor")
    (synopsis "Look up colored console capabilities")
    (description "Look up colored console capabilities")
    (license (list license:expat license:asl2.0))))
 
(define rust-concolor-override-1
  (package
    (name "rust-concolor-override")
    (version "1.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "concolor-override" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "140yb63zrbdvxvy3zaqvldgrjh5rm9qijy14w0imk7g3i1995920"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-colorchoice" ,rust-colorchoice-1))))
    (home-page "https://github.com/rust-cli/concolor")
    (synopsis "Global override of color control")
    (description "Global override of color control")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-wincon-0.2
  (package
    (name "rust-anstyle-wincon")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-wincon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yil703c9gp5hn1d8fn5m3dr4mlwml80v6mvhwr9y52v2kv7l4n3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-0.3)
                       ("rust-windows-sys" ,rust-windows-sys-0.45))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Styling legacy Windows terminals")
    (description "Styling legacy Windows terminals")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-parse-0.1
  (package
    (name "rust-anstyle-parse")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-parse" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05h1zy6y2ha2k8cnah9s0a296w2g3bfyfi2z7r7x3zly9r9vpld7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Parse ANSI Style Escapes")
    (description "Parse ANSI Style Escapes")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-stream-0.2
  (package
    (name "rust-anstyle-stream")
    (version "0.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-stream" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1l695l55mwxfz3iaw524cy89j57bm5y9y8xv63z5bldslmmrd0qk"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-0.3)
                       ("rust-anstyle-parse" ,rust-anstyle-parse-0.1)
                       ("rust-anstyle-wincon" ,rust-anstyle-wincon-0.2)
                       ("rust-concolor-override" ,rust-concolor-override-1)
                       ("rust-concolor-query" ,rust-concolor-query-0.3)
                       ("rust-is-terminal" ,rust-is-terminal-0.4)
                       ("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis
     "A simple cross platform library for writing colored text to a terminal.")
    (description
     "This package provides a simple cross platform library for writing colored text
to a terminal.")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-0.3
  (package
    (name "rust-anstyle")
    (version "0.3.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ll42s5ch4ldp0fw8laidqji540p7higd06h2v111qq2pn0rxsi3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "ANSI text styling")
    (description "ANSI text styling")
    (license (list license:expat license:asl2.0))))
 
(define rust-winnow-0.5
  (package
    (name "rust-winnow")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "winnow" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0r0yyq4c0kp945jm3vnb0mg1p2gcx27c70shw40v3ckk00cs3amc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (;("rust-anstyle" ,rust-anstyle-0.3)
                       ;("rust-anstyle-stream" ,rust-anstyle-stream-0.2)
                       ("rust-anstream" ,rust-anstream-0.3)
                       ("rust-anstyle" ,rust-anstyle-1)
                       ("rust-is-terminal" ,rust-is-terminal-0.4)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-terminal-size" ,rust-terminal-size-0.2))))
    (home-page "https://github.com/winnow-rs/winnow")
    (synopsis "A byte-oriented, zero-copy, parser combinators library")
    (description
     "This package provides a byte-oriented, zero-copy, parser combinators library")
    (license license:expat)))
 
(define rust-toml-datetime-0.6
  (package
    (name "rust-toml-datetime")
    (version "0.6.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "toml_datetime" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jsy7v8bdvmzsci6imj8fzgd255fmy5fzp6zsri14yrry7i77nkw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis "A TOML-compatible datetime type")
    (description "This package provides a TOML-compatible datetime type")
    (license (list license:expat license:asl2.0))))
 
(define rust-serde-spanned-0.6
  (package
    (name "rust-serde-spanned")
    (version "0.6.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_spanned" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11p1l83r5g3k18pi88cqri2r9ai03pm8b4azj4j02ypx6scnqhln"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis "Serde-compatible spanned Value")
    (description "Serde-compatible spanned Value")
    (license (list license:expat license:asl2.0))))
 
(define rust-toml-edit-0.19
  (package
    (name "rust-toml-edit")
    (version "0.19.14")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "toml_edit" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12hf91s6mrvjpa0d40j3nibryddyc2szs857zcylm5v9x4kky4pq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
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

(define rust-deranged-0.3
  (package
    (name "rust-deranged")
    (version "0.3.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "deranged" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ag9ynv5s33nw485f7kgamwl2nqzpjafcbkvxx9ph6dgn6gs913n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-rand" ,rust-rand-0.8)
                                   ("rust-serde-json" ,rust-serde-json-1))))
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
 
(define rust-thiserror-impl-1
  (package
    (name "rust-thiserror-impl")
    (version "1.0.47")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror-impl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16z1irxb45l011af53diap97x44dixnbp60v9g6pvarrdssj7dkb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/dtolnay/thiserror")
    (synopsis "Implementation detail of the `thiserror` crate")
    (description "Implementation detail of the `thiserror` crate")
    (license (list license:expat license:asl2.0))))
 
(define rust-thiserror-1
  (package
    (name "rust-thiserror")
    (version "1.0.47")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13wdsrdyrq6x3rcydvxlx4mxck0c5v3mz1dj8zp7xhdg63n05a4p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-thiserror-impl" ,rust-thiserror-impl-1))))
    (home-page "https://github.com/dtolnay/thiserror")
    (synopsis "derive(Error)")
    (description "derive(Error)")
    (license (list license:expat license:asl2.0))))
 
(define rust-ntapi-0.4
  (package
    (name "rust-ntapi")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ntapi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1r38zhbwdvkis2mzs6671cm1p6djgsl49i7bwxzrvhwicdf8k8z8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/MSxDOS/ntapi")
    (synopsis "FFI bindings for Native API")
    (description "FFI bindings for Native API")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sysinfo-0.29
  (package
    (name "rust-sysinfo")
    (version "0.29.8")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sysinfo" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0a3mhvkhj61ldk7gapgigz3ryma3rgysg2fjani3afk64afdf3ni"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-ntapi" ,rust-ntapi-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/GuillaumeGomez/sysinfo")
    (synopsis
     "Library to get system information such as processes, CPUs, disks, components and networks")
    (description
     "Library to get system information such as processes, CPUs, disks, components and
networks")
    (license license:expat)))
 
(define rust-sysctl-0.5
  (package
    (name "rust-sysctl")
    (version "0.5.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sysctl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ghxnlffv8xc65hgr84pr3gbnyjvi5khgjcv51cncrdxrjidcrpd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-enum-as-inner" ,rust-enum-as-inner-0.5)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/johalun/sysctl-rs")
    (synopsis "Simplified interface to libc::sysctl")
    (description "Simplified interface to libc::sysctl")
    (license license:expat)))
 
(define rust-serde-derive-internals-0.26
  (package
    (name "rust-serde-derive-internals")
    (version "0.26.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_derive_internals" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0g2zdr6s8i0r29yy7pdl6ahimq8w6ck70hvrciiry2ljwwlq5gw5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://serde.rs")
    (synopsis "AST representation used by Serde derive macros. Unstable.")
    (description "AST representation used by Serde derive macros.  Unstable.")
    (license (list license:expat license:asl2.0))))
 
(define rust-schemars-derive-0.8
  (package
    (name "rust-schemars-derive")
    (version "0.8.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "schemars_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0z2yahra4mbxf29zz02bg5r9b5bz1jcm56drdpmqshwpn7ka378h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-serde-derive-internals" ,rust-serde-derive-internals-0.26)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://graham.cool/schemars/")
    (synopsis "Macros for #[derive(JsonSchema)], for use with schemars")
    (description "Macros for #[derive(JsonSchema)], for use with schemars")
    (license license:expat)))
 
(define rust-schemars-0.8
  (package
    (name "rust-schemars")
    (version "0.8.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "schemars" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0kz41p88zdrh0rmabldi8qkpbgjz3kdx9ny5zp1z1r92hql17ih2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.5)
                       ("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-bigdecimal" ,rust-bigdecimal-0.3)
                       ("rust-bytes" ,rust-bytes-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-dyn-clone" ,rust-dyn-clone-1)
                       ("rust-either" ,rust-either-1)
                       ("rust-enumset" ,rust-enumset-1)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-rust-decimal" ,rust-rust-decimal-1)
                       ("rust-schemars-derive" ,rust-schemars-derive-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-smallvec" ,rust-smallvec-1)
                       ("rust-smol-str" ,rust-smol-str-0.1)
                       ("rust-url" ,rust-url-2)
                       ("rust-uuid" ,rust-uuid-0.8)
                       ("rust-uuid" ,rust-uuid-1))))
    (home-page "https://graham.cool/schemars/")
    (synopsis "Generate JSON Schemas from Rust code")
    (description "Generate JSON Schemas from Rust code")
    (license license:expat)))

 (define rust-uom-0.35
  (package
    (name "rust-uom")
    (version "0.35.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uom" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cl7853v99bpzrwcn6102gvj8gysw7b768anyfksficqg961jql3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-complex" ,rust-num-complex-0.4)
                       ("rust-num-rational" ,rust-num-rational-0.4)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-typenum" ,rust-typenum-1))))
    (home-page "https://github.com/iliekturtles/uom")
    (synopsis "Units of measurement")
    (description "Units of measurement")
    (license (list license:asl2.0 license:expat))))

(define rust-starship-battery-0.8
  (package
    (name "rust-starship-battery")
    (version "0.8.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "starship-battery" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03jm5jfvrb7hkpymscg5lwrzbdqh6110fj02s958ncm5bddmncrn"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-core-foundation" ,rust-core-foundation-0.9)
                       ("rust-lazycell" ,rust-lazycell-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-nix" ,rust-nix-0.26)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-schemars" ,rust-schemars-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-uom" ,rust-uom-0.35)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/starship/rust-battery")
    (synopsis "Cross-platform information about the notebook batteries")
    (description "Cross-platform information about the notebook batteries")
    (license license:isc)))
 
(define rust-equivalent-1
  (package
    (name "rust-equivalent")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "equivalent" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18f0q7vd4awiv9bv5mda5yv8lfhpzxspiq8f2jdjqhw0bnygxgw8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/cuviper/equivalent")
    (synopsis "Traits for key comparison in maps.")
    (description "Traits for key comparison in maps.")
    (license (list license:asl2.0 license:expat))))
 
(define rust-indexmap-2
  (package
    (name "rust-indexmap")
    (version "2.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "indexmap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0pdnbvv6gnyxx2li8mks8p00fya3ynmhx3n6infpcy8a4gi7yiym"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustc-rayon" ,rust-rustc-rayon-0.5)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/bluss/indexmap")
    (synopsis "A hash table with consistent order and fast iteration.")
    (description
     "This package provides a hash table with consistent order and fast iteration.")
    (license (list license:asl2.0 license:expat))))
 
(define rust-serde-json-1
  (package
    (name "rust-serde-json")
    (version "1.0.105")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_json" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0q73miix7rmja8vss57s42dm7a2xpngyx7gcpinksmi7mkhm2cb9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-ryu" ,rust-ryu-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/serde-rs/json")
    (synopsis "A JSON serialization file format")
    (description "This package provides a JSON serialization file format")
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
       #:cargo-inputs (("rust-serde-derive" ,rust-serde-derive-1))))
    (home-page "https://serde.rs")
    (synopsis "A generic serialization/deserialization framework")
    (description
     "This package provides a generic serialization/deserialization framework")
    (license (list license:expat license:asl2.0))))
 
(define rust-regex-syntax-0.7
  (package
    (name "rust-regex-syntax")
    (version "0.7.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex-syntax" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1nhjmqdlakfi4yb8lh7vbbh71dsy90jjvrjvvnrih6larldgpdfv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-lang/regex")
    (synopsis "A regular expression parser.")
    (description "This package provides a regular expression parser.")
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

(define rust-regex-automata-0.3
  (package
    (name "rust-regex-automata")
    (version "0.3.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex-automata" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ag66r1k32q4gfkj2rmfx3jfhn50dfxkz23f91dnxq9nl4408ls9"))))
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

(define rust-regex-1
  (package
    (name "rust-regex")
    (version "1.9.4")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "regex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0a8sg48nhskdygki42z9r6q8z7by4876bpay56qs8psfhpzjxphj"))))
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

(define rust-unicode-segmentation-1
  (package
    (name "rust-unicode-segmentation")
    (version "1.10.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "unicode-segmentation" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0dky2hm5k51xy11hc3nk85p533rvghd462b6i0c532b7hl4j9mhx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/unicode-rs/unicode-segmentation")
    (synopsis
     "This crate provides Grapheme Cluster, Word and Sentence boundaries
according to Unicode Standard Annex #29 rules.
")
    (description
     "This crate provides Grapheme Cluster, Word and Sentence boundaries according to
Unicode Standard Annex #29 rules.")
    (license (list license:expat license:asl2.0))))
 
(define rust-deltae-0.3
  (package
    (name "rust-deltae")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "deltae" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0lws5fg4gjvm8g60lk8hwy6d34ivsdlaqff8asxbk253q3i13wry"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://gitlab.com/ryanobeirne/deltae")
    (synopsis "Calculate Delta E between two colors in CIE Lab space.")
    (description "Calculate Delta E between two colors in CIE Lab space.")
    (license license:expat)))
 
(define rust-phf-shared-0.11
  (package
    (name "rust-phf-shared")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf_shared" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0azphb0a330ypqx3qvyffal5saqnks0xvl8rj73jlk3qxxgbkz4h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-siphasher" ,rust-siphasher-0.3)
                       ("rust-uncased" ,rust-uncased-0.9)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Support code shared by PHF libraries")
    (description "Support code shared by PHF libraries")
    (license license:expat)))
 
(define rust-phf-generator-0.11
  (package
    (name "rust-phf-generator")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf_generator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c14pjyxbcpwkdgw109f7581cc5fa3fnkzdq1ikvx7mdq9jcrr28"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-criterion" ,rust-criterion-0.3)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-rand" ,rust-rand-0.8))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "PHF generation logic")
    (description "PHF generation logic")
    (license license:expat)))
 
(define rust-phf-macros-0.11
  (package
    (name "rust-phf-macros")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf_macros" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0js61lc0bhzzrbd9vhpcqp11vvwckdkz3g7k95z5h1k651p68i1l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-phf-generator" ,rust-phf-generator-0.11)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Macros to generate types in the phf crate")
    (description "Macros to generate types in the phf crate")
    (license license:expat)))
 
(define rust-phf-0.11
  (package
    (name "rust-phf")
    (version "0.11.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "phf" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p03rsw66l7naqhpgr1a34r9yzi1gv9jh16g3fsk6wrwyfwdiqmd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-phf-macros" ,rust-phf-macros-0.11)
                       ("rust-phf-shared" ,rust-phf-shared-0.11)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-phf/rust-phf")
    (synopsis "Runtime support for perfect hash function data structures")
    (description "Runtime support for perfect hash function data structures")
    (license license:expat)))
 
(define rust-cint-0.3
  (package
    (name "rust-cint")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cint" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16l9glvaxshbp3awcga3s8cdfv00gb1n2s7ixzxxjwc5yz6qf3ks"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bytemuck" ,rust-bytemuck-1))))
    (home-page "https://github.com/termhn/cint")
    (synopsis
     "A lean, minimal, and stable set of types for color interoperation between crates in Rust.")
    (description
     "This package provides a lean, minimal, and stable set of types for color
interoperation between crates in Rust.")
    (license (list license:expat license:asl2.0 license:zlib))))
 
(define rust-csscolorparser-0.6
  (package
    (name "rust-csscolorparser")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "csscolorparser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1gxh11hajx96mf5sd0az6mfsxdryfqvcfcphny3yfbfscqq7sapb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cint" ,rust-cint-0.3)
                       ("rust-lab" ,rust-lab-0.11)
                       ("rust-phf" ,rust-phf-0.11)
                       ("rust-rgb" ,rust-rgb-0.8)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/mazznoer/csscolorparser-rs")
    (synopsis "CSS color parser library")
    (description "CSS color parser library")
    (license (list license:expat license:asl2.0))))
 
(define rust-wezterm-color-types-0.2
  (package
    (name "rust-wezterm-color-types")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wezterm-color-types" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xvphmrqgg69v9l879xj5lq010z13f5ixi854ykmny6j7m47lvjc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-csscolorparser" ,rust-csscolorparser-0.6)
                       ("rust-deltae" ,rust-deltae-0.3)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-wezterm-dynamic" ,rust-wezterm-dynamic-0.1))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "Types for working with colors")
    (description "Types for working with colors")
    (license license:expat)))
 
(define rust-wezterm-dynamic-derive-0.1
  (package
    (name "rust-wezterm-dynamic-derive")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wezterm-dynamic-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1w07qf8njyq19nxi9vpshwprk00blhzg9ybis2rhfba433rmx7qc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis
     "config serialization for wezterm via dynamic json-like data values")
    (description
     "config serialization for wezterm via dynamic json-like data values")
    (license license:expat)))
 
(define rust-wezterm-dynamic-0.1
  (package
    (name "rust-wezterm-dynamic")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wezterm-dynamic" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1al8fmfr852m62mlcr0v2lg3a18icl2sv79zv7jnv9v0rk07hpm7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-ordered-float" ,rust-ordered-float-3)
                       ("rust-strsim" ,rust-strsim-0.10)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wezterm-dynamic-derive" ,rust-wezterm-dynamic-derive-0.1))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis
     "config serialization for wezterm via dynamic json-like data values")
    (description
     "config serialization for wezterm via dynamic json-like data values")
    (license license:expat)))
 
(define rust-wezterm-bidi-0.2
  (package
    (name "rust-wezterm-bidi")
    (version "0.2.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wezterm-bidi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0dkcwscvlwnv6lnagxfb08rcd21gfyrxbr7afcjaj3wvycn3hq0m"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-log" ,rust-log-0.4)
                       ("rust-wezterm-dynamic" ,rust-wezterm-dynamic-0.1))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "The Unicode Bidi Algorithm (UBA)")
    (description "The Unicode Bidi Algorithm (UBA)")
    (license (list license:expat license:expat))))
 
(define rust-vtparse-0.6
  (package
    (name "rust-vtparse")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "vtparse" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1l5yz9650zhkaffxn28cvfys7plcw2wd6drajyf41pshn37jm6vd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "Low level escape sequence parser")
    (description "Low level escape sequence parser")
    (license license:expat)))
 
(define rust-memmem-0.1
  (package
    (name "rust-memmem")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "memmem" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05ccifqgxdfxk6yls41ljabcccsz3jz6549l1h3cwi17kr494jm6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "http://github.com/jneem/memmem")
    (synopsis "Substring searching")
    (description "Substring searching")
    (license (list license:expat license:asl2.0))))
 
(define rust-finl-unicode-1
  (package
    (name "rust-finl-unicode")
    (version "1.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "finl_unicode" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ipdx778849czik798sjbgk5yhwxqybydac18d2g9jb20dxdrkwg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://finl.xyz")
    (synopsis
     "Library for handling Unicode functionality for finl (categories and grapheme segmentation)")
    (description
     "Library for handling Unicode functionality for finl (categories and grapheme
segmentation)")
    (license (list license:expat license:asl2.0))))
 
(define rust-termwiz-0.20
  (package
    (name "rust-termwiz")
    (version "0.20.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "termwiz" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1yj80sli95wcw0im2iic9h7mx20hms3f9shxk7jarjqgl5waj2cm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-base64" ,rust-base64-0.21)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-cassowary" ,rust-cassowary-0.3)
                       ("rust-filedescriptor" ,rust-filedescriptor-0.8)
                       ("rust-finl-unicode" ,rust-finl-unicode-1)
                       ("rust-fixedbitset" ,rust-fixedbitset-0.4)
                       ("rust-fnv" ,rust-fnv-1)
                       ("rust-hex" ,rust-hex-0.4)
                       ("rust-image" ,rust-image-0.24)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-memmem" ,rust-memmem-0.1)
                       ("rust-nix" ,rust-nix-0.24)
                       ("rust-num-derive" ,rust-num-derive-0.3)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-ordered-float" ,rust-ordered-float-3)
                       ("rust-pest" ,rust-pest-2)
                       ("rust-pest-derive" ,rust-pest-derive-2)
                       ("rust-phf" ,rust-phf-0.10)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-semver" ,rust-semver-0.11)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-sha2" ,rust-sha2-0.9)
                       ("rust-signal-hook" ,rust-signal-hook-0.1)
                       ("rust-siphasher" ,rust-siphasher-0.3)
                       ("rust-terminfo" ,rust-terminfo-0.7)
                       ("rust-termios" ,rust-termios-0.3)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-ucd-trie" ,rust-ucd-trie-0.1)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-vtparse" ,rust-vtparse-0.6)
                       ("rust-wezterm-bidi" ,rust-wezterm-bidi-0.2)
                       ("rust-wezterm-color-types" ,rust-wezterm-color-types-0.2)
                       ("rust-wezterm-dynamic" ,rust-wezterm-dynamic-0.1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "Terminal Wizardry for Unix and Windows")
    (description "Terminal Wizardry for Unix and Windows")
    (license license:expat)))

(define rust-signal-hook-0.3
  (package
    (name "rust-signal-hook")
    (version "0.3.17")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "signal-hook" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0098nsah04spqf3n8niirmfym4wsdgjl57c78kmzijlq8xymh8c6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-cc" ,rust-cc-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-signal-hook-registry" ,rust-signal-hook-registry-1))))
    (home-page "https://github.com/vorner/signal-hook")
    (synopsis "Unix signal handling")
    (description "Unix signal handling")
    (license (list license:asl2.0 license:expat))))

(define rust-bitflags-2
  (package
    (name "rust-bitflags")
    (version "2.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bitflags" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0dc6xa7flfl59makmhixjcrslwlvdxxwrgxbr8p7bkvz53k2ls5l"))))
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

(define rust-ratatui-0.22
  (package
    (name "rust-ratatui")
    (version "0.22.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ratatui" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1mfk8a9c6sqq00r2p8pwxqxalf7gcasprqy0jafqg7ywifivm1c2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-cassowary" ,rust-cassowary-0.3)
                       ("rust-crossterm" ,rust-crossterm-0.26)
                       ("rust-indoc" ,rust-indoc-2)
                       ("rust-paste" ,rust-paste-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-termion" ,rust-termion-2)
                       ("rust-termwiz" ,rust-termwiz-0.20)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/tui-rs-revival/ratatui")
    (synopsis "A library to build rich terminal user interfaces or dashboards
")
    (description
     "This package provides a library to build rich terminal user interfaces or
dashboards")
    (license license:expat)))

 (define rust-itertools-0.11
  (package
    (name "rust-itertools")
    (version "0.11.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "itertools" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mzyqcc59azx9g5cg6fs8k529gvh4463smmka6jvzs3cd2jp7hdi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-either" ,rust-either-1))))
    (home-page "https://github.com/rust-itertools/itertools")
    (synopsis
     "Extra iterator adaptors, iterator methods, free functions, and macros.")
    (description
     "Extra iterator adaptors, iterator methods, free functions, and macros.")
    (license (list license:expat license:asl2.0))))

(define rust-once-cell-1
  (package
    (name "rust-once-cell")
    (version "1.18.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "once_cell" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vapcd5ambwck95wyz3ymlim35jirgnqn9a0qmi19msymv95v2yx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-atomic-polyfill" ,rust-atomic-polyfill-1)
                       ("rust-critical-section" ,rust-critical-section-1)
                       ("rust-parking-lot-core" ,rust-parking-lot-core-0.9))))
    (home-page "https://github.com/matklad/once_cell")
    (synopsis "Single assignment cells and lazy values.")
    (description "Single assignment cells and lazy values.")
    (license (list license:expat license:asl2.0))))
 
(define rust-wrapcenum-derive-0.4
  (package
    (name "rust-wrapcenum-derive")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wrapcenum-derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1v0aqs935881g1ar5hw0a3i14mw3ckqqn4d45b8knb5dhmf0dk3b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-darling" ,rust-darling-0.10)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/Cldfire/wrapcenum-derive")
    (synopsis "Derive macro for nvml-wrapper, not for general use")
    (description "Derive macro for nvml-wrapper, not for general use")
    (license (list license:expat license:asl2.0))))
 
(define rust-nvml-wrapper-sys-0.7
  (package
    (name "rust-nvml-wrapper-sys")
    (version "0.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nvml-wrapper-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0zlqqhvj88yshaadwmhcdjs7p1jvdw7hjscfnxlrmicikvma4qf9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libloading" ,rust-libloading-0.7))))
    (home-page "https://github.com/Cldfire/nvml-wrapper")
    (synopsis "Generated bindings to the NVIDIA Management Library.")
    (description "Generated bindings to the NVIDIA Management Library.")
    (license (list license:expat license:asl2.0))))
 
(define rust-nvml-wrapper-0.9
  (package
    (name "rust-nvml-wrapper")
    (version "0.9.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "nvml-wrapper" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0m1lmlwcmdwv6gscrq6sc9qy0hvlbigsizy92lskrkhwbagiplkw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-1)
                       ("rust-libloading" ,rust-libloading-0.7)
                       ("rust-nvml-wrapper-sys" ,rust-nvml-wrapper-sys-0.7)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-static-assertions" ,rust-static-assertions-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wrapcenum-derive" ,rust-wrapcenum-derive-0.4))))
    (home-page "https://github.com/Cldfire/nvml-wrapper")
    (synopsis
     "A safe and ergonomic Rust wrapper for the NVIDIA Management Library")
    (description
     "This package provides a safe and ergonomic Rust wrapper for the NVIDIA
Management Library")
    (license (list license:expat license:asl2.0))))
 
(define rust-mach2-0.4
  (package
    (name "rust-mach2")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "mach2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1s5dbscwk0w6czzvhxp9ix9c2djv4fpnj4za9byaclfiphq1h3bd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/JohnTitor/mach2")
    (synopsis
     "A Rust interface to the user-space API of the Mach 3.0 kernel that underlies OSX.")
    (description
     "This package provides a Rust interface to the user-space API of the Mach 3.0
kernel that underlies OSX.")
    (license (list license:bsd-2 license:expat license:asl2.0))))
 
(define rust-sval-test-2
  (package
    (name "rust-sval-test")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_test" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "10kmxysanpa0kvll716s7a4bqsfd8c0w0b4g1a1g3mv2mm8cbip2"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval" ,rust-sval-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Utilities for testing sval::Value implementations")
    (description "Utilities for testing sval::Value implementations")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-serde-2
  (package
    (name "rust-sval-serde")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_serde" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0imhipninbxsj4l6ahiqb3dw8vvbbk9y9yhyspjw7xw10p6jc2c3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-sval" ,rust-sval-2)
                       ("rust-sval-buffer" ,rust-sval-buffer-2)
                       ("rust-sval-fmt" ,rust-sval-fmt-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Integration between serde::Serialize and sval::Value")
    (description "Integration between serde::Serialize and sval::Value")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-json-2
  (package
    (name "rust-sval-json")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_json" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13c8hna2n7ykiz3l3ahx2iqmfjmwhyfm0j9n51h8ifwcwckzd9md"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-itoa" ,rust-itoa-1)
                       ("rust-ryu" ,rust-ryu-1)
                       ("rust-sval" ,rust-sval-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "JSON support for sval")
    (description "JSON support for sval")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-fmt-2
  (package
    (name "rust-sval-fmt")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_fmt" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "09j3ss5kayp6pb23wasc1k9mjcvv0x6v1xrqzasml162cj9rxh3x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-itoa" ,rust-itoa-1)
                       ("rust-ryu" ,rust-ryu-1)
                       ("rust-sval" ,rust-sval-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Integration between std::fmt::Debug and sval::Value")
    (description "Integration between std::fmt::Debug and sval::Value")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-dynamic-2
  (package
    (name "rust-sval-dynamic")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_dynamic" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1kq3shbdfz74hhq4aaf27h99ax7piaqd3f4d6g9nx93pia765vx0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval" ,rust-sval-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Object-safe versions of sval::Stream and sval::Value")
    (description "Object-safe versions of sval::Stream and sval::Value")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-buffer-2
  (package
    (name "rust-sval-buffer")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_buffer" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0a30rw303lafs5n08xpb2sfmw45h490wri9c7wpk8szj590ykxvb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval" ,rust-sval-2)
                       ("rust-sval-ref" ,rust-sval-ref-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Value buffering for sval")
    (description "Value buffering for sval")
    (license (list license:asl2.0 license:expat))))
 
(define rust-value-bag-sval2-1
  (package
    (name "rust-value-bag-sval2")
    (version "1.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "value-bag-sval2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0zdd1xj6vby5bv575vqc7in3gs9mzg8jgxfbj4g3dwxn8r0lzcih"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval" ,rust-sval-2)
                       ("rust-sval-buffer" ,rust-sval-buffer-2)
                       ("rust-sval-dynamic" ,rust-sval-dynamic-2)
                       ("rust-sval-fmt" ,rust-sval-fmt-2)
                       ("rust-sval-json" ,rust-sval-json-2)
                       ("rust-sval-ref" ,rust-sval-ref-2)
                       ("rust-sval-serde" ,rust-sval-serde-2)
                       ("rust-sval-test" ,rust-sval-test-2))))
    (home-page "")
    (synopsis "Implementation detail for value-bag")
    (description "Implementation detail for value-bag")
    (license (list license:asl2.0 license:expat))))
 
(define rust-serde-buf-0.1
  (package
    (name "rust-serde-buf")
    (version "0.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "serde_buf" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1k2nc3pa7rbzyhhnjakw6nkx2wa6da6nrxf65s6p2d3xdjfvx1is"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/KodrAus/serde_buf.git")
    (synopsis "Generic buffering for serde")
    (description "Generic buffering for serde")
    (license (list license:asl2.0 license:expat))))
 
(define rust-value-bag-serde1-1
  (package
    (name "rust-value-bag-serde1")
    (version "1.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "value-bag-serde1" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1523528ccb5pmba1pwz4nk5qns7wv2k435vysva50fj0xzzg7fdh"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-erased-serde" ,rust-erased-serde-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-buf" ,rust-serde-buf-0.1)
                       ("rust-serde-fmt" ,rust-serde-fmt-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-test" ,rust-serde-test-1))))
    (home-page "")
    (synopsis "Implementation detail for value-bag")
    (description "Implementation detail for value-bag")
    (license (list license:asl2.0 license:expat))))
 
(define rust-value-bag-1
  (package
    (name "rust-value-bag")
    (version "1.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "value-bag" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18zl11ghirkc4mnkma1ms210gzgg0hm1an8vq1430l48zdkwsb6r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-value-bag-serde1" ,rust-value-bag-serde1-1)
                       ("rust-value-bag-sval2" ,rust-value-bag-sval2-1))))
    (home-page "https://github.com/sval-rs/value-bag")
    (synopsis "Anonymous structured values")
    (description "Anonymous structured values")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-ref-2
  (package
    (name "rust-sval-ref")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_ref" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0z1dy9mvqw9w63mz82h8il1r9dxlp1dadh54npcx0jwq5aaa2g3h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval" ,rust-sval-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "A variant of sval::Value for types with internal references")
    (description
     "This package provides a variant of sval::Value for types with internal
references")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-derive-2
  (package
    (name "rust-sval-derive")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xp383009kz8lw0892fli31nbz17d7yw6f4gks1f5i70d1vcsadb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Derive support for sval")
    (description "Derive support for sval")
    (license (list license:asl2.0 license:expat))))
 
(define rust-sval-2
  (package
    (name "rust-sval")
    (version "2.6.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "sval" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1cbq3cx67dw0my4cn8ldgf9p4hkxsmb5g6yggi3yklrllhh160wb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-sval-derive" ,rust-sval-derive-2))))
    (home-page "https://github.com/sval-rs/sval")
    (synopsis "Streaming, structured value serialization")
    (description "Streaming, structured value serialization")
    (license (list license:asl2.0 license:expat))))
 
(define rust-log-0.4
  (package
    (name "rust-log")
    (version "0.4.20")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "log" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13rf7wphnwd61vazpxr7fiycin6cb1g8fmvgqg18i464p0y1drmm"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-serde" ,rust-serde-1)
                       ("rust-sval" ,rust-sval-2)
                       ("rust-sval-ref" ,rust-sval-ref-2)
                       ("rust-value-bag" ,rust-value-bag-1))))
    (home-page "https://github.com/rust-lang/log")
    (synopsis "A lightweight logging facade for Rust
")
    (description "This package provides a lightweight logging facade for Rust")
    (license (list license:expat license:asl2.0))))
 
(define rust-rustc-rayon-core-0.5
  (package
    (name "rust-rustc-rayon-core")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustc-rayon-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0zqbr87x58j2g9rgm2lc0254b6yqabb41jvddw99qd8fy2m8srk7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-crossbeam-channel" ,rust-crossbeam-channel-0.5)
                       ("rust-crossbeam-deque" ,rust-crossbeam-deque-0.8)
                       ("rust-crossbeam-utils" ,rust-crossbeam-utils-0.8)
                       ("rust-num-cpus" ,rust-num-cpus-1))))
    (home-page "https://github.com/rust-lang/rustc-rayon")
    (synopsis "Core APIs for Rayon - fork for rustc")
    (description "Core APIs for Rayon - fork for rustc")
    (license (list license:expat license:asl2.0))))
 
(define rust-rustc-rayon-0.5
  (package
    (name "rust-rustc-rayon")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustc-rayon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "040p2am25g3isnpsixrcrjrv70yz2lzkbq8gpv76xjipi3fam0gb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-either" ,rust-either-1)
                       ("rust-rustc-rayon-core" ,rust-rustc-rayon-core-0.5))))
    (home-page "https://github.com/rust-lang/rustc-rayon")
    (synopsis "Simple work-stealing parallelism for Rust - fork for rustc")
    (description "Simple work-stealing parallelism for Rust - fork for rustc")
    (license (list license:expat license:asl2.0))))
 
(define rust-indexmap-1
  (package
    (name "rust-indexmap")
    (version "1.9.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "indexmap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "16dxmy7yvk51wvnih3a3im6fp5lmx0wx76i03n06wyak6cwhw1xx"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arbitrary" ,rust-arbitrary-1)
                       ("rust-autocfg" ,rust-autocfg-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.12)
                       ("rust-quickcheck" ,rust-quickcheck-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustc-rayon" ,rust-rustc-rayon-0.5)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/bluss/indexmap")
    (synopsis "A hash table with consistent order and fast iteration.")
    (description
     "This package provides a hash table with consistent order and fast iteration.")
    (license (list license:asl2.0 license:expat))))
 
(define rust-humantime-serde-1
  (package
    (name "rust-humantime-serde")
    (version "1.1.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "humantime-serde" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0310ri4zb33qbwqv0n51xysfjpnwc6rgxscl5i09jgcjlmgdp8sp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-humantime" ,rust-humantime-2)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/jean-airoldie/humantime-serde")
    (synopsis "Serde support for the `humantime` crate")
    (description "Serde support for the `humantime` crate")
    (license (list license:expat license:asl2.0))))
 
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
 
(define rust-syslog-6
  (package
    (name "rust-syslog")
    (version "6.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syslog" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0vzrwwv3v9bwfinp7yz4kcdxxs00ikz89gzl61fj3qfcridyjd3l"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-error-chain" ,rust-error-chain-0.12)
                       ("rust-hostname" ,rust-hostname-0.3)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-time" ,rust-time-0.3))))
    (home-page "https://github.com/Geal/rust-syslog")
    (synopsis "Send log messages to syslog")
    (description "Send log messages to syslog")
    (license license:expat)))
 
(define rust-reopen-1
  (package
    (name "rust-reopen")
    (version "1.0.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "reopen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "14w2v7a4dav23jzfrxj9lgacp731xizvng4bn7slan7qmk1wwhpz"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-signal-hook" ,rust-signal-hook-0.3))))
    (home-page "https://github.com/vorner/reopen")
    (synopsis "File reopening utility")
    (description "File reopening utility")
    (license (list license:asl2.0 license:expat))))
 
(define rust-fern-0.6
  (package
    (name "rust-fern")
    (version "0.6.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fern" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1vpinainw32498p0zydmxc24yd3r6479pmhdfb429mfbji3c3w6r"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                       ("rust-colored" ,rust-colored-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-reopen" ,rust-reopen-0.3)
                       ("rust-reopen" ,rust-reopen-1)
                       ("rust-syslog" ,rust-syslog-3)
                       ("rust-syslog" ,rust-syslog-4)
                       ("rust-syslog" ,rust-syslog-6))))
    (home-page "https://github.com/daboross/fern")
    (synopsis "Simple, efficient logging")
    (description "Simple, efficient logging")
    (license license:expat)))
 
(define rust-option-ext-0.2
  (package
    (name "rust-option-ext")
    (version "0.2.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "option-ext" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0zbf7cx8ib99frnlanpyikm1bx8qn8x602sw1n7bg6p9x94lyx04"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/soc/option-ext")
    (synopsis "Extends `Option` with additional operations")
    (description "Extends `Option` with additional operations")
    (license license:mpl2.0)))
 
(define rust-dirs-sys-0.4
  (package
    (name "rust-dirs-sys")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dirs-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "071jy0pvaad9lsa6mzawxrh7cmr7hsmsdxwzm7jzldfkrfjha3sj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-option-ext" ,rust-option-ext-0.2)
                       ("rust-redox-users" ,rust-redox-users-0.4)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/dirs-dev/dirs-sys-rs")
    (synopsis
     "System-level helper functions for the dirs and directories crates.")
    (description
     "System-level helper functions for the dirs and directories crates.")
    (license (list license:expat license:asl2.0))))
 
(define rust-dirs-5
  (package
    (name "rust-dirs")
    (version "5.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "dirs" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0992xk5vx75b2x91nw9ssb51mpl8x73j9rxmpi96cryn0ffmmi24"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-dirs-sys" ,rust-dirs-sys-0.4))))
    (home-page "https://github.com/soc/dirs-rs")
    (synopsis
     "A tiny low-level library that provides platform-specific standard locations of directories for config, cache and other data on Linux, Windows, macOS and Redox by leveraging the mechanisms defined by the XDG base/user directory specifications on Linux, the Known Folder API on Windows, and the Standard Directory guidelines on macOS.")
    (description
     "This package provides a tiny low-level library that provides platform-specific
standard locations of directories for config, cache and other data on Linux,
Windows, macOS and Redox by leveraging the mechanisms defined by the XDG
base/user directory specifications on Linux, the Known Folder API on Windows,
and the Standard Directory guidelines on macOS.")
    (license (list license:expat license:asl2.0))))
 
(define rust-ctrlc-3
  (package
    (name "rust-ctrlc")
    (version "3.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ctrlc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03hj4gvkds0cfkk2j7fdnjz6g8999zwzcyiv2hgrrkim5jz1n09a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-nix" ,rust-nix-0.26)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/Detegr/rust-ctrlc")
    (synopsis "Easy Ctrl-C handler for Rust projects")
    (description "Easy Ctrl-C handler for Rust projects")
    (license (list license:expat license:asl2.0))))
 
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
 
(define rust-crossterm-winapi-0.9
  (package
    (name "rust-crossterm-winapi")
    (version "0.9.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crossterm_winapi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0axbfb2ykbwbpf1hmxwpawwfs8wvmkcka5m561l7yp36ldi7rpdc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/crossterm-rs/crossterm-winapi")
    (synopsis
     "WinAPI wrapper that provides some basic simple abstractions around common WinAPI calls")
    (description
     "@code{WinAPI} wrapper that provides some basic simple abstractions around common
@code{WinAPI} calls")
    (license license:expat)))

(define rust-crossterm-0.27
  (package
    (name "rust-crossterm")
    (version "0.27.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "crossterm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1pr413ki440xgddlmkrc4j1bfx1h8rpmll87zn8ykja1bm2gwxpl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
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
(define rust-concat-string-1
  (package
    (name "rust-concat-string")
    (version "1.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "concat-string" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "02c6hfxsvs1ff2j58f3qzr526w1yg8d2nf6yyjv81ixgbz5vwfbl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/FaultyRAM/concat-string")
    (synopsis
     "Provides macros for concatenating string slices into owned strings.")
    (description
     "This package provides macros for concatenating string slices into owned strings.")
    (license (list license:asl2.0 license:expat))))

(define rust-roff-0.2
  (package
    (name "rust-roff")
    (version "0.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "roff" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05j324x84xkgp848smhnknnlpl70833xb9lalqg4n2ga6k8dhcxq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/roff-rs")
    (synopsis "ROFF (man page format) generation library")
    (description "ROFF (man page format) generation library")
    (license (list license:expat license:asl2.0))))
 
(define rust-clap-mangen-0.2
  (package
    (name "rust-clap-mangen")
    (version "0.2.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_mangen" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "07yc2p6g39phn9g0dr8w3sh9vj09x8mpx2sa8b197q6sg6sk4blg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-4)
                       ("rust-roff" ,rust-roff-0.2))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_mangen")
    (synopsis "A manpage generator for clap")
    (description "This package provides a manpage generator for clap")
    (license (list license:expat license:asl2.0))))

(define rust-clap-complete-4
  (package
    (name "rust-clap-complete")
    (version "4.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_complete" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1khpx0fxmjh46s8354nn507ba4s9kfksiia6ambh9a419hrl7i2z"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-4)
                       ("rust-clap-lex" ,rust-clap-lex-0.5)
                       ("rust-is-executable" ,rust-is-executable-1)
                       ("rust-pathdiff" ,rust-pathdiff-0.2)
                       ("rust-shlex" ,rust-shlex-1)
                       ("rust-unicode-xid" ,rust-unicode-xid-0.2))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_complete")
    (synopsis "Generate shell completion scripts for your clap::Command")
    (description "Generate shell completion scripts for your clap::Command")
    (license (list license:expat license:asl2.0))))
 
(define rust-hashbrown-0.13
  (package
    (name "rust-hashbrown")
    (version "0.13.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hashbrown" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "03ji3n19j4b6mf2wlla81vsixcmlivglp6hgk79d1pcxfcrw38s3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-ahash" ,rust-ahash-0.8)
                       ("rust-bumpalo" ,rust-bumpalo-3)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/rust-lang/hashbrown")
    (synopsis "A Rust port of Google's SwissTable hash map")
    (description
     "This package provides a Rust port of Google's SwissTable hash map")
    (license (list license:expat license:asl2.0))))

(define rust-miniz-oxide-0.7
  (package
    (name "rust-miniz-oxide")
    (version "0.7.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "miniz_oxide" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ivl3rbbdm53bzscrd01g60l46lz5krl270487d8lhjvwl5hx0g7"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-adler" ,rust-adler-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-simd-adler32" ,rust-simd-adler32-0.3))))
    (home-page "https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide")
    (synopsis
     "DEFLATE compression and decompression library rewritten in Rust based on miniz")
    (description
     "DEFLATE compression and decompression library rewritten in Rust based on miniz")
    (license (list license:expat license:zlib license:asl2.0))))

(define rust-wasmparser-0.102
  (package
    (name "rust-wasmparser")
    (version "0.102.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wasmparser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0jqh6p7w5kng9vz1k1bblwfx6l4fbnqr2sxgksmik0jrszils4s8"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-1)
                       ("rust-url" ,rust-url-2))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmparser")
    (synopsis
     "A simple event-driven library for parsing WebAssembly binary files.
")
    (description
     "This package provides a simple event-driven library for parsing
@code{WebAssembly} binary files.")
    (license (list license:asl2.0))))

(define rust-wasmparser-0.110
  (package
    (name "rust-wasmparser")
    (version "0.110.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "wasmparser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0g214qyjbgrbmcdk0dy3snmdnfs2ww103wkbbg4fc0bgv5rdpz0x"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-semver" ,rust-semver-1))))
    (home-page
     "https://github.com/bytecodealliance/wasm-tools/tree/main/crates/wasmparser")
    (synopsis
     "A simple event-driven library for parsing WebAssembly binary files.
")
    (description
     "This package provides a simple event-driven library for parsing
@code{WebAssembly} binary files.")
    (license (list license:asl2.0))))
(define rust-thiserror-core-impl-1
  (package
    (name "rust-thiserror-core-impl")
    (version "1.0.38")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror-core-impl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1b32vakaixn8z54813dkv3ymzrkrrv9d151gdg8i8c74a181rb0h"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/FlorianUekermann/thiserror/tree/core")
    (synopsis "Implementation detail of the `thiserror` crate")
    (description "Implementation detail of the `thiserror` crate")
    (license (list license:expat license:asl2.0))))

(define rust-thiserror-core-1
  (package
    (name "rust-thiserror-core")
    (version "1.0.38")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "thiserror-core" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "15zlv507q2nypg2aphk1fvfnrqzqks59v0aqrl221frpcigk95qd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-thiserror-core-impl" ,rust-thiserror-core-impl-1))))
    (home-page "https://github.com/FlorianUekermann/thiserror/tree/core")
    (synopsis "derive(Error)")
    (description "derive(Error)")
    (license (list license:expat license:asl2.0))))

(define rust-ruzstd-0.4
  (package
    (name "rust-ruzstd")
    (version "0.4.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ruzstd" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1p4ghqzkq36dy1x1ijnk7jmml4wi3v9bkfzlbm2hsnkiz6wglgxc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-thiserror-core" ,rust-thiserror-core-1)
                       ("rust-twox-hash" ,rust-twox-hash-1))))
    (home-page "https://github.com/KillingSpark/zstd-rs")
    (synopsis "A decoder for the zstd compression format")
    (description
     "This package provides a decoder for the zstd compression format")
    (license license:expat)))

(define rust-object-0.32
  (package
    (name "rust-object")
    (version "0.32.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "object" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ghynapcbgzrmnbwmmxj129dbzvmh0hwx8bplmh8ra5f0yympb3p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-crc32fast" ,rust-crc32fast-1)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-ruzstd" ,rust-ruzstd-0.4)
                       ("rust-wasmparser" ,rust-wasmparser-0.110))))
    (home-page "https://github.com/gimli-rs/object")
    (synopsis
     "A unified interface for reading and writing object file formats.")
    (description
     "This package provides a unified interface for reading and writing object file
formats.")
    (license (list license:asl2.0 license:expat))))

(define rust-gimli-0.28
  (package
    (name "rust-gimli")
    (version "0.28.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "gimli" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1h7hcl3chfvd2gfrrxjymnwj7anqxjslvz20kcargkvsya2dgf3g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-fallible-iterator" ,rust-fallible-iterator-0.3)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-stable-deref-trait" ,rust-stable-deref-trait-1))))
    (home-page "https://github.com/gimli-rs/gimli")
    (synopsis "A library for reading and writing the DWARF debugging format.")
    (description
     "This package provides a library for reading and writing the DWARF debugging
format.")
    (license (list license:expat license:asl2.0))))

(define rust-object-0.31
  (package
    (name "rust-object")
    (version "0.31.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "object" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1lb670wallm2i6rzrx2hz1afya4bfjzz6n9zhfw52l1bkxyndnlb"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-crc32fast" ,rust-crc32fast-1)
                       ("rust-flate2" ,rust-flate2-1)
                       ("rust-hashbrown" ,rust-hashbrown-0.13)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-memchr" ,rust-memchr-2)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-wasmparser" ,rust-wasmparser-0.102))))
    (home-page "https://github.com/gimli-rs/object")
    (synopsis
     "A unified interface for reading and writing object file formats.")
    (description
     "This package provides a unified interface for reading and writing object file
formats.")
    (license (list license:asl2.0 license:expat))))
 
(define rust-fallible-iterator-0.3
  (package
    (name "rust-fallible-iterator")
    (version "0.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fallible-iterator" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0ja6l56yka5vn4y4pk6hn88z0bpny7a8k1919aqjzp0j1yhy9k1a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/sfackler/rust-fallible-iterator")
    (synopsis "Fallible iterator traits")
    (description "Fallible iterator traits")
    (license (list license:expat license:asl2.0))))

(define rust-addr2line-0.21
  (package
    (name "rust-addr2line")
    (version "0.21.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "addr2line" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1jx0k3iwyqr8klqbzk6kjvr496yd94aspis10vwsj5wy7gib4c4a"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-cpp-demangle" ,rust-cpp-demangle-0.4)
                       ("rust-fallible-iterator" ,rust-fallible-iterator-0.3)
                       ("rust-gimli" ,rust-gimli-0.28)
                       ("rust-memmap2" ,rust-memmap2-0.5)
                       ("rust-object" ,rust-object-0.32)
                       ("rust-rustc-demangle" ,rust-rustc-demangle-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-smallvec" ,rust-smallvec-1))))
    (home-page "https://github.com/gimli-rs/addr2line")
    (synopsis
     "A cross-platform symbolication library written in Rust, using `gimli`")
    (description
     "This package provides a cross-platform symbolication library written in Rust,
using `gimli`")
    (license (list license:asl2.0 license:expat))))

(define rust-gimli-0.27
  (package
    (name "rust-gimli")
    (version "0.27.3")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "gimli" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0bpdnkyzi3vp2r0wglwrncbk451zhp46mdl83f6xj4gsmy20kj5n"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-fallible-iterator" ,rust-fallible-iterator-0.2)
                       ("rust-indexmap" ,rust-indexmap-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-stable-deref-trait" ,rust-stable-deref-trait-1))))
    (home-page "https://github.com/gimli-rs/gimli")
    (synopsis "A library for reading and writing the DWARF debugging format.")
    (description
     "This package provides a library for reading and writing the DWARF debugging
format.")
    (license (list license:expat license:asl2.0))))
 
(define rust-tempfile-3
  (package
    (name "rust-tempfile")
    (version "3.7.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "tempfile" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1649gc0f4qfbqfj6qhikqhpdr160bdjdfbiqlqw50blbwx70k1jl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-autocfg" ,rust-autocfg-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-fastrand" ,rust-fastrand-1)
                       ("rust-redox-syscall" ,rust-redox-syscall-0.3)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://stebalien.com/projects/tempfile-rs/")
    (synopsis "A library for managing temporary files and directories.")
    (description
     "This package provides a library for managing temporary files and directories.")
    (license (list license:expat license:asl2.0))))
 
(define rust-fs-extra-1
  (package
    (name "rust-fs-extra")
    (version "1.3.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fs_extra" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "075i25z70j2mz9r7i9p9r521y8xdj81q7skslyb7zhqnnw33fw22"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/webdesus/fs_extra")
    (synopsis
     "Expanding std::fs and std::io. Recursively copy folders with information about process and much more.")
    (description
     "Expanding std::fs and std::io.  Recursively copy folders with information about
process and much more.")
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
    (version "1.0.63")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "proc-macro2" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ssr3643nwfhw7yvqhibjw1k6nsnbv0lxq7mc1zcw38vjax8ydkv"))))
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
    (version "2.0.22")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "05j6n81lm86idf0cgv9rfpddscajyj91rlfbrmmvvsplmkkymyrf"))))
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
 
(define rust-clap-derive-4
  (package
    (name "rust-clap-derive")
    (version "4.3.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_derive" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0l50j37jwbzfl29bd2a1ib7z1jpch4b9868himrgwpgwb1bvpaal"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-heck" ,rust-heck-0.4)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_derive")
    (synopsis
     "Parse command line argument by defining a struct, derive crate.")
    (description
     "Parse command line argument by defining a struct, derive crate.")
    (license (list license:expat license:asl2.0))))
 
(define rust-clap-lex-0.5
  (package
    (name "rust-clap-lex")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_lex" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "06vcvpvp65qggc5agbirzqk2di00gxg6vazzc3qlwzkw70qxm9id"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/clap-rs/clap/tree/master/clap_lex")
    (synopsis "Minimal, flexible command line parser")
    (description "Minimal, flexible command line parser")
    (license (list license:expat license:asl2.0))))
 
(define rust-linux-raw-sys-0.4
  (package
    (name "rust-linux-raw-sys")
    (version "0.4.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "linux-raw-sys" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "00w52pb2cb4b2880ksyzagmzbyjdmp9ac0w3qfvjv3453fnzvg2p"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1))))
    (home-page "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis "Generated bindings for Linux's userspace API")
    (description "Generated bindings for Linux's userspace API")
    (license (list license:asl2.0 license:expat license:asl2.0
                   license:expat))))
 
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
    (license (list license:asl2.0 license:expat license:asl2.0
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
    (version "0.37.20")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1h5j9d3rnz06rq56c9p1hkddzixipiqjg39i3xnnll5a0hfqjvmr"))))
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
                       ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/bytecodealliance/rustix")
    (synopsis "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (description
     "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (license (list license:asl2.0 license:expat license:asl2.0
                   license:expat))))
 
(define rust-rustix-0.38
  (package
    (name "rust-rustix")
    (version "0.38.10")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "rustix" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0r096k86c9sbvirfnz5vy8k8qphkkwahcvi6irqfn9d6rbhlhqpd"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-errno" ,rust-errno-0.3)
                       ;("rust-io-lifetimes" ,rust-io-lifetimes-1)
                       ("rust-itoa" ,rust-itoa-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/bytecodealliance/rustix")
    (synopsis "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (description
     "Safe Rust bindings to POSIX/Unix/Linux/Winsock2-like syscalls")
    (license (list license:asl2.0 license:expat license:asl2.0
                   license:expat))))
 
(define rust-hermit-abi-0.3
  (package
    (name "rust-hermit-abi")
    (version "0.3.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "hermit-abi" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11j2v3q58kmi5mhjvh6hfrb7il2yzg7gmdf5lpwnwwv6qj04im7y"))))
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
 
(define rust-is-terminal-0.4
  (package
    (name "rust-is-terminal")
    (version "0.4.9")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "is-terminal" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12xgvc7nsrp3pn8hcxajfhbli2l5wnh3679y2fmky88nhj4qj26b"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-hermit-abi" ,rust-hermit-abi-0.3)
                       ;("rust-io-lifetimes" ,rust-io-lifetimes-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/sunfishcode/is-terminal")
    (synopsis "Test whether a given stream is a terminal")
    (description "Test whether a given stream is a terminal")
    (license license:expat)))
 
(define rust-colorchoice-1
  (package
    (name "rust-colorchoice")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "colorchoice" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ix7w85kwvyybwi2jdkl3yva2r2bvdcc3ka2grjfzfgrapqimgxc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Global override of color control")
    (description "Global override of color control")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-wincon-1
  (package
    (name "rust-anstyle-wincon")
    (version "1.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-wincon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12714vwjf4c1wm3qf49m5vmd93qvq2nav6zpjc0bxbh3ayjby2hq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Styling legacy Windows terminals")
    (description "Styling legacy Windows terminals")
    (license (list license:expat license:asl2.0))))

 (define rust-windows-interface-0.51
  (package
    (name "rust-windows-interface")
    (version "0.51.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-interface" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0xps1k3ii3cdiniv896mgcv3mbmm787gl4937m008k763hzfcih5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The interface macro for the windows crate")
    (description "The interface macro for the windows crate")
    (license (list license:expat license:asl2.0))))

(define rust-windows-implement-0.51
  (package
    (name "rust-windows-implement")
    (version "0.51.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-implement" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0mg5q1rzfix05xvl4fhmp5b6azm8a0pn4dk8hkc21by5zs71aazv"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/microsoft/windows-rs")
    (synopsis "The implement macro for the windows crate")
    (description "The implement macro for the windows crate")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-msvc-0.48
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_x86_64_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_i686_gnu" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_msvc" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows_aarch64_gnullvm" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))))
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
    (version "0.48.5")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "windows-targets" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))))
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
 
(define rust-anstyle-query-1
  (package
    (name "rust-anstyle-query")
    (version "1.0.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-query" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0js9bgpqz21g0p2nm350cba1d0zfyixsma9lhyycic5sw55iv8aw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Look up colored console capabilities")
    (description "Look up colored console capabilities")
    (license (list license:expat license:asl2.0))))
 
(define rust-utf8parse-0.2
  (package
    (name "rust-utf8parse")
    (version "0.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "utf8parse" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "02ip1a0az0qmc2786vxk2nqwsgcwf17d3a38fkf0q7hrmwh9c6vi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/alacritty/vte")
    (synopsis "Table-driven UTF-8 parser")
    (description "Table-driven UTF-8 parser")
    (license (list license:asl2.0 license:expat))))
 
(define rust-anstyle-parse-0.2
  (package
    (name "rust-anstyle-parse")
    (version "0.2.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-parse" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0cy38fbdlnmwyy6q8dn8dcfrpycwnpjkljsjqn3kmc40b7zp924k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-arrayvec" ,rust-arrayvec-0.7)
                       ("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Parse ANSI Style Escapes")
    (description "Parse ANSI Style Escapes")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-1
  (package
    (name "rust-anstyle")
    (version "1.0.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1kff80219d5rvvi407wky2zdlb0naxvbbg005s274pidbxfdlc1s"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "ANSI text styling")
    (description "ANSI text styling")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstream-0.3
  (package
    (name "rust-anstream")
    (version "0.3.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstream" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0qzinx9c8zfq3xqpxzmlv6nrm3ymccr4n8gffkdmj31p50v4za0c"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-1)
                       ("rust-anstyle-parse" ,rust-anstyle-parse-0.2)
                       ("rust-anstyle-query" ,rust-anstyle-query-1)
                       ("rust-anstyle-wincon" ,rust-anstyle-wincon-1)
                       ("rust-colorchoice" ,rust-colorchoice-1)
                       ("rust-is-terminal" ,rust-is-terminal-0.4)
                       ("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis
     "A simple cross platform library for writing colored text to a terminal.")
    (description
     "This package provides a simple cross platform library for writing colored text
to a terminal.")
    (license (list license:expat license:asl2.0))))
 
(define rust-anstyle-wincon-2
  (package
    (name "rust-anstyle-wincon")
    (version "2.1.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstyle-wincon" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1zcxnwgmgr2578j4kah0mqzx2y5bq4zapkk6l21i59fzqq84vxaq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-1)
                       ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "Styling legacy Windows terminals")
    (description "Styling legacy Windows terminals")
    (license (list license:expat license:asl2.0))))

(define rust-anstream-0.5
  (package
    (name "rust-anstream")
    (version "0.5.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anstream" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "036cqmji930gx0wn9whlyrqm3qqw4gkbc054y504jd5crw8qixdi"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstyle" ,rust-anstyle-1)
                       ("rust-anstyle-parse" ,rust-anstyle-parse-0.2)
                       ("rust-anstyle-query" ,rust-anstyle-query-1)
                       ("rust-anstyle-wincon" ,rust-anstyle-wincon-2)
                       ("rust-colorchoice" ,rust-colorchoice-1)
                       ("rust-utf8parse" ,rust-utf8parse-0.2))))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis
     "A simple cross platform library for writing colored text to a terminal.")
    (description
     "This package provides a simple cross platform library for writing colored text
to a terminal.")
    (license (list license:expat license:asl2.0))))

(define rust-clap-builder-4
  (package
    (name "rust-clap-builder")
    (version "4.3.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_builder" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "167sw9rxa3638aldj3x74dv75priml5dxdmnf05bijbqnvznzkpq"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-anstream" ,rust-anstream-0.3)
                       ("rust-anstyle" ,rust-anstyle-1)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-clap-lex" ,rust-clap-lex-0.5)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-strsim" ,rust-strsim-0.10)
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
 
(define rust-clap-4
  (package
    (name "rust-clap")
    (version "4.3.23")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "18yw8w8344zaxv1i902jgqf10644xwk4iw10rqarr1vxvy6z3bh3"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap-builder" ,rust-clap-builder-4)
                       ("rust-clap-derive" ,rust-clap-derive-4)
                       ("rust-once-cell" ,rust-once-cell-1))))
    (home-page "https://github.com/clap-rs/clap")
    (synopsis
     "A simple to use, efficient, and full-featured Command Line Argument Parser")
    (description
     "This package provides a simple to use, efficient, and full-featured Command Line
Argument Parser")
    (license (list license:expat license:asl2.0))))
 
(define rust-afl-0.13
  (package
    (name "rust-afl")
    (version "0.13.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "afl" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1q320w41jmda5lyfd0rjrxjljnd62560yy2vyy1q9rvrxdc94ynj"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-clap" ,rust-clap-4)
                       ("rust-fs-extra" ,rust-fs-extra-1)
                       ("rust-home" ,rust-home-0.5)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-rustc-version" ,rust-rustc-version-0.4)
                       ("rust-tempfile" ,rust-tempfile-3)
                       ("rust-xdg" ,rust-xdg-2)
                       ("rust-xdg" ,rust-xdg-2))))
    (home-page "https://github.com/rust-fuzz/afl.rs")
    (synopsis "Fuzzing Rust code with american-fuzzy-lop")
    (description "Fuzzing Rust code with american-fuzzy-lop")
    (license license:asl2.0)))
 
(define rust-cpp-demangle-0.4
  (package
    (name "rust-cpp-demangle")
    (version "0.4.2")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "cpp_demangle" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0x56jgc05rp377lp0ywsl59nc7wj8xfdi0bg7s7nsgfrwcp0ad7f"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-afl" ,rust-afl-0.13)
                       ("rust-cfg-if" ,rust-cfg-if-1))))
    (home-page "https://github.com/gimli-rs/cpp_demangle")
    (synopsis "A crate for demangling C++ symbols")
    (description "This package provides a crate for demangling C++ symbols")
    (license (list license:expat license:asl2.0))))
 
(define rust-addr2line-0.20
  (package
    (name "rust-addr2line")
    (version "0.20.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "addr2line" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1qv590hm40lz2q77p7s3lghaa5gdbrxcvpiaj1gf1z34ikhpiypl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-cpp-demangle" ,rust-cpp-demangle-0.4)
                       ("rust-fallible-iterator" ,rust-fallible-iterator-0.2)
                       ("rust-gimli" ,rust-gimli-0.27)
                       ("rust-memmap2" ,rust-memmap2-0.5)
                       ("rust-object" ,rust-object-0.31)
                       ("rust-rustc-demangle" ,rust-rustc-demangle-0.1)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-smallvec" ,rust-smallvec-1))))
    (home-page "https://github.com/gimli-rs/addr2line")
    (synopsis
     "A cross-platform symbolication library written in Rust, using `gimli`")
    (description
     "This package provides a cross-platform symbolication library written in Rust,
using `gimli`")
    (license (list license:asl2.0 license:expat))))
 
(define rust-backtrace-0.3
  (package
    (name "rust-backtrace")
    (version "0.3.69")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "backtrace" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0dsq23dhw4pfndkx2nsa1ml2g31idm7ss7ljxp8d57avygivg290"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-addr2line" ,rust-addr2line-0.21)
                       ("rust-cc" ,rust-cc-1)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-cpp-demangle" ,rust-cpp-demangle-0.4)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-miniz-oxide" ,rust-miniz-oxide-0.7)
                       ("rust-object" ,rust-object-0.32);; ADD
                       ("rust-rustc-demangle" ,rust-rustc-demangle-0.1)
                       ("rust-rustc-serialize" ,rust-rustc-serialize-0.3)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/rust-lang/backtrace-rs")
    (synopsis
     "A library to acquire a stack trace (backtrace) at runtime in a Rust program.
")
    (description
     "This package provides a library to acquire a stack trace (backtrace) at runtime
in a Rust program.")
    (license (list license:expat license:asl2.0))))
 
(define rust-anyhow-1
  (package
    (name "rust-anyhow")
    (version "1.0.75")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "anyhow" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1rmcjkim91c5mw7h9wn8nv0k6x118yz0xg0z1q18svgn42mqqrm4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build? #t
       #:cargo-inputs (("rust-backtrace" ,rust-backtrace-0.3))))
    (home-page "https://github.com/dtolnay/anyhow")
    (synopsis "Flexible concrete Error type built on std::error::Error")
    (description "Flexible concrete Error type built on std::error::Error")
    (license (list license:expat license:asl2.0))))

(define rust-syn-2
  (package
    (name "rust-syn")
    (version "2.0.28")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "syn" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0rqm6lnxdgg5blva19l2sjr7iwj2r5dwb3cx32r4iqzmndsijdh4"))))
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

(define-public rust-bottom-0.9
  (package
    (name "rust-bottom")
    (version "0.9.6")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "bottom" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1rr74py6d4hm0mnzvr13q7grrjgxhnzkqyqjclgc2zfi8b65wbf8"))))
    (build-system cargo-build-system)
    ;(propagated-inputs (list nvidia-nvml))
    (arguments
     `(#:install-source? #f
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-clap" ,rust-clap-4)
                       ("rust-clap-complete" ,rust-clap-complete-4)
                       ("rust-clap-mangen" ,rust-clap-mangen-0.2) ;; ADDED
                       ("rust-concat-string" ,rust-concat-string-1) ;; ADDED
                       ("rust-core-foundation" ,rust-core-foundation-0.9)
                       ("rust-crossterm" ,rust-crossterm-0.27)
                       ("rust-ctrlc" ,rust-ctrlc-3)
                       ("rust-dirs" ,rust-dirs-5) ;; ADDED
                       ("rust-fern" ,rust-fern-0.6)
                       ("rust-filedescriptor" ,rust-filedescriptor-0.8) ;; ADDED
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-humantime" ,rust-humantime-2)
                       ;("rust-humantime-serde" ,rust-humantime-serde-1)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-itertools" ,rust-itertools-0.11)
                       ("rust-kstring" ,rust-kstring-2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mach2" ,rust-mach2-0.4);; ADDED
                       ("rust-nvml-wrapper" ,rust-nvml-wrapper-0.9);; ADDED
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-ratatui" ,rust-ratatui-0.22);; ADDED
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-starship-battery" ,rust-starship-battery-0.8);; ADDED
                       ("rust-sysctl" ,rust-sysctl-0.5)
                       ("rust-sysinfo" ,rust-sysinfo-0.29)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-toml-edit" ,rust-toml-edit-0.19)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1) ;; ADDED
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-windows" ,rust-windows-0.51))
       #:cargo-development-inputs (("rust-assert-cmd" ,rust-assert-cmd-2)
                                   ("rust-cargo-husky" ,rust-cargo-husky-1)
                                   ("rust-predicates" ,rust-predicates-3))))
    (home-page "https://github.com/ClementTsang/bottom")
    (synopsis
     "A customizable cross-platform graphical process/system monitor for the terminal. Supports Linux, macOS, and Windows.")
    (description
     "This package provides a customizable cross-platform graphical process/system
monitor for the terminal.  Supports Linux, macOS, and Windows.")
    (license license:expat)))

;rust-bottom-0.9
