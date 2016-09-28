(use-modules (gnu packages))
(use-package-modules version-control
                     java)
(packages->manifest
  (map specification->package `("unzip"
                                "zip"
                                "the-silver-searcher"
                                "geiser"
                                "postgresql"
                                "xbacklight"
                                "util-linux"
                                "xdpyinfo"
                                "curl"
                                "tar"
                                "openssh"
                                "perl"
                                "openssl"
                                "openvpn"
                                "ruby"
                                "arandr"
                                "glibc"
                                "git"
                                "node"
                                "libreoffice"
                                "emacs")))
