
(use-modules (gnu)
             (gnu system nss)
             (gnu services xorg)
             (gnu services networking)
             (guix monads)
             (guix store)
             (srfi srfi-1))

(use-service-modules desktop)
(use-package-modules admin
                     linux
                     firmware
                     linux-nonfree
                     vim
                     wm
                     lxde
                     pulseaudio
                     gstreamer
                     gtk

                     xorg
                     version-control
                     gnuzilla
                     gnome
                     xdisorg
                     package-management
                     suckless
                     certs
                     zsh
                     terminals
                     fonts
                     irc
                     screen
                     ghostscript
                     tls

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

#!
I can't get this section to work
(define monitor-description
  "Section \"Monitor\"
    Identifier \"Monitor0\"
    DisplaySize 346 194
  EndSection")

(define (my-slim-service)
  (mlet* %store-monad (
                       (config (xorg-configuration-file
                               #:extra-config (list monitor-description)))
                      (startx (xorg-start-command
                               #:configuration-file config))
                      )
    (slim-service #:startx startx)))
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
  (packages (cons* zsh
                   i3-wm
                   rofi
                   xrandr
                   vim
                   tcpdump
                   myrepos
                   icecat
                   xmodmap
                   i3status
                   termite
                   stow
                   arandr
                   nss-certs
                   isc-dhcp
                   epiphany
                   font-terminus
                   font-inconsolata
                   gs-fonts
                   font-dejavu
                   font-gnu-freefont-ttf
                   xbacklight
                   screen
                   irssi
                   network-manager-applet
                   setxkbmap
                   nix
                   gnutls

                   ;audio
                   pulseaudio
                   pavucontrol
                   gstreamer
                   gst-plugins-bad
                   gst-plugins-ugly

                   xrdb

                   ;; dependencies for anti-caps-lock-service
                   ;bash
                   ;kbd
                   ;sed
                   %base-packages))
#!
  (services (cons*
              (slim-service #:startx (xorg-start-command
                                      #:configuration-file (xorg-configuration-file
                                                            #:extra-config (list
"Section \"Monitor\"
  Identifier \"Monitor0\"
  DisplaySize 337 190 #337.82 190.5
EndSection

Section \"Screen\"
  Identifier \"Screen0\"  #Collapse Monitor and Device section to Screen section
  Device \"nvidia\"
  Monitor \"Monitor0\"
  DefaultDepth 24 #Choose the depth (16||24)
  SubSection \"Display\"
    Depth 24
    Modes \"3840x2160_60.00\" #Choose the resolution
  EndSubSection
EndSection

Section \"Device\"
  Identifier \"intel\"
  Driver \"intel\"
  BusID \"PCI:0:2:0\"
  #Option \"AccelMethod\" \"SNA\"
EndSection

Section \"Device\"
  Identifier \"nvidia\"
  Driver \"nouveau\"
  BusID \"PCI:2:0:0\"
  #Option \"ConstrainCursor\" \"off\"
EndSection
"))))
              ;(my-slim-service)
              (remove (lambda (service)
                        (eq? (service-kind service)
                          slim-service-type))
                      %desktop-services)))
  ;network-manager doesn't seem to work correctly
  (services (cons (network-manager-service) (remove (lambda (service)
                      (eq? (service-kind service)
                           wicd-service-type))
                    %desktop-services)))
  !#
  (services %desktop-services)
)
