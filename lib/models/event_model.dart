// final today = DateTime.now();
// final firstDay = DateTime(today.year, today.month - 3, today.day);
// final lastDay = DateTime(today.year, today.month + 3, today.day);

class Event {
  DateTime date;
  String title;

  Event(this.date, this.title);

  @override
  String toString() => title;
}


// final eventsList = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_eventsSource);

// final _eventsSource = Map.fromIterable(List.generate(50, (index) => index),
// key: (item) => DateTime.utc(firstDay.year, firstDay.month, item * 5),
// value: (item) => List.generate(item, (index) => null))