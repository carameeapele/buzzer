import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
    return Scaffold(
      appBar: const AppBarWidget(title: 'Categories'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: types.length,
                itemBuilder: (BuildContext context, int index) {
                  final type = types[index];

                  return Card(
                    color: (selectedType.compareTo(type) == 0)
                        ? BuzzerColors.orange
                        : BuzzerColors.lightGrey,
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        type,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: (selectedType.compareTo(type) == 0)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      trailing: (selectedType.compareTo(type) == 0)
                          ? const Icon(
                              Icons.check,
                              size: 20.0,
                              color: Colors.white,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          selectedType = type;
                          Navigator.pop(context, selectedType);
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
