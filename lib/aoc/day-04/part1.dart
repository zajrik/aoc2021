part of advent;

/// Represents a cell on a bingo card
class BingoCell
{
	int value = 0;
	bool _marked = false;

	BingoCell(this.value);

	void mark() => _marked = true;
	bool get isMarked => _marked;
}

/// Represents a bingo card
class BingoCard
{
	static const _indices = [0, 1, 2, 3, 4];

	final List<List<BingoCell>> card = [];

	/// Add a line of cells to this bingo card
	void addLine(List<BingoCell> line) => card.add(line);

	/// Mark a cell (if any cell matches the given number)
	void mark(int number)
	{
		for (List<BingoCell> line in card)
			for (BingoCell cell in line)
				if (cell.value == number)
					cell.mark();
	}

	/// Returns whether or not there is a bingo in the given column
	bool _checkColumn(int index) => _indices
		.map((i) => card[i][index].isMarked)
		.reduce((a, b) => a && b);

	/// Returns whether or not there is a bingo in the given row
	bool _checkRow(int index) => _indices
		.map((i) => card[index][i].isMarked)
		.reduce((a, b) => a && b);

	/// Whether or not this card has a bingo
	bool get hasBingo =>
		_indices.map((e) => _checkColumn(e)).any((e) => e)
			|| _indices.map((e) => _checkRow(e)).any((e) => e);

	@override
	String toString()
	{
		String result = '';
		for (List<BingoCell> line in card)
		{
			for (BingoCell cell in line)
				result += '${cell.value.toString().padLeft(2)}${cell.isMarked ? '+ ' : '  '}';

			result += '\n';
		}

		return result.trim();
	}
}

Future<int> day4part1(Iterable<String> input) async
{
	// Save the bingo numbers to call
	Iterable<int> numbers = input
		.first
		.split(',')
		.map((e) => int.parse(e));

	// Capture all of the bingo card string values
	Iterable<List<String>> rawCards = input
		.skip(1)
		.toList()
		.partition(5);

	List<BingoCard> cards = [];

	// Generate BingoCards from the raw bingo card string values
	for (List<String> rawCard in rawCards)
	{
		BingoCard card = BingoCard();

		for (String line in rawCard)
			card.addLine(
				line
					.split(' ')
					.where((e) => e != '')
					.map((e) => BingoCell(int.parse(e)))
					.toList()
			);

		cards.add(card);
	}

	bool winnerFound = false;
	BingoCard winningCard = BingoCard();
	int winningNumber = 0;

	// Mark cards until a winner is found
	for (int number in numbers)
	{
		for (BingoCard card in cards)
		{
			card.mark(number);

			if (card.hasBingo)
			{
				winnerFound = true;
				winningCard = card;
				winningNumber = number;
				break;
			}
		}

		if (winnerFound)
			break;
	}

	// Solution is the sum of all unmarked numbers times the winning number
	return winningCard.card
		.fold<List<BingoCell>>([], (a, b) => a..addAll(b))
		.where((e) => !e.isMarked)
		.map((e) => e.value)
		.sum * winningNumber;
}
