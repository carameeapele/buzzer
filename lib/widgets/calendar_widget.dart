import 'package:buzzer/main.dart';
import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/style/calendar_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  //late PageController _pageController = PageController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;

  late Map<DateTime, List<Event>> _dayEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _dayEvents = {};

    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void dispose() {
    _selectedEvents.dispose();

    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime date) {
    return _dayEvents[date] ?? [];
  }

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      // if (selectedDay.month > _selectedDay!.month) {
      //   _pageController.nextPage(
      //     duration: const Duration(milliseconds: 300),
      //     curve: Curves.easeIn,
      //   );
      // } else if (selectedDay.month < _selectedDay!.month) {
      //   _pageController.previousPage(
      //     duration: const Duration(milliseconds: 300),
      //     curve: Curves.easeIn,
      //   );
      // }
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.disabled;
      });
    }
  }

  // @override
  // void dispose() {
  //   _selectedEvents.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      firstDay: DateTime.utc(2000, 01, 01),
      lastDay: DateTime.utc(2040, 01, 01),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: RangeSelectionMode.disabled,
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      //onCalendarCreated: (controller) => _pageController = controller,
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: calendarStyle,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) {
          return DateFormat.E(locale).format(date).substring(0, 2);
        },
        weekdayStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        weekendStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          color: BuzzerColors.orange,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: BuzzerColors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              color: BuzzerColors.orange,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
            ),
            margin: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '${date.day}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      headerStyle: HeaderStyle(
        titleTextFormatter: (date, locale) =>
            DateFormat.MMMM(locale).format(date),
        titleTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 30.0,
        ),
        headerPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
    );
  }
}
