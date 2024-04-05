#!/usr/bin/env zsh
set -Eeuo pipefail
set +x
# CONFIGURATION
introduction(){
 # These commands are not printed, not ran
 CAT <<EOF

   Manual instructions for setup
   =============================

   To setup your environment manually do the following
   Commands you should run are indicated by a $ like this

   $ run this

   If you are copying and pasting do not copy the $ sign


   This: # indicates a comment.
   These won't get executed if you copy and paste them
   so I use them to explain what the command do

   All of this needs to be done in a terminal.
   IntelliJ has one built in and 'Terminal' comes with your Mac.
   Lots of people like to use Iterm2, which is a souped up terminal.

EOF
}
prerequisites() {
  cat <<EOF
   Prerequisites
   -------------

   This assumes you have homebrew and git installed.

EOF
}
homebrew(){
  cat <<EOF
   Install Homebrew
   ----------------

   The default install instructions are:
   \`\`\`
   $ /bin/bash -c \"$}(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   \`\`\`
   N.B. This is telling your computer to download a file off the internet and then just run it.
   This is not generally a good idea. Its better to download the file, read it to see what it does
   then run it
   \`\`\`
   $ curl https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > install.sh # get file
   # read the file
   $ chmod +x install.sh              # makes the file executable
   $ ./install.sh                     # runs the file and installs homebrew (called brew when used)
   \`\`\`

   In the case of Homebrew you are installing software that installs other software so this
   is the least part of the trust issue so you can go ahead.

   If you are unfamiliar with command line software you can run it with the -h (sometimes --help)
   to get basic instructions. You can do it with this script
   \`\`\`
   $ brew -h                # find out how to install software with brew
   $ ./README_SETUP.sh -h   # The ./ refers to the local directory/folder, not normally needed
   \`\`\`
   For more see: https://brew.sh/  & https://docs.brew.sh/Installation
   *Important* If you don't have git installed, or have a local copy of the repo
   Do the following first, otherwise you can skip ahead to the next section
   manual_instructions, then read to the end before proceeding

EOF
}

git_instructions() {
  cat << EOF
   Install git
   ----------
   \`\`\`
   $ brew update                # make sure brew is upto date
   # install git via homebrew if you don't already have it
   $ if  command -v >&-  git; then brew install git; fi
   \`\`\`
   You should have ssh installed on your system. You can run the following to check

   $ which ssh

   If you have not set it up you should generate a set of keys.

   Look for a folder called .ssh in your home folder
   In it you should see a file called id_rsa.pub if you have a set of keys
   This is your public key and can be shared . You can add it to Github and Gitlab.
   id_rsa is your private key, *never* share this with anyone.
   Dot files are hidden in finder press Command + shift + . to show them. They will be greyed out.
   To generate keys run
   \`\`\`
   $ ssh-keygen
   \`\`\`
   Be sure to set a pasword when prompted.
   To add to Github, click on your icon, go to settings, SSH & GPG keys add new ssh key
   then copy and paste the contents of id_rsa.pub  (note the .pub)

   To get a local copy of this repo run:
  \`\`\`
   $ git clone git@github.com:coopdigital/codeclub-library.git
  \`\`\`
EOF
}

manual_instructions (){
  cat << EOF
   For your information
   --------------------
   From this point read ahead to see what the procedure is
   When you get to the end you can either got back up and follow the instruction
   to do this manually, or read on about automation now you know what is going on.

   In a terminal change into the codeclub-library folder or open the project
   in intellij and use the terminal there

   Install software
   ----------------
   \`\`\`
   $ brew update                # make sure brew is up to date
   \`\`\`

   Install nvm (node version manager) - this allows you to have multiple node and
npm versions so you can set this on a per project basis

   N.B. nvm is a shell function, not a program, so it's hard to detect. Skip this part
   if you have it installed. If you installed in via brew doing this will just tell you
   it is installed
   \`\`\`
   # Checks to see if the .nvm  exists in your home directory  and create it if not
   $ if [ !  -d \$HOME/.nvm ]; then mkdir \$HOME/.nvm; fi

   # install nvm
   $ brew install nvm
   \`\`\`
EOF
}

mob_instructions() {
  cat << EOF
   Install mob, used to manage handovers when ensemble coding: https://mob.sh
   \`\`\`
   $ if  command -v >&-  mob; then brew install remotemobprogramming/brew/mob; fi
   \`\`\`
EOF
}

config_instructions() {
  cat << EOF
   Configure Git
   -------------
   \`\`\`
   $ git config --global user.name 'Your Name'   # Tell git what your name is so it shows in commits & mob.timer
   $ git config --global user.email 'your.name@coop.co.uk'     # set your email
   \`\`\`
   Configure Mob.sh
   ----------------
   Set the mob room so we can see the mob timer online at
   https://timer.mob.sh/CodeClub
   \`\`\`
   $ echo MOB_TIMER_ROOM="CodeClub" >> /Users/MundPa/.mob
   \`\`\`

   Configure nvm
   -------------
   Check your shell
   \`$ echo SHELL\`

   This will normally be:
   /usr/bin/zsh

   if so add following to your shell profile ~/.zshrc, if it is not there.
   If you are using bash add it to .~/profile.
   Make sure you have a .nvm folder in your home directory.
   \`\`\`
      export NVM_DIR="\$HOME/.nvm"
     [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
     [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
   \`\`\`
   You can set $HOME/.nvm to any location, but leaving it unchanged from
   /opt/homebrew/Cellar/nvm/0.39.5 will destroy any nvm-installed Node installations
   upon upgrade/reinstall.
EOF
}

final_setup() {
  cat << EOF
   Set up the correct version of Node and npm
   -------------------------------------------
   Note you have to run these yourself, it can't be automated
   \`\`\`
   $ nvm install --lts
   $ nvm use --lts       # run this every session to set the version
   \`\`\`
   Install packages
   ----------------
   \`\`\`
   $ npm ci
   \`\`\`
EOF
}

automated_instructions() {
  cat << EOF
  How to run the automatic setup
  --------------------------------
  To use the automated part of this script
  run:
  ```
  $ZSHARGZERO -P
  ```
  to determine if you need to do any manual setup first, then run
  ```
  $ZSHARGZERO -A
  ```
  Make sure you pay attention to what is printed out, as there are
  some manual setup steps required when it is finshed (see the sections
  in setting up correct node versions and installing packages above)
EOF
}

# shellcheck disable=SC2120
help(){
cat <<EOF

usage: $ZSH_ARGZERO [OPTION]...

-h      prints this message
-m      print manual instructions (read these first)
-w      write manual instructions to file setup.md
-A      run through the automatic install and configuration process
-P      list any prerequisites required and print install instructions

This script will guide you through setting up your local environment.
If you read it you can see the manual instructions but it can also be ran to
automate the process.

Run $ZSH_ARGZERO -P first, to determine if you need to do any manual set first,
then review the process with $ZSH_ARGZERO -m or $ZSH_ARGZERO -w
before running $ZSH_ARGZERO -A for the automated setup process.
EOF

    # if $1 exists and is a number 0..255 return that otherwise return 0
    if [[ -n ${1-} && $(echo {0..255}) =~ $1 ]]; then
            exit $1
    else
            exit 0
    fi
}

#FUNCTIONS
write_instructions(){
  introduction
  prerequisites
  if ! isinstalled brew; then
    homebrew
  fi
  if ! isinstalled git; then
    git_instructions
  fi
  manual_instructions
  if ! isinstalled mob; then
    mob_instructions
  fi
  config_instructions
  final_setup
  automatic_instructions
  exit 0
}

isinstalled(){
  command -v >&- "$@"
}


check_prerequisites(){
  MISSING=''
  if  ! isinstalled git; then
    MISSING="git "
  fi
  if ! isinstalled brew; then
    MISSING=$MISSING"homebrew "
  fi
  if [ -z  ${MISSING+x}  ]; then
    echo "The following pieces of software must be installed manually: ${MISSING}"
    return 1
  fi
  return 0
}

skip (){
  printf "\n$1 is already installed, skipping...\n"
}

set_git_username() {
  vared -p 'Enter your full name ' -c NAME
  git config --global user.name "$NAME"
}

set_git_email() {
  vared -p 'Enter your (co-op) email ' -c EMAIL
  git config --global user.email "$EMAIL"
}

configure_git() {
  echo "configuring git..."
  GITUSERNAME=$(git config --global --get user.name)
  GITEMAIL=$(git config --global --get user.email)
  if [ -z {$GITUSERNAME-x} ]; then
    set_git_username
  else
    if ! read -q "?Your name in git is $GITUSERNAME. Is this correct? (Y/N) "; then
      set_git_username
    fi
  fi
  echo
  if [ -z {$GITEMAIL-x} ]; then
    set_git_email
  else
    if ! read -q "?Your email in git is $GITEMAIL. Is this correct? (Y/N) "; then
      set_git_email
    fi
  fi
  echo
}

configure_nvm () {
  if [[ $SHELL =~ zsh ]]; then
    FILE="$HOME/.zshrc"
  else
    FILE="$HOME/.profile"
  fi
  if ! grep -q 'NVMDIR' $FILE; then
    echo "About to add nvm config to $FILE, this should be ok, but answer N if you have it elsewhere"
    if read -q "?Proceed? (Y/N) "; then
      cat << EOF >> $FILE
export NVM_DIR="\$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF
  else
    echo
    cat << EOF
    Ensure you have the following in the relevant rcfile e.g. $HOME/.zshrc, $HOME/.profile etc
    export NVM_DIR="\$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
EOF
  fi
fi
echo
}

auto_install() {
  echo "Preparing automatic installed and configuration..."
  echo "updating brew..."
  brew update                # make sure brew is upto date
  # Checks to see if the .nvm  exists in your home directory  and create it if not
  if [ -d $HOME/.nvm ]; then
    NVM=1
  else
    mkdir $HOME/.nvm;
  fi
  if [ ! -z ${NVM+x} ]; then
    echo "It looks like you have nvm installed on your system."
    echo "You can answer no to the next question if you do."
  fi
  # install nvm
  if  read -q "?Install nvm? (Hit N only if you already have it installed) (Y/N) "; then

    printf "\ninstalling nvm...\n"
    brew install nvm;
  else
    skip nvm
  fi
  # install mob
  if  ! isinstalled  mob; then
    echo "installing mob..."
    brew install remotemobprogramming/brew/mob;
  else
    skip mob;
  fi
  configure_git
  if [ ! -e $HOME/.mob ] || ! grep -q 'MOB_TIMER_ROOM' $HOME/.mob; then
    echo "Setting mob timer room..."
    echo 'MOB_TIMER_ROOM="CodeClub"' >> $HOME/.mob
  else
    echo "mob is already configured..."
  fi
  configure_nvm
  read -s -k "?About to print out the final manual setup, press any key to continue"
  cat << EOF

   Set up the correct version of Node and npm
   -------------------------------------------
   Note you have to run these yourself, it can't be automated
   $ nvm install --lts
   $ nvm use --lts       # run this every session to set the version
   $ npm ci
EOF
}

instructions () {
  if [ ! -z  ${PREQUISITES+x}  ]; then
    if ! check_prerequisites; then
      prerequisites
      if ! isinstalled brew; then
        homebrew
      fi
      if ! isinstalled git; then
        git_instructions
      fi
    else
      echo "All prerequisites already installed"
    fi
  fi
  if [ ! -z  ${PRINT_MANUAL+x}  ]; then
    write_instructions
  fi
  if [ ! -z  ${WRITE_MANUAL+x}  ]; then
    echo "Writing instructions to ${PWD}/setup.md"
    write_instructions > ./setup.md
  fi
}

# process option arguments
while getopts "hmwAP" option; do		# w: place variable following w in $OPTARG
	case "$option" in
		h) help;;
    m) INSTRUCTIONS=0;PRINT_MANUAL=0;;
    w) INSTRUCTIONS=0;WRITE_MANUAL=0;;
    A) AUTO_INSTALL=0;;
    P) INSTRUCTIONS=0;PREQUISITES=0;;
		[?])  echo "bad option supplied" ;
			help;;
	esac
done

#MAIN
# print manual instructions if required then exit
if [ ! -z ${INSTRUCTIONS+x} ]; then
  instructions
elif [ ! -z ${AUTO_INSTALL+x} ]; then
  if ! check_prerequisites; then
    echo " run $ARGZER0 -P for instructions"
    exit 255
  fi
  auto_install
else
  help
fi