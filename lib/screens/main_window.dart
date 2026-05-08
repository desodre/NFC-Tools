import 'package:flutter/material.dart';
import 'package:nfctools/screens/nfc_read_window.dart';
import 'package:nfctools/screens/recent_tags.dart';
import 'package:nfctools/viewmodels/app_view_model.dart';
import 'package:nfctools/viewmodels/nfc_scan_view_model.dart';
import 'package:nfctools/viewmodels/recent_tags_view_model.dart';

class NfcModelApp extends StatelessWidget {
  final AppViewModel appViewModel;
  final NfcScanViewModel nfcScanViewModel;
  final RecentTagsViewModel recentTagsViewModel;

  const NfcModelApp({
    super.key,
    required this.appViewModel,
    required this.nfcScanViewModel,
    required this.recentTagsViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWindow(
        appViewModel: appViewModel,
        nfcScanViewModel: nfcScanViewModel,
        recentTagsViewModel: recentTagsViewModel,
      ),
    );
  }
}

class MainWindow extends StatefulWidget {
  final AppViewModel appViewModel;
  final NfcScanViewModel nfcScanViewModel;
  final RecentTagsViewModel recentTagsViewModel;

  const MainWindow({
    super.key,
    required this.appViewModel,
    required this.nfcScanViewModel,
    required this.recentTagsViewModel,
  });

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      NfcReadWindow(viewModel: widget.nfcScanViewModel),
      RecentTagsWindow(viewModel: widget.recentTagsViewModel),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appViewModel,
      builder: (context, _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: widget.appViewModel.clearAllTags,
            tooltip: 'Clear all saved tags',
            child: const Icon(Icons.delete_sweep),
          ),
          appBar: AppBar(title: const Text('NFC Tools')),
          body: IndexedStack(
            index: widget.appViewModel.currentPageIndex,
            children: _pages,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: widget.appViewModel.currentPageIndex,
            indicatorColor: Colors.blueAccent,
            onDestinationSelected: widget.appViewModel.navigateTo,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.nfc), label: 'NFC'),
              NavigationDestination(
                icon: Icon(Icons.recycling_rounded),
                label: 'Recent Tags',
              ),
            ],
          ),
        );
      },
    );
  }
}
