fun blink(counter: MutableMap<Long, Long>): MutableMap<Long, Long> {

  val new_counter = mutableMapOf<Long, Long>().withDefault { 0 }

  for ((key, value) in counter) {
    if (key == 0L) {
      new_counter[1L] = new_counter.getValue(1L)+value
      continue
    } else if (key.toString().length % 2 == 0) {

      val tmp = key.toString()
      val mid = tmp.length / 2
      val firstHalf = tmp.substring(0, mid).toLong()
      val secondHalf = tmp.substring(mid).toLong()
      // Replace current number with the two new numbers
      new_counter[firstHalf]=new_counter.getValue(firstHalf)+value
      new_counter[secondHalf]=new_counter.getValue(secondHalf)+value
      continue
    } else {
      new_counter[key*2024L] = new_counter.getValue(key*2024L) + value
      continue
    }
  }
  return new_counter
}

fun main() {
  // need to change to a counter, 75 is too long to eval 
  var counter = mutableMapOf<Long, Long>().withDefault { 0 }
  // var seq = listOf(125L, 17L)
  var seq = listOf(64599L, 31L, 674832L, 2659361L, 1L, 0L, 8867L, 321L)
    for (s in seq){
        counter[s]=1L
    }

  for (i in 1..75) {
    counter = blink(counter)
    if (i==25){
          println("Part 1: ${counter.values.sum()}")
    }
  }
  println("Part 2: ${counter.values.sum()}")

}
