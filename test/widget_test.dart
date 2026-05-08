// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nfctools/repositories/tag_repository.dart';
import 'package:nfctools/screens/main_window.dart';
import 'package:nfctools/viewmodels/app_view_model.dart';
import 'package:nfctools/viewmodels/nfc_scan_view_model.dart';
import 'package:nfctools/viewmodels/recent_tags_view_model.dart';

void main() {
  testWidgets('main_window smoke test', (WidgetTester tester) async {
    final repository = TagRepository();
    final recentTagsViewModel = RecentTagsViewModel(repository);
    final nfcScanViewModel = NfcScanViewModel(repository);
    final appViewModel = AppViewModel(repository, recentTagsViewModel);

    await tester.pumpWidget(NfcModelApp(
      appViewModel: appViewModel,
      nfcScanViewModel: nfcScanViewModel,
      recentTagsViewModel: recentTagsViewModel,
    ));

    expect(find.text('NFC Tools'), findsOneWidget);
  });
}
