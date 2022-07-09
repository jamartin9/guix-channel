;@node ZFS File System
;
;@subsection ZFS File System
;
;
;
;Support for ZFS file systems in Guix is based on the OpenZFS project.
;
;OpenZFS currently only supports Linux-Libre and is not available on the
;
;Hurd.
;
;
;
;OpenZFS is free software; unfortunately its license is incompatible with
;
;the GNU General Public License (GPL), the license of the Linux kernel,
;
;which means they cannot be distributed together.  However, as a user,
;
;you can choose to build ZFS and use it together with Linux; you can
;
;even rely on Guix to automate this task.  See
;
;@uref{https://www.fsf.org/licensing/zfs-and-linux, this analysis by
;
;the Free Software Foundation} for more information.
;
;
;
;As a large and complex kernel module, OpenZFS has to be compiled for a
;
;specific version of Linux-Libre.  At times, the latest OpenZFS package
;
;available in Guix is not compatible with the latest Linux-Libre version.
;
;Thus, directly installing the @code{zfs} package can fail.
;
;
;
;Instead, you are recommended to select a specific older long-term-support
;
;Linux-Libre kernel.  Do not use @code{linux-libre-lts}, as even the
;
;latest long-term-support kernel may be too new for @code{zfs}.  Instead,
;
;explicitly select a specific older version, such as @code{linux-libre-5.10},
;
;and upgrade it manually later as new long-term-support kernels become
;
;available that you have confirmed is compatible with the latest available
;
;OpenZFS version on Guix.
;
;
;
;For example, you can modify your system configuration file to a specific
;
;Linux-Libre version and add the @code{zfs-service-type} service.
;
;
;
;@lisp
;
;(use-modules (gnu))
;
;(use-package-modules
;
;  #;@dots{}
;
;  linux)
;
;(use-service-modules
;
;  #;@dots{}
;
;  file-systems)
;
;
;
;(define my-kernel linux-libre-5.10)
;
;
;
;(operating-system
;
;  (kernel my-kernel)
;
;  #;@dots{}
;
;  (services
;
;    (cons* (service zfs-service-type
;
;                    (zfs-configuration
;
;                      (kernel my-kernel)))
;
;           #;@dots{}
;
;           %desktop-services))
;
;  #;@dots{})
;
;@end lisp
;
;
;
;@defvr {Scheme Variable} zfs-service-type
;
;This is the type for a service that adds ZFS support to your operating
;
;system.  The service is configured using a @code{zfs-configuration}
;
;record.
;
;
;
;Here is an example use:
;
;
;
;@lisp
;
;(service zfs-service-type
;
;  (zfs-configuration
;
;    (kernel linux-libre-5.4)))
;
;@end lisp
;
;@end defvr
;
;
;
;@deftp {Data Type} zfs-configuration
;
;This data type represents the configuration of the ZFS support in Guix
;
;System.  Its fields are:
;
;
;
;@table @asis
;
;@item @code{kernel}
;
;The package of the Linux-Libre kernel to compile OpenZFS for.  This field
;
;is always required.  It @emph{must} be the same kernel you use in your
;
;@code{operating-system} form.
;
;
;
;@item @code{base-zfs} (default: @code{zfs})
;
;The OpenZFS package that will be compiled for the given Linux-Libre kernel.
;
;
;
;@item @code{base-zfs-auto-snapshot} (default: @code{zfs-auto-snapshot})
;
;The @code{zfs-auto-snapshot} package to use.  It will be modified to
;
;specifically use the OpenZFS compiled for your kernel.
;
;
;
;@item @code{dependencies} (default: @code{'()})
;
;A list of @code{<file-system>} or @code{<mapped-device>} records that must
;
;be mounted or opened before OpenZFS scans for pools to import.  For example,
;
;if you have set up LUKS containers as leaf VDEVs in a pool, you have to
;
;include their corresponding @code{<mapped-ddevice>} records so that OpenZFS
;
;can import the pool correctly at bootup.
;
;
;
;@item @code{auto-mount?} (default: @code{#t})
;
;Whether to mount datasets with the ZFS @code{mountpoint} property automatically
;
;at startup.  This is the behavior that ZFS users usually expect.  You might
;
;set this to @code{#f} for an operating system intended as a ``rescue'' system
;
;that is intended to help debug problems with the disks rather than actually
;
;work in production.
;
;
;
;@item @code{auto-scrub} (default: @code{'weekly})
;
;Specifies how often to scrub all pools.  Can be the symbols @code{'weekly} or
;
;@code{'monthly}, or a schedule specification understood by
;
;@xref{mcron, mcron job specifications,, mcron, GNU@tie{}mcron}, such as
;
;@code{"0 3 * * 6"} for ``every 3AM on Saturday''.
;
;It can also be @code{#f} to disable auto-scrubbing (@strong{not recommended}).
;
;
;
;The general guideline is to scrub weekly when using consumer-quality drives, and
;
;to scrub monthly when using enterprise-quality drives.
;
;
;
;@code{'weekly} scrubs are done on Sunday midnight, while @code{monthly} scrubs
;
;are done on midnight on the first day of each month.
;
;
;
;@item @code{auto-snapshot?} (default: @code{#t})
;
;Specifies whether to auto-snapshot by default.  If @code{#t}, then snapshots
;
;are automatically created except for ZFS datasets with the
;
;@code{com.sun:auto-snapshot} ZFS vendor property set to @code{false}.
;
;
;
;If @code{#f}, snapshots will not be automatically created, unless the ZFS
;
;dataset has the @code{com.sun:auto-snapshot} ZFS vendor property set to
;
;@code{true}.
;
;
;
;@item @code{auto-snapshot-keep} (default: @code{'()})
;
;Specifies an association list of symbol-number pairs, indicating the number
;
;of automatically-created snapshots to retain for each frequency type.
;
;
;
;If not specified via this field, by default there are 4 @code{frequent}, 24
;
;@code{hourly}, 31 @code{daily}, 8 @code{weekly}, and 12 @code{monthly} snapshots.
;
;
;
;For example:
;
;
;
;@lisp
;
;(zfs-configuration
;
;  (kernel my-kernel)
;
;  (auto-snapshot-keep
;
;    '((frequent . 8)
;
;      (hourly . 12))))
;
;@end lisp
;
;
;
;The above will keep 8 @code{frequent} snapshots and 12 @code{hourly} snapshots.
;
;@code{daily}, @code{weekly}, and @code{monthly} snapshots will keep their
;
;defaults (31 @code{daily}, 8 @code{weekly}, and 12 @code{monthly}).
;
;
;
;@end table
;
;@end deftp
;
;
;
;@subsubsection ZFS Auto-Snapshot
;
;
;
;The ZFS service on Guix System supports auto-snapshots as implemented in the
;
;Solaris operating system.
;
;
;
;@code{frequent} (every 15 minutes), @code{hourly}, @code{daily}, @code{weekly},
;
;and @code{monthly} snapshots are created automatically for ZFS datasets that
;
;have auto-snapshot enabled.  They will be named, for example,
;
;@code{zfs-auto-snap_frequent-2021-03-22-1415}.  You can continue to use
;
;manually-created snapshots as long as they do not conflict with the naming
;
;convention used by auto-snapshot.  You can also safely manually destroy
;
;automatically-created snapshots, for example to free up space.
;
;
;
;The @code{com.sun:auto-snapshot} ZFS property controls auto-snapshot on a
;
;per-dataset level.  Sub-datasets will inherit this property from their parent
;
;dataset, but can have their own property.
;
;
;
;You @emph{must} set this property to @code{true} or @code{false} exactly,
;
;otherwise it will be treated as if the property is unset.
;
;
;
;For example:
;
;
;
;@example
;
;# zfs list -o name
;
;NAME
;
;tank
;
;tank/important-data
;
;tank/tmp
;
;# zfs set com.sun:auto-snapshot=true tank
;
;# zfs set com.sun:auto-snapshot=false tank/tmp
;
;@end example
;
;
;
;The above will set @code{tank} and @code{tank/important-data} to be
;
;auto-snapshot, while @code{tank/tmp} will not be auto-snapshot.
;
;
;
;If the @code{com.sun:auto-snapshot} property is not set for a dataset
;
;(the default when pools and datasets are created), then whether
;
;auto-snapshot is done or not will depend on the @code{auto-snapshot?}
;
;field of the @code{zfs-configuration} record.
;
;
;
;There are also @code{com.sun:auto-snapshot:frequent},
;
;@code{com.sun:auto-snapshot:hourly}, @code{com.sun:auto-snapshot:daily},
;
;@code{com.sun:auto-snapshot:weekly}, and @code{com.sun:auto-snapshot:monthly}
;
;properties that give finer-grained control of whether to auto-snapshot a
;
;dataset at a particular schedule.
;
;
;
;The number of snapshots kept for all datasets can be overridden via the
;
;@code{auto-snapshot-keep} field of the @code{zfs-configuration} record.
;
;There is currently no support to have different numbers of snapshots to
;
;keep for different datasets.
;
;
;
;@subsubsection ZVOLs
;
;
;
;ZFS supports ZVOLs, block devices that ZFS exposes to the operating
;
;system in the @code{/dev/zvol/} directory.  The ZVOL will have the same
;
;resilience and self-healing properties as other datasets on your ZFS pool.
;
;ZVOLs can also be snapshotted (and will be included in auto-snapshotting
;
;if enabled), which snapshots the state of the block device, effectively
;
;snapshotting the hosted file system.
;
;
;
;You can put any file system inside the ZVOL.  However, in order to mount this
;
;file system at system start, you need to add @code{%zfs-zvol-dependency} as a
;
;dependency of each file system inside a ZVOL.
;
;
;
;@defvr {Scheme Variable} %zfs-zvol-dependency
;
;An artificial @code{<mapped-device>} which tells the file system mounting
;
;service to wait for ZFS to provide ZVOLs before mounting the
;
;@code{<file-system>} dependent on it.
;
;@end defvr
;
;
;
;For example, suppose you create a ZVOL and put an ext4 filesystem
;
;inside it:
;
;
;
;@example
;
;# zfs create -V 100G tank/ext4-on-zfs
;
;# mkfs.ext4 /dev/zvol/tank/ext4-on-zfs
;
;# mkdir /ext4-on-zfs
;
;# mount /dev/zvol/tank/ext4-on-zfs /ext4-on-zfs
;
;@end example
;
;
;
;You can then set this up to be mounted at boot by adding this to the
;
;@code{file-systems} field of your @code{operating-system} record:
;
;
;
;@lisp
;
;(file-system
;
;  (device "/dev/zvol/tank/ext4-on-zfs")
;
;  (mount-point "/ext4-on-zfs")
;
;  (type "ext4")
;
;  (dependencies (list %zfs-zvol-dependency)))
;
;@end lisp
;
;
;
;You @emph{must not} add @code{%zfs-zvol-dependency} to your
;
;@code{operating-system}'s @code{mapped-devices} field, and you @emph{must
;
;not} add it (or any @code{<file-system>}s dependent on it) to the
;
;@code{dependencies} field of @code{zfs-configuration}.  Finally, you
;
;@emph{must not} use @code{%zfs-zvol-dependency} unless you actually
;
;instantiate @code{zfs-service-type} on your system.
;
;
;
;@subsubsection Unsupported Features
;
;
;
;Some common features and uses of ZFS are currently not supported, or not
;
;fully supported, on Guix.
;
;
;
;@enumerate
;
;@item
;
;Shepherd-managed daemons that are configured to read from or write to ZFS
;
;mountpoints need to include @code{user-processes} in their @code{requirement}
;
;field.  This is the earliest that ZFS file systems are assured of being
;
;mounted.
;
;
;
;Generally, most daemons will, directly or indirectly, require
;
;@code{networking}, or @code{user-processes}, or both.  Most implementations
;
;of @code{networking} will also require @code{user-processes} so daemons that
;
;require only @code{networking} will also generally start up after
;
;@code{user-processes}.  A notable exception, however, is
;
;@code{static-networking-service-type}.  You will need to explicitly add
;
;@code{user-processes} as a @code{requirement} of your @code{static-networking}
;
;record.
;
;
;
;@item
;
;@code{mountpoint=legacy} ZFS file systems.  The handlers for the Guix mounting
;
;system have not yet been modified to support ZFS, and will expect @code{/dev}
;
;paths in the @code{<file-system>}'s @code{device} field, but ZFS file systems
;
;are referred to via non-path @code{pool/file/system} names.  Such file systems
;
;also need to be mounted @emph{after} OpenZFS has scanned for pools.
;
;
;
;You can still manually mount these file systems after system boot; what is
;
;only unsupported is mounting them automatically at system boot by specifying
;
;them in @code{<file-system>} records of your @code{operating-system}.
;
;
;
;@item
;
;@code{/home} on ZFS.  Guix will create home directories for users, but this
;
;process currently cannot be scheduled after ZFS file systems are mounted.
;
;Thus, the ZFS file system might be mounted @emph{after} Guix has created
;
;home directories at boot, at which point OpenZFS will refuse to mount since
;
;the mountpoint is not empty.  However, you @emph{can} create an ext4, xfs,
;
;btrfs, or other supported file system inside a ZVOL, have that depend on
;
;@code{%zfs-zvol-dependency}, and set it to mount on the @code{/home}
;
;directory; they will be scheduled to mount before the @code{user-homes}
;
;process.
;
;
;
;Similarly, other locations like @code{/var}, @code{/gnu/store} and so
;
;on cannot be reliably put in a ZFS file system, though they may be
;
;possible to create as other file systems inside ZVOL containers.
;
;
;
;@item
;
;@code{/} and @code{/boot} on ZFS.  These require Guix to expose more of
;
;the @code{initrd} very early boot process to services.  It also requires
;
;Guix to have the ability to explicitly load modules while still in
;
;@code{initrd} (currently kernel modules loaded by
;
;@code{kernel-module-loader-service-type} are loaded after @code{/} is
;
;mounted).  Further, since one of ZFS's main advantages is that it can
;
;continue working despite the loss of one or more devices, it makes sense
;
;to also support installing the bootloader on all devices of the pool that
;
;contains the @code{/} and @code{/boot}; after all, if ZFS can survive the
;
;loss of one device, the bootloader should also be able to survive the loss
;
;of one device.
;
;
;
;@item
;
;ZVOL swap devices.  Mapped swap devices need to be listed in
;
;@code{mapped-devices} to ensure they are opened before the system attempts
;
;to use them, but you cannot currently add @code{%zfs-zvol-dependency} to
;
;@code{mapped-devices}.
;
;
;
;This will also require significant amounts of testing, as various kernel
;
;build options and patches may affect how swapping works, which are possibly
;
;different on Guix System compared to other distributions that this feature is
;
;known to work on.
;
;
;
;@item
;
;ZFS Event Daemon.  Support for this has not been written yet, patches are
;
;welcome.  The main issue is how to design this in a Guix style while
;
;supporting legacy shell-script styles as well.  In particular, OpenZFS itself
;
;comes with a number of shell scripts intended for ZFS Event Daemon, and we
;
;need to figure out how the user can choose to use or not use the provided
;
;scripts (and configure any settings they have) or override with their own
;
;custom code (which could be shell scripts they have written and trusted from
;
;previous ZFS installations).
;
;
;
;As-is, you can create your own service that activates the ZFS Event Daemon
;
;by creating the @file{/etc/zfs/zed} directory and filling it appropriately,
;
;then launching @code{zed}.
;
;
;
;@item
;
;@file{/etc/zfs/zpool.cache}.  Currently the ZFS support on Guix always forces
;
;scanning of all devices at bootup to look for ZFS pools.  For systems with
;
;dozens or hundreds of storage devices, this can lead to slow bootup.  One issue
;
;is that tools should really not write to @code{/etc} which is supposed to be for
;
;configuration; possibly it could be moved to @code{/var} instead.  Another issue
;
;is that if Guix ever supports @code{/} on ZFS, we would need to somehow keep the
;
;@code{zpool.cache} file inside the @code{initrd} up-to-date with what is in the
;
;@code{/} mount point.
;
;
;
;@item
;
;@code{zfs share}.  This will require some (unknown amount of) work to integrate
;
;into the Samba and NFS services of Guix.  You @emph{can} manually set up Samba
;
;and NFS to share any mounted ZFS datasets by setting up their configurations
;
;properly; it just can't be done for you by @code{zfs share} and the
;
;@code{sharesmb} and @code{sharenfs} properties.
;
;@end enumerate
;
;
;
;Hopefully, support for the above only requires code to be written, and users
;
;are encouraged to hack on Guix to implement the above features.
(define-module (jam packages zfs)
   #:use-module (gnu packages file-systems)
   #:use-module (gnu services)
   #:use-module (gnu services base)
   #:use-module (gnu services linux)
   #:use-module (gnu services mcron)
   #:use-module (gnu services shepherd)
   #:use-module (gnu system mapped-devices)
   #:use-module (guix gexp)
   #:use-module (guix modules)
   #:use-module (guix packages)
   #:use-module (guix records)
   #:use-module (srfi srfi-1)
   #:export (zfs-service-type
             zfs-configuration
             zfs-configuration?
             zfs-configuration-kernel
             zfs-configuration-base-zfs
             zfs-configuration-base-zfs-auto-snapshot
             zfs-configuration-dependencies
             zfs-configuration-auto-mount?
             zfs-configuration-auto-scrub
             zfs-configuration-auto-snapshot?
             zfs-configuration-auto-snapshot-keep
             %zfs-zvol-dependency))
(define-record-type* <zfs-configuration>
  zfs-configuration
  make-zfs-configuration
  zfs-configuration?
   ;; linux-libre kernel you want to compile the base-zfs module for.
   (kernel                     zfs-configuration-kernel)
   ;; the OpenZFS package that will be modified to compile for the
   ;; given kernel.
   ;; Because it is modified and not the actual package that is used,
   ;; we prepend the name 'base-'.
   (base-zfs                   zfs-configuration-base-zfs
                               (default zfs))
   ;; the zfs-auto-snapshot package that will be modified to compile
   ;; for the given kernel.
   ;; Because it is modified and not the actual package that is used,
   ;; we prepend the name 'base-'.
   (base-zfs-auto-snapshot     zfs-configuration-base-zfs-auto-snapshot
                               (default zfs-auto-snapshot))
   ;; list of <mapped-device> or <file-system> objects that must be
   ;; opened/mounted before we import any ZFS pools.
   (dependencies               zfs-configuration-dependencies
                               (default '()))
   ;; #t to mount all mountable datasets by default.
   ;; #f if not mounting.
   ;; #t is the expected behavior on other operating systems, the
   ;; #f is only supported for "rescue" operating systems where
   ;; the user wants lower-level control of when to mount.
   (auto-mount?                zfs-configuration-auto-mount?
                               (default #t))
   ;; 'weekly for weekly scrubbing, 'monthly for monthly scrubbing, an
  ;; mcron time specification that can be given to `job`, or #f to
  ;; disable.
  (auto-scrub                 zfs-configuration-auto-scrub
                              (default 'weekly))

  ;; #t to auto-snapshot by default (and `com.sun:auto-snapshot=false`
  ;; disables auto-snapshot per dataset), #f to not auto-snapshot
  ;; by default (and `com.sun:auto-snapshot=true` enables auto-snapshot
  ;; per dataset).
  (auto-snapshot?             zfs-configuration-auto-snapshot?
                              (default #t))

  ;; association list of symbol-number pairs to indicate the number
  ;; of automatic snapshots to keep for each of 'frequent, 'hourly,
  ;; 'daily, 'weekly, and 'monthly.
  ;; e.g. '((frequent . 8) (hourly . 12))
  (auto-snapshot-keep         zfs-configuration-auto-snapshot-keep
                              (default '())))

(define %default-auto-snapshot-keep
  '((frequent .  4)
    (hourly .    24)
    (daily .     31)
    (weekly .    8)
    (monthly .   12)))

(define %auto-snapshot-mcron-schedule
  '((frequent .  "0,15,30,45 * * * *")
    (hourly .    "0 * * * *")
    (daily .     "0 0 * * *")
    (weekly .    "0 0 * * 7")
    (monthly .   "0 0 1 * *")))

;; A synthetic and unusable MAPPED-DEVICE intended for use when
;; the user has created a mountable filesystem inside a ZFS
;; zvol and wants it mounted inside the configuration.scm.
(define %zfs-zvol-dependency
  (mapped-device
    (source '())
    (targets '("zvol/*"))
    (type #f)))

(define (make-zfs-package conf)
  "Creates a zfs package based on the given zfs-configuration.

  OpenZFS is a kernel package and to ensure best compatibility
  it should be compiled with the specific Linux-Libre kernel
  used on the system.  This simply overrides the kernel used
  in compilation with that given in the configuration, which
  the user has to ensure is the same as in the operating-system."
  (let ((kernel    (zfs-configuration-kernel conf))
        (base-zfs  (zfs-configuration-base-zfs conf)))
    (package
      (inherit base-zfs)
      (arguments (cons* #:linux kernel
                        (package-arguments base-zfs))))))

(define (make-zfs-auto-snapshot-package conf)
  "Creates a zfs-auto-snapshot package based on the given
  zfs-configuration.

  Since the OpenZFS tools above are compiled to a specific
  kernel version, zfs-auto-snapshot --- which calls into the
  OpenZFS tools --- has to be compiled with the specific
  modified OpenZFS package created in the make-zfs-package
  procedure."
  (let ((zfs                    (make-zfs-package conf))
        (base-zfs-auto-snapshot (zfs-configuration-base-zfs-auto-snapshot conf)))
    (package
      (inherit base-zfs-auto-snapshot)
      (inputs `(("zfs" ,zfs))))))

(define (zfs-loadable-modules conf)
  "Specifies that the specific 'module' output of the OpenZFS
  package is to be used; for use in indicating it as a
  loadable kernel module."
  (list (list (make-zfs-package conf) "module")))

(define (zfs-shepherd-services conf)
  "Constructs a list of Shepherd services that is installed
  by the ZFS Guix service.

  'zfs-scan' scans all devices for ZFS pools, and makes them
  available to 'zpool' commands.
  'device-mapping-zvol/*' waits for /dev/zvol/* to be
  populated by 'udev', and runs after 'zfs-scan'.
  'zfs-auto-mount' mounts all ZFS datasets with a 'mount'
  property, which defaults to '/' followed by the name of
  the dataset.

  All the above behavior is expected by ZFS users from
  typical ZFS installations.  A mild difference is that
  scanning is usually based on '/etc/zfs/zpool.cache'
  instead of the 'scan all devices' used below, but that
  file is questionable in Guix since ideally '/etc/'
  files are modified by the sysad directly;
  '/etc/zfs/zpool.cache' is modified by ZFS tools."
  (let* ((zfs-package     (make-zfs-package conf))
         (zpool           (file-append zfs-package "/sbin/zpool"))
         (zfs             (file-append zfs-package "/sbin/zfs"))
         (zvol_wait       (file-append zfs-package "/bin/zvol_wait"))
         (scheme-modules  `((srfi srfi-1)
                            (srfi srfi-34)
                            (srfi srfi-35)
                            (rnrs io ports)
                            ,@%default-modules)))
    (define zfs-scan
      (shepherd-service
        (provision '(zfs-scan))
        (requirement `(root-file-system
                       kernel-module-loader
                       udev
                       ,@(map (@@ (gnu services base) dependency->shepherd-service-name); PATCH: private usage instead of export
                              (zfs-configuration-dependencies conf))))
        (documentation "Scans for and imports ZFS pools.")
        (modules scheme-modules)
        (start #~(lambda _
                   (guard (c ((message-condition? c)
                              (format (current-error-port)
                                      "zfs: error importing pools: ~s~%"
                                      (condition-message c))
                              #f))
                     ;; TODO optionally use a cachefile.
                     (invoke #$zpool "import" "-a" "-N"))))
        ;; Why not one-shot?  Because we don't really want to rescan
        ;; this each time a requiring process is restarted, as scanning
        ;; can take a long time and a lot of I/O.
        (stop #~(const #f))))

    (define device-mapping-zvol/*
      (shepherd-service
        (provision '(device-mapping-zvol/*))
        (requirement '(zfs-scan))
        (documentation "Waits for all ZFS ZVOLs to be opened.")
        (modules scheme-modules)
        (start #~(lambda _
                   (guard (c ((message-condition? c)
                              (format (current-error-port)
                                      "zfs: error opening zvols: ~s~%"
                                      (condition-message c))
                              #f))
                     (invoke #$zvol_wait))))
        (stop #~(const #f))))

    (define zfs-auto-mount
      (shepherd-service
        (provision '(zfs-auto-mount))
        (requirement '(zfs-scan))
        (documentation "Mounts all non-legacy mounted ZFS filesystems.")
        (modules scheme-modules)
        (start #~(lambda _
                   (guard (c ((message-condition? c)
                              (format (current-error-port)
                                      "zfs: error mounting file systems: ~s~%"
                                      (condition-message c))
                              #f))
                     ;; Output to current-error-port, otherwise the
                     ;; user will not see any prompts for passwords
                     ;; of encrypted datasets.
                     ;; XXX Maybe better to explicitly open /dev/console ?
                     (with-output-to-port (current-error-port)
                       (lambda ()
                         (invoke #$zfs "mount" "-a" "-l"))))))
        (stop #~(lambda _
                  ;; Make sure that Shepherd does not have a CWD that
                  ;; is a mounted ZFS filesystem, which would prevent
                  ;; unmounting.
                  (chdir "/")
                  (invoke #$zfs "unmount" "-a" "-f")))))

    `(,zfs-scan
      ;,device-mapping-zvol/* ; TODO zfs not found
      ,@(if (zfs-configuration-auto-mount? conf)
            `(,zfs-auto-mount)
            '()))))

(define (zfs-user-processes conf)
  "Provides the last Shepherd service that 'user-processes' has to
  wait for.

  If not auto-mounting, then user-processes should only wait for
  the device scan."
  (if (zfs-configuration-auto-mount? conf)
      '(zfs-auto-mount)
      '(zfs-scan)))

(define (zfs-mcron-auto-snapshot-jobs conf)
  "Creates a list of mcron jobs for auto-snapshotting, one for each
  of the standard durations."
  (let* ((user-auto-snapshot-keep      (zfs-configuration-auto-snapshot-keep conf))
         ;; assoc-ref has earlier entries overriding later ones.
         (auto-snapshot-keep           (append user-auto-snapshot-keep
                                               %default-auto-snapshot-keep))
         (auto-snapshot?               (zfs-configuration-auto-snapshot? conf))
         (zfs-auto-snapshot-package    (make-zfs-auto-snapshot-package conf))
         (zfs-auto-snapshot            (file-append zfs-auto-snapshot-package
                                                    "/sbin/zfs-auto-snapshot")))
    (map
      (lambda (label)
        (let ((keep   (assoc-ref auto-snapshot-keep label))
              (sched  (assoc-ref %auto-snapshot-mcron-schedule label)))
          #~(job '#$sched
                 (lambda ()
                   (system* #$zfs-auto-snapshot
                            "--quiet"
                            "--syslog"
                            #$(string-append "--label="
                                             (symbol->string label))
                            #$(string-append "--keep="
                                             (number->string keep))
                            "//")))))
      (map first %auto-snapshot-mcron-schedule))))

(define (zfs-mcron-auto-scrub-jobs conf)
  "Creates a list of mcron jobs for auto-scrubbing."
  (let* ((zfs-package    (make-zfs-package conf))
         (zpool          (file-append zfs-package "/sbin/zpool"))
         (auto-scrub     (zfs-configuration-auto-scrub conf))
         (sched          (cond
                           ((eq? auto-scrub 'weekly)  "0 0 * * 7")
                           ((eq? auto-scrub 'monthly) "0 0 1 * *")
                           (else                      auto-scrub))))
    (define code
      ;; We need to get access to (guix build utils) for the
      ;; invoke procedures.
      (with-imported-modules (source-module-closure '((guix build utils)))
        #~(begin
            (use-modules (guix build utils)
                         (ice-9 ports))
            ;; The ZFS pools in the system.
            (define pools
              (invoke/quiet #$zpool "list" "-o" "name" "-H"))
            ;; Only scrub if there are actual ZFS pools, as the
            ;; zpool scrub command errors out if given an empty
            ;; argument list.
            (unless (null? pools)
              ;; zpool scrub only initiates the scrub and otherwise
              ;; prints nothing.  Results are always seen on the
              ;; zpool status command.
              (apply invoke #$zpool "scrub" pools)))))
    (list
      #~(job '#$sched
             #$(program-file "mcron-zfs-scrub.scm" code)))))

(define (zfs-mcron-jobs conf)
  "Creates a list of mcron jobs for ZFS management."
  (append (zfs-mcron-auto-snapshot-jobs conf)
          (if (zfs-configuration-auto-scrub conf)
              (zfs-mcron-auto-scrub-jobs conf)
              '())))

(define zfs-service-type
  (service-type
    (name 'zfs)
    (extensions
      (list ;; Install OpenZFS kernel module into kernel profile.
            (service-extension linux-loadable-module-service-type
                               zfs-loadable-modules)
            ;; And load it.
            (service-extension kernel-module-loader-service-type
                               (const '("zfs")))
            ;; Make sure ZFS pools and datasets are mounted at
            ;; boot.
            (service-extension shepherd-root-service-type
                               zfs-shepherd-services)
            ;; Make sure user-processes don't start until
            ;; after ZFS does.
            (service-extension user-processes-service-type
                               zfs-user-processes)
            ;; Install automated scrubbing and snapshotting.
            (service-extension mcron-service-type
                               zfs-mcron-jobs)

            ;; Install ZFS management commands in the system
            ;; profile.
            (service-extension profile-service-type
                               (compose list make-zfs-package))
            ;; Install ZFS udev rules.
            (service-extension udev-service-type
                               (compose list make-zfs-package))))
    (description "Installs ZFS, an advanced filesystem and volume manager.")))
