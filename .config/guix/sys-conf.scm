;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu) (gnu system nss) (guix utils)
  (gnu packages terminals)
  (gnu packages wm)
  (gnu packages xdisorg)
  (gnu packages suckless)
  (gnu packages gtk)
  ((gnu packages linux) #:prefix glinux:)
  (nongnu packages linux)
  (nongnu system linux-initrd))
(use-service-modules desktop sddm xorg lightdm)
(use-package-modules certs gnome)

(operating-system
  (host-name "skibidi")
  (timezone "Europe/Brussels")
  (locale "en_US.utf8")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (keyboard-layout "be"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (uuid "3bde5b6a-6cfc-419d-b426-58f819d9241b"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (uuid "2E7E-4FF0" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; Specify a swap file for the system, which resides on the
  ;; root file system.
  (swap-devices (list (swap-space
                       (target (uuid "a9e23da2-399d-466e-9a28-704510b0d297")))))

  ;; Create user `bob' with `alice' as its initial password.
  (users (cons (user-account
                (name "lucas")
                (comment "Lucas Van Laer")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"
                                        "input")))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (append (list
                     ;; for HTTPS access
                     nss-certs
                     ;; for user mounts
                     gvfs
                     ulauncher
                     dmenu
                     sway
                     gtk+
                     waybar
                     glinux:brightnessctl
                     kitty)
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (if (target-x86-64?)
                (append (list (service greetd-service-type
                                (greetd-configuration
                                  (terminals
                                    (list
                                      (greetd-terminal-configuration
                                        (terminal-vt "1")
                                        (terminal-switch #t)
                                        (default-session-command
                                          (greetd-agreety-session
                                            (command (file-append sway "/bin/sway"))
                                            (command-args '()))))
                                      (greetd-terminal-configuration (terminal-vt "2"))
                                      (greetd-terminal-configuration (terminal-vt "3"))
                                      (greetd-terminal-configuration (terminal-vt "4"))
                                      (greetd-terminal-configuration (terminal-vt "5"))
                                      (greetd-terminal-configuration (terminal-vt "6")))))))
                          ;; (service enlightenment-desktop-service-type)
                          ;;     (service slim-service-type (slim-configuration
                          ;;                                  (xorg-configuration
                          ;;                                    (xorg-configuration
                          ;;                                      (keyboard-layout keyboard-layout))))))
                              ;; (set-xorg-configuration
                              ;;  (xorg-configuration
                              ;;   (keyboard-layout keyboard-layout))
                              ;;   slim-service-type))
                        (modify-services %desktop-services
             (guix-service-type config => (guix-configuration
               (inherit config)
               (substitute-urls
                (append (list "https://substitutes.nonguix.org")
                  %default-substitute-urls))
               (authorized-keys
                (append (list (local-file "./signing-key.pub"))
                  %default-authorized-guix-keys))))
                (delete gdm-service-type)
                (delete login-service-type)
                (delete mingetty-service-type)))

                ;; FIXME: Since GDM depends on Rust (gdm -> gnome-shell -> gjs
                ;; -> mozjs -> rust) and Rust is currently unavailable on
                ;; non-x86_64 platforms, we use SDDM and Mate here instead of
                ;; GNOME and GDM.
                (append (list (service greetd-service-type))
                          ;; (service enlightenment-desktop-service-type)
                          ;;     (service slim-service-type (slim-configuration
                          ;;                                  (xorg-configuration
                          ;;                                    (xorg-configuration
                          ;;                                      (keyboard-layout keyboard-layout))))))
                              ;; (service slim-service-type)
                              ;; (set-xorg-configuration
                              ;;  (xorg-configuration
                              ;;   (keyboard-layout keyboard-layout))
                              ;;  slim-service-type))
                        (modify-services %desktop-services
             (guix-service-type config => (guix-configuration
               (inherit config)
               (substitute-urls
                (append (list "https://substitutes.nonguix.org")
                  %default-substitute-urls))
               (authorized-keys
                (append (list (local-file "./signing-key.pub"))
                  %default-authorized-guix-keys))))
                (delete gdm-service-type)
                (delete login-service-type)
                (delete mingetty-service-type)))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
