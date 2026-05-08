import 'package:flutter/foundation.dart';
import 'package:nfctools/repositories/tag_repository.dart';
import 'package:nfctools/viewmodels/recent_tags_view_model.dart';

class AppViewModel extends ChangeNotifier {
  final TagRepository _repository;
  final RecentTagsViewModel _recentTagsViewModel;

  AppViewModel(this._repository, this._recentTagsViewModel);

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void navigateTo(int index) {
    _currentPageIndex = index;
    if (index == 1) {
      _recentTagsViewModel.loadTags();
    }
    notifyListeners();
  }

  Future<void> clearAllTags() async {
    await _repository.clearAll();
    await _recentTagsViewModel.loadTags();
    notifyListeners();
  }
}
