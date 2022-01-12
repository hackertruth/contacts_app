import 'dart:convert';

import 'package:contact_app/models/contact.dart';
import 'package:contact_app/widgets/column_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Contact> contactInfo = [];

  //reading a json file from a local directory

  Future<void> readFile() async {
    String content = await rootBundle.loadString('data/info.json');

    //Converting jsonString to List datastructure
    List collection = jsonDecode(content);

    List<Contact> contact =
        collection.map((json) => Contact.fromJson(json)).toList();

    setState(() {
      contactInfo = contact;
    });
  }

  @override
  void initState() {
    readFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'My Contacts',
            style: TextStyle(
                color: Theme.of(context).appBarTheme.toolbarTextStyle!.color,
                fontSize: 25.0,
                fontFamily: 'Nunito'),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/jay.jpg'),
              ),
            )
          ],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                            width: 2.0, color: Color(0xFFfadf8e)))),
              ),
            ),
          )),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
          child: Text(
            'Recents',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Contact information = contactInfo[index];
              return ColumnWidget(contact: information);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.lightBlue,
                    thickness: 3.0,
                  ),
                ),
            itemCount: contactInfo.length)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF060130),
      ),
    );
  }
}
