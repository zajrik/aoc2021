part of advent;

Future<int> day3part1(Iterable<String> input) async
{
	List<int> zeroes = List.filled(12, 0);
	List<int> ones = List.filled(12, 0);

	for (String line in input)
		for (ListEntry bit in line.split('').entries)
			(bit.value == '0' ? zeroes : ones)[bit.index] += 1;

	int gamma = 0;
	int epsilon = 0;

	for (int i = 0; i < 12; i++)
	{
		gamma = (gamma << 1) + (zeroes[i] > ones[i] ? 0 : 1);
		epsilon = (epsilon << 1) + (zeroes[i] > ones[i] ? 1 : 0);
	}

	return gamma * epsilon;
}
