import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ClassTypes extends StatefulWidget {
  const ClassTypes({
    Key? key,
    required this.selectedType,
  }) : super(key: key);

  final String selectedType;

  @override
  State<ClassTypes> createState() => _ClassTypesState();
}

class _ClassTypesState extends State<ClassTypes> {
  List<String> types = ['None', 'Course', 'Seminar', 'Laboratory'];
  late String selectedType = widget.selectedType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 25.0,
      ),
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: types.length,
            itemBuilder: (BuildContext context, int index) {
              final type = types[index];

              return customCard(
                ListTile(
                  selected: (selectedType.compareTo(type) == 0),
                  selectedColor: BuzzerColors.orange,
                  dense: true,
                  title: Text(
                    type,
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  trailing: (selectedType.compareTo(type) == 0)
                      ? Icon(
                          Icons.check,
                          size: 20.0,
                          color: BuzzerColors.orange,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedType = type;
                      Navigator.pop(context, selectedType);
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
