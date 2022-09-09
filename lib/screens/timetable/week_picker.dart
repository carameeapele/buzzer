import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class WeekPicker extends StatefulWidget {
  const WeekPicker({
    Key? key,
    required this.optionIndex,
  }) : super(key: key);

  final int optionIndex;

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  List<String> options = ['Every Week', 'Odd Week', 'Even Week'];
  late int selectedOption = widget.optionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 25.0,
      ),
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final option = options[index];

              return customCard(
                ListTile(
                  selected: (selectedOption == index),
                  selectedColor: BuzzerColors.orange,
                  dense: true,
                  title: Text(option),
                  trailing: (selectedOption == index)
                      ? Icon(
                          Icons.check,
                          size: 20.0,
                          color: BuzzerColors.orange,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedOption = index;
                      Navigator.pop(context, selectedOption);
                    });
                  },
                ),
                false,
              );
            },
          ),
        ],
      ),
    );
  }
}
