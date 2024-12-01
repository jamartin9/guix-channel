(define-module (jam system home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
;  #:use-module (gnu home services sound)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services shepherd)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (srfi srfi-9 gnu)
  #:use-module (guix channels)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (jam packages emacs)
  #:use-module (jam packages tree-sitter)
  #:use-module (jam system services)
  #:use-module (jam system channels)
  #:use-module (guix gexp)
  #:export (%jam-home))

  (define emacs-service
    (shepherd-service
     (provision '(emacs))
     (start #~(make-system-constructor "emacs --daemon"))
     (stop #~(make-system-destructor "emacsclient --eval '(kill-emacs)'"))
     (auto-start? #f)))

  (define guix-service ; add type for portable guix package
    (shepherd-service
     (provision '(guix))
     (start #~(make-forkexec-constructor `("guix-daemon" ,(string-append "--listen=" (if (getenv "XDG_DATA_HOME") (getenv "XDG_DATA_HOME")
                                                                                         (string-append (getenv "HOME")
                                                                                                        file-name-separator-string
                                                                                                        ".local"
                                                                                                        file-name-separator-string
                                                                                                        "share"))
                                                                         file-name-separator-string
                                                                         "guix"
                                                                         file-name-separator-string
                                                                         "var"
                                                                         file-name-separator-string
                                                                         "guix"
                                                                         file-name-separator-string
                                                                         "daemon-socket"
                                                                         file-name-separator-string
                                                                         "socket") ;;"--build-users-group=guixbuild"
                                           "--disable-chroot")
                                         #:environment-variables `(,(string-append "NIX_STORE=" (if (getenv "XDG_DATA_HOME")
                                                                                                   (getenv "XDG_DATA_HOME")
                                                                                                    (string-append (getenv "HOME")
                                                                                                                   file-name-separator-string
                                                                                                                   ".local"
                                                                                                                   file-name-separator-string
                                                                                                                   "share"))
                                                                                   file-name-separator-string
                                                                                   "guix"
                                                                                   file-name-separator-string
                                                                                   "gnu"
                                                                                   file-name-separator-string
                                                                                   "store")
                                                                   ,@(environ))))
     (stop #~(make-kill-destructor))
     (auto-start? #f)))

  (define ssh-service ; writes to /etc/dropbear for keys
    (set-fields       ; least-authority-wrapper or fork+exec-command/container or run-container to contain
     (car ((@@ (gnu services ssh) dropbear-shepherd-service) (dropbear-configuration (port-number 2222)
                                                                                     (syslog-output? #f)
                                                                                     (password-authentication? #f)
                                                                                     (pid-file "/tmp/dropbear.pid"))))
     ((shepherd-service-requirement) '())
     ((shepherd-service-auto-start?) #f)))

(define %jam-home
  (home-environment
   (packages (append
            (list tree-sitter-yaml)
            ;(map transform-emacs-build-git (list emacs-fd))
            (map specification->package (list "guile"
                                              "emacs-pgtk-xwidgets" ; managed by default profile
                                              "git"
                                              "nss-certs"
                                              "aspell" "aspell-dict-en"
                                              ;"ungoogled-chromium" "ublock-origin-chromium"
                                              ;"ripgrep" ;"fd"
                                              ;"mpv"; MAYBE add guix package for mpv with libvdpau-nvidia from nvidia-libs nonguix
                                              ;"virt-viewer" ; "qemu"; for spice remote-viewer
                                              ;"alacritty"; "xterm"
                                              ;"screen"
                                              ;"xdg-utils" "xdg-dbus-proxy" "shared-mime-info"; "xorg-server-wayland" ;(list glib "bin")
                                              "gnupg"
                                              "curl"; emacs-osm needs for CA's
                                              "tree-sitter-rust" "tree-sitter-python"
                                              "emacs-gptel" "emacs-eat" "emacs-debbugs" "emacs-org-roam" "emacs-guix" "emacs-osm" "emacs-minions" "emacs-transmission" "emacs-undo-tree" "emacs-company" "emacs-dape" "emacs-which-key" "emacs-macrostep-geiser" "emacs-geiser-guile" "emacs-flymake-guile" "emacs-pyvenv"))))
   (services
    (list
     ;(service home-pipewire-service-type)
     (simple-service 'my-channel-services
                     home-channels-service-type
                     %jam-channels
                     )
     (service home-shepherd-service-type (home-shepherd-configuration
                                          (shepherd (specification->package "shepherd"))
                                          ;(auto-start? #f)
                                          (services (list emacs-service
                                                          ;transmission-service
                                                          ;ssh-service
                                                          ;guix-service
                                                          ))))

     (service home-bash-service-type
              (home-bash-configuration
               (package (specification->package "bash"))
               (guix-defaults? #f)
               ;(environment-variables (list '("EDITOR" . "emacs")))
               (bashrc (list (plain-file "guix.alias" "\
  #!/usr/bin/env bash
  # shellcheck disable=SC2155,SC2076,SC2068,SC1090,SC1091

  export TMPDIR=\"/tmp\"

  export HISTFILE=\"${XDG_STATE_HOME}\"/bash/history

  export CARGO_HOME=\"${XDG_DATA_HOME}\"/cargo
  export RUSTUP_HOME=\"${XDG_DATA_HOME}\"/rustup
  export GNUPGHOME=\"${XDG_DATA_HOME}\"/gnupg
  export PASSWORD_STORE_DIR=\"${XDG_DATA_HOME}\"/pass

  export CUDA_CACHE_PATH=\"${XDG_CACHE_HOME}\"/nv
  export ICEAUTHORITY=\"${XDG_CACHE_HOME}\"/ICEauthority
  export TEXMFVAR=\"${XDG_CACHE_HOME}\"/texlive/texmf-var

  export GPG_TTY=$(tty)

  export EDITOR=\"emacs\"
  alias emacsc=\"emacsclient -c -a ''\"
  alias emacskill=\"emacsc -e '(kill-emacs)'\"
  _emacs_run_dump(){
      if [ ! -f ~/emp.dmp ]; then
          emacs --batch --load ${XDG_CONFIG_DIR:-~/.config}/emacs/init.el --eval='(dump-emacs-portable \"~/emp.dmp\")'
      fi
      emacs --dump-file=$HOME/emp.dmp $@
  }
  alias emrd=\"_emacs_run_dump\"

  # Guix parts
  alias guixPack=\"guix pack -S /bin=bin -RR\"
  alias guixPackDock=\"guix pack -S /bin=bin -f docker\"
  alias guixPackVm=\"guix system image -t qcow2\" # qemu-img resize x.qcow +10G boot then growpart and resize2fs

  _guix_run_vm(){
      local vmOpts=()
      local qOpts=()
      local target=\"\"
      while [ $# -gt 0 ]; do
          local arg=\"${1}\"
          case \"${arg}\" in
              -d|--default)
                  qOpts=(\"-spice\" \"port=5930,disable-ticketing\" \"-m\" \"2048\" \"-nic\" \"user,model=virtio-net-pci,hostfwd=tcp::8080-:8081\" \"${qOpts[@]}\")
                  vmOpts=(\"--share=$HOME/tmp=/storage\" \"${vmOpts[@]}\") # --persistent
                  shift
                  ;;
              -qo|--qopt)
                  qOpts=(\"${qOpts[@]}\" \"${2}\")
                  shift 2
                  ;;
              -t|--target)
                  target=\"${2}\"
                  shift 2
                  ;;
              -vo|--vmopt)
                  vmOpts=(\"${vmOpts[@]}\" \"${2}\" )
                  shift 2
                  ;;
              *)
                  printf 'Invalid option %s \n' \"${1}\"
                  printf 'Valid options are: -t OS.scm -qo QEMU-OPTS -vo GUIXVM-OPTS --default \n'
                  shift
                  ;;
          esac
      done
      $(guix system vm \"${vmOpts[@]}\" \"${target}\") \"${qOpts[@]}\"
  }
  alias guixRunVm=\"_guix_run_vm\" # guixRunVm -d -t os.scm

  _guix_vars(){
      if [ -z \"${GUIX_PREV_ENV}\" ]; then # unset vars in guix-home and keep login vars
          export GUIX_PREV_ENV=(\"$(env -u PATH -u GUIX_PROFILE -u GUILE_LOAD_COMPILED_PATH -u GUILE_LOAD_PATH -u SSL_CERT_DIR -u SSL_CERT_FILE -u GIT_EXEC_PATH -u GIT_SSL_CAINFO -u INFOPATH -u EMACSLOADPATH -u EMACSNATIVELOADPATH -u BASH_LOADABLES_PATH -u PASSWORD_STORE_SYSTEM_EXTENSION_DIR -u CURL_CA_BUNDLE PATH=/sbin:/bin:/usr/sbin:/usr/bin /bin/sh -c '. /etc/profile && env')\")
          export GUIX_ACTIVE_PROFILES=()
          # guix-home activated with login shell
          [ -f ~/.guix-home/setup-environment ] && export GUIX_PREV_ENV_home=(\"$(env)\") && export GUIX_ACTIVE_PROFILES=(\"home\")
      fi
      if [ -z \"${GUIX_MANIFEST_DIR}\" ]; then
          export GUIX_MANIFEST_DIR=${XDG_CONFIG_DIR:-~/.config}/guix-manifests
      fi
      if [ -z \"${GUIX_EXTRA_PROFILES}\" ]; then
          export GUIX_EXTRA_PROFILES=${XDG_DATA_HOME:-~/.local/share}/guix-extra-profiles
      fi
  }
  _guix_list_profiles(){
      printf \"The following profiles are available: \n\"
      if [ -f ~/.guix-profile/etc/profile ]; then
          printf \"default \n\"
      fi
      if [ -f ~/.guix-home/profile/etc/profile ]; then
          printf \"home \n\"
      fi
      for manifest in \"${GUIX_MANIFEST_DIR}\"/*.scm; do
          if [ \"${manifest}\" != \"${GUIX_MANIFEST_DIR}/*.scm\" ]; then # no glob
              printf '%s \n' \"$(basename \"${manifest%.*}\")\"
          fi
      done
      printf \"The following profiles are active: \n\"
      for prof in ${GUIX_ACTIVE_PROFILES[@]}; do
          printf '%s \n' \"${prof}\"
      done

  }
  _guix_update_profile(){
      local arg=\"${1}\"
      local profile=\"${GUIX_EXTRA_PROFILES}/${arg}/${arg}\"
      if [ \"${arg}\" = \"default\" ]; then
          guix package -u
      elif [ \"${arg}\" = \"home\" ]; then
           guix home reconfigure ~/.guix-home/configuration.scm
      elif [ -f \"${GUIX_MANIFEST_DIR}/${arg}.scm\" ]; then
           if [ ! -d \"${profile}\" ]; then
              mkdir -p \"${GUIX_EXTRA_PROFILES}/${arg}\"
           fi
           guix package -m \"${GUIX_MANIFEST_DIR}/${arg}.scm\" -p \"${profile}\"
      fi
  }
  _guix_activate_profile(){
      local arg=\"${1}\"
      local profile=\"${GUIX_EXTRA_PROFILES}/${arg}/${arg}\"
      if [ \"${arg}\" != \"default\" ] &&
         [ \"${arg}\" != \"home\" ] &&
         [ ! -f \"${profile}\"/etc/profile ]; then # home and default are always installed
          _guix_update_profile \"${arg}\"
      fi
      if [ \"${arg}\" = \"default\" ]; then # unset GUIX_PROFILE so path proliferates
          [ -f ~/.guix-profile/etc/profile ] && unset GUIX_PROFILE && . ~/.guix-profile/etc/profile
          [ -f ~/.config/guix/current/etc/profile ] && unset GUIX_PROFILE && . ~/.config/guix/current/etc/profile
      elif [ \"${arg}\" = \"home\" ]; then # tilde avoids variables
          [ -f ~/.guix-home/setup-environment ] && . ~/.guix-home/setup-environment && export GUIX_PROFILE
      elif [ -f \"${profile}\"/etc/profile ]; then
          unset GUIX_PROFILE && . \"${profile}\"/etc/profile
      else
          printf 'The manifest for %s does not exist \n' \"${arg}\"
          return
      fi
      local stash=(\"${GUIX_PREV_ENV[@]}\") # hide prev envs from being saved in new GUIX_PREV_ENV_$manifest
      unset GUIX_PREV_ENV
      for mani in ${GUIX_ACTIVE_PROFILES[@]}; do
          local ref=\"GUIX_PREV_ENV_${mani}[@]\"
          local \"stash_${mani}=${!ref}\" # MAYBE indirect variable expansion portable
          unset \"GUIX_PREV_ENV_${mani}\"
      done
      local prev=(\"$(env)\") # save current env
      export \"GUIX_PREV_ENV_${arg}=${prev[*]}\"
      export GUIX_PREV_ENV=(\"${stash[@]}\") # restore prev envs
      for mani in ${GUIX_ACTIVE_PROFILES[@]}; do
          local ref_stash=\"stash_${mani}\"
          export \"GUIX_PREV_ENV_${mani}=${!ref_stash}\" # MAYBE indirect variable expansion portable
      done
      GUIX_ACTIVE_PROFILES+=(\"${arg}\")
      export GUIX_ACTIVE_PROFILES
  }
  _guix_deactivate_profile(){
      local arg=\"${1}\"
      local ref=\"GUIX_PREV_ENV_${arg}\"
      if [ -n \"${!ref}\" ]; then # the prev env exists # MAYBE indirect variable expansion portable
          for entry in ${!ref}; do # unset vars of profile # MAYBE indirect variable expansion portable
              if [[ ! \"${entry%%=*}\" =~ GUIX_PREV_ENV.* ]] && [[ \"${entry}\"  =~ \"=\" ]] &&
                 [ \"${entry%%=*}\" != \"GUIX_ACTIVE_PROFILES\" ] ;then
                  unset \"${entry%%=*}\"
              fi
          done
          unset \"GUIX_PREV_ENV_${arg}\"
          local prev_entry
          for entry in ${GUIX_PREV_ENV[@]}; do # restore init env
              if [[ ! \"${entry}\"  =~ \"=\" ]]; then # append onto the prev_entry for the space seperated args without equality assignment
                  prev_entry=\"${prev_entry} ${entry}\"
                  export \"${prev_entry?}\"
              else
                  prev_entry=\"${entry}\"
                  export \"${entry%%=*}=${entry#*=}\"
              fi
          done
          # active manifests again
          local active_stash=(\"${GUIX_ACTIVE_PROFILES[@]}\") # export GUIX_ACTIVE_PROFILES=(\"${GUIX_ACTIVE_PROFILES[@]/$arg}\")
          export GUIX_ACTIVE_PROFILES=() # unset profiles so GUIX_PREV_ENV_${manifest} will not be saved
          for mani in ${active_stash[@]}; do
              if [ \"${mani}\" != \"${arg}\" ]; then
                  unset \"GUIX_PREV_ENV_${mani}\" # prevent all GUIX_PREV_ENV_${manifest}'s from being saved
              fi
          done
          for mani in ${active_stash[@]}; do
              if [ \"${mani}\" != \"${arg}\" ]; then
                  _guix_activate_profile \"${mani}\"
              fi
          done
      fi
  }
  _guix_opts(){
      local help=\"
       Takes a list of profile manifest shortnames/commands
       GUIX_MANIFEST_DIR will be set to ${XDG_CONFIG_DIR:-~/.config}/guix-manifests when not set
       GUIX_EXTRA_PROFILES will be set to ${XDG_DATA_HOME:-~/.local/share}/guix-extra-profiles when not set
       GUIX_ACTIVE_PROFILES will be set to the profiles that are activated (in order)
       GUIX_PREV_ENV will be set to contents of env without guix profiles
       GUIX_PREV_ENV_shortname will be set to the contents of env with the profile
       The shortname is the basename
       GUIX_MANIFEST_DIR/shortname.scm is the format of manifest search path
       Profiles besides home/default will be stored under: GUIX_EXTRA_PROFILES/shortname/shortname
       The commands are activate, update, deactivate and list; activate is the default
       -a|--activate shortname -> sources/installs profile; appends to GUIX_ACTIVE_PROFILES
       -d|--deactivate shortname -> restore env before the profile was activated
       -u|--update shortname -> guix package upgrades profile
       -l|--list -> print the contents of GUIX_ACTIVE_PROFILES and GUIX_MANIFEST_DIR (as shortnames)
       -h|--help -> print this message
  \"
      _guix_vars
      while [ $# -gt 0 ]; do
          local arg=\"${1}\"
          case \"${arg}\" in
              -a|--activate)
                  if [[ \" ${GUIX_ACTIVE_PROFILES[*]} \" =~ \" ${2} \" ]]; then
                      printf '%s is already active \n' \"${2}\"
                  else
                      _guix_activate_profile \"${2}\"
                  fi
                  shift 2
                  ;;
              -d|--deactivate)
                  if [[ \" ${GUIX_ACTIVE_PROFILES[*]} \" =~ \" ${2} \" ]]; then
                      _guix_deactivate_profile \"${2}\"
                      cd . # restore ps1 prompt dir/info
                  else
                      printf '%s is not active \n' \"${2}\"
                  fi
                  shift 2
                  ;;
              -h|--help)
                  printf '%s' \"${help}\"
                  shift
                  ;;
              -l|--list)
                  _guix_list_profiles
                  shift
                  ;;
              -u|--update)
                  _guix_update_profile \"${2}\"
                  shift 2
                  ;;
              *)
                  if [[ \" ${GUIX_ACTIVE_PROFILES[*]} \" =~ \" ${1} \" ]]; then
                      printf '%s is already active \n' \"${1}\"
                  else
                      _guix_activate_profile \"${1}\"
                  fi
                  shift
                  ;;
          esac
      done
  }
  alias guixProf=_guix_opts
  _guix_opts default"))))))))
)
%jam-home
