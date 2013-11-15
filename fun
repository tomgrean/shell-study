#!/bin/ksh

foo() {
	echo "in func foo"
	export a=ssss
}


echo before $a

foo

echo after $a
