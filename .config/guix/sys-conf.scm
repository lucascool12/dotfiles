;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS, and a swap file.

(use-modules (gnu) (gnu system nss) (guix utils)
  (guix gexp)
  (gnu packages terminals)
  (gnu packages gnome)
  (gnu packages wm)
  (gnu packages xdisorg)
  (gnu packages suckless)
  (gnu packages gtk)
  (gnu packages bash)
  (gnu services)
  (gnu home services)
  ((gnu system keyboard) #:prefix k:)
  (packages gtkgreet)
  (services greetd)
  ((gnu packages linux) #:prefix glinux:)
  (nongnu packages linux)
  (nongnu system linux-initrd))
(use-service-modules desktop sddm xorg lightdm)
(use-package-modules certs gnome)

(define* (gtkgreet-sway-config layouts #:optional (input "*"))
  (mixed-text-file
    "gtkgreet-sway-config"
    "# `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.\n"
    (sway-keyboard-layout layouts input)
    "exec \"" gtkgreet-envs "/bin/gtkgreet -l; " sway "/bin/swaymsg exit\"\n"
    "bindsym Mod4+BackSpace input \"" input "\" xkb_switch_layout next \n"
    "bindsym Mod4+shift+e exec swaynag \\\n"
    "	-t warning \\\n"
    "	-m 'What do you want to do?' \\\n"
    "	-b 'Poweroff' 'systemctl poweroff' \\\n"
    "   -b 'Reboot' 'systemctl reboot'\n"
    "bindsym --locked XF86MonBrightnessUp exec brightnessctl s 5%+\n"
    "bindsym --locked XF86MonBrightnessDown exec brightnessctl s 5%-\n"
    "include " sway "/etc/sway/config.d/*\n"))

(define gtkgreet-environments
  `(("greetd/environments/1-sway" ,(greetd-gtkgreet-tty-xdg-session-command
                                   "run-sway"
                                   (file-append sway "/bin/sway")))
    ("greetd/environments/2-bash" ,(greetd-gtkgreet-tty-xdg-session-command
                                   "bash-tty"
                                   (file-append bash "/bin/bash")
                                   '("-l")))))
  ;; (mixed-text-file "gtkgreet-environments"
  ;;             (greetd-gtkgreet-tty-xdg-session-command
  ;;               "run-sway"
  ;;               (file-append sway "/bin/sway")) "\n"
  ;;             (greetd-gtkgreet-tty-xdg-session-command
  ;;               "bash-tty"
  ;;               (file-append bash "/bin/bash")
  ;;               '("-l")) "\n"))

(operating-system
  (host-name "skibidi")
  (timezone "Europe/Brussels")
  (locale "en_US.utf8")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.
  (keyboard-layout (k:keyboard-layout "be"))

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
                       (target (uuid "8543e5ba-6d95-466f-9f59-a9cee4305be2")))))

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
                     dmenu
                     sway
                     gtk+
                     waybar
                     glinux:brightnessctl
                     hicolor-icon-theme
                     rofi
                     swaylock
                     swayidle
                     kitty)
                    %base-packages))

  (services
    (append (list 
              (service 
                greetd-service-type
                (greetd-configuration
                  (terminals
                    (list
                      (greetd-terminal-configuration
                        (terminal-vt "1")
                        (terminal-switch #t)
                        (default-session-command
                          (greetd-gtkgreet-greeter
                            (greet-command-args 
                              `("-c" 
                                ,(gtkgreet-sway-config
                                   (list keyboard-layout (k:keyboard-layout "us" "intl"))))))))
                      (greetd-terminal-configuration (terminal-vt "2"))
                      (greetd-terminal-configuration (terminal-vt "3"))
                      (greetd-terminal-configuration (terminal-vt "4"))
                      (greetd-terminal-configuration (terminal-vt "5"))
                      (greetd-terminal-configuration (terminal-vt "6"))))))
              (service screen-locker-service-type
                       (screen-locker-configuration
                         (name "swaylock")
                         (program (file-append swaylock "/bin/swaylock"))
                         (using-setuid? #f)))
              (simple-service 'gtkgreet-etc-service etc-service-type
                              gtkgreet-environments))
            (modify-services %desktop-services
                             (guix-service-type config => (guix-configuration
                                                            (inherit config)
                                                            (substitute-urls
                                                              (append (list "https://substitutes.nonguix.org")
                                                                      %default-substitute-urls))
                                                            (authorized-keys
                                                              (append (list (local-file "./nonguix-signing-key.pub"))
                                                                      %default-authorized-guix-keys))))
                             (delete gdm-service-type)
                             (delete login-service-type)
                             (delete mingetty-service-type)
                             (delete screen-locker-service-type))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
