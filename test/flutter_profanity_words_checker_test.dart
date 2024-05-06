import 'package:flutter/widgets.dart';
import 'package:flutter_profanity_words_checker/flutter_profanity_words_checker.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String languageCode = 'en';
  final FlutterProfanityChecker flutterProfanityChecker =
      FlutterProfanityChecker(
          language: Language.getByLanguageCode(languageCode));
  await flutterProfanityChecker.init();

  // API Function retrieves all the profanity words as an text input.
  group('API Function retrieves all the profanity words as an text input', () {
    test('Should return the profanity word', () async {
      const tesingStr = 'I have a vibrator';
      final result = await flutterProfanityChecker.all(tesingStr);
      expect(result, ['vibrator']);
    });

    // Check if the word is not a profanity word
    test('Should return an empty list', () async {
      final result = await flutterProfanityChecker.all('good morning');
      expect(result, []);
    });

    // Check if the word is empty
    test('Should return an empty list', () async {
      final result = await flutterProfanityChecker.all('');
      expect(result, []);
    });
  });

  /// API Function to checks if a given sentence contains any profanity words.
  /// Returns true if the sentence contains profanity words, otherwise false.
  group(
      'API Function to checks if a given sentence contains any profanity words',
      () {
    test('Should return true', () async {
      const tesingStr = 'I have a vibrator';
      final result = await flutterProfanityChecker.hasCurseWords(tesingStr);
      expect(result, true);
    });

    // Check if the word is not a profanity word
    test('Should return false', () async {
      final result =
          await flutterProfanityChecker.hasCurseWords('good morning');
      expect(result, false);
    });

    // Check if the word is empty
    test('Should return false', () async {
      final result = await flutterProfanityChecker.hasCurseWords('');
      expect(result, false);
    });
  });
}
