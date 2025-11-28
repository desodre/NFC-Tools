import 'package:flutter/material.dart';
import 'package:nfctools/screens/nfc_read_window.dart';
import 'package:nfctools/screens/recent_tags.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NfcModelApp extends StatefulWidget {
  const NfcModelApp({super.key});

  @override
  State<NfcModelApp> createState() => _NfcModelAppState();
}

class _NfcModelAppState extends State<NfcModelApp> {
  int currentPageIndex = 0;
  final List<Widget> _pages = <Widget>[NfcReadWindow(), RecentTagsWindow()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          setState(() {
          });
        }),
        appBar: AppBar(title: const Text('NFC Model')),
        body: _pages.elementAt(currentPageIndex),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          indicatorColor: Colors.blueAccent,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.nfc),
              label: 'NFC'),

            NavigationDestination(
              icon: Icon(Icons.recycling_rounded),
              label: 'Recent Tags',
            ),
          ],
        ),
      ),
    );
  }
}
