part of advent;

Future<int> day7part1(Iterable<String> input) async
{
	List<int> crabs = input.first
		.split(',')
		.map((e) => int.parse(e))
		.toList()
		..sort();

	int highest = crabs.last;
	int lowest = 0x7fffffffffffffff;

	for (int pos = 0; pos <= highest; pos++)
	{
		List<int> distances = [];

		for (int crab in crabs)
			distances.add((crab - pos).abs());

		int total = distances.reduce((a, b) => a + b);

		if (total < lowest)
			lowest = total;
	}

	return lowest;
}
