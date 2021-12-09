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

/// An index/value pair representing an entry in a List
class ListEntry<T>
{
	/// The index of the entry
	final int index;

	/// The value of the entry
	final T value;

	const ListEntry._(this.index, this.value);

	/// Creates an entry with the given index and value
	const factory ListEntry(int index, T value) = ListEntry._;

	@override
	String toString() => 'ListEntry($index: $value})';
}

extension ListExtension<T> on List<T>
{
	/// The entries of this list
	Iterable<ListEntry<T>> get entries sync*
	{
		int index = 0;

		for (final T value in this)
			yield ListEntry(index++, value);
	}
}


/// Get the puzzle input for the given day
Iterable<String> getInput(int day) =>
	File('${Platform.script.directory.path}/aoc/day-${day.toString().padLeft(2, '0')}/input.txt')
		.readAsStringSync()
		.replaceAll('\r\n', '\n')
		.split('\n')
		.where((e) => e != '');
