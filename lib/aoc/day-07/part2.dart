part of advent;

Future<int> day7part2(Iterable<String> input) async
{
	List<int> crabs = input.first
		.split(',')
		.map((e) => int.parse(e))
		.toList()
		..sort();

	int highest = crabs.last;
	int lowest = 0x7fffffffffffffff;

	int calculateFuel(int value)
	{
		int result = 0;
		for (int i = 0; i < value; i++)
			result += i + 1;

		return result;
	}

	for (int pos = 1; pos <= highest; pos++)
	{
		List<int> fuelCosts = [];

		for (int crab in crabs)
			fuelCosts.add(calculateFuel((crab - pos).abs()));

		int total = fuelCosts.reduce((a, b) => a + b);

		if (total < lowest)
			lowest = total;
	}

	return lowest;
}
