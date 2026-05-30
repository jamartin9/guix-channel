(define-module (jam packages dolby)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system cargo) ;rust-dolby-vision-3 for vs-placebo and vs-nlq
  #:use-module (gnu packages rust) ;rust-cargo-c for rust-dolby-vision-3
  #:use-module (gnu packages rust-apps) ;for vs-nlq
  ;; #:use-module (gnu packages rust-crates) ; for vs-nlq
  ;; #:use-module (gnu packages rust-sources) ; for vs-nlq (criterion)
  #:use-module (gnu packages video) ;vapoursynth for vs-nlq
  #:use-module (jam packages) ;for search-patches
  #:use-module (jam packages vs) ;for vapoursynth-git
  #:use-module ((guix licenses)
                #:prefix license:))
;; guix import crate -f Cargo.lock dolby_vision
(define rust-aho-corasick-1.1.3
  (crate-source "aho-corasick" "1.1.3"
                "05mrpkvdgp5d20y2p989f187ry9diliijgwrs254fs9s1m1x6q4f"))

(define rust-anes-0.1.6
  (crate-source "anes" "0.1.6"
                "16bj1ww1xkwzbckk32j2pnbn5vk6wgsl3q4p3j9551xbcarwnijb"))

(define rust-anstyle-1.0.10
  (crate-source "anstyle" "1.0.10"
                "1yai2vppmd7zlvlrp9grwll60knrmscalf8l2qpfz8b7y5lkpk2m"))

(define rust-anyhow-1.0.98
  (crate-source "anyhow" "1.0.98"
                "11ylvjdrcjs0q9jgk1af4r5cx1qppj63plxqkq595vmc24rjsvg1"))

(define rust-autocfg-1.4.0
  (crate-source "autocfg" "1.4.0"
                "09lz3by90d2hphbq56znag9v87gfpd9gb8nr82hll8z6x2nhprdc"))

(define rust-bitstream-io-2.6.0
  (crate-source "bitstream-io" "2.6.0"
                "1cli390l1dhp9skygyjjnqvczp36b7f31mkx9ry3dg26330cv6b0"))

(define rust-bitvec-1.0.1
  (crate-source "bitvec" "1.0.1"
                "173ydyj2q5vwj88k6xgjnfsshs4x9wbvjjv7sm0h36r34hn87hhv"))

(define rust-bitvec-helpers-3.1.6
  (crate-source "bitvec_helpers" "3.1.6"
                "16kh7454glivrjvwpvndzzyfma3hs74pjcxx8vqi8hd3fzwsz9nr"))

(define rust-bumpalo-3.17.0
  (crate-source "bumpalo" "3.17.0"
                "1gxxsn2fsjmv03g8p3m749mczv2k4m8xspifs5l7bcx0vx3gna0n"))

(define rust-cast-0.3.0
  (crate-source "cast" "0.3.0"
                "1dbyngbyz2qkk0jn2sxil8vrz3rnpcj142y184p9l4nbl9radcip"))

(define rust-cfg-if-1.0.0
  (crate-source "cfg-if" "1.0.0"
                "1za0vb97n4brpzpv8lsbnzmq5r8f2b0cpqqr0sy8h5bn751xxwds"))

(define rust-ciborium-0.2.2
  (crate-source "ciborium" "0.2.2"
                "03hgfw4674im1pdqblcp77m7rc8x2v828si5570ga5q9dzyrzrj2"))

(define rust-ciborium-io-0.2.2
  (crate-source "ciborium-io" "0.2.2"
                "0my7s5g24hvp1rs1zd1cxapz94inrvqpdf1rslrvxj8618gfmbq5"))

(define rust-ciborium-ll-0.2.2
  (crate-source "ciborium-ll" "0.2.2"
                "1n8g4j5rwkfs3rzfi6g1p7ngmz6m5yxsksryzf5k72ll7mjknrjp"))

(define rust-clap-4.5.39
  (crate-source "clap" "4.5.39"
                "17raqwxkhhhm80iyblp1v83fvpddkg7rgqr2cjsmz3p6kczfcq7x"))

(define rust-clap-builder-4.5.39
  (crate-source "clap_builder" "4.5.39"
                "0lggb5vscs21jliisvjjphcazzb1iw8347yp42wbwazpl6967k49"))

(define rust-clap-lex-0.7.4
  (crate-source "clap_lex" "0.7.4"
                "19nwfls5db269js5n822vkc8dw0wjq2h1wf0hgr06ld2g52d2spl"))

(define rust-crc-3.3.0
  (crate-source "crc" "3.3.0"
                "0xg6yg57lbyzf69y8znq5gjb333w1fnlis2gnjg38blwffrx644p"))

(define rust-crc-catalog-2.4.0
  (crate-source "crc-catalog" "2.4.0"
                "1xg7sz82w3nxp1jfn425fvn1clvbzb3zgblmxsyqpys0dckp9lqr"))

(define rust-criterion-0.6.0
  (crate-source "criterion" "0.6.0"
                "0ya6igyv29wm1i11hscclmasc4hrr5ybslg51fyq34wqn1kazxrv"))

(define rust-criterion-plot-0.5.0
  (crate-source "criterion-plot" "0.5.0"
                "1c866xkjqqhzg4cjvg01f8w6xc1j3j7s58rdksl52skq89iq4l3b"))

(define rust-crossbeam-deque-0.8.6
  (crate-source "crossbeam-deque" "0.8.6"
                "0l9f1saqp1gn5qy0rxvkmz4m6n7fc0b3dbm6q1r5pmgpnyvi3lcx"))

(define rust-crossbeam-epoch-0.9.18
  (crate-source "crossbeam-epoch" "0.9.18"
                "03j2np8llwf376m3fxqx859mgp9f83hj1w34153c7a9c7i5ar0jv"))

(define rust-crossbeam-utils-0.8.21
  (crate-source "crossbeam-utils" "0.8.21"
                "0a3aa2bmc8q35fb67432w16wvi54sfmb69rk9h5bhd18vw0c99fh"))

(define rust-crunchy-0.2.3
  (crate-source "crunchy" "0.2.3"
                "0aa9k4izp962qlsn5ndgw2zq62mizcpnkns8bxscgz3gqr35knj3"))

(define rust-either-1.15.0
  (crate-source "either" "1.15.0"
                "069p1fknsmzn9llaizh77kip0pqmcwpdsykv2x30xpjyija5gis8"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-funty-2.0.0
  (crate-source "funty" "2.0.0"
                "177w048bm0046qlzvp33ag3ghqkqw4ncpzcm5lq36gxf2lla7mg6"))

(define rust-half-2.6.0
  (crate-source "half" "2.6.0"
                "1j83v0xaqvrw50ppn0g33zig0zsbdi7xiqbzgn7sd5al57nrd4a5"))

(define rust-hashbrown-0.15.3
  (crate-source "hashbrown" "0.15.3"
                "1cwfw1yzkvsqkhmkg5igdvgsl8a0wyi716cn83k2j8h09ma6rcl4"))

(define rust-indexmap-2.9.0
  (crate-source "indexmap" "2.9.0"
                "07m15a571yywmvqyb7ms717q9n42b46badbpsmx215jrg7dhv9yf"))

(define rust-itertools-0.10.5
  (crate-source "itertools" "0.10.5"
                "0ww45h7nxx5kj6z2y6chlskxd1igvs4j507anr6dzg99x1h25zdh"))

(define rust-itertools-0.13.0
  (crate-source "itertools" "0.13.0"
                "11hiy3qzl643zcigknclh446qb9zlg4dpdzfkjaa9q9fqpgyfgj1"))

(define rust-itoa-1.0.15
  (crate-source "itoa" "1.0.15"
                "0b4fj9kz54dr3wam0vprjwgygvycyw8r0qwg7vp19ly8b2w16psa"))

(define rust-js-sys-0.3.77
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "js-sys" "0.3.77"
                "13x2qcky5l22z4xgivi59xhjjx4kxir1zg7gcj0f1ijzd4yg7yhw"))

(define rust-libc-0.2.172
  (crate-source "libc" "0.2.172"
                "1ykz4skj7gac14znljm5clbnrhini38jkq3d60jggx3y5w2ayl6p"))

(define rust-log-0.4.27
  (crate-source "log" "0.4.27"
                "150x589dqil307rv0rwj0jsgz5bjbwvl83gyl61jf873a7rjvp0k"))

(define rust-memchr-2.7.4
  (crate-source "memchr" "2.7.4"
                "18z32bhxrax0fnjikv475z7ii718hq457qwmaryixfxsl2qrmjkq"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-once-cell-1.21.3
  (crate-source "once_cell" "1.21.3"
                "0b9x77lb9f1j6nqgf5aka4s2qj0nly176bpbrv6f9iakk5ff3xa2"))

(define rust-oorandom-11.1.5
  (crate-source "oorandom" "11.1.5"
                "07mlf13z453fq01qff38big1lh83j8l6aaglf63ksqzzqxc0yyfn"))

(define rust-plotters-0.3.7
  (crate-source "plotters" "0.3.7"
                "0ixpy9svpmr2rkzkxvvdpysjjky4gw104d73n7pi2jbs7m06zsss"))

(define rust-plotters-backend-0.3.7
  (crate-source "plotters-backend" "0.3.7"
                "0ahpliim4hrrf7d4ispc2hwr7rzkn6d6nf7lyyrid2lm28yf2hnz"))

(define rust-plotters-svg-0.3.7
  (crate-source "plotters-svg" "0.3.7"
                "0w56sxaa2crpasa1zj0bhxzihlapqfkncggavyngg0w86anf5fji"))

(define rust-proc-macro2-1.0.95
  (crate-source "proc-macro2" "1.0.95"
                "0y7pwxv6sh4fgg6s715ygk1i7g3w02c0ljgcsfm046isibkfbcq2"))

(define rust-quote-1.0.40
  (crate-source "quote" "1.0.40"
                "1394cxjg6nwld82pzp2d4fp6pmaz32gai1zh9z5hvh0dawww118q"))

(define rust-radium-0.7.0
  (crate-source "radium" "0.7.0"
                "02cxfi3ky3c4yhyqx9axqwhyaca804ws46nn4gc1imbk94nzycyw"))

(define rust-rayon-1.10.0
  (crate-source "rayon" "1.10.0"
                "1ylgnzwgllajalr4v00y4kj22klq2jbwllm70aha232iah0sc65l"))

(define rust-rayon-core-1.12.1
  (crate-source "rayon-core" "1.12.1"
                "1qpwim68ai5h0j7axa8ai8z0payaawv3id0lrgkqmapx7lx8fr8l"))

(define rust-regex-1.11.1
  (crate-source "regex" "1.11.1"
                "148i41mzbx8bmq32hsj1q4karkzzx5m60qza6gdw4pdc9qdyyi5m"))

(define rust-regex-automata-0.4.9
  (crate-source "regex-automata" "0.4.9"
                "02092l8zfh3vkmk47yjc8d631zhhcd49ck2zr133prvd3z38v7l0"))

(define rust-regex-syntax-0.8.5
  (crate-source "regex-syntax" "0.8.5"
                "0p41p3hj9ww7blnbwbj9h7rwxzxg0c1hvrdycgys8rxyhqqw859b"))

(define rust-roxmltree-0.20.0
  (crate-source "roxmltree" "0.20.0"
                "15vw91ps91wkmmgy62khf9zb63bdinvm80957dascbsw7dwvc83c"))

(define rust-rustversion-1.0.21
  (crate-source "rustversion" "1.0.21"
                "07bb1xx05hhwpnl43sqrhsmxyk5sd5m5baadp19nxp69s9xij3ca"))

(define rust-ryu-1.0.20
  (crate-source "ryu" "1.0.20"
                "07s855l8sb333h6bpn24pka5sp7hjk2w667xy6a0khkf6sqv5lr8"))

(define rust-same-file-1.0.6
  (crate-source "same-file" "1.0.6"
                "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))

(define rust-serde-1.0.219
  (crate-source "serde" "1.0.219"
                "1dl6nyxnsi82a197sd752128a4avm6mxnscywas1jq30srp2q3jz"))

(define rust-serde-derive-1.0.219
  (crate-source "serde_derive" "1.0.219"
                "001azhjmj7ya52pmfiw4ppxm16nd44y15j2pf5gkcwrcgz7pc0jv"))

(define rust-serde-json-1.0.140
  (crate-source "serde_json" "1.0.140"
                "0wwkp4vc20r87081ihj3vpyz5qf7wqkqipq17v99nv6wjrp8n1i0"))

(define rust-syn-2.0.101
  (crate-source "syn" "2.0.101"
                "1brwsh7fn3bnbj50d2lpwy9akimzb3lghz0ai89j8fhvjkybgqlc"))

(define rust-tap-1.0.1
  (crate-source "tap" "1.0.1"
                "0sc3gl4nldqpvyhqi3bbd0l9k7fngrcl4zs47n314nqqk4bpx4sm"))

(define rust-tinytemplate-1.2.1
  (crate-source "tinytemplate" "1.2.1"
                "1g5n77cqkdh9hy75zdb01adxn45mkh9y40wdr7l68xpz35gnnkdy"))

(define rust-tinyvec-1.9.0
  (crate-source "tinyvec" "1.9.0"
                "0w9w8qcifns9lzvlbfwa01y0skhr542anwa3rpn28rg82wgndcq9"))

(define rust-unicode-ident-1.0.18
  (crate-source "unicode-ident" "1.0.18"
                "04k5r6sijkafzljykdq26mhjpmhdx4jwzvn1lh90g9ax9903jpss"))

(define rust-walkdir-2.5.0
  (crate-source "walkdir" "2.5.0"
                "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))

(define rust-wasm-bindgen-0.2.100
  (crate-source "wasm-bindgen" "0.2.100"
                "1x8ymcm6yi3i1rwj78myl1agqv2m86i648myy3lc97s9swlqkp0y"))

(define rust-wasm-bindgen-backend-0.2.100
  (crate-source "wasm-bindgen-backend" "0.2.100"
                "1ihbf1hq3y81c4md9lyh6lcwbx6a5j0fw4fygd423g62lm8hc2ig"))

(define rust-wasm-bindgen-macro-0.2.100
  (crate-source "wasm-bindgen-macro" "0.2.100"
                "01xls2dvzh38yj17jgrbiib1d3nyad7k2yw9s0mpklwys333zrkz"))

(define rust-wasm-bindgen-macro-support-0.2.100
  (crate-source "wasm-bindgen-macro-support" "0.2.100"
                "1plm8dh20jg2id0320pbmrlsv6cazfv6b6907z19ys4z1jj7xs4a"))

(define rust-wasm-bindgen-shared-0.2.100
  (crate-source "wasm-bindgen-shared" "0.2.100"
                "0gffxvqgbh9r9xl36gprkfnh3w9gl8wgia6xrin7v11sjcxxf18s"))

(define rust-web-sys-0.3.77
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "web-sys" "0.3.77"
                "1lnmc1ffbq34qw91nndklqqm75rasaffj2g4f8h1yvqqz4pdvdik"))

(define rust-winapi-util-0.1.9
  (crate-source "winapi-util" "0.1.9"
                "1fqhkcl9scd230cnfj8apfficpf5c9vhwnk4yy9xfc1sw69iq8ng"))

(define rust-windows-sys-0.59.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.59.0"
                "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-wyz-0.5.1
  (crate-source "wyz" "0.5.1"
                "1vdrfy7i2bznnzjdl9vvrzljvs4s3qm8bnlgqwln6a941gy61wq5"))

;; guix import crate dolby_vision
(define-public rust-dolby-vision-3
  (package
    (name "rust-dolby-vision")
    (version "3.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dolby_vision" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "167pn3iji2rcyjdm8y0j7wpabm3z4wrfxz475s106kbg6cr9ygak"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:phases (modify-phases %standard-phases
                  (replace 'build
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let ((out (assoc-ref outputs "out")))
                        (invoke "cargo" "cinstall" "--release"
                                (string-append "--prefix=" out))))))))
    (native-inputs `(("cargo-c" ,rust-cargo-c))) ;guix import crate -f Cargo.lock dolby_vision | grep "(define" | grep -o " .*"
    (inputs (list  rust-aho-corasick-1.1.3
                   rust-anes-0.1.6
                   rust-anstyle-1.0.10
                   rust-anyhow-1.0.98
                   rust-autocfg-1.4.0
                   rust-bitstream-io-2.6.0
                   rust-bitvec-1.0.1
                   rust-bitvec-helpers-3.1.6
                   rust-bumpalo-3.17.0
                   rust-cast-0.3.0
                   rust-cfg-if-1.0.0
                   rust-ciborium-0.2.2
                   rust-ciborium-io-0.2.2
                   rust-ciborium-ll-0.2.2
                   rust-clap-4.5.39
                   rust-clap-builder-4.5.39
                   rust-clap-lex-0.7.4
                   rust-crc-3.3.0
                   rust-crc-catalog-2.4.0
                   rust-criterion-0.6.0
                   rust-criterion-plot-0.5.0
                   rust-crossbeam-deque-0.8.6
                   rust-crossbeam-epoch-0.9.18
                   rust-crossbeam-utils-0.8.21
                   rust-crunchy-0.2.3
                   rust-either-1.15.0
                   rust-equivalent-1.0.2
                   rust-funty-2.0.0
                   rust-half-2.6.0
                   rust-hashbrown-0.15.3
                   rust-indexmap-2.9.0
                   rust-itertools-0.10.5
                   rust-itertools-0.13.0
                   rust-itoa-1.0.15
                   rust-js-sys-0.3.77
                   rust-libc-0.2.172
                   rust-log-0.4.27
                   rust-memchr-2.7.4
                   rust-num-traits-0.2.19
                   rust-once-cell-1.21.3
                   rust-oorandom-11.1.5
                   rust-plotters-0.3.7
                   rust-plotters-backend-0.3.7
                   rust-plotters-svg-0.3.7
                   rust-proc-macro2-1.0.95
                   rust-quote-1.0.40
                   rust-radium-0.7.0
                   rust-rayon-1.10.0
                   rust-rayon-core-1.12.1
                   rust-regex-1.11.1
                   rust-regex-automata-0.4.9
                   rust-regex-syntax-0.8.5
                   rust-roxmltree-0.20.0
                   rust-rustversion-1.0.21
                   rust-ryu-1.0.20
                   rust-same-file-1.0.6
                   rust-serde-1.0.219
                   rust-serde-derive-1.0.219
                   rust-serde-json-1.0.140
                   rust-syn-2.0.101
                   rust-tap-1.0.1
                   rust-tinytemplate-1.2.1
                   rust-tinyvec-1.9.0
                   rust-unicode-ident-1.0.18
                   rust-walkdir-2.5.0
                   rust-wasm-bindgen-0.2.100
                   rust-wasm-bindgen-backend-0.2.100
                   rust-wasm-bindgen-macro-0.2.100
                   rust-wasm-bindgen-macro-support-0.2.100
                   rust-wasm-bindgen-shared-0.2.100
                   rust-web-sys-0.3.77
                   rust-winapi-util-0.1.9
                   rust-windows-sys-0.59.0
                   rust-windows-targets-0.52.6
                   rust-windows-aarch64-gnullvm-0.52.6
                   rust-windows-aarch64-msvc-0.52.6
                   rust-windows-i686-gnu-0.52.6
                   rust-windows-i686-gnullvm-0.52.6
                   rust-windows-i686-msvc-0.52.6
                   rust-windows-x86-64-gnu-0.52.6
                   rust-windows-x86-64-gnullvm-0.52.6
                   rust-windows-x86-64-msvc-0.52.6
                   rust-wyz-0.5.1
                   ))
    (home-page "https://github.com/quietvoid/dovi_tool/tree/main/dolby_vision")
    (synopsis "Dolby Vision metadata parsing and writing")
    (description
     "This package provides Dolby Vision metadata parsing and writing.")
    (license license:expat)))

(define rust-anyhow-1.0.102
  (crate-source "anyhow" "1.0.102"
                "0b447dra1v12z474c6z4jmicdmc5yxz5bakympdnij44ckw2s83z"))

(define rust-cfg-if-1.0.4
  (crate-source "cfg-if" "1.0.4"
                "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))

(define rust-crc-3.4.0
  (crate-source "crc" "3.4.0"
                "03dsq5qsv86m35ikg84l80d00wnkjm8q4pjxgac0vaqjrnhs5f2y"))

(define rust-crc-catalog-2.5.0
  (crate-source "crc-catalog" "2.5.0"
                "0lq8dl60g457za8la86pak6i7ydxanm2lrpkqh5kyjkbz7m9hxi1"))

(define rust-dolby-vision-3.3.2
  (crate-source "dolby_vision" "3.3.2"
                "167pn3iji2rcyjdm8y0j7wpabm3z4wrfxz475s106kbg6cr9ygak"))

(define rust-itertools-0.14.0
  (crate-source "itertools" "0.14.0"
                "118j6l1vs2mx65dqhwyssbrxpawa90886m3mzafdvyip41w2q69b"))

(define rust-libloading-0.9.0
  (crate-source "libloading" "0.9.0"
                "0q4bvhp4kqy2v3bw4cn2bmyq73hskqd1ansa9125gfq5x0ns4k3m"))

(define rust-proc-macro2-1.0.106
  (crate-source "proc-macro2" "1.0.106"
                "0d09nczyaj67x4ihqr5p7gxbkz38gxhk4asc0k8q23g9n85hzl4g"))

(define rust-quote-1.0.45
  (crate-source "quote" "1.0.45"
                "095rb5rg7pbnwdp6v8w5jw93wndwyijgci1b5lw8j1h5cscn3wj1"))

(define rust-syn-2.0.117
  (crate-source "syn" "2.0.117"
                "16cv7c0wbn8amxc54n4w15kxlx5ypdmla8s0gxr2l7bv7s0bhrg6"))

(define rust-thiserror-2.0.18
  (crate-source "thiserror" "2.0.18"
                "1i7vcmw9900bvsmay7mww04ahahab7wmr8s925xc083rpjybb222"))

(define rust-thiserror-impl-2.0.18
  (crate-source "thiserror-impl" "2.0.18"
                "1mf1vrbbimj1g6dvhdgzjmn6q09yflz2b92zs1j9n3k7cxzyxi7b"))

(define rust-tinyvec-1.11.0
  (crate-source "tinyvec" "1.11.0"
                "1wvycrghzmaysnw34kzwnf0mfx6r75045s24r214wnnjadqfcq9y"))

(define rust-unicode-ident-1.0.24
  (crate-source "unicode-ident" "1.0.24"
                "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))

(define rust-vapoursynth-0.5.4
  (crate-source "vapoursynth" "0.5.4"
                "1kq1pdkf37l3chvb69xnvvkwlg5gphzwhjf1dx52w3bfym8ch5lk"))

(define rust-vapoursynth-sys-0.6.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "vapoursynth-sys" "0.6.0"
                "0bp18kzi90vjnvkinm9spgmyshq4x8nbxb8y4phdn4vnh72pvx2f"))

(define rust-windows-link-0.2.1
  (crate-source "windows-link" "0.2.1"
                "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))

(define rust-wyz-0.5.1
  (crate-source "wyz" "0.5.1"
                "1vdrfy7i2bznnzjdl9vvrzljvs4s3qm8bnlgqwln6a941gy61wq5"))

(define-public rust-vs-nlq
  (package
    (name "rust-vs-nlq")
    (version "git-97cbb19")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/quietvoid/vs-nlq")
             (commit "97cbb19a9883feb05e558a6fb4a2192b7c6d8005")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0prvcxg9sla1r1cfap2q4k5gs6z4g13a9fq7fw2b1947k2ygqmr5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:phases (modify-phases %standard-phases
                  (add-after 'install 'install-library
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let ((out (assoc-ref outputs "out")))
                        (install-file (car (find-files "." "^libvs_nlq\\.so$"))
                                      (string-append out "/lib/vapoursynth"))))))))
    (inputs (list rust-aho-corasick-1.1.3
                   rust-anes-0.1.6
                   rust-anstyle-1.0.10
                   rust-anyhow-1.0.98
                   rust-autocfg-1.4.0
                   rust-bitstream-io-2.6.0
                   rust-bitvec-1.0.1
                   rust-bitvec-helpers-3.1.6
                   rust-bumpalo-3.17.0
                   rust-cast-0.3.0
                   rust-cfg-if-1.0.0
                   rust-ciborium-0.2.2
                   rust-ciborium-io-0.2.2
                   rust-ciborium-ll-0.2.2
                   rust-clap-4.5.39
                   rust-clap-builder-4.5.39
                   rust-clap-lex-0.7.4
                   rust-crc-3.3.0
                   rust-crc-catalog-2.4.0
                   rust-criterion-0.6.0
                   rust-criterion-plot-0.5.0
                   rust-crossbeam-deque-0.8.6
                   rust-crossbeam-epoch-0.9.18
                   rust-crossbeam-utils-0.8.21
                   rust-crunchy-0.2.3
                   rust-either-1.15.0
                   rust-equivalent-1.0.2
                   rust-funty-2.0.0
                   rust-half-2.6.0
                   rust-hashbrown-0.15.3
                   rust-indexmap-2.9.0
                   rust-itertools-0.10.5
                   rust-itertools-0.13.0
                   rust-itoa-1.0.15
                   rust-js-sys-0.3.77
                   rust-libc-0.2.172
                   rust-log-0.4.27
                   rust-memchr-2.7.4
                   rust-num-traits-0.2.19
                   rust-once-cell-1.21.3
                   rust-oorandom-11.1.5
                   rust-plotters-0.3.7
                   rust-plotters-backend-0.3.7
                   rust-plotters-svg-0.3.7
                   rust-proc-macro2-1.0.95
                   rust-quote-1.0.40
                   rust-radium-0.7.0
                   rust-rayon-1.10.0
                   rust-rayon-core-1.12.1
                   rust-regex-1.11.1
                   rust-regex-automata-0.4.9
                   rust-regex-syntax-0.8.5
                   rust-roxmltree-0.20.0
                   rust-rustversion-1.0.21
                   rust-ryu-1.0.20
                   rust-same-file-1.0.6
                   rust-serde-1.0.219
                   rust-serde-derive-1.0.219
                   rust-serde-json-1.0.140
                   rust-syn-2.0.101
                   rust-tap-1.0.1
                   rust-tinytemplate-1.2.1
                   rust-tinyvec-1.9.0
                   rust-unicode-ident-1.0.18
                   rust-walkdir-2.5.0
                   rust-wasm-bindgen-0.2.100
                   rust-wasm-bindgen-backend-0.2.100
                   rust-wasm-bindgen-macro-0.2.100
                   rust-wasm-bindgen-macro-support-0.2.100
                   rust-wasm-bindgen-shared-0.2.100
                   rust-web-sys-0.3.77
                   rust-winapi-util-0.1.9
                   rust-windows-sys-0.59.0
                   rust-windows-targets-0.52.6
                   rust-windows-aarch64-gnullvm-0.52.6
                   rust-windows-aarch64-msvc-0.52.6
                   rust-windows-i686-gnu-0.52.6
                   rust-windows-i686-gnullvm-0.52.6
                   rust-windows-i686-msvc-0.52.6
                   rust-windows-x86-64-gnu-0.52.6
                   rust-windows-x86-64-gnullvm-0.52.6
                   rust-windows-x86-64-msvc-0.52.6
                   rust-wyz-0.5.1
                  rust-dolby-vision-3.3.2 ;above are dolby-vision-deps
                  rust-anyhow-1.0.102
                  rust-cfg-if-1.0.4
                  rust-crc-3.4.0
                  rust-crc-catalog-2.5.0
                  rust-itertools-0.14.0
                  rust-libloading-0.9.0
                  rust-proc-macro2-1.0.106
                  rust-quote-1.0.45
                  rust-syn-2.0.117
                  rust-thiserror-2.0.18
                  rust-thiserror-impl-2.0.18
                  rust-tinyvec-1.11.0
                  rust-unicode-ident-1.0.24
                  rust-vapoursynth-0.5.4
                  rust-vapoursynth-sys-0.6.0
                  rust-windows-link-0.2.1
                  vapoursynth-git))
    (home-page "https://github.com/quietvoid/vs-nlq/")
    (synopsis "vs-nlq plugin for vapoursynth")
    (description "Dolby Vision FEL mapping plugin for vapoursynth")
    (license license:expat)))


;rust-dolby-vision-3
rust-vs-nlq
