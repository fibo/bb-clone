bb-clone() {
tif [ -z "$1" ]
tthen
t	cat <<-EOF
t	# Bitbucket clone repo util
t	##
t	# Installation instructions, source and license available here:
t	# https://github.com/fibo/bb-clone#bb-clone
t	##
t	USAGE: bb-clone [user/]repo
t	EOF
t	return 0
tfi
tBITBUCKET_DIR=${BITBUCKET_DIR:-~/bitbucket.org}
tMY_BITBUCKET_USER=$(git config --global bitbucket.user)
tif [ -z "$MY_BITBUCKET_USER" ]
tthen
t	read -p "Enter your bitbucket.user: " MY_BITBUCKET_USER
t	git config --global bitbucket.user $MY_BITBUCKET_USER
tfi
tBITBUCKET_USER=$(echo $1 | cut -d / -f1)
tREPO_NAME=$(echo $1 | cut -d / -f2)
tif [ "$REPO_NAME" == "$BITBUCKET_USER" ]
tthen
t	BITBUCKET_USER=$MY_BITBUCKET_USER
tfi
tTARGET_DIR=$BITBUCKET_DIR/$BITBUCKET_USER
tmkdir -p $TARGET_DIR
tcd $TARGET_DIR
tREPO_URL=git@bitbucket.org:$BITBUCKET_USER/${REPO_NAME}.git
tgit clone --recursive $REPO_URL && cd $REPO_NAME
tif [ -e package.json ]
tthen
t	NPM=$(which npm 2> /dev/null)
t	if [ ! -z "$NPM" ]
t	then
t		$NPM install
t	fi
tfi
tif [ -e bower.json ]
tthen
t	BOWER=$(which bower 2> /dev/null)
t	if [ ! -z "$BOWER" ]
t	then
t		$BOWER install
t	fi
tfi
tunset BOWER
tunset BITBUCKET_DIR
tunset BITBUCKET_USER
tunset MY_BITBUCKET_USER
tunset NPM
tunset REPO_NAME
tunset REPO_URL
tunset TARGET_DIR
}
