import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DropdownItem {
  String title;
  Icon icon;
  DropdownItem({this.title, this.icon});
}

class CustomDropdownList extends StatefulWidget {
  @override
  CustomDropdownListState createState() => CustomDropdownListState();
}

class CustomDropdownListState extends State<CustomDropdownList> {
  static List<DropdownItem> items = <DropdownItem>[
    DropdownItem(
        icon: Icon(EvaIcons.arrowIosUpwardOutline, size: 18), title: "Newest"),
    DropdownItem(
        icon: Icon(EvaIcons.arrowIosDownwardOutline, size: 18),
        title: "Oldest"),
  ];
  DropdownItem _selectedItem = items.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropdownItem>(
        //hint: DropdownItem(title: "",icon: ""),
        value: _selectedItem,
        onChanged: (DropdownItem value) {
          setState(() {
            _selectedItem = value;
          });
        },
        items: items.map((DropdownItem item) {
          return DropdownMenuItem<DropdownItem>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item.icon,
                SizedBox(width:5),
                Text(
                  item.title,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),underline: Container(),icon: Container(),);
  }
}
