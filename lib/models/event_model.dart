// final today = DateTime.now();
// final firstDay = DateTime(today.year, today.month - 3, today.day);
// final lastDay = DateTime(today.year, today.month + 3, today.day);

class Event {
  final String title;
  final DateTime date;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final int reminders;
  final String notes;

  Event(this.title, this.date, this.location, this.startTime, this.endTime,
      this.reminders, this.notes);
}
