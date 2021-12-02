part of advent;

extension UriExtensions on Uri
{
	/// The directory path containing whatever this Uri points to
	Directory get directory => Directory(dirname(toFilePath()));
}

extension StringExtension on String
{
	/// Compares this string to another using `compareNatural()`
	int compareNaturallyTo(String other) => compareNatural(this, other);
}

/// Get the puzzle input for the given day
Iterable<String> getInput(int day) =>
	File('${Platform.script.directory.path}/aoc/day-${day.toString().padLeft(2, '0')}/input.txt')
		.readAsStringSync()
		.replaceAll('\r\n', '\n')
		.split('\n')
		.where((e) => e != '');
