import 'package:flutter/material.dart';
import 'package:nfctools/repositories/tag_repository.dart';
import 'package:nfctools/screens/main_window.dart';
import 'package:nfctools/viewmodels/app_view_model.dart';
import 'package:nfctools/viewmodels/nfc_scan_view_model.dart';
import 'package:nfctools/viewmodels/recent_tags_view_model.dart';

void main(List<String> args) {
  final repository = TagRepository();
  final recentTagsViewModel = RecentTagsViewModel(repository);
  final nfcScanViewModel = NfcScanViewModel(repository);
  final appViewModel = AppViewModel(repository, recentTagsViewModel);

  runApp(
    NfcModelApp(
      appViewModel: appViewModel,
      nfcScanViewModel: nfcScanViewModel,
      recentTagsViewModel: recentTagsViewModel,
    ),
  );
}
