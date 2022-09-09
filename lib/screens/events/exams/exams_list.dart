import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/events/exams/edit_exam.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late bool deleteExams = preferences.get('deleteExams', defaultValue: true);

  @override
  void initState() {
    _automaticallyDelete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.liquor,
            size: 50.0,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 5.0),
          Text(
            'Click + to add an exam',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    return ValueListenableBuilder<Box<Exam>>(
      valueListenable: Hive.box<Exam>('exams').listenable(),
      builder: (context, box, widget) {
        final exams = box.values.toList().cast<Exam>();
        exams.sort((a, b) => a.date.compareTo(b.date));

        return exams.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: exams.length,
                itemBuilder: (BuildContext context, int index) {
                  Exam exam = exams[index];

                  DateTime now = DateTime.now();
                  bool _isToday = (exam.date.day == now.day &&
                      exam.date.month == now.month &&
                      exam.date.year == now.year);
                  bool _isTomorrow = (exam.date.day == (now.day + 1) &&
                      exam.date.month == now.month &&
                      exam.date.year == now.year);

                  return Opacity(
                    opacity: now.isBefore(exam.date) ? 1.0 : 0.4,
                    child: customCard(
                      Theme(
                        data: data,
                        child: ExpansionTile(
                          title:
                              examTitle(exam.title, exam.category, exam.date),
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          trailing: examTrailing(exam.date, exam.time),
                          childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0.0,
                          ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          expandedAlignment: Alignment.centerLeft,
                          children: <Widget>[
                            if (now.isBefore(exam.date))
                              classRow(
                                'Time',
                                Text(
                                  DateFormat('Hm').format(exam.time),
                                  style: TextStyle(
                                    color: BuzzerColors.grey,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10.0),
                            if (exam.building.isNotEmpty)
                              classRow(
                                'Building',
                                Text(
                                  exam.building,
                                  style: TextStyle(
                                    color: BuzzerColors.grey,
                                  ),
                                ),
                              ),
                            if (exam.building.isNotEmpty)
                              const SizedBox(height: 10.0),
                            if (exam.room.isNotEmpty)
                              classRow(
                                'Room',
                                Text(
                                  exam.room,
                                  style: TextStyle(
                                    color: BuzzerColors.grey,
                                  ),
                                ),
                              ),
                            if (exam.details.isNotEmpty)
                              Text(
                                exam.details,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: BuzzerColors.grey),
                              ),
                            tileOptions(
                              context,
                              EditExam(exam: exam),
                              () {
                                _deleteExam(exam);
                              },
                            ),
                          ],
                        ),
                      ),
                      _isToday || _isTomorrow,
                    ),
                  );
                },
              );
      },
    );
  }

  void _automaticallyDelete() {
    if (deleteExams) {
      final box = Hive.box<Exam>('exams');
      final exams = box.values.toList().cast<Exam>();

      for (var exam in exams) {
        if (exam.date.add(const Duration(days: 1)).isBefore(DateTime.now())) {
          _deleteExam(exam);
        }
      }
    }
  }

  void _deleteExam(Exam exam) {
    exam.delete();

    final categoryBox = Hive.box<Category>('categories');
    final categories = categoryBox.values.toList().cast<Category>();

    final index = categories
        .indexWhere((category) => category.name.compareTo(exam.category) == 0);

    if (index != -1) {
      categories[index].uses--;
      categories[index].save();

      if (categories[index].uses < 1) {
        categories[index].delete();
      }
    }
  }
}
