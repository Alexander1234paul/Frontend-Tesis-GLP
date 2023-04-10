import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contacts extends StatefulWidget {
  const Contacts({Key? key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List contactsData = [];
  late Map data;

  Future<void> getAll() async {
    http.Response response = await http.get(Uri.parse('http://10.0.2.2:3000'));
    data = json.decode(response.body);

    setState(() {
      contactsData = data['contacts'];
    });
  }

  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: contactsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[
                Text('${contactsData[index]["firstname"]}')
              ],
            ),
          );
        },
      ),
    );
  }
}
