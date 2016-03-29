;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

(use-modules (gnu)
             (gnu system nss))

(use-service-modules desktop)
(use-package-modules admin
                     linux
                     firmware
                     linux-nonfree
                     emacs
                     vim
                     wm
                     xorg
                     version-control
                     gnuzilla
                     gnome
                     xdisorg
                     package-management
                     suckless
                     certs
                     lxde
                     zsh
                     wicd
                     terminals
                     fonts
                     irc
                     ghostscript

                     ;development tools
                     base
                     autotools
                     gettext
                     texinfo
                     graphviz
                     pkg-config)


#!
copied from mark-weaver
(define (anti-caps-lock-service)
  (let ((dumpkeys #~(string-append #$kbd  "/bin/dumpkeys"))
        (loadkeys #~(string-append #$kbd  "/bin/loadkeys"))
        (grep     #~(string-append #$grep "/bin/grep"))
        (sed      #~(string-append #$sed  "/bin/sed"))
        (bash     #~(string-append #$bash "/bin/bash")))
    (with-monad %store-monad
      (return
       (service
        (documentation "Change caps-lock to control on the ttys.")
        (provision '(anti-caps-lock))
        (requirement '(user-processes))
        (start
         #~(lambda _
             (zero? (system* #$bash "-c"
                             (string-append #$dumpkeys " | "
                                            #$grep " Caps_Lock | "
                                            #$sed " s/Caps_Lock/Control/g | "
                                            #$loadkeys))))))))))
!#

(define zsh-location
  #~(string-append #$zsh "/bin/zsh"))


(operating-system
  (host-name "molsen")
  (timezone "America/Denver")
  (locale "en_US.UTF-8")
  (kernel linux-nonfree)

  (firmware (cons* iwlwifi-firmware-nonfree
                   %base-firmware))

  ;; Assuming /dev/sdX is the target hard disk, and "root" is
  ;; the label of the target root file system.
  (bootloader (grub-configuration (device "/dev/sda")))
  (file-systems (cons (file-system
                        (device "guixsd")
                        (title 'label)
                        (mount-point "/")
                        (type "ext4"))
                      %base-file-systems))

  ;; This is where user accounts are specified.  The "root"
  ;; account is implicit, and is initially created with the
  ;; empty password.
  (users (cons (user-account
                (name "mckinley")
                (comment "McKinley Olsen")
                (group "users")
                (shell zsh-location)

                ;; Adding the account to the "wheel" group
                ;; makes it a sudoer.  Adding it to "audio"
                ;; and "video" allows the user to play sound
                ;; and access the webcam.
                (supplementary-groups '("wheel"
                                        "audio"
                                        "video"
                                        "netdev"))
                (home-directory "/home/mckinley"))
               %base-user-accounts))

  ;; Globally-installed packages.
  (packages (cons* emacs
                   zsh
                   stow
                   i3-wm
                   dmenu
                   xrandr
                   vim
                   tcpdump
                   myrepos
                   icecat
                   wicd
                   xmodmap
                   i3status
                   ;i3blocks
                   termite
                   stow
                   git
                   arandr
                   lxrandr
                   nss-certs
                   isc-dhcp
                   epiphany
                   font-terminus
                   font-inconsolata
                   gs-fonts
                   font-dejavu
                   font-gnu-freefont-ttf
                   xbacklight
                   irssi

                   ;; dependencies for anti-caps-lock-service
                   ;bash
                   ;kbd
                   ;sed

                   ; development packages; see: https://www.gnu.org/software/guix/manual/html_node/Building-from-Git.html#Building-from-Git
                   autoconf
                   automake
                   gnu-gettext
                   texinfo
                   graphviz
                   pkg-config
                   gnu-make
                   nix
                   %base-packages))

  (services %desktop-services))
