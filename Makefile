
.PHONY: fun

fun:
	echo 'bb-clone() {' > fun.sh; grep '    ' README.md | sed -e 's/    /\t/' >> fun.sh; echo '}' >> fun.sh

