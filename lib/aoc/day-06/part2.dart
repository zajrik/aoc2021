part of advent;

Future<int> day6part2(Iterable<String> input) async
{
	List<int> school = input.first
		.split(',')
		.map((e) => int.parse(e))
		.toList();

	// Create buckets for the fish
	List<int> buckets = List.filled(9, 0, growable: true);

	// Sort fish into buckets by how many days until they spawn another fish
	for (int fish in school)
		buckets[fish]++;

	// Run each day of spawning
	for (int i = 0; i < 256; i++)
	{
		int spawning = buckets.removeAt(0);
		buckets[6] += spawning;
		buckets.add(spawning);
	}

	// Solution is the total number of fish
	return buckets.reduce((a, b) => a + b);
}
