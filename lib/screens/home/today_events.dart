import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TodayEvents extends StatefulWidget {
  const TodayEvents({Key? key}) : super(key: key);

  @override
  State<TodayEvents> createState() => _TodayEventsState();
}

class _TodayEventsState extends State<TodayEvents> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Exam>>(
      valueListenable: Hive.box<Exam>('exams').listenable(),
      builder: (context, box, widget) {
        final exams = box.values.toList().cast<Exam>();
        exams.removeWhere((exam) =>
            DateTime.now().add(const Duration(days: 1)).isBefore(exam.date));
        exams.sort((a, b) => a.date.compareTo(b.date));

        return exams.isEmpty
            ? const SizedBox()
            : SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: exams.length > 3 ? 3 : exams.length,
                      itemBuilder: (BuildContext context, int index) {
                        Exam exam = exams[index];
                        DateTime now = DateTime.now();
                        bool _isToday = (exam.date.day == now.day &&
                            exam.date.month == now.month &&
                            exam.date.year == now.year);

                        return examCard(
                          ListTile(
                            dense: true,
                            title: examTodayTitle(
                                exam.title, exam.category, exam.date),
                            trailing: Text(
                              _isToday
                                  ? DateFormat('Hm').format(exam.time)
                                  : DateFormat('dd MMM', 'en_US')
                                      .format(exam.date),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).popAndPushNamed('/exams');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
