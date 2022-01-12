import threadpool, sugar
from strutils import parseInt, split, replace
from sequtils import any, map, foldl
from os import sleep

let school: seq[int] = readfile("input.txt")
    .split(",")
    .map(e => e.replace("\n", ""))
    .map(parseInt)

iterator partition[T](self: seq[T], sectionLength: int): seq[T] =
    ## Partition the given sequence into sequences of the given length
    var i: int = 0
    while i < self.len:
        yield self[i..<(if i + sectionLength > self.len: self.len else: i + sectionLength)]
        i += sectionLength

proc simulate(school: seq[int]): seq[int] =
    ## Simulate a day of lanternfish breeding
    for i in school:
        if i == 0:
            result.add(6)
            result.add(8)

        else:
            result.add(i - 1)

var partitions: seq[seq[int]] = collect:
    for partition in school.partition(school.len div 6):
        partition

var threads: array[6, FlowVar[seq[int]]]

for i in 0..<256:
    # Create and run simulation threads
    for j in 0..<6:
        threads[j] = spawn(simulate(partitions[j]))

    # Wait for threads to finish
    while threads.any(e => not e.isReady): sleep(1)

    # Save simulation results
    var k: int = 0
    for val in threads:
        partitions[k] = ^val
        inc k

echo partitions.map(e => e.len).foldl(a + b)

# I rewrote this in Nim thinking I was just limited by resources and the dart VM
# but it turns out this is just not the way to do this problem. I'll save this
# code for posterity at least
