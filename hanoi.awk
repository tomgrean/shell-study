#awk script

function moveit(from, to)
{
	print "move", from, "-->", to;
}

function hanoi(n, from, temp, to)
{
	if (n > 0) {
		hanoi(n - 1, from, to, temp);
		moveit(from, to);
		hanoi(n - 1, temp, from, to);
	}
}

hanoi($1, $2, $3, $4)
