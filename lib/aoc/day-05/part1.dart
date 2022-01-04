part of advent;

/// Represents a point on the map. Count is the number of input lines that cross that point.
class VentMapPoint
{
	final int x;
	final int y;
	int count = 0;

	VentMapPoint(this.x, this.y);

	void increment() => count++;
}

/// Represents a line start or end point
class LinePoint
{
	final int x;
	final int y;

	const LinePoint(this.x, this.y);
}

/// Represents an underwater vent line
class VentLine
{
	LinePoint start;
	LinePoint end;

	VentLine(this.start, this.end);

	bool get isHorizontal => start.y == end.y;
	bool get isVertical => start.x == end.x;

	bool get isHorizontalOrVertical => isHorizontal || isVertical;
}

Future<int> day5part1(Iterable<String> input) async
{
	// Generate an empty 1000 x 1000 map
	List<List<VentMapPoint>> ventMap =
		List.generate(1000, (y) => List.generate(1000, (x) => VentMapPoint(x, y)));

	List<VentLine> ventLines = [];

	RegExp lineRegex = RegExp(r'(\d+),(\d+) -> (\d+),(\d+)');

	// Parse input lines
	for (String line in input)
	{
		RegExpMatch match = lineRegex.firstMatch(line)!;
		int startX = int.parse(match.group(1)!);
		int startY = int.parse(match.group(2)!);
		int endX = int.parse(match.group(3)!);
		int endY = int.parse(match.group(4)!);

		ventLines.add(VentLine(LinePoint(startX, startY), LinePoint(endX, endY)));
	}

	// Add the lines to the vent map by incrementing each point the line passes through
	for (VentLine line in ventLines.where((e) => e.isHorizontalOrVertical))
	{
		if (line.isHorizontal)
		{
			for (
				int x = line.start.x;
				line.start.x < line.end.x ? x <= line.end.x : x >= line.end.x;
				line.start.x < line.end.x ? x++ : x--
			)
				ventMap[line.start.y][x].increment();
		}

		if (line.isVertical)
		{
			for (
				int y = line.start.y;
				line.start.y < line.end.y ? y <= line.end.y : y >= line.end.y;
				line.start.y < line.end.y ? y++ : y--
			)
				ventMap[y][line.start.x].increment();
		}
	}

	// Solution is the number points where a line passes through more than once
	return ventMap
		.fold<List<VentMapPoint>>([], (a, b) => a..addAll(b))
		.where((e) => e.count > 1)
		.length;
}
