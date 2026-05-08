import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/repositories/tag_repository.dart';

enum NfcScanStatus { idle, scanning, tagFound, timeout }

class NfcScanViewModel extends ChangeNotifier {
  final TagRepository _repository;

  NfcScanViewModel(this._repository);

  NfcScanStatus _status = NfcScanStatus.idle;
  NFCTag? _tag;

  NfcScanStatus get status => _status;
  NFCTag? get tag => _tag;

  Future<NFCAvailability> checkAvailability() {
    return FlutterNfcKit.nfcAvailability;
  }

  Future<void> pollTag() async {
    _status = NfcScanStatus.scanning;
    _tag = null;
    notifyListeners();

    try {
      _tag = await FlutterNfcKit.poll(
        androidPlatformSound: true,
        timeout: const Duration(seconds: 5),
        iosMultipleTagMessage: 'Multiple tags found!',
        iosAlertMessage: 'Scan your tag',
      );
      _status = NfcScanStatus.tagFound;
    } catch (_) {
      _status = NfcScanStatus.timeout;
    }

    notifyListeners();
  }

  Future<void> saveCurrentTag() async {
    if (_tag != null) {
      await _repository.saveTag(_tag!);
    }
  }

  void reset() {
    _status = NfcScanStatus.idle;
    _tag = null;
    notifyListeners();
  }
}
