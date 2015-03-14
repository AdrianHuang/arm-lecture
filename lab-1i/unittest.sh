#!/bin/bash

QEMU_ARM_CMD="qemu-arm -L /usr/arm-linux-gnueabihf"

function usage()
{
	echo -e "Usage: $0 program_name"
	return
}

if [ $# -ne 1 ]
then
	usage $0
	exit 1
fi

n=0
prev_fib_result=0

while true
do
	output=`$QEMU_ARM_CMD $1 $n`

	[ "$?" -eq 0 ] || exit 0

	# Get the result of f(n)
	fib_result=`echo $output | cut -d ':' -f 2 | tr -d '[[:space:]]'`

	# Check if the result is accurate
	[ $fib_result -ge $prev_fib_result ] || exit 0

	echo -e "fib($n) = $fib_result"

	n=$((n+1))
	prev_fib_result=$fib_result
done
