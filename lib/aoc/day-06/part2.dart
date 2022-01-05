part of advent;

// TODO: Multithread this I guess? just gonna let it run all day tomorrow and hope it finishes lol

Future<int> day6part2(Iterable<String> input) async
{
	Iterable<int> initialValues = input.first.split(',').map((e) => int.parse(e));
	List<int> school = initialValues.toList();

	List<int> simulateBreeding(List<int> school)
	{
		List<int> result = [];

		for (int fish in school)
			result.addAll(fish == 0 ? [6, 8] : [fish - 1]);

		return result;
	}

	for (int i = 0; i < 256; i++)
		school = simulateBreeding(school);

	return school.length;
}
