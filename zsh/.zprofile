#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
#path=(
#  /usr/local/{bin,sbin}
#  $path
#)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

source /etc/profile

#export TERMINFO_DIRS=/run/current-system/profile/share/terminfo
#export PATH=$PATH:/run/setuid-programs:/root/.guix-profile/bin
export INFOPATH="/root/.guix-profile/share/info"
export ACLOCAL_PATH="/root/.guix-profile/share/aclocal"
export C_INCLUDE_PATH="/root/.guix-profile/include"
export CPLUS_INCLUDE_PATH="/root/.guix-profile/include"
export LIBRARY_PATH="/root/.guix-profile/lib"
export GUILE_LOAD_COMPILED_PATH="/root/.guix-profile/lib/guile/2.0/ccache"
export PKG_CONFIG_PATH="/root/.guix-profile/lib/pkgconfig"
export GUILE_LOAD_PATH="/root/.guix-profile/share/guile/site/2.0"

#new
#export JAVA_HOME="/home/mckinley/jdk1.8.0_77"
#export JRE_HOME="$JAVA_HOME/jre"
#export PATH="$PATH:$JRE_HOME/bin:$JAVA_HOME/bin:/root/.guix-profile/bin:/root/.guix-profile/sbin:/home/mckinley/bin"
export PATH=$PATH:/home/mckinley/terrible/sqldeveloper/sqldeveloper/bin
export PATH="$PATH:/home/mckinley/terrible/bin"
export PATH="$PATH:/home/mckinley/terrible/idea-IU-162.2032.8/bin"
export GUILE_LOAD_PATH="/root/.guix-profile/share/guile/site/2.0"
export GUILE_LOAD_COMPILED_PATH="/root/.guix-profile/lib/guile/2.0/ccache:/root/.guix-profile/share/guile/site/2.0"
export C_INCLUDE_PATH="/root/.guix-profile/include"
export CPLUS_INCLUDE_PATH="/root/.guix-profile/include"
export LIBRARY_PATH="/root/.guix-profile/lib"
export INFOPATH="/root/.guix-profile/share/info"
export ACLOCAL_PATH="/root/.guix-profile/share/aclocal"
export PKG_CONFIG_PATH="/root/.guix-profile/lib/pkgconfig"
export XDG_CONFIG_HOME=$HOME/.config

#export JAVA_OPTS="-Djavax.net.ssl.trustStore=/home/mckinley/open-jdk-8-security/cacerts -Djavax.net.ssl.keyStorePassword="

# sudo ACLOCAL_PATH="/root/.guix-profile/share/aclocal" LIBRARY_PATH="/root/.guix-profile/lib" C_INCLUDE_PATH="/root/.guix-profile/include" PKG_CONFIG_PATH="/root/.guix-profile/lib/pkgconfig" CPLUS_INCLUDE_PATH="/root/.guix-profile/include" ./configure

#WORKED:
#sudo ACLOCAL_PATH="/root/.guix-profile/share/aclocal" LIBRARY_PATH="/root/.guix-profile/lib" C_INCLUDE_PATH="/root/.guix-profile/include" PKG_CONFIG_PATH="/root/.guix-profile/lib/pkgconfig" CPLUS_INCLUDE_PATH="/root/.guix-profile/include" GUILE_LOAD_PATH="/root/.guix-profile/share/guile/site/2.0" ./pre-inst-env guix system reconfigure ../../config.scm --fallback

#to update application binary interface (ABI)
#sudo ACLOCAL_PATH="/root/.guix-profile/share/aclocal" LIBRARY_PATH="/root/.guix-profile/lib" C_INCLUDE_PATH="/root/.guix-profile/include" PKG_CONFIG_PATH="/root/.guix-profile/lib/pkgconfig" CPLUS_INCLUDE_PATH="/root/.guix-profile/include" GUILE_LOAD_PATH="/root/.guix-profile/share/guile/site/2.0" make clean-go && make


#PATH with ZSH
#/usr/local/bin:/usr/local/sbin:/run/current-system/profile/bin:/run/setuid-programs:/root/.guix-profile/bin:/run/setuid-programs:/root/.guix-profile/bin

#PATH WITH BASH
#/home/mckinley/.guix-profile/bin:/home/mckinley/.guix-profile/sbin:/run/setuid-programs:/run/current-system/profile/bin:/run/current-system/profile/sbin



#BUILD OUTPUT
export PATH=$PATH:/home/mckinley/.perfect/bin

export RUBYOPT="-KU -E utf-8:utf-8"
