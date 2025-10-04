(define-module (jam packages vspreview)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages video) ; vapoursynth
  #:use-module (jam packages) ; for search-patches
  #:use-module ((guix licenses) #:prefix license:))

(define rust-ab-glyph-0.2.29
  (crate-source "ab_glyph" "0.2.29"
                "1c7p94qf8x6n62nrbia7nzwdxm2sbyygnhd5qfmfl7p7h30p4dpc"))

(define rust-ab-glyph-rasterizer-0.1.8
  (crate-source "ab_glyph_rasterizer" "0.1.8"
                "0ikhgzig59q8b1a1iw83sxfnvylg5gx6w2y8ynbnf231xs9if6y7"))

(define rust-accesskit-0.12.3
  (crate-source "accesskit" "0.12.3"
                "0szw1d6ml049779m55h0l107abhsmchmdx58rdfjbhcr7m7v393l"))

(define rust-accesskit-consumer-0.16.1
  (crate-source "accesskit_consumer" "0.16.1"
                "1rj5vsaxn9m5aazr22vzlb5bxfbl28h2mck7hqldgyq97jjwq5wc"))

(define rust-accesskit-macos-0.10.1
  (crate-source "accesskit_macos" "0.10.1"
                "19vpwi1cnyxbjal4ngjb2x7yhfm9x3yd63w41v8wxyxvxbhnlfyd"))

(define rust-accesskit-unix-0.6.2
  (crate-source "accesskit_unix" "0.6.2"
                "022a77nm8461v0f6mpzidamkci0h1kmkxl9x2bbim9lvv4c6rx09"))

(define rust-accesskit-windows-0.15.1
  (crate-source "accesskit_windows" "0.15.1"
                "02sazww6l5h0wsgif0npdpkb5lczx0xph65kn31wfkwpq1zf5jmg"))

(define rust-accesskit-winit-0.16.1
  (crate-source "accesskit_winit" "0.16.1"
                "0rwaz6mkllcl131b8y4s787gfmdrqzms0a242r8f3n8pra52312j"))

(define rust-addr2line-0.24.2
  (crate-source "addr2line" "0.24.2"
                "1hd1i57zxgz08j6h5qrhsnm2fi0bcqvsh389fw400xm3arz2ggnz"))

(define rust-adler2-2.0.0
  (crate-source "adler2" "2.0.0"
                "09r6drylvgy8vv8k20lnbvwq8gp09h7smfn6h1rxsy15pgh629si"))

(define rust-ahash-0.8.11
  (crate-source "ahash" "0.8.11"
                "04chdfkls5xmhp1d48gnjsmglbqibizs3bpbj6rsj604m10si7g8"))

(define rust-aho-corasick-1.1.3
  (crate-source "aho-corasick" "1.1.3"
                "05mrpkvdgp5d20y2p989f187ry9diliijgwrs254fs9s1m1x6q4f"))

(define rust-allocator-api2-0.2.21
  (crate-source "allocator-api2" "0.2.21"
                "08zrzs022xwndihvzdn78yqarv2b9696y67i6h78nla3ww87jgb8"))

(define rust-android-activity-0.5.2
  (crate-source "android-activity" "0.5.2"
                "12a2qky6147bvs40iz83fxmz47al6r2h8kps9gw49bjvj31c14gf"))

(define rust-android-properties-0.2.2
  (crate-source "android-properties" "0.2.2"
                "016slvg269c0y120p9qd8vdfqa2jbw4j0g18gfw6p3ain44v4zpw"))

(define rust-android-system-properties-0.1.5
  (crate-source "android_system_properties" "0.1.5"
                "04b3wrz12837j7mdczqd95b732gw5q7q66cv4yn4646lvccp57l1"))

(define rust-anstream-0.6.18
  (crate-source "anstream" "0.6.18"
                "16sjk4x3ns2c3ya1x28a44kh6p47c7vhk27251i015hik1lm7k4a"))

(define rust-anstyle-1.0.10
  (crate-source "anstyle" "1.0.10"
                "1yai2vppmd7zlvlrp9grwll60knrmscalf8l2qpfz8b7y5lkpk2m"))

(define rust-anstyle-parse-0.2.6
  (crate-source "anstyle-parse" "0.2.6"
                "1acqayy22fwzsrvr6n0lz6a4zvjjcvgr5sm941m7m0b2fr81cb9v"))

(define rust-anstyle-query-1.1.2
  (crate-source "anstyle-query" "1.1.2"
                "036nm3lkyk43xbps1yql3583fp4hg3b1600is7mcyxs1gzrpm53r"))

(define rust-anstyle-wincon-3.0.6
  (crate-source "anstyle-wincon" "3.0.6"
                "099ir0w3lbpsp1nxdzbf4anq98ww8ykyc9pd1g03xgkj1v7dn291"))

(define rust-anyhow-1.0.94
  (crate-source "anyhow" "1.0.94"
                "1xqz3j4h3dxiqi37k8dwl5cc2sb3rlzy7rywfqiblf7g52h07zf1"))

(define rust-arboard-3.4.1
  (crate-source "arboard" "3.4.1"
                "1x2p8dfhzm3w0cpw81ab2rbyzvkzqs9g66xcakq4y0fd2v5rq2fz"))

(define rust-arrayref-0.3.9
  (crate-source "arrayref" "0.3.9"
                "1jzyp0nvp10dmahaq9a2rnxqdd5wxgbvp8xaibps3zai8c9fi8kn"))

(define rust-arrayvec-0.7.6
  (crate-source "arrayvec" "0.7.6"
                "0l1fz4ccgv6pm609rif37sl5nv5k6lbzi7kkppgzqzh1vwix20kw"))

(define rust-as-raw-xcb-connection-1.0.1
  (crate-source "as-raw-xcb-connection" "1.0.1"
                "0sqgpz2ymv5yx76r5j2npjq2x5qvvqnw0vrs35cyv30p3pfp2m8p"))

(define rust-ash-0.37.3+1.3.251
  (crate-source "ash" "0.37.3+1.3.251"
                "0jndbsi5c8xifh4fdp378xpbyzdhs7y38hmbhih0lsv8bn1w7s9r"))

(define rust-ashpd-0.10.2
  (crate-source "ashpd" "0.10.2"
                "1cw0ngs9037w3sb61vb67vzf7n48yhwma080xmmwrnqlfrq9vhz9"))

(define rust-async-broadcast-0.5.1
  (crate-source "async-broadcast" "0.5.1"
                "0avdqbci1qdlfc4glc3wqrb0wi5ffc7bqv2q1wg14syayvdwqj3w"))

(define rust-async-broadcast-0.7.1
  (crate-source "async-broadcast" "0.7.1"
                "0zia7z1y31awmxma9c89zmvkbj7mdkf7highkmz5z3pa4lp0xk90"))

(define rust-async-channel-2.3.1
  (crate-source "async-channel" "2.3.1"
                "0skvwxj6ysfc6d7bhczz9a2550260g62bm5gl0nmjxxyn007id49"))

(define rust-async-executor-1.13.1
  (crate-source "async-executor" "1.13.1"
                "1v6w1dbvsmw6cs4dk4lxj5dvrikc6xi479wikwaab2qy3h09mjih"))

(define rust-async-fs-1.6.0
  (crate-source "async-fs" "1.6.0"
                "01if2h77mry9cnm91ql2md595108i2c1bfy9gaivzvjfcl2gk717"))

(define rust-async-fs-2.1.2
  (crate-source "async-fs" "2.1.2"
                "0jp0p7lg9zqy2djgdmivbzx0yqmfn9sm2s9dkhaws3zlharhkkgb"))

(define rust-async-io-1.13.0
  (crate-source "async-io" "1.13.0"
                "1byj7lpw0ahk6k63sbc9859v68f28hpaab41dxsjj1ggjdfv9i8g"))

(define rust-async-io-2.4.0
  (crate-source "async-io" "2.4.0"
                "0n8h0vy53n4vdkq529scqnkzm9vcl3r73za9nj81s2nfrhiv78j3"))

(define rust-async-lock-2.8.0
  (crate-source "async-lock" "2.8.0"
                "0asq5xdzgp3d5m82y5rg7a0k9q0g95jy6mgc7ivl334x7qlp4wi8"))

(define rust-async-lock-3.4.0
  (crate-source "async-lock" "3.4.0"
                "060vh45i809wcqyxzs5g69nqiqah7ydz0hpkcjys9258vqn4fvpz"))

(define rust-async-net-2.0.0
  (crate-source "async-net" "2.0.0"
                "1xyc5a5vcp3a7h1q2lbfh79wz8136dig4q4x6g4w2ws8ml7h0j5r"))

(define rust-async-once-cell-0.5.4
  (crate-source "async-once-cell" "0.5.4"
                "0np3zj2yvk20ha4rk7sf8s0rngywhcykl1zgyb36flkq4qvzi222"))

(define rust-async-process-1.8.1
  (crate-source "async-process" "1.8.1"
                "126s968lvhg9rlwsnxp7wfzkfn7rl87p0dlvqqlibn081ax3hr7a"))

(define rust-async-process-2.3.0
  (crate-source "async-process" "2.3.0"
                "1fr6cpqdw7hrmzns1983lgx86cg8vyz7nlrn0h0125iqq8fmy9b3"))

(define rust-async-recursion-1.1.1
  (crate-source "async-recursion" "1.1.1"
                "04ac4zh8qz2xjc79lmfi4jlqj5f92xjvfaqvbzwkizyqd4pl4hrv"))

(define rust-async-signal-0.2.10
  (crate-source "async-signal" "0.2.10"
                "1wxrq3871l00mil43nmh0akvwjjjnv0bn7n2pzwbvh00k0s00zk3"))

(define rust-async-task-4.7.1
  (crate-source "async-task" "4.7.1"
                "1pp3avr4ri2nbh7s6y9ws0397nkx1zymmcr14sq761ljarh3axcb"))

(define rust-async-trait-0.1.83
  (crate-source "async-trait" "0.1.83"
                "1p8q8gm4fv2fdka8hwy2w3f8df7p5inixqi7rlmbnky3wmysw73j"))

(define rust-atomic-waker-1.1.2
  (crate-source "atomic-waker" "1.1.2"
                "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))

(define rust-atspi-0.19.0
  (crate-source "atspi" "0.19.0"
                "1jl7iv3bvnabg5jd4cpf8ba7zz2dbhk39cr70yh3wnbgmd8g6nb0"))

(define rust-atspi-common-0.3.0
  (crate-source "atspi-common" "0.3.0"
                "1xfdn94r697l98669gsq04rpfxysivkc4cn65fb1yhyjcvwrbbwj"))

(define rust-atspi-connection-0.3.0
  (crate-source "atspi-connection" "0.3.0"
                "0fdrfsgjg3d84mkk6nk3knqz0ygryfdmsn1d7c74qvgqf1ymxim0"))

(define rust-atspi-proxies-0.3.0
  (crate-source "atspi-proxies" "0.3.0"
                "0lmvfycsrach6phz1ymcg9lks8iqiy6bxp2njci7lgkhfc96d5b4"))

(define rust-autocfg-1.4.0
  (crate-source "autocfg" "1.4.0"
                "09lz3by90d2hphbq56znag9v87gfpd9gb8nr82hll8z6x2nhprdc"))

(define rust-backtrace-0.3.74
  (crate-source "backtrace" "0.3.74"
                "06pfif7nwx66qf2zaanc2fcq7m64i91ki9imw9xd3bnz5hrwp0ld"))

(define rust-base64-0.21.7
  (crate-source "base64" "0.21.7"
                "0rw52yvsk75kar9wgqfwgb414kvil1gn7mqkrhn9zf1537mpsacx"))

(define rust-bit-set-0.5.3
  (crate-source "bit-set" "0.5.3"
                "1wcm9vxi00ma4rcxkl3pzzjli6ihrpn9cfdi0c5b4cvga2mxs007"))

(define rust-bit-vec-0.6.3
  (crate-source "bit-vec" "0.6.3"
                "1ywqjnv60cdh1slhz67psnp422md6jdliji6alq0gmly2xm9p7rl"))

(define rust-bitflags-1.3.2
  (crate-source "bitflags" "1.3.2"
                "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy"))

(define rust-bitflags-2.6.0
  (crate-source "bitflags" "2.6.0"
                "1pkidwzn3hnxlsl8zizh0bncgbjnw7c41cx7bby26ncbzmiznj5h"))

(define rust-block-0.1.6
  (crate-source "block" "0.1.6"
                "16k9jgll25pzsq14f244q22cdv0zb4bqacldg3kx6h89d7piz30d"))

(define rust-block-buffer-0.10.4
  (crate-source "block-buffer" "0.10.4"
                "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))

(define rust-block-sys-0.1.0-beta.1
  ;; TODO: Check bundled sources.
  (crate-source "block-sys" "0.1.0-beta.1"
                "0ihiar08hk0das4q0ii1gsmql975z3rslli1h13jb44hxr0mg98g"))

(define rust-block-sys-0.2.1
  ;; TODO: Check bundled sources.
  (crate-source "block-sys" "0.2.1"
                "1rzp0218mwigdmfd5rhmj5h7c1vp0bq0nxaklhsvi8vydrls11df"))

(define rust-block2-0.2.0-alpha.6
  (crate-source "block2" "0.2.0-alpha.6"
                "0hpcdl81rmwvhfni9413hrg1wd4xwf6vhch3yv15bxs42wyfdncd"))

(define rust-block2-0.3.0
  (crate-source "block2" "0.3.0"
                "0s2ywcis2xf9444vmdgzr7ankrrkpchn8zimaw950cszm1imdd8m"))

(define rust-block2-0.5.1
  (crate-source "block2" "0.5.1"
                "0pyiha5his2grzqr3mynmq244laql2j20992i59asp0gy7mjw4rc"))

(define rust-blocking-1.6.1
  (crate-source "blocking" "1.6.1"
                "1si99l8zp7c4zq87y35ayjgc5c9b60jb8h0k14zfcs679z2l2gvh"))

(define rust-bumpalo-3.16.0
  (crate-source "bumpalo" "3.16.0"
                "0b015qb4knwanbdlp1x48pkb4pm57b8gidbhhhxr900q2wb6fabr"))

(define rust-bytemuck-1.20.0
  (crate-source "bytemuck" "1.20.0"
                "0nk9llwmvjpjlsrlga1qg3spqvci8g1nr286nhamvn7zcf5chdwb"))

(define rust-bytemuck-derive-1.8.0
  (crate-source "bytemuck_derive" "1.8.0"
                "1v5r33dgl12rqbvh440fdjxmxxr49qpzmg6vpw5jzdbcjk6w7z5w"))

(define rust-byteorder-1.5.0
  (crate-source "byteorder" "1.5.0"
                "0jzncxyf404mwqdbspihyzpkndfgda450l0893pz5xj685cg5l0z"))

(define rust-byteorder-lite-0.1.0
  (crate-source "byteorder-lite" "0.1.0"
                "15alafmz4b9az56z6x7glcbcb6a8bfgyd109qc3bvx07zx4fj7wg"))

(define rust-bytes-1.9.0
  (crate-source "bytes" "1.9.0"
                "16ykzx24v1x4f42v2lxyvlczqhdfji3v7r4ghwckpwijzvb1hn9j"))

(define rust-calloop-0.12.4
  (crate-source "calloop" "0.12.4"
                "162jk6j6qgqisyngkiay2qhzcj3i1q0260jiadaqxaasvnsav9zv"))

(define rust-calloop-0.13.0
  (crate-source "calloop" "0.13.0"
                "1v5zgidnhsyml403rzr7vm99f8q6r5bxq5gxyiqkr8lcapwa57dr"))

(define rust-calloop-wayland-source-0.2.0
  (crate-source "calloop-wayland-source" "0.2.0"
                "00lgxlqnkd150ylfn3wi4464ibif1qwbp38shj1aszvc8ywsj3hg"))

(define rust-calloop-wayland-source-0.3.0
  (crate-source "calloop-wayland-source" "0.3.0"
                "086x5mq16prrcwd9k6bw9an0sp8bj9l5daz4ziz5z4snf2c6m9lm"))

(define rust-cc-1.2.3
  (crate-source "cc" "1.2.3"
                "0bcga5xf5fgvddfamsjhg89hlydzbdk1fwvcym5kkxfggdj5gxi7"))

(define rust-cesu8-1.1.0
  (crate-source "cesu8" "1.1.0"
                "0g6q58wa7khxrxcxgnqyi9s1z2cjywwwd3hzr5c55wskhx6s0hvd"))

(define rust-cfg-if-1.0.0
  (crate-source "cfg-if" "1.0.0"
                "1za0vb97n4brpzpv8lsbnzmq5r8f2b0cpqqr0sy8h5bn751xxwds"))

(define rust-cfg-aliases-0.1.1
  (crate-source "cfg_aliases" "0.1.1"
                "17p821nc6jm830vzl2lmwz60g3a30hcm33nk6l257i1rjdqw85px"))

(define rust-cfg-aliases-0.2.1
  (crate-source "cfg_aliases" "0.2.1"
                "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))

(define rust-cgl-0.3.2
  (crate-source "cgl" "0.3.2"
                "1zs7skrsyrsm759vfy2cygkx52fx91b567a12bpaz1sf4d8hbv8c"))

(define rust-clap-4.5.23
  (crate-source "clap" "4.5.23"
                "110cf0i9fmkfqzqhi1h8za9y0vnr5rwhy3wmv1p0rcgp5vnffd9i"))

(define rust-clap-builder-4.5.23
  (crate-source "clap_builder" "4.5.23"
                "0f28rgc09kdgfq1hgg1bb1ydaw243w6dwyw74syz439k6b32yn1h"))

(define rust-clap-derive-4.5.18
  (crate-source "clap_derive" "4.5.18"
                "1ardb26bvcpg72q9myr7yir3a8c83gx7vxk1cccabsd9n73s1ija"))

(define rust-clap-lex-0.7.4
  (crate-source "clap_lex" "0.7.4"
                "19nwfls5db269js5n822vkc8dw0wjq2h1wf0hgr06ld2g52d2spl"))

(define rust-clipboard-win-5.4.0
  (crate-source "clipboard-win" "5.4.0"
                "14n87fc0vzbd0wdhqzvcs1lqgafsncplzcanhpik93xhhalfgvqm"))

(define rust-cocoa-0.25.0
  (crate-source "cocoa" "0.25.0"
                "0g1pl5hq28arqmvsswf2ib7smj445miwa58qa7wrfvksz54h857n"))

(define rust-cocoa-foundation-0.1.2
  (crate-source "cocoa-foundation" "0.1.2"
                "1xwk1khdyqw3dwsl15vr8p86shdcn544fr60ass8biz4nb5k8qlc"))

(define rust-codespan-reporting-0.11.1
  (crate-source "codespan-reporting" "0.11.1"
                "0vkfay0aqk73d33kh79k1kqxx06ka22894xhqi89crnc6c6jff1m"))

(define rust-color-quant-1.1.0
  (crate-source "color_quant" "1.1.0"
                "12q1n427h2bbmmm1mnglr57jaz2dj9apk0plcxw7nwqiai7qjyrx"))

(define rust-colorchoice-1.0.3
  (crate-source "colorchoice" "1.0.3"
                "1439m3r3jy3xqck8aa13q658visn71ki76qa93cy55wkmalwlqsv"))

(define rust-com-0.6.0
  (crate-source "com" "0.6.0"
                "1xnryd43mqdyq66qlnagwxrcs9iyr0kcbw9f3ddvclvks5zqh5vy"))

(define rust-com-macros-0.6.0
  (crate-source "com_macros" "0.6.0"
                "198k9fqd9rnpv3x6pxav6g636gl6m30iyqx63r4cfs56h0sqhxfk"))

(define rust-com-macros-support-0.6.0
  (crate-source "com_macros_support" "0.6.0"
                "033ix2k6j0930b0gpm77r2zc2d4f5fvpqbbr8ib6sad9hw89m2dd"))

(define rust-combine-4.6.7
  (crate-source "combine" "4.6.7"
                "1z8rh8wp59gf8k23ar010phgs0wgf5i8cx4fg01gwcnzfn5k0nms"))

(define rust-concurrent-queue-2.5.0
  (crate-source "concurrent-queue" "2.5.0"
                "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))

(define rust-core-foundation-0.9.4
  (crate-source "core-foundation" "0.9.4"
                "13zvbbj07yk3b61b8fhwfzhy35535a583irf23vlcg59j7h9bqci"))

(define rust-core-foundation-sys-0.8.7
  ;; TODO: Check bundled sources.
  (crate-source "core-foundation-sys" "0.8.7"
                "12w8j73lazxmr1z0h98hf3z623kl8ms7g07jch7n4p8f9nwlhdkp"))

(define rust-core-graphics-0.23.2
  (crate-source "core-graphics" "0.23.2"
                "10dhv3gk4kmbzl14xxkrhhky4fdp8h6nzff6h0019qgr6nz84xy0"))

(define rust-core-graphics-types-0.1.3
  (crate-source "core-graphics-types" "0.1.3"
                "1bxg8nxc8fk4kxnqyanhf36wq0zrjr552c58qy6733zn2ihhwfa5"))

(define rust-cpufeatures-0.2.16
  (crate-source "cpufeatures" "0.2.16"
                "1hy466fkhxjbb16i7na95wz8yr14d0kd578pwzj5lbkz14jh5f0n"))

(define rust-crc32fast-1.4.2
  (crate-source "crc32fast" "1.4.2"
                "1czp7vif73b8xslr3c9yxysmh9ws2r8824qda7j47ffs9pcnjxx9"))

(define rust-crossbeam-utils-0.8.20
  (crate-source "crossbeam-utils" "0.8.20"
                "100fksq5mm1n7zj242cclkw6yf7a4a8ix3lvpfkhxvdhbda9kv12"))

(define rust-crypto-common-0.1.6
  (crate-source "crypto-common" "0.1.6"
                "1cvby95a6xg7kxdz5ln3rl9xh66nz66w46mm3g56ri1z5x815yqv"))

(define rust-cursor-icon-1.1.0
  (crate-source "cursor-icon" "1.1.0"
                "14brf4vd6az9hnszwzqj7xyfaymqx9806d4i7xmwlaja3wjsr9ln"))

(define rust-derivative-2.2.0
  (crate-source "derivative" "2.2.0"
                "02vpb81wisk2zh1d5f44szzxamzinqgq2k8ydrfjj2wwkrgdvhzw"))

(define rust-digest-0.10.7
  (crate-source "digest" "0.10.7"
                "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))

(define rust-directories-next-2.0.0
  (crate-source "directories-next" "2.0.0"
                "1g1vq8d8mv0vp0l317gh9y46ipqg2fxjnbc7lnjhwqbsv4qf37ik"))

(define rust-dirs-sys-next-0.1.2
  (crate-source "dirs-sys-next" "0.1.2"
                "0kavhavdxv4phzj4l0psvh55hszwnr0rcz8sxbvx20pyqi2a3gaf"))

(define rust-dispatch-0.2.0
  (crate-source "dispatch" "0.2.0"
                "0fwjr9b7582ic5689zxj8lf7zl94iklhlns3yivrnv8c9fxr635x"))

(define rust-displaydoc-0.2.5
  (crate-source "displaydoc" "0.2.5"
                "1q0alair462j21iiqwrr21iabkfnb13d6x5w95lkdg21q2xrqdlp"))

(define rust-dlib-0.5.2
  (crate-source "dlib" "0.5.2"
                "04m4zzybx804394dnqs1blz241xcy480bdwf3w9p4k6c3l46031k"))

(define rust-document-features-0.2.10
  (crate-source "document-features" "0.2.10"
                "182h528pjyv4ppil2pd2nir46qrb393x5kvm4y51yhnjmgm6jsfb"))

(define rust-downcast-rs-1.2.1
  (crate-source "downcast-rs" "1.2.1"
                "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))

(define rust-dunce-1.0.5
  (crate-source "dunce" "1.0.5"
                "04y8wwv3vvcqaqmqzssi6k0ii9gs6fpz96j5w9nky2ccsl23axwj"))

(define rust-ecolor-0.27.2
  (crate-source "ecolor" "0.27.2"
                "041vlwgk57lysyh45ksnsprr6j4df24n15q7bvascmxx5d1hm4r0"))

(define rust-eframe-0.27.2
  (crate-source "eframe" "0.27.2"
                "1cmsj5y31zd8dmsga9v70z1nz155cknpwbslphfwgkmvyv72q3h2"))

(define rust-egui-0.27.2
  (crate-source "egui" "0.27.2"
                "16p2gwngk1qij01y3411agmiy6my5liay8rki9vjayx6z4dmsk2q"))

(define rust-egui-wgpu-0.27.2
  (crate-source "egui-wgpu" "0.27.2"
                "0dwvrd36rq5h48x0zrw3sab8w3ivs2vk458sfcmp12pq8dcgd7s6"))

(define rust-egui-winit-0.27.2
  (crate-source "egui-winit" "0.27.2"
                "029nay2wh2bgs57n51fymc07pbz45nwkb6sr1i2l3wr0w35s0g9f"))

(define rust-egui-glow-0.27.2
  (crate-source "egui_glow" "0.27.2"
                "1jj47zg5xav894bazdfkamydwpf14yxqinxi6lyxqvn8ydsxkrg0"))

(define rust-either-1.13.0
  (crate-source "either" "1.13.0"
                "1w2c1mybrd7vljyxk77y9f4w9dyjrmp3yp82mk7bcm8848fazcb0"))

(define rust-emath-0.27.2
  (crate-source "emath" "0.27.2"
                "0gqgc81shxci0p372dr7cdcx38443ks3b7a4083n656arx9abhz4"))

(define rust-endi-1.1.0
  (crate-source "endi" "1.1.0"
                "1gxp388g2zzbncp3rdn60wxkr49xbhhx94nl9p4a6c41w4ma7n53"))

(define rust-enumflags2-0.7.10
  (crate-source "enumflags2" "0.7.10"
                "0g8kmhaqxq44v76wh971biljrgaqbjc8fbyw2d1z3wsnb5zxncnj"))

(define rust-enumflags2-derive-0.7.10
  (crate-source "enumflags2_derive" "0.7.10"
                "1s29iqx3gj5l5s19a22lpn0nljhp5l9smqac99126n2qhfhlh3fy"))

(define rust-enumn-0.1.14
  (crate-source "enumn" "0.1.14"
                "0f1gagm6841sih4ipw46c7gn1idjgqfay1f5q6hchdwjg2rxd7ig"))

(define rust-epaint-0.27.2
  (crate-source "epaint" "0.27.2"
                "0xj16dv8vqc4vz27z0f1mv2dab7k74c3b5bhhg7llyk596qzi0dk"))

(define rust-equivalent-1.0.1
  (crate-source "equivalent" "1.0.1"
                "1malmx5f4lkfvqasz319lq6gb3ddg19yzf9s8cykfsgzdmyq0hsl"))

(define rust-errno-0.3.10
  (crate-source "errno" "0.3.10"
                "0pgblicz1kjz9wa9m0sghkhh2zw1fhq1mxzj7ndjm746kg5m5n1k"))

(define rust-error-code-3.3.1
  (crate-source "error-code" "3.3.1"
                "0bx9hw3pahzqym8jvb0ln4qsabnysgn98mikyh2afhk9rif31nd5"))

(define rust-event-listener-2.5.3
  (crate-source "event-listener" "2.5.3"
                "1q4w3pndc518crld6zsqvvpy9lkzwahp2zgza9kbzmmqh9gif1h2"))

(define rust-event-listener-3.1.0
  (crate-source "event-listener" "3.1.0"
                "1hihkg6ihvb6p9yi7nq11di8mhd5y0iqv81ij6h0rf0fvsy7ff6r"))

(define rust-event-listener-5.3.1
  (crate-source "event-listener" "5.3.1"
                "1fkm6q4hjn61wl52xyqyyxai0x9w0ngrzi0wf1qsf8vhsadvwck0"))

(define rust-event-listener-strategy-0.5.3
  (crate-source "event-listener-strategy" "0.5.3"
                "1ch5gf6knllyq12jkb5zdfag573dh44307q4pwwi2g37sc6lwgiw"))

(define rust-fast-image-resize-5.1.0
  (crate-source "fast_image_resize" "5.1.0"
                "1qp95mkllxmkc3q0iwh1rj9cgv0rixpjz5wdw6avv2n17g090y7c"))

(define rust-fastrand-1.9.0
  (crate-source "fastrand" "1.9.0"
                "1gh12m56265ihdbzh46bhh0jf74i197wm51jg1cw75q7ggi96475"))

(define rust-fastrand-2.3.0
  (crate-source "fastrand" "2.3.0"
                "1ghiahsw1jd68df895cy5h3gzwk30hndidn3b682zmshpgmrx41p"))

(define rust-fdeflate-0.3.7
  (crate-source "fdeflate" "0.3.7"
                "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))

(define rust-flate2-1.0.35
  (crate-source "flate2" "1.0.35"
                "0z6h0wa095wncpfngx75wyhyjnqwld7wax401gsvnzjhzgdbydn9"))

(define rust-foreign-types-0.5.0
  (crate-source "foreign-types" "0.5.0"
                "0rfr2zfxnx9rz3292z5nyk8qs2iirznn5ff3rd4vgdwza6mdjdyp"))

(define rust-foreign-types-macros-0.2.3
  (crate-source "foreign-types-macros" "0.2.3"
                "0hjpii8ny6l7h7jpns2cp9589016l8mlrpaigcnayjn9bdc6qp0s"))

(define rust-foreign-types-shared-0.3.1
  (crate-source "foreign-types-shared" "0.3.1"
                "0nykdvv41a3d4py61bylmlwjhhvdm0b3bcj9vxhqgxaxnp5ik6ma"))

(define rust-form-urlencoded-1.2.1
  (crate-source "form_urlencoded" "1.2.1"
                "0milh8x7nl4f450s3ddhg57a3flcv6yq8hlkyk6fyr3mcb128dp1"))

(define rust-futures-channel-0.3.31
  (crate-source "futures-channel" "0.3.31"
                "040vpqpqlbk099razq8lyn74m0f161zd0rp36hciqrwcg2zibzrd"))

(define rust-futures-core-0.3.31
  (crate-source "futures-core" "0.3.31"
                "0gk6yrxgi5ihfanm2y431jadrll00n5ifhnpx090c2f2q1cr1wh5"))

(define rust-futures-io-0.3.31
  (crate-source "futures-io" "0.3.31"
                "1ikmw1yfbgvsychmsihdkwa8a1knank2d9a8dk01mbjar9w1np4y"))

(define rust-futures-lite-1.13.0
  (crate-source "futures-lite" "1.13.0"
                "1kkbqhaib68nzmys2dc8j9fl2bwzf2s91jfk13lb2q3nwhfdbaa9"))

(define rust-futures-lite-2.5.0
  (crate-source "futures-lite" "2.5.0"
                "18cii1zgxbm04almisj0ycnmf7nj7qqyvy8x0i8mnl9cmqhhvx6f"))

(define rust-futures-macro-0.3.31
  (crate-source "futures-macro" "0.3.31"
                "0l1n7kqzwwmgiznn0ywdc5i24z72zvh9q1dwps54mimppi7f6bhn"))

(define rust-futures-sink-0.3.31
  (crate-source "futures-sink" "0.3.31"
                "1xyly6naq6aqm52d5rh236snm08kw8zadydwqz8bip70s6vzlxg5"))

(define rust-futures-task-0.3.31
  (crate-source "futures-task" "0.3.31"
                "124rv4n90f5xwfsm9qw6y99755y021cmi5dhzh253s920z77s3zr"))

(define rust-futures-util-0.3.31
  (crate-source "futures-util" "0.3.31"
                "10aa1ar8bgkgbr4wzxlidkqkcxf77gffyj8j7768h831pcaq784z"))

(define rust-generic-array-0.14.7
  (crate-source "generic-array" "0.14.7"
                "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))

(define rust-gethostname-0.4.3
  (crate-source "gethostname" "0.4.3"
                "063qqhznyckwx9n4z4xrmdv10s0fi6kbr17r6bi1yjifki2y0xh1"))

(define rust-getrandom-0.2.15
  (crate-source "getrandom" "0.2.15"
                "1mzlnrb3dgyd1fb84gvw10pyr8wdqdl4ry4sr64i1s8an66pqmn4"))

(define rust-gimli-0.31.1
  (crate-source "gimli" "0.31.1"
                "0gvqc0ramx8szv76jhfd4dms0zyamvlg4whhiz11j34hh3dqxqh7"))

(define rust-gl-generator-0.14.0
  (crate-source "gl_generator" "0.14.0"
                "0k8j1hmfnff312gy7x1aqjzcm8zxid7ij7dlb8prljib7b1dz58s"))

(define rust-glow-0.13.1
  (crate-source "glow" "0.13.1"
                "1c91n554dp4bdp5d86rpl77ryv6rjyrqn7735m7mfcivqh28wd5x"))

(define rust-glutin-0.31.3
  (crate-source "glutin" "0.31.3"
                "0il7aija3y17p3sz6qqzxyahrgp5crqzbf002fnr3nc69spd9z0q"))

(define rust-glutin-winit-0.4.2
  (crate-source "glutin-winit" "0.4.2"
                "0dbppmj0m2i5df4ww565f5kg3vxmjbq5c7hqql988fzp4jxdzg0y"))

(define rust-glutin-egl-sys-0.6.0
  ;; TODO: Check bundled sources.
  (crate-source "glutin_egl_sys" "0.6.0"
                "1kcv5pdpdsyhzpiahga15kk7yd4m64ia2k6xqcrz97ihylimdk3p"))

(define rust-glutin-glx-sys-0.5.0
  ;; TODO: Check bundled sources.
  (crate-source "glutin_glx_sys" "0.5.0"
                "0krv3chf5sy83rsfwq267paczskpwnb5gcw0agac5p0hdilgsrd1"))

(define rust-glutin-wgl-sys-0.5.0
  ;; TODO: Check bundled sources.
  (crate-source "glutin_wgl_sys" "0.5.0"
                "1b9f6qjc8gwhfxac4fpxkvv524l493f6b6q764nslpwmmjnri03c"))

(define rust-gpu-alloc-0.6.0
  (crate-source "gpu-alloc" "0.6.0"
                "0wd1wq7qs8ja0cp37ajm9p1r526sp6w0kvjp3xx24jsrjfx2vkgv"))

(define rust-gpu-alloc-types-0.3.0
  (crate-source "gpu-alloc-types" "0.3.0"
                "190wxsp9q8c59xybkfrlzqqyrxj6z39zamadk1q7v0xad2s07zwq"))

(define rust-gpu-allocator-0.25.0
  (crate-source "gpu-allocator" "0.25.0"
                "11484bhn0p8555gprr58kmz1aqccz1zqbx5ww4c3rl38i4qzcmkg"))

(define rust-gpu-descriptor-0.2.4
  (crate-source "gpu-descriptor" "0.2.4"
                "0b38pi460ajx8ksb61zxardwkpa27qgz8fpm252mczlfrqddy4fc"))

(define rust-gpu-descriptor-types-0.1.2
  (crate-source "gpu-descriptor-types" "0.1.2"
                "135pp1b3bzyr7bfnb30rf9pkgy61h75w0jabi8fpw2q9dxpb7w3b"))

(define rust-hashbrown-0.14.5
  (crate-source "hashbrown" "0.14.5"
                "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))

(define rust-hashbrown-0.15.2
  (crate-source "hashbrown" "0.15.2"
                "12dj0yfn59p3kh3679ac0w1fagvzf4z2zp87a13gbbqbzw0185dz"))

(define rust-hassle-rs-0.11.0
  (crate-source "hassle-rs" "0.11.0"
                "147886vviw14zm2a3yh8gs1r81r5gy88lrpv67d4hk7kw5rpwamg"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-hermit-abi-0.3.9
  (crate-source "hermit-abi" "0.3.9"
                "092hxjbjnq5fmz66grd9plxd0sh6ssg5fhgwwwqbrzgzkjwdycfj"))

(define rust-hermit-abi-0.4.0
  (crate-source "hermit-abi" "0.4.0"
                "1k1zwllx6nfq417hy38x4akw1ivlv68ymvnzyxs76ffgsqcskxpv"))

(define rust-hex-0.4.3
  (crate-source "hex" "0.4.3"
                "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))

(define rust-hexf-parse-0.2.1
  (crate-source "hexf-parse" "0.2.1"
                "1pr3a3sk66ddxdyxdxac7q6qaqjcn28v0njy22ghdpfn78l8d9nz"))

(define rust-home-0.5.9
  (crate-source "home" "0.5.9"
                "19grxyg35rqfd802pcc9ys1q3lafzlcjcv2pl2s5q8xpyr5kblg3"))

(define rust-icrate-0.0.4
  (crate-source "icrate" "0.0.4"
                "06d3g8n6xw3f0ai84mya0dlknp2n33zqdxpxp8272mslibzsmlwr"))

(define rust-icu-collections-1.5.0
  (crate-source "icu_collections" "1.5.0"
                "09j5kskirl59mvqc8kabhy7005yyy7dp88jw9f6f3gkf419a8byv"))

(define rust-icu-locid-1.5.0
  (crate-source "icu_locid" "1.5.0"
                "0dznvd1c5b02iilqm044q4hvar0sqibq1z46prqwjzwif61vpb0k"))

(define rust-icu-locid-transform-1.5.0
  (crate-source "icu_locid_transform" "1.5.0"
                "0kmmi1kmj9yph6mdgkc7v3wz6995v7ly3n80vbg0zr78bp1iml81"))

(define rust-icu-locid-transform-data-1.5.0
  (crate-source "icu_locid_transform_data" "1.5.0"
                "0vkgjixm0wzp2n3v5mw4j89ly05bg3lx96jpdggbwlpqi0rzzj7x"))

(define rust-icu-normalizer-1.5.0
  (crate-source "icu_normalizer" "1.5.0"
                "0kx8qryp8ma8fw1vijbgbnf7zz9f2j4d14rw36fmjs7cl86kxkhr"))

(define rust-icu-normalizer-data-1.5.0
  (crate-source "icu_normalizer_data" "1.5.0"
                "05lmk0zf0q7nzjnj5kbmsigj3qgr0rwicnn5pqi9n7krmbvzpjpq"))

(define rust-icu-properties-1.5.1
  (crate-source "icu_properties" "1.5.1"
                "1xgf584rx10xc1p7zjr78k0n4zn3g23rrg6v2ln31ingcq3h5mlk"))

(define rust-icu-properties-data-1.5.0
  (crate-source "icu_properties_data" "1.5.0"
                "0scms7pd5a7yxx9hfl167f5qdf44as6r3bd8myhlngnxqgxyza37"))

(define rust-icu-provider-1.5.0
  (crate-source "icu_provider" "1.5.0"
                "1nb8vvgw8dv2inqklvk05fs0qxzkw8xrg2n9vgid6y7gm3423m3f"))

(define rust-icu-provider-macros-1.5.0
  (crate-source "icu_provider_macros" "1.5.0"
                "1mjs0w7fcm2lcqmbakhninzrjwqs485lkps4hz0cv3k36y9rxj0y"))

(define rust-idna-1.0.3
  (crate-source "idna" "1.0.3"
                "0zlajvm2k3wy0ay8plr07w22hxkkmrxkffa6ah57ac6nci984vv8"))

(define rust-idna-adapter-1.2.0
  (crate-source "idna_adapter" "1.2.0"
                "0wggnkiivaj5lw0g0384ql2d7zk4ppkn3b1ry4n0ncjpr7qivjns"))

(define rust-image-0.24.9
  (crate-source "image" "0.24.9"
                "17gnr6ifnpzvhjf6dwbl9hki8x6bji5mwcqp0048x1jm5yfi742n"))

(define rust-image-0.25.5
  (crate-source "image" "0.25.5"
                "0fsnfgg8hr66ag5nxipvb7d50kbg40qfpbsql59qkwa2ssp48vyd"))

(define rust-indexmap-2.7.0
  (crate-source "indexmap" "2.7.0"
                "07s7jmdymvd0rm4yswp0j3napx57hkjm9gs9n55lvs2g78vj5y32"))

(define rust-instant-0.1.13
  (crate-source "instant" "0.1.13"
                "08h27kzvb5jw74mh0ajv0nv9ggwvgqm8ynjsn2sa9jsks4cjh970"))

(define rust-io-lifetimes-1.0.11
  (crate-source "io-lifetimes" "1.0.11"
                "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))

(define rust-is-terminal-polyfill-1.70.1
  (crate-source "is_terminal_polyfill" "1.70.1"
                "1kwfgglh91z33kl0w5i338mfpa3zs0hidq5j4ny4rmjwrikchhvr"))

(define rust-itertools-0.13.0
  (crate-source "itertools" "0.13.0"
                "11hiy3qzl643zcigknclh446qb9zlg4dpdzfkjaa9q9fqpgyfgj1"))

(define rust-jni-0.21.1
  (crate-source "jni" "0.21.1"
                "15wczfkr2r45slsljby12ymf2hij8wi5b104ghck9byjnwmsm1qs"))

(define rust-jni-sys-0.3.0
  ;; TODO: Check bundled sources.
  (crate-source "jni-sys" "0.3.0"
                "0c01zb9ygvwg9wdx2fii2d39myzprnpqqhy7yizxvjqp5p04pbwf"))

(define rust-jobserver-0.1.32
  (crate-source "jobserver" "0.1.32"
                "1l2k50qmj84x9mn39ivjz76alqmx72jhm12rw33zx9xnpv5xpla8"))

(define rust-js-sys-0.3.76
  ;; TODO: Check bundled sources.
  (crate-source "js-sys" "0.3.76"
                "1dz7v777h2j38wkf8k5iwkfxskn6nff2cdv2jsslyxkpn2svc5v7"))

(define rust-khronos-egl-6.0.0
  (crate-source "khronos-egl" "6.0.0"
                "0xnzdx0n1bil06xmh8i1x6dbxvk7kd2m70bbm6nw1qzc43r1vbka"))

(define rust-khronos-api-3.1.0
  (crate-source "khronos_api" "3.1.0"
                "1p0xj5mlbagqyvvnv8wmv3cr7l9y1m153888pxqwg3vk3mg5inz2"))

(define rust-lazy-static-1.5.0
  (crate-source "lazy_static" "1.5.0"
                "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))

(define rust-lcms2-6.1.0
  (crate-source "lcms2" "6.1.0"
                "0x3gps06mr2d55a6f3pfy73jj8m888vhmwh2rbwhlvn38bxc63k8"))

(define rust-lcms2-sys-4.0.5
  ;; TODO: Check bundled sources.
  (crate-source "lcms2-sys" "4.0.5"
                "0bixcbxvgsvll5nl26abjaz333rl67p809dn9w18088plgwnacjr"))

(define rust-libc-0.2.168
  (crate-source "libc" "0.2.168"
                "0vab4inpw0dz78nii02hsxp1skqn06xzh64psw8wl1h63scb5bjs"))

(define rust-libloading-0.7.4
  (crate-source "libloading" "0.7.4"
                "17wbccnjvhjd9ibh019xcd8kjvqws8lqgq86lqkpbgig7gyq0wxn"))

(define rust-libloading-0.8.6
  (crate-source "libloading" "0.8.6"
                "0d2ccr88f8kv3x7va2ccjxalcjnhrci4j2kwxp7lfmbkpjs4wbzw"))

(define rust-libredox-0.1.3
  (crate-source "libredox" "0.1.3"
                "139602gzgs0k91zb7dvgj1qh4ynb8g1lbxsswdim18hcb6ykgzy0"))

(define rust-linux-raw-sys-0.3.8
  ;; TODO: Check bundled sources.
  (crate-source "linux-raw-sys" "0.3.8"
                "068mbigb3frrxvbi5g61lx25kksy98f2qgkvc4xg8zxznwp98lzg"))

(define rust-linux-raw-sys-0.4.14
  ;; TODO: Check bundled sources.
  (crate-source "linux-raw-sys" "0.4.14"
                "12gsjgbhhjwywpqcrizv80vrp7p7grsz5laqq773i33wphjsxcvq"))

(define rust-litemap-0.7.4
  (crate-source "litemap" "0.7.4"
                "012ili3vppd4952sh6y3qwcd0jkd0bq2qpr9h7cppc8sj11k7saf"))

(define rust-litrs-0.4.1
  (crate-source "litrs" "0.4.1"
                "19cssch9gc0x2snd9089nvwzz79zx6nzsi3icffpx25p4hck1kml"))

(define rust-lock-api-0.4.12
  (crate-source "lock_api" "0.4.12"
                "05qvxa6g27yyva25a5ghsg85apdxkvr77yhkyhapj6r8vnf8pbq7"))

(define rust-log-0.4.22
  (crate-source "log" "0.4.22"
                "093vs0wkm1rgyykk7fjbqp2lwizbixac1w52gv109p5r4jh0p9x7"))

(define rust-malloc-buf-0.0.6
  (crate-source "malloc_buf" "0.0.6"
                "1jqr77j89pwszv51fmnknzvd53i1nkmcr8rjrvcxhm4dx1zr1fv2"))

(define rust-memchr-2.7.4
  (crate-source "memchr" "2.7.4"
                "18z32bhxrax0fnjikv475z7ii718hq457qwmaryixfxsl2qrmjkq"))

(define rust-memmap2-0.9.5
  (crate-source "memmap2" "0.9.5"
                "0krpvvkpg4i3l05cv3q2xk24a1vj5c86gbrli2wzhj1qkpnpwgzx"))

(define rust-memoffset-0.7.1
  (crate-source "memoffset" "0.7.1"
                "1x2zv8hv9c9bvgmhsjvr9bymqwyxvgbca12cm8xkhpyy5k1r7s2x"))

(define rust-memoffset-0.9.1
  (crate-source "memoffset" "0.9.1"
                "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))

(define rust-metal-0.27.0
  (crate-source "metal" "0.27.0"
                "09bz461vyi9kw69k55gy2fpd3hz17j6g2n0v08gm3glc7yap6gy4"))

(define rust-miniz-oxide-0.8.0
  (crate-source "miniz_oxide" "0.8.0"
                "1wadxkg6a6z4lr7kskapj5d8pxlx7cp1ifw4daqnkzqjxych5n72"))

(define rust-mio-1.0.3
  (crate-source "mio" "1.0.3"
                "1gah0h4ia3avxbwym0b6bi6lr6rpysmj9zvw6zis5yq0z0xq91i8"))

(define rust-naga-0.19.2
  (crate-source "naga" "0.19.2"
                "0hq82fg8rj067wppqrk7h9q5b89vkp98spmb37s9lggm89355qsh"))

(define rust-ndk-0.8.0
  (crate-source "ndk" "0.8.0"
                "1dx5yyqh32bi161mipg4br4i33syjidw81qrq0w7mc8hf0ds6xi0"))

(define rust-ndk-context-0.1.1
  (crate-source "ndk-context" "0.1.1"
                "12sai3dqsblsvfd1l1zab0z6xsnlha3xsfl7kagdnmj3an3jvc17"))

(define rust-ndk-sys-0.5.0+25.2.9519653
  ;; TODO: Check bundled sources.
  (crate-source "ndk-sys" "0.5.0+25.2.9519653"
                "14bnxww0f17xl8pyn6j5kpkl98snjl9lin8i7qv4zzb0vmlnf6cc"))

(define rust-nix-0.26.4
  (crate-source "nix" "0.26.4"
                "06xgl4ybb8pvjrbmc3xggbgk3kbs1j0c4c0nzdfrmpbgrkrym2sr"))

(define rust-nix-0.29.0
  (crate-source "nix" "0.29.0"
                "0ikvn7s9r2lrfdm3mx1h7nbfjvcc6s9vxdzw7j5xfkd2qdnp9qki"))

(define rust-nohash-hasher-0.2.0
  (crate-source "nohash-hasher" "0.2.0"
                "0lf4p6k01w4wm7zn4grnihzj8s7zd5qczjmzng7wviwxawih5x9b"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-num-enum-0.7.3
  (crate-source "num_enum" "0.7.3"
                "0yai0vafhy85mvhknzfqd7lm04hzaln7i5c599rhy8mj831kyqaf"))

(define rust-num-enum-derive-0.7.3
  (crate-source "num_enum_derive" "0.7.3"
                "0mksna1jj87ydh146gn6jcqkvvs920c3dgh0p4f3xk184kpl865g"))

(define rust-objc-0.2.7
  (crate-source "objc" "0.2.7"
                "1cbpf6kz8a244nn1qzl3xyhmp05gsg4n313c9m3567625d3innwi"))

(define rust-objc-sys-0.2.0-beta.2
  ;; TODO: Check bundled sources.
  (crate-source "objc-sys" "0.2.0-beta.2"
                "1msm1bwv69k12ikxm71mi1ifrbx2bzsmk2w2bah98mp9q4s9hfyz"))

(define rust-objc-sys-0.3.5
  ;; TODO: Check bundled sources.
  (crate-source "objc-sys" "0.3.5"
                "0423gry7s3rmz8s3pzzm1zy5mdjif75g6dbzc2lf2z0c77fipffd"))

(define rust-objc2-0.3.0-beta.3.patch-leaks.3
  (crate-source "objc2" "0.3.0-beta.3.patch-leaks.3"
                "0s54wfgw20ypg4ibzldwkqvv6b2kkqbmwcl0pq5j5c9ckw7n80by"))

(define rust-objc2-0.4.1
  (crate-source "objc2" "0.4.1"
                "13gr3zqv8gzlylff5d4za91f50asb7vsrkpv8kiva3nkzm05m72m"))

(define rust-objc2-0.5.2
  (crate-source "objc2" "0.5.2"
                "015qa2d3vh7c1j2736h5wjrznri7x5ic35vl916c22gzxva8b9s6"))

(define rust-objc2-app-kit-0.2.2
  (crate-source "objc2-app-kit" "0.2.2"
                "1zqyi5l1bm26j1bgmac9783ah36m5kcrxlqp5carglnpwgcrms74"))

(define rust-objc2-core-data-0.2.2
  (crate-source "objc2-core-data" "0.2.2"
                "1vvk8zjylfjjj04dzawydmqqz5ajvdkhf22cnb07ihbiw14vyzv1"))

(define rust-objc2-core-image-0.2.2
  (crate-source "objc2-core-image" "0.2.2"
                "102csfb82zi2sbzliwsfd589ckz0gysf7y6434c9zj97lmihj9jm"))

(define rust-objc2-encode-2.0.0-pre.2
  (crate-source "objc2-encode" "2.0.0-pre.2"
                "04h5wns3hxmc9g652hr9xqzrijs4ij9sdnlgc0ha202v050srz5b"))

(define rust-objc2-encode-3.0.0
  (crate-source "objc2-encode" "3.0.0"
                "0rknhkcnyj4qv1pzqp5j8l80726phz8fcxpsbpz9nhmg6xdq8yfh"))

(define rust-objc2-encode-4.0.3
  (crate-source "objc2-encode" "4.0.3"
                "1y7hjg4k828zhn4fjnbidrz3vzw4llk9ldy92drj47ydjc9yg4bq"))

(define rust-objc2-foundation-0.2.2
  (crate-source "objc2-foundation" "0.2.2"
                "1a6mi77jsig7950vmx9ydvsxaighzdiglk5d229k569pvajkirhf"))

(define rust-objc2-metal-0.2.2
  (crate-source "objc2-metal" "0.2.2"
                "1mmdga66qpxrcfq3gxxhysfx3zg1hpx4z886liv3j0pnfq9bl36x"))

(define rust-objc2-quartz-core-0.2.2
  (crate-source "objc2-quartz-core" "0.2.2"
                "0ynw8819c36l11rim8n0yzk0fskbzrgaqayscyqi8swhzxxywaz4"))

(define rust-objc-exception-0.1.2
  (crate-source "objc_exception" "0.1.2"
                "191cmdmlypp6piw67y4m8y5swlxf5w0ss8n1lk5xd2l1ans0z5xd"))

(define rust-object-0.36.5
  (crate-source "object" "0.36.5"
                "0gk8lhbs229c68lapq6w6qmnm4jkj48hrcw5ilfyswy514nhmpxf"))

(define rust-once-cell-1.20.2
  (crate-source "once_cell" "1.20.2"
                "0xb7rw1aqr7pa4z3b00y7786gyf8awx2gca3md73afy76dzgwq8j"))

(define rust-orbclient-0.3.48
  (crate-source "orbclient" "0.3.48"
                "0hzxjsvvsl5i9d3aqzc6kdcsch1i6flij5dkignhhkz2qb72c2xs"))

(define rust-ordered-stream-0.2.0
  (crate-source "ordered-stream" "0.2.0"
                "0l0xxp697q7wiix1gnfn66xsss7fdhfivl2k7bvpjs4i3lgb18ls"))

(define rust-owned-ttf-parser-0.25.0
  (crate-source "owned_ttf_parser" "0.25.0"
                "1i5jhazmm87nf8wbqm76vjvncmcv28ghpqm4170q2aivpydp3v12"))

(define rust-parking-2.2.1
  (crate-source "parking" "2.2.1"
                "1fnfgmzkfpjd69v4j9x737b1k8pnn054bvzcn5dm3pkgq595d3gk"))

(define rust-parking-lot-0.12.3
  (crate-source "parking_lot" "0.12.3"
                "09ws9g6245iiq8z975h8ycf818a66q3c6zv4b5h8skpm7hc1igzi"))

(define rust-parking-lot-core-0.9.10
  (crate-source "parking_lot_core" "0.9.10"
                "1y3cf9ld9ijf7i4igwzffcn0xl16dxyn4c5bwgjck1dkgabiyh0y"))

(define rust-paste-1.0.15
  (crate-source "paste" "1.0.15"
                "02pxffpdqkapy292harq6asfjvadgp1s005fip9ljfsn9fvxgh2p"))

(define rust-percent-encoding-2.3.1
  (crate-source "percent-encoding" "2.3.1"
                "0gi8wgx0dcy8rnv1kywdv98lwcx67hz0a0zwpib5v2i08r88y573"))

(define rust-pin-project-lite-0.2.15
  (crate-source "pin-project-lite" "0.2.15"
                "1zz4xif3iknfrpmvqmh0pcc9mx4cxm28jywqydir3pimcla1wnli"))

(define rust-pin-utils-0.1.0
  (crate-source "pin-utils" "0.1.0"
                "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb"))

(define rust-piper-0.2.4
  (crate-source "piper" "0.2.4"
                "0rn0mjjm0cwagdkay77wgmz3sqf8fqmv9d9czm79mvr2yj8c9j4n"))

(define rust-pkg-config-0.3.31
  (crate-source "pkg-config" "0.3.31"
                "1wk6yp2phl91795ia0lwkr3wl4a9xkrympvhqq8cxk4d75hwhglm"))

(define rust-png-0.17.15
  (crate-source "png" "0.17.15"
                "07918iqrf9m1grgixk252bvvw5fgl64ymqkh89hzzgb5bfyq4xdn"))

(define rust-poll-promise-0.3.0
  (crate-source "poll-promise" "0.3.0"
                "1pxprny826xsy1jbppb8xsnd324ps97ww86vpijqknprrgz5hsjz"))

(define rust-polling-2.8.0
  (crate-source "polling" "2.8.0"
                "1kixxfq1af1k7gkmmk9yv4j2krpp4fji2r8j4cz6p6d7ihz34bab"))

(define rust-polling-3.7.4
  (crate-source "polling" "3.7.4"
                "0bs4nhwfwsvlzlhah2gbhj3aa9ynvchv2g350wapswh26a65c156"))

(define rust-pollster-0.3.0
  (crate-source "pollster" "0.3.0"
                "1wn73ljx1pcb4p69jyiz206idj7nkfqknfvdhp64yaphhm3nys12"))

(define rust-ppv-lite86-0.2.20
  (crate-source "ppv-lite86" "0.2.20"
                "017ax9ssdnpww7nrl1hvqh2lzncpv04nnsibmnw9nxjnaqlpp5bp"))

(define rust-presser-0.3.1
  (crate-source "presser" "0.3.1"
                "1ykvqx861sjmhkdh540aafqba7i7li7gqgwrcczy6v56i9m8xkz8"))

(define rust-proc-macro-crate-1.3.1
  (crate-source "proc-macro-crate" "1.3.1"
                "069r1k56bvgk0f58dm5swlssfcp79im230affwk6d9ck20g04k3z"))

(define rust-proc-macro-crate-3.2.0
  (crate-source "proc-macro-crate" "3.2.0"
                "0yzsqnavb3lmrcsmbrdjfrky9vcbl46v59xi9avn0796rb3likwf"))

(define rust-proc-macro2-1.0.92
  (crate-source "proc-macro2" "1.0.92"
                "1c1vjy5wg8iy7kxsxda564qf4ljp0asysmbn2i7caj177x5m9lrp"))

(define rust-profiling-1.0.16
  (crate-source "profiling" "1.0.16"
                "0kcz2xzg4qx01r5az8cf9ffjasi2srj56sna32igddh0vi7cggdg"))

(define rust-quick-xml-0.36.2
  (crate-source "quick-xml" "0.36.2"
                "1zj3sjcjk6sn544wb2wvhr1km5f9cy664vzclygfsnph9mxrlr7p"))

(define rust-quote-1.0.37
  (crate-source "quote" "1.0.37"
                "1brklraw2g34bxy9y4q1nbrccn7bv36ylihv12c9vlcii55x7fdm"))

(define rust-rand-0.8.5
  (crate-source "rand" "0.8.5"
                "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))

(define rust-rand-chacha-0.3.1
  (crate-source "rand_chacha" "0.3.1"
                "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-raw-window-handle-0.5.2
  (crate-source "raw-window-handle" "0.5.2"
                "1f9k10fgda464ia1b2hni8f0sa8i0bphdsbs3di032x80qgrmzzj"))

(define rust-raw-window-handle-0.6.2
  (crate-source "raw-window-handle" "0.6.2"
                "0ff5c648hncwx7hm2a8fqgqlbvbl4xawb6v3xxv9wkpjyrr5arr0"))

(define rust-redox-syscall-0.3.5
  (crate-source "redox_syscall" "0.3.5"
                "0acgiy2lc1m2vr8cr33l5s7k9wzby8dybyab1a9p753hcbr68xjn"))

(define rust-redox-syscall-0.5.7
  (crate-source "redox_syscall" "0.5.7"
                "07vpgfr6a04k0x19zqr1xdlqm6fncik3zydbdi3f5g3l5k7zwvcv"))

(define rust-redox-users-0.4.6
  (crate-source "redox_users" "0.4.6"
                "0hya2cxx6hxmjfxzv9n8rjl5igpychav7zfi1f81pz6i4krry05s"))

(define rust-regex-1.11.1
  (crate-source "regex" "1.11.1"
                "148i41mzbx8bmq32hsj1q4karkzzx5m60qza6gdw4pdc9qdyyi5m"))

(define rust-regex-automata-0.4.9
  (crate-source "regex-automata" "0.4.9"
                "02092l8zfh3vkmk47yjc8d631zhhcd49ck2zr133prvd3z38v7l0"))

(define rust-regex-syntax-0.8.5
  (crate-source "regex-syntax" "0.8.5"
                "0p41p3hj9ww7blnbwbj9h7rwxzxg0c1hvrdycgys8rxyhqqw859b"))

(define rust-renderdoc-sys-1.1.0
  ;; TODO: Check bundled sources.
  (crate-source "renderdoc-sys" "1.1.0"
                "0cj8zjs7k0gvchcx3jhpg8r9bbqy8b1hsgbz0flcq2ydn12hmcqr"))

(define rust-rfd-0.15.1
  (crate-source "rfd" "0.15.1"
                "1s01pnp9w60f96sd5vpja2bzq3yk4ncwlws607clf9l8kc5gixj6"))

(define rust-rgb-0.8.50
  (crate-source "rgb" "0.8.50"
                "02ii3nsciska0sj23ggxaz8gj64ksw8nbpfjcwxlh037chb7sfap"))

(define rust-ron-0.8.1
  (crate-source "ron" "0.8.1"
                "154w53s895yxdfg7rn87c6f6x4yncc535x1x31zpcj7p0pzpw7xr"))

(define rust-rustc-demangle-0.1.24
  (crate-source "rustc-demangle" "0.1.24"
                "07zysaafgrkzy2rjgwqdj2a8qdpsm6zv6f5pgpk9x0lm40z9b6vi"))

(define rust-rustc-hash-1.1.0
  (crate-source "rustc-hash" "1.1.0"
                "1qkc5khrmv5pqi5l5ca9p5nl5hs742cagrndhbrlk3dhlrx3zm08"))

(define rust-rustix-0.37.27
  (crate-source "rustix" "0.37.27"
                "1lidfswa8wbg358yrrkhfvsw0hzlvl540g4lwqszw09sg8vcma7y"))

(define rust-rustix-0.38.42
  (crate-source "rustix" "0.38.42"
                "11fvprv3p450ggyqacp7sdpjbbsgm5zvfjwnzy8bfbmbrf7c6ggr"))

(define rust-same-file-1.0.6
  (crate-source "same-file" "1.0.6"
                "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))

(define rust-scoped-tls-1.0.1
  (crate-source "scoped-tls" "1.0.1"
                "15524h04mafihcvfpgxd8f4bgc3k95aclz8grjkg9a0rxcvn9kz1"))

(define rust-scopeguard-1.2.0
  (crate-source "scopeguard" "1.2.0"
                "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))

(define rust-sctk-adwaita-0.8.3
  (crate-source "sctk-adwaita" "0.8.3"
                "1iq2wr1rhbpmwkfqxjhrgjrmfc90anww6vwim72r4w19r93i9cvh"))

(define rust-serde-1.0.215
  (crate-source "serde" "1.0.215"
                "13xqkw93cw9rnbkm0zy1apnilzq7l2xf1qw8m1nkga8i1fnw24v5"))

(define rust-serde-derive-1.0.215
  (crate-source "serde_derive" "1.0.215"
                "1h2nswy0rmzblil38h12wxsgni1ik63rk22wy19g48v9hrpqc7md"))

(define rust-serde-repr-0.1.19
  (crate-source "serde_repr" "0.1.19"
                "1sb4cplc33z86pzlx38234xr141wr3cmviqgssiadisgl8dlar3c"))

(define rust-sha1-0.10.6
  (crate-source "sha1" "0.10.6"
                "1fnnxlfg08xhkmwf2ahv634as30l1i3xhlhkvxflmasi5nd85gz3"))

(define rust-shlex-1.3.0
  (crate-source "shlex" "1.3.0"
                "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))

(define rust-signal-hook-registry-1.4.2
  (crate-source "signal-hook-registry" "1.4.2"
                "1cb5akgq8ajnd5spyn587srvs4n26ryq0p78nswffwhv46sf1sd9"))

(define rust-simd-adler32-0.3.7
  (crate-source "simd-adler32" "0.3.7"
                "1zkq40c3iajcnr5936gjp9jjh1lpzhy44p3dq3fiw75iwr1w2vfn"))

(define rust-slab-0.4.9
  (crate-source "slab" "0.4.9"
                "0rxvsgir0qw5lkycrqgb1cxsvxzjv9bmx73bk5y42svnzfba94lg"))

(define rust-slotmap-1.0.7
  (crate-source "slotmap" "1.0.7"
                "0amqb2fn9lcy1ri0risblkcp88dl0rnfmynw7lx0nqwza77lmzyv"))

(define rust-smallvec-1.13.2
  (crate-source "smallvec" "1.13.2"
                "0rsw5samawl3wsw6glrsb127rx6sh89a8wyikicw6dkdcjd1lpiw"))

(define rust-smithay-client-toolkit-0.18.1
  (crate-source "smithay-client-toolkit" "0.18.1"
                "0fpm2yfpsif7022w4xalxgn53y8w5dc8zkipcpbj1n1vmgpd6bwj"))

(define rust-smithay-client-toolkit-0.19.2
  (crate-source "smithay-client-toolkit" "0.19.2"
                "05h05hg4dn3v6br5jbdbs5nalk076a64s7fn6i01nqzby2hxwmrl"))

(define rust-smithay-clipboard-0.7.2
  (crate-source "smithay-clipboard" "0.7.2"
                "0inqnr4x458nqz0wdcanbgn77dad3bj0m7pjj074lrv3qkp1d0nc"))

(define rust-smol-str-0.2.2
  (crate-source "smol_str" "0.2.2"
                "1bfylqf2vnqaglw58930vpxm2rfzji5gjp15a2c0kh8aj6v8ylyx"))

(define rust-socket2-0.4.10
  (crate-source "socket2" "0.4.10"
                "03ack54dxhgfifzsj14k7qa3r5c9wqy3v6mqhlim99cc03y1cycz"))

(define rust-socket2-0.5.8
  (crate-source "socket2" "0.5.8"
                "1s7vjmb5gzp3iaqi94rh9r63k9cj00kjgbfn7gn60kmnk6fjcw69"))

(define rust-spirv-0.3.0+sdk-1.3.268.0
  (crate-source "spirv" "0.3.0+sdk-1.3.268.0"
                "0i3qj7yvvprai1s03dvll2gkfy8398nl64wvllkhaaa4vh1i197d"))

(define rust-stable-deref-trait-1.2.0
  (crate-source "stable_deref_trait" "1.2.0"
                "1lxjr8q2n534b2lhkxd6l6wcddzjvnksi58zv11f9y0jjmr15wd8"))

(define rust-static-assertions-1.1.0
  (crate-source "static_assertions" "1.1.0"
                "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2"))

(define rust-strict-num-0.1.1
  (crate-source "strict-num" "0.1.1"
                "0cb7l1vhb8zj90mzm8avlk815k40sql9515s865rqdrdfavvldv6"))

(define rust-strsim-0.11.1
  (crate-source "strsim" "0.11.1"
                "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))

(define rust-syn-1.0.109
  (crate-source "syn" "1.0.109"
                "0ds2if4600bd59wsv7jjgfkayfzy3hnazs394kz6zdkmna8l3dkj"))

(define rust-syn-2.0.90
  (crate-source "syn" "2.0.90"
                "0cfg5dsr1x0hl6b9hz08jp1197mx0rq3xydqmqaws36xlms3p7ci"))

(define rust-synstructure-0.13.1
  (crate-source "synstructure" "0.13.1"
                "0wc9f002ia2zqcbj0q2id5x6n7g1zjqba7qkg2mr0qvvmdk7dby8"))

(define rust-tempfile-3.14.0
  (crate-source "tempfile" "3.14.0"
                "037f9jm13bmfc6xq9w86dp0nylrddh6ynvl6db4gm1xwzi8y5k18"))

(define rust-termcolor-1.4.1
  (crate-source "termcolor" "1.4.1"
                "0mappjh3fj3p2nmrg4y7qv94rchwi9mzmgmfflr8p2awdj7lyy86"))

(define rust-terminal-size-0.4.1
  (crate-source "terminal_size" "0.4.1"
                "1sd4nq55h9sjirkx0138zx711ddxq1k1a45lc77ninhzj9zl8ljk"))

(define rust-thiserror-1.0.69
  (crate-source "thiserror" "1.0.69"
                "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))

(define rust-thiserror-impl-1.0.69
  (crate-source "thiserror-impl" "1.0.69"
                "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))

(define rust-tiny-skia-0.11.4
  (crate-source "tiny-skia" "0.11.4"
                "1aq9gd4qh4418g8v08qzakqqggx8hl66qcianl3k5bjdsja37lc3"))

(define rust-tiny-skia-path-0.11.4
  (crate-source "tiny-skia-path" "0.11.4"
                "14ywbdfakvacl6rxxmzbnycplaxpc6i2linh2yqk0sp8qb07z7lw"))

(define rust-tinystr-0.7.6
  (crate-source "tinystr" "0.7.6"
                "0bxqaw7z8r2kzngxlzlgvld1r6jbnwyylyvyjbv1q71rvgaga5wi"))

(define rust-tokio-1.42.0
  (crate-source "tokio" "1.42.0"
                "0lbmf21h16iibdy7m63ck66grkwa7b1x8yy9gwvp60j5n0hrpv2w"))

(define rust-tokio-macros-2.4.0
  (crate-source "tokio-macros" "2.4.0"
                "0lnpg14h1v3fh2jvnc8cz7cjf0m7z1xgkwfpcyy632g829imjgb9"))

(define rust-tokio-stream-0.1.17
  (crate-source "tokio-stream" "0.1.17"
                "0ix0770hfp4x5rh5bl7vsnr3d4iz4ms43i522xw70xaap9xqv9gc"))

(define rust-toml-datetime-0.6.8
  (crate-source "toml_datetime" "0.6.8"
                "0hgv7v9g35d7y9r2afic58jvlwnf73vgd1mz2k8gihlgrf73bmqd"))

(define rust-toml-edit-0.19.15
  (crate-source "toml_edit" "0.19.15"
                "08bl7rp5g6jwmfpad9s8jpw8wjrciadpnbaswgywpr9hv9qbfnqv"))

(define rust-toml-edit-0.22.22
  (crate-source "toml_edit" "0.22.22"
                "1xf7sxfzmnc45f75x302qrn5aph52vc8w226v59yhrm211i8vr2a"))

(define rust-tracing-0.1.41
  (crate-source "tracing" "0.1.41"
                "1l5xrzyjfyayrwhvhldfnwdyligi1mpqm8mzbi2m1d6y6p2hlkkq"))

(define rust-tracing-attributes-0.1.28
  (crate-source "tracing-attributes" "0.1.28"
                "0v92l9cxs42rdm4m5hsa8z7ln1xsiw1zc2iil8c6k7lzq0jf2nir"))

(define rust-tracing-core-0.1.33
  (crate-source "tracing-core" "0.1.33"
                "170gc7cxyjx824r9kr17zc9gvzx89ypqfdzq259pr56gg5bwjwp6"))

(define rust-ttf-parser-0.25.1
  (crate-source "ttf-parser" "0.25.1"
                "0cbgqglcwwjg3hirwq6xlza54w04mb5x02kf7zx4hrw50xmr1pyj"))

(define rust-type-map-0.5.0
  (crate-source "type-map" "0.5.0"
                "17qaga12nkankr7hi2mv43f4lnc78hg480kz6j9zmy4g0h28ddny"))

(define rust-typenum-1.17.0
  (crate-source "typenum" "1.17.0"
                "09dqxv69m9lj9zvv6xw5vxaqx15ps0vxyy5myg33i0kbqvq0pzs2"))

(define rust-uds-windows-1.1.0
  (crate-source "uds_windows" "1.1.0"
                "1fb4y65pw0rsp0gyfyinjazlzxz1f6zv7j4zmb20l5pxwv1ypnl9"))

(define rust-unicode-ident-1.0.14
  (crate-source "unicode-ident" "1.0.14"
                "10ywa1pg0glgkr4l3dppjxizr9r2b7im0ycbfa0137l69z5fdfdd"))

(define rust-unicode-segmentation-1.12.0
  (crate-source "unicode-segmentation" "1.12.0"
                "14qla2jfx74yyb9ds3d2mpwpa4l4lzb9z57c6d2ba511458z5k7n"))

(define rust-unicode-width-0.1.14
  (crate-source "unicode-width" "0.1.14"
                "1bzn2zv0gp8xxbxbhifw778a7fc93pa6a1kj24jgg9msj07f7mkx"))

(define rust-unicode-xid-0.2.6
  (crate-source "unicode-xid" "0.2.6"
                "0lzqaky89fq0bcrh6jj6bhlz37scfd8c7dsj5dq7y32if56c1hgb"))

(define rust-url-2.5.4
  (crate-source "url" "2.5.4"
                "0q6sgznyy2n4l5lm16zahkisvc9nip9aa5q1pps7656xra3bdy1j"))

(define rust-urlencoding-2.1.3
  (crate-source "urlencoding" "2.1.3"
                "1nj99jp37k47n0hvaz5fvz7z6jd0sb4ppvfy3nphr1zbnyixpy6s"))

(define rust-utf16-iter-1.0.5
  (crate-source "utf16_iter" "1.0.5"
                "0ik2krdr73hfgsdzw0218fn35fa09dg2hvbi1xp3bmdfrp9js8y8"))

(define rust-utf8-iter-1.0.4
  (crate-source "utf8_iter" "1.0.4"
                "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))

(define rust-utf8parse-0.2.2
  (crate-source "utf8parse" "0.2.2"
                "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))

(define rust-vapoursynth-0.4.0
  (crate-source "vapoursynth" "0.4.0"
                "0mig50a74ggljqjp52mchbdhynwdwnhj9y4k7gx1rv2xqq1gfz8c"))

(define rust-vapoursynth-sys-0.4.1
  ;; TODO: Check bundled sources.
  (crate-source "vapoursynth-sys" "0.4.1"
                "1ddr770frvfkln3js50k82c2ah87bplyklmzm82r0y8swqmhjd9b"))

(define rust-version-check-0.9.5
  (crate-source "version_check" "0.9.5"
                "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))

(define rust-waker-fn-1.2.0
  (crate-source "waker-fn" "1.2.0"
                "1dvk0qsv88kiq22x8w0qz0k9nyrxxm5a9a9czdwdvvhcvjh12wii"))

(define rust-walkdir-2.5.0
  (crate-source "walkdir" "2.5.0"
                "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))

(define rust-wasi-0.11.0+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.0+wasi-snapshot-preview1"
                "08z4hxwkpdpalxjps1ai9y7ihin26y9f476i53dv98v45gkqg3cw"))

(define rust-wasm-bindgen-0.2.99
  (crate-source "wasm-bindgen" "0.2.99"
                "15k3rzb3kjrxyqnh0916gq99mrpwhwy62smawxxc2w0x3llgcx54"))

(define rust-wasm-bindgen-backend-0.2.99
  (crate-source "wasm-bindgen-backend" "0.2.99"
                "0ycwa4c68j34687k513djgyy2asn3fw3yp4g9rkq2kvbchwbp2az"))

(define rust-wasm-bindgen-futures-0.4.49
  (crate-source "wasm-bindgen-futures" "0.4.49"
                "18pc937q8kg549czxk3ah57h9vb7q56c62zz9qcfk17a8jdns5rq"))

(define rust-wasm-bindgen-macro-0.2.99
  (crate-source "wasm-bindgen-macro" "0.2.99"
                "1znlcrk5bvisr3vscwlqkdby959n3sb367zgdzpjwjd7v4giiiic"))

(define rust-wasm-bindgen-macro-support-0.2.99
  (crate-source "wasm-bindgen-macro-support" "0.2.99"
                "1hihsgyg0kf46kjhgfv8x5g9x0q1d0aizj6n7s84ag1xfrdskmrh"))

(define rust-wasm-bindgen-shared-0.2.99
  (crate-source "wasm-bindgen-shared" "0.2.99"
                "19h61snrhh1qhb5gz6zyb89l7fbj1fhmxcvi09p9l0mav8zsnfll"))

(define rust-wayland-backend-0.3.7
  (crate-source "wayland-backend" "0.3.7"
                "1xhnh0mn4cv0wmq3zcm0iic2sbhsz4qdra6kb58x8l51sz73ar85"))

(define rust-wayland-client-0.31.7
  (crate-source "wayland-client" "0.31.7"
                "105j23dj1k36rpvv3nk5v3lm99gs029k3k429kbnzxv9zk9ljqmn"))

(define rust-wayland-csd-frame-0.3.0
  (crate-source "wayland-csd-frame" "0.3.0"
                "0zjcmcqprfzx57hlm741n89ssp4sha5yh5cnmbk2agflvclm0p32"))

(define rust-wayland-cursor-0.31.7
  (crate-source "wayland-cursor" "0.31.7"
                "0k4yijr0rxlqw15clzbh6a3jd760l1xz3zg0gxg07c7xmb1qpc1j"))

(define rust-wayland-protocols-0.31.2
  (crate-source "wayland-protocols" "0.31.2"
                "1x310l1p6p3p3l76nl1l2yava9408dy77s605917zadlp1jz70cg"))

(define rust-wayland-protocols-0.32.5
  (crate-source "wayland-protocols" "0.32.5"
                "13pmq788d2w9c7sqpjjxi1344bzq1g1ja4vlaa4rlvjfgkjsvl3w"))

(define rust-wayland-protocols-plasma-0.2.0
  (crate-source "wayland-protocols-plasma" "0.2.0"
                "0yglbxd4ka8284k0j0ssh9hf6wd9qp2n0s2qrsdymyaz258kb013"))

(define rust-wayland-protocols-wlr-0.2.0
  (crate-source "wayland-protocols-wlr" "0.2.0"
                "1mjww9psk2nc5hm2q4s3qas30rbzfg1sb6qgw518fbbcdfvn27xd"))

(define rust-wayland-protocols-wlr-0.3.5
  (crate-source "wayland-protocols-wlr" "0.3.5"
                "08j0xfpfqv6kzbfzmdv6crfzalxbxc2n5m9hc4qkqg4jrpv14bkq"))

(define rust-wayland-scanner-0.31.5
  (crate-source "wayland-scanner" "0.31.5"
                "1hv16shy6j32hi9i0r54pyk5pw3q7qfpkffmwchi3z75n80j0zsr"))

(define rust-wayland-sys-0.31.5
  ;; TODO: Check bundled sources.
  (crate-source "wayland-sys" "0.31.5"
                "02cyl94ydazgjdjf7asm2phni8h62j4cg4pwr6sy7lwfiq6sra7g"))

(define rust-web-sys-0.3.76
  ;; TODO: Check bundled sources.
  (crate-source "web-sys" "0.3.76"
                "1g0j3kii20mh7hqmdajz2r4c21zynb9h9h026wymalkx88ip5p84"))

(define rust-web-time-0.2.4
  (crate-source "web-time" "0.2.4"
                "1q6gk0nkwbfz30g1pz8g52mq00zjx7m5im36k3474aw73jdh8c5a"))

(define rust-webbrowser-0.8.15
  (crate-source "webbrowser" "0.8.15"
                "12zw844al9kf32p5llv6dbqzaky9fa3ng497i3sk8mj0m5sswryv"))

(define rust-wgpu-0.19.4
  (crate-source "wgpu" "0.19.4"
                "009cfqxabinkwmk93wm08gj8nz7d4hl1m17imfxgxg1aplfk3myb"))

(define rust-wgpu-core-0.19.4
  (crate-source "wgpu-core" "0.19.4"
                "0fmzd5rjga26yh96qi57244sv6y25d7pc94yk9f9xflrzhjlbf98"))

(define rust-wgpu-hal-0.19.5
  (crate-source "wgpu-hal" "0.19.5"
                "00r7am82cmli890ww9rcjzbjyfscsnr2cqw1anl12rnqbz2wzaxz"))

(define rust-wgpu-types-0.19.2
  (crate-source "wgpu-types" "0.19.2"
                "01cqjr9qvp34bgjlnrj27wwh7mp7xghlwjbny5pv8y1zn2gzywdn"))

(define rust-widestring-1.1.0
  (crate-source "widestring" "1.1.0"
                "048kxd6iykzi5la9nikpc5hvpp77hmjf1sw43sl3z2dcdrmx66bj"))

(define rust-winapi-0.3.9
  (crate-source "winapi" "0.3.9"
                "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))

(define rust-winapi-i686-pc-windows-gnu-0.4.0
  (crate-source "winapi-i686-pc-windows-gnu" "0.4.0"
                "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))

(define rust-winapi-util-0.1.9
  (crate-source "winapi-util" "0.1.9"
                "1fqhkcl9scd230cnfj8apfficpf5c9vhwnk4yy9xfc1sw69iq8ng"))

(define rust-winapi-x86-64-pc-windows-gnu-0.4.0
  (crate-source "winapi-x86_64-pc-windows-gnu" "0.4.0"
                "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))

(define rust-windows-0.48.0
  (crate-source "windows" "0.48.0"
                "03vh89ilnxdxdh0n9np4ns4m10fvm93h3b0cc05ipg3qq1mqi1p6"))

(define rust-windows-0.52.0
  (crate-source "windows" "0.52.0"
                "1gnh210qjlprpd1szaq04rjm1zqgdm9j7l9absg0kawi2rwm72p4"))

(define rust-windows-core-0.52.0
  (crate-source "windows-core" "0.52.0"
                "1nc3qv7sy24x0nlnb32f7alzpd6f72l4p24vl65vydbyil669ark"))

(define rust-windows-implement-0.48.0
  (crate-source "windows-implement" "0.48.0"
                "1764n853zd7bb0wn94i0qxfs6kdy7wrz7v9qhdn7x7hvk64fabjy"))

(define rust-windows-interface-0.48.0
  (crate-source "windows-interface" "0.48.0"
                "1iqcilw0hfyzwhk12xfmcy40r10406sgf4xmdansijlv1kr8vyz6"))

(define rust-windows-sys-0.45.0
  ;; TODO: Check bundled sources.
  (crate-source "windows-sys" "0.45.0"
                "1l36bcqm4g89pknfp8r9rl1w4bn017q6a8qlx8viv0xjxzjkna3m"))

(define rust-windows-sys-0.48.0
  ;; TODO: Check bundled sources.
  (crate-source "windows-sys" "0.48.0"
                "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))

(define rust-windows-sys-0.52.0
  ;; TODO: Check bundled sources.
  (crate-source "windows-sys" "0.52.0"
                "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))

(define rust-windows-sys-0.59.0
  ;; TODO: Check bundled sources.
  (crate-source "windows-sys" "0.59.0"
                "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))

(define rust-windows-targets-0.42.2
  (crate-source "windows-targets" "0.42.2"
                "0wfhnib2fisxlx8c507dbmh97kgij4r6kcxdi0f9nk6l1k080lcf"))

(define rust-windows-targets-0.48.5
  (crate-source "windows-targets" "0.48.5"
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-aarch64-gnullvm-0.42.2
  (crate-source "windows_aarch64_gnullvm" "0.42.2"
                "1y4q0qmvl0lvp7syxvfykafvmwal5hrjb4fmv04bqs0bawc52yjr"))

(define rust-windows-aarch64-gnullvm-0.48.5
  (crate-source "windows_aarch64_gnullvm" "0.48.5"
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-msvc-0.42.2
  (crate-source "windows_aarch64_msvc" "0.42.2"
                "0hsdikjl5sa1fva5qskpwlxzpc5q9l909fpl1w6yy1hglrj8i3p0"))

(define rust-windows-aarch64-msvc-0.48.5
  (crate-source "windows_aarch64_msvc" "0.48.5"
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-i686-gnu-0.42.2
  (crate-source "windows_i686_gnu" "0.42.2"
                "0kx866dfrby88lqs9v1vgmrkk1z6af9lhaghh5maj7d4imyr47f6"))

(define rust-windows-i686-gnu-0.48.5
  (crate-source "windows_i686_gnu" "0.48.5"
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-msvc-0.42.2
  (crate-source "windows_i686_msvc" "0.42.2"
                "0q0h9m2aq1pygc199pa5jgc952qhcnf0zn688454i7v4xjv41n24"))

(define rust-windows-i686-msvc-0.48.5
  (crate-source "windows_i686_msvc" "0.48.5"
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-x86-64-gnu-0.42.2
  (crate-source "windows_x86_64_gnu" "0.42.2"
                "0dnbf2xnp3xrvy8v9mgs3var4zq9v9yh9kv79035rdgyp2w15scd"))

(define rust-windows-x86-64-gnu-0.48.5
  (crate-source "windows_x86_64_gnu" "0.48.5"
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnullvm-0.42.2
  (crate-source "windows_x86_64_gnullvm" "0.42.2"
                "18wl9r8qbsl475j39zvawlidp1bsbinliwfymr43fibdld31pm16"))

(define rust-windows-x86-64-gnullvm-0.48.5
  (crate-source "windows_x86_64_gnullvm" "0.48.5"
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-msvc-0.42.2
  (crate-source "windows_x86_64_msvc" "0.42.2"
                "1w5r0q0yzx827d10dpjza2ww0j8iajqhmb54s735hhaj66imvv4s"))

(define rust-windows-x86-64-msvc-0.48.5
  (crate-source "windows_x86_64_msvc" "0.48.5"
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-winit-0.29.15
  (crate-source "winit" "0.29.15"
                "1jp5j96hcr6xif7asgck522791fqmlmhd3wwy3x5fmk3babasn8d"))

(define rust-winnow-0.5.40
  (crate-source "winnow" "0.5.40"
                "0xk8maai7gyxda673mmw3pj1hdizy5fpi7287vaywykkk19sk4zm"))

(define rust-winnow-0.6.20
  (crate-source "winnow" "0.6.20"
                "16y4i8z9vh8hazjxg5mvmq0c5i35wlk8rxi5gkq6cn5vlb0zxh9n"))

(define rust-write16-1.0.0
  (crate-source "write16" "1.0.0"
                "0dnryvrrbrnl7vvf5vb1zkmwldhjkf2n5znliviam7bm4900z2fi"))

(define rust-writeable-0.5.5
  (crate-source "writeable" "0.5.5"
                "0lawr6y0bwqfyayf3z8zmqlhpnzhdx0ahs54isacbhyjwa7g778y"))

(define rust-x11-dl-2.21.0
  (crate-source "x11-dl" "2.21.0"
                "0vsiq62xpcfm0kn9zjw5c9iycvccxl22jya8wnk18lyxzqj5jwrq"))

(define rust-x11rb-0.13.1
  (crate-source "x11rb" "0.13.1"
                "04jyfm0xmc538v09pzsyr2w801yadsgvyl2p0p76hzzffg5gz4ax"))

(define rust-x11rb-protocol-0.13.1
  (crate-source "x11rb-protocol" "0.13.1"
                "0gfbxf2k7kbk577j3rjhfx7hm70kmwln6da7xyc4l2za0d2pq47c"))

(define rust-xcursor-0.3.8
  (crate-source "xcursor" "0.3.8"
                "0qazsl7h8nrbbzx84qrv39w8m2qc27g0mvrszgdls2v6n6k3vwqf"))

(define rust-xdg-home-1.3.0
  (crate-source "xdg-home" "1.3.0"
                "1xm122zz0wjc8p8cmchij0j9nw34hwncb39jc7dc0mgvb2rdl77c"))

(define rust-xkbcommon-dl-0.4.2
  (crate-source "xkbcommon-dl" "0.4.2"
                "1iai0r3b5skd9vbr8z5b0qixiz8jblzfm778ddm8ba596a0dwffh"))

(define rust-xkeysym-0.2.1
  (crate-source "xkeysym" "0.2.1"
                "0mksx670cszyd7jln6s7dhkw11hdfv7blwwr3isq98k22ljh1k5r"))

(define rust-xml-rs-0.8.24
  (crate-source "xml-rs" "0.8.24"
                "0ck4s3j1dk4bnqam9h06nfmicnzdp69pz7y2hihlj2vrk8f3k2za"))

(define rust-yoke-0.7.5
  (crate-source "yoke" "0.7.5"
                "0h3znzrdmll0a7sglzf9ji0p5iqml11wrj1dypaf6ad6kbpnl3hj"))

(define rust-yoke-derive-0.7.5
  (crate-source "yoke-derive" "0.7.5"
                "0m4i4a7gy826bfvnqa9wy6sp90qf0as3wps3wb0smjaamn68g013"))

(define rust-zbus-3.15.2
  (crate-source "zbus" "3.15.2"
                "1ri5gklhh3kl9gywym95679xs7n3sw2j3ky80jcd8siacc5ifpb7"))

(define rust-zbus-5.1.1
  (crate-source "zbus" "5.1.1"
                "02464m606nmnhylpzgmw536rh1x8xb7bql21qky2j5ivqr6hjqhi"))

(define rust-zbus-macros-3.15.2
  (crate-source "zbus_macros" "3.15.2"
                "19g0d7d4b8l8ycw498sz8pwkplv300j31i9hnihq0zl81xxljcbi"))

(define rust-zbus-macros-5.1.1
  (crate-source "zbus_macros" "5.1.1"
                "0vfidjw4xbppz8vj2mj9231kr6ski5d3pqxpfiypywp2wgfdrlic"))

(define rust-zbus-names-2.6.1
  (crate-source "zbus_names" "2.6.1"
                "13achs6jbrp4l0jy5m6nn7v89clfgb63qhldkg5ddgjh6y6p6za3"))

(define rust-zbus-names-4.1.0
  (crate-source "zbus_names" "4.1.0"
                "0yv4rqd0hrky4iqb6gzmkwwwibncigpcwmkqsipq8w8zh4w7lsw5"))

(define rust-zerocopy-0.7.35
  (crate-source "zerocopy" "0.7.35"
                "1w36q7b9il2flg0qskapgi9ymgg7p985vniqd09vi0mwib8lz6qv"))

(define rust-zerocopy-derive-0.7.35
  (crate-source "zerocopy-derive" "0.7.35"
                "0gnf2ap2y92nwdalzz3x7142f2b83sni66l39vxp2ijd6j080kzs"))

(define rust-zerofrom-0.1.5
  (crate-source "zerofrom" "0.1.5"
                "0bnd8vjcllzrvr3wvn8x14k2hkrpyy1fm3crkn2y3plmr44fxwyg"))

(define rust-zerofrom-derive-0.1.5
  (crate-source "zerofrom-derive" "0.1.5"
                "022q55phhb44qbrcfbc48k0b741fl8gnazw3hpmmndbx5ycfspjr"))

(define rust-zerovec-0.10.4
  (crate-source "zerovec" "0.10.4"
                "0yghix7n3fjfdppwghknzvx9v8cf826h2qal5nqvy8yzg4yqjaxa"))

(define rust-zerovec-derive-0.10.3
  (crate-source "zerovec-derive" "0.10.3"
                "1ik322dys6wnap5d3gcsn09azmssq466xryn5czfm13mn7gsdbvf"))

(define rust-zvariant-3.15.2
  (crate-source "zvariant" "3.15.2"
                "1nxj9x187jl32fd32zvq8hfn6lyq3kjadb2q7f6kb6x0igl2pvsf"))

(define rust-zvariant-5.1.0
  (crate-source "zvariant" "5.1.0"
                "0vx5w4a2s21y9agr1y9lbm8maj3rli4sjmg42aiybw9jmkk0w851"))

(define rust-zvariant-derive-3.15.2
  (crate-source "zvariant_derive" "3.15.2"
                "1nbydrkawjwxan12vy79qsrn7gwc483mpfzqs685ybyppv04vhip"))

(define rust-zvariant-derive-5.1.0
  (crate-source "zvariant_derive" "5.1.0"
                "05l9m8ypcf28v3xjwkl7zc2bz6hlgp976v6kpd7i1jg6zabknzk8"))

(define rust-zvariant-utils-1.0.1
  (crate-source "zvariant_utils" "1.0.1"
                "00625h3240rixvfhq6yhws1d4bwf3vrf74v8s69b97aq27cg0d3j"))

(define rust-zvariant-utils-3.0.2
  (crate-source "zvariant_utils" "3.0.2"
                "1in90pg2x1m0jyxdrw17gzmshhicbvzyxk6cbw73c4lglc8x1l90"))

 (define-public vspreview-rs
  (package
    (name "vspreview-rs")
    (version "git")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference (url "https://github.com/quietvoid/vspreview-rs")
                           (commit "b6b10997e7b2c5627f794e906a0cdfced6626d7a")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0npnhwr6q5rhhd5gzl152gyim82nvs664cr4fcf1gpli9pzv3j4v"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       ;#:phases
       ;(modify-phases %standard-phases
       ;               (add-after 'install 'install-library
       ;                          (lambda* (#:key outputs #:allow-other-keys)
       ;                            (let ((out (assoc-ref outputs "out")))
       ;                            (install-file
       ;                             (car (find-files "." "^libvs_nlq\\.so$"))
       ;                             (string-append out "/lib/vapoursynth"))))))
       ))
    (inputs (list vapoursynth ; guix import crate -f Cargo.lock vspreview-rs | grep "(define" | grep -o " .*"
              rust-ab-glyph-0.2.29
              rust-ab-glyph-rasterizer-0.1.8
              rust-accesskit-0.12.3
              rust-accesskit-consumer-0.16.1
              rust-accesskit-macos-0.10.1
              rust-accesskit-unix-0.6.2
              rust-accesskit-windows-0.15.1
              rust-accesskit-winit-0.16.1
              rust-addr2line-0.24.2
              rust-adler2-2.0.0
              rust-ahash-0.8.11
              rust-aho-corasick-1.1.3
              rust-allocator-api2-0.2.21
              rust-android-activity-0.5.2
              rust-android-properties-0.2.2
              rust-android-system-properties-0.1.5
              rust-anstream-0.6.18
              rust-anstyle-1.0.10
              rust-anstyle-parse-0.2.6
              rust-anstyle-query-1.1.2
              rust-anstyle-wincon-3.0.6
              rust-anyhow-1.0.94
              rust-arboard-3.4.1
              rust-arrayref-0.3.9
              rust-arrayvec-0.7.6
              rust-as-raw-xcb-connection-1.0.1
              rust-ash-0.37.3+1.3.251
              rust-ashpd-0.10.2
              rust-async-broadcast-0.5.1
              rust-async-broadcast-0.7.1
              rust-async-channel-2.3.1
              rust-async-executor-1.13.1
              rust-async-fs-1.6.0
              rust-async-fs-2.1.2
              rust-async-io-1.13.0
              rust-async-io-2.4.0
              rust-async-lock-2.8.0
              rust-async-lock-3.4.0
              rust-async-net-2.0.0
              rust-async-once-cell-0.5.4
              rust-async-process-1.8.1
              rust-async-process-2.3.0
              rust-async-recursion-1.1.1
              rust-async-signal-0.2.10
              rust-async-task-4.7.1
              rust-async-trait-0.1.83
              rust-atomic-waker-1.1.2
              rust-atspi-0.19.0
              rust-atspi-common-0.3.0
              rust-atspi-connection-0.3.0
              rust-atspi-proxies-0.3.0
              rust-autocfg-1.4.0
              rust-backtrace-0.3.74
              rust-base64-0.21.7
              rust-bit-set-0.5.3
              rust-bit-vec-0.6.3
              rust-bitflags-1.3.2
              rust-bitflags-2.6.0
              rust-block-0.1.6
              rust-block-buffer-0.10.4
              rust-block-sys-0.1.0-beta.1
              rust-block-sys-0.2.1
              rust-block2-0.2.0-alpha.6
              rust-block2-0.3.0
              rust-block2-0.5.1
              rust-blocking-1.6.1
              rust-bumpalo-3.16.0
              rust-bytemuck-1.20.0
              rust-bytemuck-derive-1.8.0
              rust-byteorder-1.5.0
              rust-byteorder-lite-0.1.0
              rust-bytes-1.9.0
              rust-calloop-0.12.4
              rust-calloop-0.13.0
              rust-calloop-wayland-source-0.2.0
              rust-calloop-wayland-source-0.3.0
              rust-cc-1.2.3
              rust-cesu8-1.1.0
              rust-cfg-if-1.0.0
              rust-cfg-aliases-0.1.1
              rust-cfg-aliases-0.2.1
              rust-cgl-0.3.2
              rust-clap-4.5.23
              rust-clap-builder-4.5.23
              rust-clap-derive-4.5.18
              rust-clap-lex-0.7.4
              rust-clipboard-win-5.4.0
              rust-cocoa-0.25.0
              rust-cocoa-foundation-0.1.2
              rust-codespan-reporting-0.11.1
              rust-color-quant-1.1.0
              rust-colorchoice-1.0.3
              rust-com-0.6.0
              rust-com-macros-0.6.0
              rust-com-macros-support-0.6.0
              rust-combine-4.6.7
              rust-concurrent-queue-2.5.0
              rust-core-foundation-0.9.4
              rust-core-foundation-sys-0.8.7
              rust-core-graphics-0.23.2
              rust-core-graphics-types-0.1.3
              rust-cpufeatures-0.2.16
              rust-crc32fast-1.4.2
              rust-crossbeam-utils-0.8.20
              rust-crypto-common-0.1.6
              rust-cursor-icon-1.1.0
              rust-derivative-2.2.0
              rust-digest-0.10.7
              rust-directories-next-2.0.0
              rust-dirs-sys-next-0.1.2
              rust-dispatch-0.2.0
              rust-displaydoc-0.2.5
              rust-dlib-0.5.2
              rust-document-features-0.2.10
              rust-downcast-rs-1.2.1
              rust-dunce-1.0.5
              rust-ecolor-0.27.2
              rust-eframe-0.27.2
              rust-egui-0.27.2
              rust-egui-wgpu-0.27.2
              rust-egui-winit-0.27.2
              rust-egui-glow-0.27.2
              rust-either-1.13.0
              rust-emath-0.27.2
              rust-endi-1.1.0
              rust-enumflags2-0.7.10
              rust-enumflags2-derive-0.7.10
              rust-enumn-0.1.14
              rust-epaint-0.27.2
              rust-equivalent-1.0.1
              rust-errno-0.3.10
              rust-error-code-3.3.1
              rust-event-listener-2.5.3
              rust-event-listener-3.1.0
              rust-event-listener-5.3.1
              rust-event-listener-strategy-0.5.3
              rust-fast-image-resize-5.1.0
              rust-fastrand-1.9.0
              rust-fastrand-2.3.0
              rust-fdeflate-0.3.7
              rust-flate2-1.0.35
              rust-foreign-types-0.5.0
              rust-foreign-types-macros-0.2.3
              rust-foreign-types-shared-0.3.1
              rust-form-urlencoded-1.2.1
              rust-futures-channel-0.3.31
              rust-futures-core-0.3.31
              rust-futures-io-0.3.31
              rust-futures-lite-1.13.0
              rust-futures-lite-2.5.0
              rust-futures-macro-0.3.31
              rust-futures-sink-0.3.31
              rust-futures-task-0.3.31
              rust-futures-util-0.3.31
              rust-generic-array-0.14.7
              rust-gethostname-0.4.3
              rust-getrandom-0.2.15
              rust-gimli-0.31.1
              rust-gl-generator-0.14.0
              rust-glow-0.13.1
              rust-glutin-0.31.3
              rust-glutin-winit-0.4.2
              rust-glutin-egl-sys-0.6.0
              rust-glutin-glx-sys-0.5.0
              rust-glutin-wgl-sys-0.5.0
              rust-gpu-alloc-0.6.0
              rust-gpu-alloc-types-0.3.0
              rust-gpu-allocator-0.25.0
              rust-gpu-descriptor-0.2.4
              rust-gpu-descriptor-types-0.1.2
              rust-hashbrown-0.14.5
              rust-hashbrown-0.15.2
              rust-hassle-rs-0.11.0
              rust-heck-0.5.0
              rust-hermit-abi-0.3.9
              rust-hermit-abi-0.4.0
              rust-hex-0.4.3
              rust-hexf-parse-0.2.1
              rust-home-0.5.9
              rust-icrate-0.0.4
              rust-icu-collections-1.5.0
              rust-icu-locid-1.5.0
              rust-icu-locid-transform-1.5.0
              rust-icu-locid-transform-data-1.5.0
              rust-icu-normalizer-1.5.0
              rust-icu-normalizer-data-1.5.0
              rust-icu-properties-1.5.1
              rust-icu-properties-data-1.5.0
              rust-icu-provider-1.5.0
              rust-icu-provider-macros-1.5.0
              rust-idna-1.0.3
              rust-idna-adapter-1.2.0
              rust-image-0.24.9
              rust-image-0.25.5
              rust-indexmap-2.7.0
              rust-instant-0.1.13
              rust-io-lifetimes-1.0.11
              rust-is-terminal-polyfill-1.70.1
              rust-itertools-0.13.0
              rust-jni-0.21.1
              rust-jni-sys-0.3.0
              rust-jobserver-0.1.32
              rust-js-sys-0.3.76
              rust-khronos-egl-6.0.0
              rust-khronos-api-3.1.0
              rust-lazy-static-1.5.0
              rust-lcms2-6.1.0
              rust-lcms2-sys-4.0.5
              rust-libc-0.2.168
              rust-libloading-0.7.4
              rust-libloading-0.8.6
              rust-libredox-0.1.3
              rust-linux-raw-sys-0.3.8
              rust-linux-raw-sys-0.4.14
              rust-litemap-0.7.4
              rust-litrs-0.4.1
              rust-lock-api-0.4.12
              rust-log-0.4.22
              rust-malloc-buf-0.0.6
              rust-memchr-2.7.4
              rust-memmap2-0.9.5
              rust-memoffset-0.7.1
              rust-memoffset-0.9.1
              rust-metal-0.27.0
              rust-miniz-oxide-0.8.0
              rust-mio-1.0.3
              rust-naga-0.19.2
              rust-ndk-0.8.0
              rust-ndk-context-0.1.1
              rust-ndk-sys-0.5.0+25.2.9519653
              rust-nix-0.26.4
              rust-nix-0.29.0
              rust-nohash-hasher-0.2.0
              rust-num-traits-0.2.19
              rust-num-enum-0.7.3
              rust-num-enum-derive-0.7.3
              rust-objc-0.2.7
              rust-objc-sys-0.2.0-beta.2
              rust-objc-sys-0.3.5
              rust-objc2-0.3.0-beta.3.patch-leaks.3
              rust-objc2-0.4.1
              rust-objc2-0.5.2
              rust-objc2-app-kit-0.2.2
              rust-objc2-core-data-0.2.2
              rust-objc2-core-image-0.2.2
              rust-objc2-encode-2.0.0-pre.2
              rust-objc2-encode-3.0.0
              rust-objc2-encode-4.0.3
              rust-objc2-foundation-0.2.2
              rust-objc2-metal-0.2.2
              rust-objc2-quartz-core-0.2.2
              rust-objc-exception-0.1.2
              rust-object-0.36.5
              rust-once-cell-1.20.2
              rust-orbclient-0.3.48
              rust-ordered-stream-0.2.0
              rust-owned-ttf-parser-0.25.0
              rust-parking-2.2.1
              rust-parking-lot-0.12.3
              rust-parking-lot-core-0.9.10
              rust-paste-1.0.15
              rust-percent-encoding-2.3.1
              rust-pin-project-lite-0.2.15
              rust-pin-utils-0.1.0
              rust-piper-0.2.4
              rust-pkg-config-0.3.31
              rust-png-0.17.15
              rust-poll-promise-0.3.0
              rust-polling-2.8.0
              rust-polling-3.7.4
              rust-pollster-0.3.0
              rust-ppv-lite86-0.2.20
              rust-presser-0.3.1
              rust-proc-macro-crate-1.3.1
              rust-proc-macro-crate-3.2.0
              rust-proc-macro2-1.0.92
              rust-profiling-1.0.16
              rust-quick-xml-0.36.2
              rust-quote-1.0.37
              rust-rand-0.8.5
              rust-rand-chacha-0.3.1
              rust-rand-core-0.6.4
              rust-raw-window-handle-0.5.2
              rust-raw-window-handle-0.6.2
              rust-redox-syscall-0.3.5
              rust-redox-syscall-0.5.7
              rust-redox-users-0.4.6
              rust-regex-1.11.1
              rust-regex-automata-0.4.9
              rust-regex-syntax-0.8.5
              rust-renderdoc-sys-1.1.0
              rust-rfd-0.15.1
              rust-rgb-0.8.50
              rust-ron-0.8.1
              rust-rustc-demangle-0.1.24
              rust-rustc-hash-1.1.0
              rust-rustix-0.37.27
              rust-rustix-0.38.42
              rust-same-file-1.0.6
              rust-scoped-tls-1.0.1
              rust-scopeguard-1.2.0
              rust-sctk-adwaita-0.8.3
              rust-serde-1.0.215
              rust-serde-derive-1.0.215
              rust-serde-repr-0.1.19
              rust-sha1-0.10.6
              rust-shlex-1.3.0
              rust-signal-hook-registry-1.4.2
              rust-simd-adler32-0.3.7
              rust-slab-0.4.9
              rust-slotmap-1.0.7
              rust-smallvec-1.13.2
              rust-smithay-client-toolkit-0.18.1
              rust-smithay-client-toolkit-0.19.2
              rust-smithay-clipboard-0.7.2
              rust-smol-str-0.2.2
              rust-socket2-0.4.10
              rust-socket2-0.5.8
              rust-spirv-0.3.0+sdk-1.3.268.0
              rust-stable-deref-trait-1.2.0
              rust-static-assertions-1.1.0
              rust-strict-num-0.1.1
              rust-strsim-0.11.1
              rust-syn-1.0.109
              rust-syn-2.0.90
              rust-synstructure-0.13.1
              rust-tempfile-3.14.0
              rust-termcolor-1.4.1
              rust-terminal-size-0.4.1
              rust-thiserror-1.0.69
              rust-thiserror-impl-1.0.69
              rust-tiny-skia-0.11.4
              rust-tiny-skia-path-0.11.4
              rust-tinystr-0.7.6
              rust-tokio-1.42.0
              rust-tokio-macros-2.4.0
              rust-tokio-stream-0.1.17
              rust-toml-datetime-0.6.8
              rust-toml-edit-0.19.15
              rust-toml-edit-0.22.22
              rust-tracing-0.1.41
              rust-tracing-attributes-0.1.28
              rust-tracing-core-0.1.33
              rust-ttf-parser-0.25.1
              rust-type-map-0.5.0
              rust-typenum-1.17.0
              rust-uds-windows-1.1.0
              rust-unicode-ident-1.0.14
              rust-unicode-segmentation-1.12.0
              rust-unicode-width-0.1.14
              rust-unicode-xid-0.2.6
              rust-url-2.5.4
              rust-urlencoding-2.1.3
              rust-utf16-iter-1.0.5
              rust-utf8-iter-1.0.4
              rust-utf8parse-0.2.2
              rust-vapoursynth-0.4.0
              rust-vapoursynth-sys-0.4.1
              rust-version-check-0.9.5
              rust-waker-fn-1.2.0
              rust-walkdir-2.5.0
              rust-wasi-0.11.0+wasi-snapshot-preview1
              rust-wasm-bindgen-0.2.99
              rust-wasm-bindgen-backend-0.2.99
              rust-wasm-bindgen-futures-0.4.49
              rust-wasm-bindgen-macro-0.2.99
              rust-wasm-bindgen-macro-support-0.2.99
              rust-wasm-bindgen-shared-0.2.99
              rust-wayland-backend-0.3.7
              rust-wayland-client-0.31.7
              rust-wayland-csd-frame-0.3.0
              rust-wayland-cursor-0.31.7
              rust-wayland-protocols-0.31.2
              rust-wayland-protocols-0.32.5
              rust-wayland-protocols-plasma-0.2.0
              rust-wayland-protocols-wlr-0.2.0
              rust-wayland-protocols-wlr-0.3.5
              rust-wayland-scanner-0.31.5
              rust-wayland-sys-0.31.5
              rust-web-sys-0.3.76
              rust-web-time-0.2.4
              rust-webbrowser-0.8.15
              rust-wgpu-0.19.4
              rust-wgpu-core-0.19.4
              rust-wgpu-hal-0.19.5
              rust-wgpu-types-0.19.2
              rust-widestring-1.1.0
              rust-winapi-0.3.9
              rust-winapi-i686-pc-windows-gnu-0.4.0
              rust-winapi-util-0.1.9
              rust-winapi-x86-64-pc-windows-gnu-0.4.0
              rust-windows-0.48.0
              rust-windows-0.52.0
              rust-windows-core-0.52.0
              rust-windows-implement-0.48.0
              rust-windows-interface-0.48.0
              rust-windows-sys-0.45.0
              rust-windows-sys-0.48.0
              rust-windows-sys-0.52.0
              rust-windows-sys-0.59.0
              rust-windows-targets-0.42.2
              rust-windows-targets-0.48.5
              rust-windows-targets-0.52.6
              rust-windows-aarch64-gnullvm-0.42.2
              rust-windows-aarch64-gnullvm-0.48.5
              rust-windows-aarch64-gnullvm-0.52.6
              rust-windows-aarch64-msvc-0.42.2
              rust-windows-aarch64-msvc-0.48.5
              rust-windows-aarch64-msvc-0.52.6
              rust-windows-i686-gnu-0.42.2
              rust-windows-i686-gnu-0.48.5
              rust-windows-i686-gnu-0.52.6
              rust-windows-i686-gnullvm-0.52.6
              rust-windows-i686-msvc-0.42.2
              rust-windows-i686-msvc-0.48.5
              rust-windows-i686-msvc-0.52.6
              rust-windows-x86-64-gnu-0.42.2
              rust-windows-x86-64-gnu-0.48.5
              rust-windows-x86-64-gnu-0.52.6
              rust-windows-x86-64-gnullvm-0.42.2
              rust-windows-x86-64-gnullvm-0.48.5
              rust-windows-x86-64-gnullvm-0.52.6
              rust-windows-x86-64-msvc-0.42.2
              rust-windows-x86-64-msvc-0.48.5
              rust-windows-x86-64-msvc-0.52.6
              rust-winit-0.29.15
              rust-winnow-0.5.40
              rust-winnow-0.6.20
              rust-write16-1.0.0
              rust-writeable-0.5.5
              rust-x11-dl-2.21.0
              rust-x11rb-0.13.1
              rust-x11rb-protocol-0.13.1
              rust-xcursor-0.3.8
              rust-xdg-home-1.3.0
              rust-xkbcommon-dl-0.4.2
              rust-xkeysym-0.2.1
              rust-xml-rs-0.8.24
              rust-yoke-0.7.5
              rust-yoke-derive-0.7.5
              rust-zbus-3.15.2
              rust-zbus-5.1.1
              rust-zbus-macros-3.15.2
              rust-zbus-macros-5.1.1
              rust-zbus-names-2.6.1
              rust-zbus-names-4.1.0
              rust-zerocopy-0.7.35
              rust-zerocopy-derive-0.7.35
              rust-zerofrom-0.1.5
              rust-zerofrom-derive-0.1.5
              rust-zerovec-0.10.4
              rust-zerovec-derive-0.10.3
              rust-zvariant-3.15.2
              rust-zvariant-5.1.0
              rust-zvariant-derive-3.15.2
              rust-zvariant-derive-5.1.0
              rust-zvariant-utils-1.0.1
              rust-zvariant-utils-3.0.2
              ))
    (home-page "https://github.com/quietvoid/vspreview-rs/")
    (synopsis "Frame viewer for vapoursynth")
    (description "minimal VapourSynth script previewer")
    (license license:expat)))

vspreview-rs
