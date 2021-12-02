part of advent;

Future<int> day1part1(Iterable<String> puzzleInput) async
{
	final Iterable<int> input = puzzleInput.map((e) => int.parse(e));

	int prev = input.first;
	int increases = 0;

	for (int value in input.skip(1))
	{
		if (value > prev)
			increases++;

		prev = value;
	}

	return increases;
}
