// ExpansionPanelList(
//   elevation: 0.0,
//   expandedHeaderPadding: const EdgeInsets.all(5.0),
//   dividerColor: Colors.white,
//   animationDuration: const Duration(seconds: 1),
//   expansionCallback: (int index, bool isExpanded) {
//     setState(() {
//       _events[index].isExpanded = !isExpanded;
//     });
//   },
//   children: _events.map<ExpansionPanel>((Item item) {
//     return ExpansionPanel(
//       canTapOnHeader: true,
//       backgroundColor: item.isExpanded
//           ? BuzzerColors.orange
//           : BuzzerColors.lightGrey,
//       headerBuilder: (BuildContext context, bool isExpanded) {
//         return ListTile(
//           textColor: isExpanded ? Colors.white : Colors.black,
//           title: Text(
//             item.headerValue,
//             style: const TextStyle(
//               fontFamily: 'Roboto',
//               fontSize: 16.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10.0),
//             ),
//           ),
//           trailing: const Text('3'),
//         );
//       },
//       body: ListTile(
//         textColor: item.isExpanded ? Colors.white : Colors.black,
//         title: Text(item.expandedValue),
//         subtitle: const Text('Delete'),
//         trailing: const Icon(Icons.delete),
//         onTap: () {
//           setState(() {
//             _events.removeWhere(
//                 (Item currentItem) => item == currentItem);
//           });
//         },
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(7.0),
//           ),
//         ),
//       ),
//       isExpanded: item.isExpanded,
//     );
//   }).toList(),
// ),

// void addEvent(Event newEvent) {}

// class Item {
//   String expandedValue;
//   String headerValue;
//   bool isExpanded;

//   Item(this.expandedValue, this.headerValue, this.isExpanded);
// }

// List<Item> generateItems(int numberOfItems) {
//   return List<Item>.generate(numberOfItems, (index) {
//     return Item('Event $index', 'This is event number $index', false);
//   });
// }