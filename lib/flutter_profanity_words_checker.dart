/*
Author: QuocBao
Email: buiquocbaodt@gmail.com
Date: 2024-05-05
This library is used to check if a given text contains any profanity words.
Special thanks to Robert James Gabriel and Coffee & Fun LLC for creating and maintaining this module, as well as the Jest team for the testing framework. Your efforts make this module more reliable and robust.
Thank coffeeandfun.com and Eris-182 for the inspiration.
En & Es files are from https://github.com/coffee-and-fun/google-profanity-words
Vi file is from https://github.com/Eris-182/vn-badwords

*/

library flutter_profanity_words_checker;

import 'package:flutter/services.dart' show rootBundle;

enum Language {
  en('en-US', 'assets/en_bad_words.txt'),
  es('es-ES', 'assets/es_bad_words.txt'),
  vi('vi-VN', 'assets/vi_bad_words.txt');

  /// Add more languages file here

  /// Constructor to get the bad words file name
  final String badWordsFileName;
  final String title;
  const Language(this.title, this.badWordsFileName);
  static Language getByLanguageCode(String languageCode) => switch (languageCode) {
        "en" => Language.en,
        "es" => Language.es,
        "vi" => Language.vi,
        // Add more languages here
        _ => throw Exception('Language not supported')
      };
}

class FlutterProfanityChecker {
  Language language;
  late Set<String> _badWords;
  FlutterProfanityChecker({required this.language});

  /// API Function to initialize the profanity words
  Future<void> init() async {
    final str = await rootBundle.loadString('packages/flutter_profanity_words_checker/${language.badWordsFileName}');
    _badWords = str.split('\n').toSet();
  }

  Future<void> changeLanguage(Language language) async {
    language = language;
    final str = await rootBundle.loadString('packages/flutter_profanity_words_checker/${language.badWordsFileName}');
    _badWords = str.split('\n').toSet();
  }

  Language get getLanguage => language;

  void _checkInit() {
    if (_badWords.isEmpty) {
      throw Exception('ProfanityChecker not initialized');
    }
  }

  /// API Function retrieves all the profanity words as an text input.
  List<String> all(String text) {
    _checkInit();
    if (text.isEmpty) return [];
    final result = <String>[];
    for (final word in _badWords) {
      if (word.isEmpty) continue;
      final regExp = RegExp(r'\b' + word + r'\b', caseSensitive: false);
      if (regExp.hasMatch(text)) {
        result.add(word);
      }
    }
    return result.toList();
  }

  /// API Function to checks if a given sentence contains any profanity words.
  /// Returns true if the sentence contains profanity words, otherwise false.
  bool hasCurseWords(String text) {
    _checkInit();
    if (text.isEmpty) return false;
    for (final word in _badWords) {
      if (word.isEmpty) continue;

      final regExp = RegExp(r'\b' + word + r'\b', caseSensitive: false);
      if (regExp.hasMatch(text)) {
        return true;
      }
    }
    return false;
  }
}
