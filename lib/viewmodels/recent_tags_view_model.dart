import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/repositories/tag_repository.dart';

class RecentTagsViewModel extends ChangeNotifier {
  final TagRepository _repository;

  RecentTagsViewModel(this._repository);

  List<NFCTag> _tags = [];
  bool _isLoading = false;

  List<NFCTag> get tags => List.unmodifiable(_tags);
  bool get isLoading => _isLoading;

  Future<void> loadTags() async {
    _isLoading = true;
    notifyListeners();
    _tags = await _repository.getTags();
    _isLoading = false;
    notifyListeners();
  }
}
