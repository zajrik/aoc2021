part of advent;

Future<int> day3part2(Iterable<String> input) async
{
	late List<int> zeroes;
	late List<int> ones;

	int generatorRating = 0;
	int scrubberRating = 0;

	// Reset the current count of 1s and 0s in all positions from the given values
	void resetCount(List<String> values)
	{
		zeroes = List.filled(12, 0);
		ones = List.filled(12, 0);

		for (String line in values)
			for (ListEntry bit in line.split('').entries)
				(bit.value == '0' ? zeroes : ones)[bit.index] += 1;
	}

	// Snapshot starting input values, count 1s and 0s
	List<String> values = input.toList();
	resetCount(values);

	// Find oxygen generator rating
	for (int i = 0; i < 12; i++)
	{
		String mostCommon = zeroes[i] == ones[i] ? '1' : zeroes[i] > ones[i] ? '0' : '1';
		values = values.where((e) => e[i] == mostCommon).toList();

		resetCount(values);

		if (values.length == 1)
			break;
	}

	// Parse oxygen generator rating, re-snapshot input, recount 1s and 0s
	generatorRating = int.parse(values.first, radix: 2);
	values = input.toList();
	resetCount(values);

	// Find C02 scrubber rating
	for (int i = 0; i < 12; i++)
	{
		String leastCommon = zeroes[i] == ones[i] ? '0' : zeroes[i] > ones[i] ? '1' : '0';
		values = values.where((e) => e[i] == leastCommon).toList();

		resetCount(values);

		if (values.length == 1)
			break;
	}

	// Parse C02 scrubber rating
	scrubberRating = int.parse(values.first, radix: 2);

	return generatorRating * scrubberRating;
}
