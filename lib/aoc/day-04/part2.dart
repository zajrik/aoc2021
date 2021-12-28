part of advent;

Future<int> day4part2(Iterable<String> input) async
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

	BingoCard winningCard = BingoCard();
	int winningNumber = 0;

	// Mark cards, capturing the most recent winning card until we find the last winner
	for (int number in numbers)
	{
		for (BingoCard card in cards)
		{
			if (card.hasBingo)
				continue;

			card.mark(number);

			if (card.hasBingo)
			{
				winningCard = card;
				winningNumber = number;
			}
		}
	}

	// Solution is the sum of all unmarked numbers times the winning number
	return winningCard.card
		.fold<List<BingoCell>>([], (a, b) => a..addAll(b))
		.where((e) => !e.isMarked)
		.map((e) => e.value)
		.sum * winningNumber;
}
