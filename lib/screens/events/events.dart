import 'package:buzzer/main.dart';
import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Item> _events = generateItems(3);

  dynamic userName;
  final AuthService _auth = AuthService();
  String error = '';

  Future<dynamic> getUserName() async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('user_info')
        .doc(_auth.toString());

    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
      if (snapshot.data() != null) {
        setState(() {
          userName = snapshot.data();
        });
      } else {
        setState(() {
          error = 'Could not connect to databse';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(
        title: 'Events',
      ),
      drawer: MenuDrawer(
        name: userName['name'],
        email: _auth.getEmail(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Exams',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ExpansionPanelList(
                elevation: 0.0,
                expandedHeaderPadding: const EdgeInsets.all(5.0),
                animationDuration: const Duration(seconds: 1),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _events[index].isExpanded = !isExpanded;
                  });
                },
                children: _events.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: item.isExpanded
                        ? BuzzerColors.orange
                        : BuzzerColors.lightGrey,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        textColor: isExpanded ? Colors.white : Colors.black,
                        title: Text(
                          item.headerValue,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        trailing: const Text('3'),
                      );
                    },
                    body: ListTile(
                      textColor: item.isExpanded ? Colors.white : Colors.black,
                      title: Text(item.expandedValue),
                      subtitle: const Text('Delete'),
                      trailing: const Icon(Icons.delete),
                      onTap: () {
                        setState(() {
                          _events.removeWhere(
                              (Item currentItem) => item == currentItem);
                        });
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void addEvent(Event newEvent) {}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item(this.expandedValue, this.headerValue, this.isExpanded);
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (index) {
    return Item('Event $index', 'This is event number $index', false);
  });
}
