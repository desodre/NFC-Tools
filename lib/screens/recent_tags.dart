import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecentTagsWindow extends StatefulWidget {
  const RecentTagsWindow({super.key});
  @override
  State<RecentTagsWindow> createState() => _RecentTagsWindowState();
}

class _RecentTagsWindowState extends State<RecentTagsWindow> {
  List<NFCTag> tags = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getNFCTags();
    });
  }

  Future<List<NFCTag>> getNFCTags() async {
    final pref = await SharedPreferences.getInstance();

    List<String>? userTags = pref.getStringList('user_saved_tags') ?? [];

    for (dynamic tag in userTags) {
      Map<String, dynamic> tg = jsonDecode(tag);
      this.tags.add(NFCTag.fromJson(tg));
    }

    return tags;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return RecentTag(tag: tags[index]);
        })
    );
  }
}

class RecentTag extends StatelessWidget {
  final NFCTag tag;
  RecentTag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Icon(Icons.nfc_sharp),
          Column(children: <Widget>[Text(tag.type.name), Text(tag.id)]),
        ],
      ),
    );
  }
}

