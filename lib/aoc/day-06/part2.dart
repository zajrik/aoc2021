part of advent;

// IDK if my work laptop just can't handle it or if Dart can't handle calculations on this level
// when running code on the Dart VM or what, but I can't compile it due to using reflection in
// the project, so I guess I'm gonna have to give up on this part or write it in a more powerful
// language separately. Maybe Nim. 🤷‍♂️

class BreedingSimulator
{
	/// The isolate that will process our data
	late Isolate isolate;

	/// The port to which we will send data
	late SendPort sendPort;

	/// Isolate function that will simulate lanternfish breeding for any school sent to it
	static Future<void> simulateBreeding(SendPort sendPort) async
	{
		ReceivePort receivePort = ReceivePort();
		sendPort.send(receivePort.sendPort);

		/// Message will be a tuple containing a SendPort to send the
		/// response and a school of lanternfish to simulate
		await for (List<dynamic> msg in receivePort)
		{
			SendPort? responsePort = msg[0];

			/// Exit the isolate function if we don't receive a SendPort
			if (responsePort == null)
				break;

			List<int> school = msg[1];
			int length = school.length;

			for (int i = 0; i < length; i++)
			{
				school[i]--;

				if (school[i] == -1)
				{
					school[i] = 6;
					school.add(8);
				}
			}

			responsePort.send(school);
		}

		receivePort.close();
	}

	/// Spawn the breeding simulation isolate and store it. This should be awaited before use
	Future<void> spawn() async
	{
		ReceivePort receivePort = ReceivePort();

		isolate = await Isolate.spawn(simulateBreeding, receivePort.sendPort);
		sendPort = await receivePort.first;

		receivePort.close();
	}

	/// Simulate a generation of breeding (Send school data to isolate and wait for response)
	Future<List<int>> simulate(List<int> school) async
	{
		ReceivePort receivePort = ReceivePort();
		sendPort.send([receivePort.sendPort, school]);

		List<int> result = await receivePort.first;
		receivePort.close();

		return result;
	}

	/// Terminate the isolate
	Future<void> terminate() async
	{
		sendPort.send([null]);
		isolate.kill();
	}
}

Future<int> day6part2(Iterable<String> input) async
{
	List<int> school = input.first
		.split(',')
		.map((e) => int.parse(e))
		.toList();

	// Prepare simulation isolates and wait for them to spawn
	List<BreedingSimulator> sims = List.generate(8, (_) => BreedingSimulator());
	await Future.wait(sims.map((e) => e.spawn()));

	// Partition input
	List<List<int>> partitions = school.partition(school.length ~/ 7).toList();

	for (int i = 0; i < 80; i++)
		partitions = await Future.wait(partitions.entries.map((e) => sims[e.index].simulate(e.value)));

	// Terminate all sim isolates
	await Future.wait(sims.map((e) => e.terminate()));

	return partitions.map((e) => e.length).sum;
}
