part of advent;

Future<int> day2part1(Iterable<String> input) async
{
	int horiz = 0;
	int depth = 0;

	void move(String dir, int distance)
	{
		if (dir == 'forward')
			horiz += distance;

		if (dir == 'down')
			depth += distance;

		if (dir == 'up')
			depth -= distance;
	}

	for (String line in input)
	{
		List<String> movement = line.split(' ');
		move(movement[0], int.parse(movement[1]));
	}

	return horiz * depth;
}
