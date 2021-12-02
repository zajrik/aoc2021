part of advent;

Future<int> day2part2(Iterable<String> input) async
{
	int horiz = 0;
	int depth = 0;
	int aim = 0;

	void move(String dir, int distance)
	{
		if (dir == 'forward')
		{
			horiz += distance;
			depth += aim * distance;
		}

		if (dir == 'down')
			aim += distance;

		if (dir == 'up')
			aim -= distance;
	}

	for (String line in input)
	{
		List<String> movement = line.split(' ');
		move(movement[0], int.parse(movement[1]));
	}

	return horiz * depth;
}
