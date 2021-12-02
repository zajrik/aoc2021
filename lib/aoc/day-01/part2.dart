part of advent;

Future<int> day1part2(Iterable<String> puzzleInput) async
{
	final List<int> input = puzzleInput.map((e) => int.parse(e)).toList();

	int prev = input.take(3).sum;
	int increases = 0;

	for (int i = 1; i < input.length - 2; i++)
	{
		final int sum = input.sublist(i, i + 3).sum;

		if (sum > prev)
			increases++;

		prev = sum;
	}

	return increases;
}
