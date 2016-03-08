bb-clone() {
	if [ -z "$1" ]
	then
		cat <<-EOF
		# Bitbucket clone repo util
		##
		# Installation instructions, source and license available here:
		# https://github.com/fibo/bb-clone#bb-clone
		##
		USAGE: bb-clone [user/]repo
		EOF
		return 0
	fi
	BITBUCKET_DIR=${BITBUCKET_DIR:-~/bitbucket.org}
	MY_BITBUCKET_USER=$(git config --global bitbucket.user)
	if [ -z "$MY_BITBUCKET_USER" ]
	then
		read -p "Enter your bitbucket.user: " MY_BITBUCKET_USER
		git config --global bitbucket.user $MY_BITBUCKET_USER
	fi
	BITBUCKET_USER=$(echo $1 | cut -d / -f1)
	REPO_NAME=$(echo $1 | cut -d / -f2)
	if [ "$REPO_NAME" == "$BITBUCKET_USER" ]
	then
		BITBUCKET_USER=$MY_BITBUCKET_USER
	fi
	TARGET_DIR=$BITBUCKET_DIR/$BITBUCKET_USER
	mkdir -p $TARGET_DIR
	cd $TARGET_DIR
	REPO_URL=git@bitbucket.org:$BITBUCKET_USER/${REPO_NAME}.git
	git clone $REPO_URL && cd $REPO_NAME
	if [ -e package.json ]
	then
		NPM=$(which npm 2> /dev/null)
		if [ ! -z "$NPM" ]
		then
			$NPM install
		fi
	fi
	if [ -e bower.json ]
	then
		BOWER=$(which bower 2> /dev/null)
		if [ ! -z "$BOWER" ]
		then
			$BOWER install
		fi
	fi
	unset BOWER
	unset BITBUCKET_DIR
	unset BITBUCKET_USER
	unset MY_BITBUCKET_USER
	unset NPM
	unset REPO_NAME
	unset REPO_URL
	unset TARGET_DIR
}
