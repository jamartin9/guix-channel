(define-module (jam packages p2pool)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages pkg-config) ; pkg-config
  #:use-module (gnu packages libevent) ; libuv
  #:use-module (gnu packages gsasl) ; gss - p2pool
  #:use-module (gnu packages networking) ; zeromq - p2pool
  #:use-module (gnu packages crypto) ; libsodium - p2pool
  #:use-module (guix build-system cmake) ; cmake
  #:use-module (gnu packages gnunet) ; libmicrohttpd - xmrig
  #:use-module (gnu packages mpi) ; hwloc - xmrig
  #:use-module (gnu packages tls) ; openssl - xmrig
  #:use-module ((gnu packages) #:prefix gnu:)
  #:use-module (guix diagnostics)
  #:use-module (guix i18n)
  #:use-module (ice-9 regex)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  )



(define (search-patch file-name)
  "Search the patch FILE-NAME.  Raise an error if not found."
  (or (search-path (%patch-path) file-name)
      (raise (formatted-message (G_ "~a: patch not found")
                                file-name))))

(define-syntax-rule (search-patches file-name ...)
  "Return the list of absolute file names corresponding to each FILE-NAME found in %PATCH-PATH."
  (list (search-patch file-name) ...))

(define %channel-root
  (find (lambda (path)
          (file-exists? (string-append path "/jam/packages/p2pool.scm")))
        %load-path))

(define %patch-path
  (make-parameter
   (append
    (list (string-append %channel-root "/jam/packages/patches"))
    (gnu:%patch-path))))



(define-public monero-p2pool
  (let ((commit "248fcee1746d14e9e9ff8d0415c34bde924c8fb9")
        (revision "1"))
    (package
      (name "p2pool-xmr")
      (version (git-version "1.6" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (recursive? #t)
                      (url "https://github.com/SChernykh/p2pool/")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1m3i1hmybczxbgvfz2kqb81bspk3nq114b3mxvm060632nngamrv"))
                (modules '((guix build utils)))))
      (build-system cmake-build-system)
      (outputs '("out"))
      (arguments
       `(#:tests? #false
         #:phases (modify-phases %standard-phases
                                 (add-after 'install 'copy
                                            (lambda* (#:key inputs outputs #:allow-other-keys)
                                              (let* ((out (assoc-ref outputs "out"))
                                                     (source (assoc-ref inputs "source")))
                                              (mkdir-p (string-append out "/bin"))
                                              (copy-file "p2pool" (string-append out "/bin" "/p2pool"))))))))
      (inputs
       (list libuv gss zeromq libsodium))
      (native-inputs
       (list pkg-config))
      (home-page "https://p2pool.io/")
      (synopsis "p2p mining xmr pool")
      (description
       "Decentralized pool for Monero mining.")
      (license license:gpl3))))


(define-public xmrig
  (let ((commit "4f103b6b45661bbff9dcd2b84cdf00a1b551e851")
        (revision "1"))
    (package
      (name "xmrig")
      (version (git-version "6.16.3" revision commit))
      (source (origin
                (patches (search-patches "xmrig-donate.patch"))
                (method git-fetch)
                (uri (git-reference
                      (recursive? #t)
                      (url "https://github.com/xmrig/xmrig/")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0d368ld811ysghwk8kyvc2f515z8fib5cgwhpjvd6rifk41gq7v1"))
                (modules '((guix build utils)))))
      (build-system cmake-build-system)
      (outputs '("out"))
      (arguments
       `(#:tests? #false
         #:phases (modify-phases %standard-phases
                                 (delete 'install)
                                 (add-after 'build 'copy
                                            (lambda* (#:key inputs outputs #:allow-other-keys)
                                              (let* ((out (assoc-ref outputs "out"))
                                                     (source (assoc-ref inputs "source")))
                                              (mkdir-p (string-append out "/bin"))
                                              (copy-file "xmrig" (string-append out "/bin" "/xmrig"))))))))
      (inputs
       (list libuv openssl `(,hwloc "lib") libmicrohttpd))
      (native-inputs
       (list pkg-config))
      (home-page "https://xmrig.com/")
      (synopsis "crypto miner")
      (description
       "Crypto mining for RandomX, KawPow, CryptoNight and AstroBTW.")
      (license license:gpl3))))
