#!/bin/bash
func (){ echo $*; }

a='aa;;;;aaa'

a="bbb" func $a

echo "______finally:"
echo $a
echo '----------'
for xx in "$@"
	do echo $xx
done
