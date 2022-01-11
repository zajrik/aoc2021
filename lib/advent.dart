library advent;

import 'dart:io';
import 'dart:mirrors';
import 'dart:isolate';

import 'package:pedantic/pedantic.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

part 'util.dart';

part 'aoc/day-01/part1.dart';
part 'aoc/day-01/part2.dart';

part 'aoc/day-02/part1.dart';
part 'aoc/day-02/part2.dart';

part 'aoc/day-03/part1.dart';
part 'aoc/day-03/part2.dart';

part 'aoc/day-04/part1.dart';
part 'aoc/day-04/part2.dart';

part 'aoc/day-05/part1.dart';
part 'aoc/day-05/part2.dart';

part 'aoc/day-06/part1.dart';
part 'aoc/day-06/part2.dart';

part 'aoc/day-07/part1.dart';
part 'aoc/day-07/part2.dart';

part 'aoc/day-08/part1.dart';
part 'aoc/day-08/part2.dart';

part 'aoc/day-09/part1.dart';
part 'aoc/day-09/part2.dart';

part 'aoc/day-10/part1.dart';
part 'aoc/day-10/part2.dart';

part 'aoc/day-11/part1.dart';
part 'aoc/day-11/part2.dart';

part 'aoc/day-12/part1.dart';
part 'aoc/day-12/part2.dart';

part 'aoc/day-13/part1.dart';
part 'aoc/day-13/part2.dart';

part 'aoc/day-14/part1.dart';
part 'aoc/day-14/part2.dart';

part 'aoc/day-15/part1.dart';
part 'aoc/day-15/part2.dart';

part 'aoc/day-16/part1.dart';
part 'aoc/day-16/part2.dart';

part 'aoc/day-17/part1.dart';
part 'aoc/day-17/part2.dart';

part 'aoc/day-18/part1.dart';
part 'aoc/day-18/part2.dart';

part 'aoc/day-19/part1.dart';
part 'aoc/day-19/part2.dart';

part 'aoc/day-20/part1.dart';
part 'aoc/day-20/part2.dart';

part 'aoc/day-21/part1.dart';
part 'aoc/day-21/part2.dart';

part 'aoc/day-22/part1.dart';
part 'aoc/day-22/part2.dart';

part 'aoc/day-23/part1.dart';
part 'aoc/day-23/part2.dart';

part 'aoc/day-24/part1.dart';
part 'aoc/day-24/part2.dart';

part 'aoc/day-25/part1.dart';
part 'aoc/day-25/part2.dart';

Future<void> main() async
{
	RegExp nameScheme = RegExp(r'day(\d{1,2})part(\d)');

	// Gather all functions in the library that match the name scheme
	LibraryMirror lib = currentMirrorSystem().findLibrary(#advent);
	List<MethodMirror> parts = lib.declarations.values
		.whereType<MethodMirror>()
		.where((e) => nameScheme.hasMatch(e.simpleName.toString()))
		.toList()
		..sort((a, b) => a.simpleName.toString().compareNaturallyTo(b.simpleName.toString()));

	// Run all solutions
	for (MethodMirror partFn in parts)
	{
		RegExpMatch match = nameScheme.firstMatch(partFn.simpleName.toString())!;
		String day = match.group(1)!;
		String part = match.group(2)!;

		Iterable<String> input;

		// If we fail to load input for a function, skip it
		try { input = getInput(int.parse(day)); }
		catch (e) { continue; }

		int result = await lib.invoke(partFn.simpleName, [input]).reflectee;

		// -0xdeadbeef is a placeholder value for unimplemented parts, skip it
		if (result == -0xdeadbeef)
			continue;

		print('Day $day, part $part: $result');
	}
}
