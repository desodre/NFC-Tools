import 'dart:convert';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagRepository {
  static const _tagsKey = 'user_saved_tags';

  Future<List<NFCTag>> getTags() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_tagsKey) ?? [];
    return rawList.map((e) => NFCTag.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveTag(NFCTag tag) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_tagsKey) ?? [];
    rawList.add(jsonEncode(tag.toJson()));
    await prefs.setStringList(_tagsKey, rawList);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tagsKey);
  }
}
