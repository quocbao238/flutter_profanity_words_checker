<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# **📦 Flutter Profanity Words Checker 📦**

A Flutter library for checking if a given text contains any profanity words.

## 🧪 Features

- Supports multiple languages: English, Spanish, Vietnamese (more can be added)
- Efficient profanity word checking algorithm
- Easy to integrate into Flutter projects

## 💊 Getting started

To start using `flutter_profanity_words_checker`, ensure you have Flutter installed and set up in your project. Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
flutter_profanity_words_checker:
  git:
    url: https://github.com/quocbao238/flutter_profanity_words_checker
    ref: 1.0.0
```

## 👨‍💻 Usage

### \* Import in your project

```dart
import 'package:flutter_profanity_words_checker/flutter_profanity_words_checker.dart';
```

#### \* Initialize the ProfanityWordsChecker

```dart
  late final FlutterProfanityChecker _flutterProfanityChecker;

  @override
    void initState() {
        super.initState();
        _flutterProfanityChecker = FlutterProfanityChecker(language: Language.getByLanguageCode('en'));
        _flutterProfanityChecker.init();
    }
```

#### \* Check if a text contains any profanity words -> result is a boolean value

```dart
  bool hasProfanityWords(String text) {
    return _flutterProfanityChecker.hasCurseWords(text);
  }
```

#### \* Check if a text contains any profanity words -> result is a list of profanity words

```dart
  List<String> getProfanityWords(String text) {
    return _flutterProfanityChecker.all(text);
  }
```

#### \* Change language

```dart
  void changeLanguage(Language language) {
    _flutterProfanityChecker.changeLanguage(language);
  }
```

## 💟 Acknowledgments

This library is used to check if a given text contains any profanity words. We would like to express our gratitude to the following individuals and organizations:

- **Robert James Gabriel**: For creating and maintaining the foundation of this module.
- **Coffee & Fun LLC**: For their ongoing contributions and support in developing and maintaining this package.
- **Jest team**: For the testing framework that ensures the reliability and robustness of this module.
- **coffeeandfun.com**: For providing inspiration and valuable resources for profanity word lists.
- **Eris-182**: For their contributions and inspiration, particularly for the Vietnamese profanity word list.
- The creators and contributors of the profanity word lists:
  - [Google Profanity Words](https://github.com/coffee-and-fun/google-profanity-words): Providing profanity word lists for English and Spanish.
  - [vn-badwords](https://github.com/Eris-182/vn-badwords): Offering profanity word lists for Vietnamese.

Your efforts and contributions have greatly enriched this package and made it more effective in serving its purpose. Thank you!


## ✨ Additional information

- **Documentation**: Find more detailed usage instructions and API documentation in the [API reference](https://pub.dev/documentation/flutter_profanity_words_checker/latest/).
- **Contribution Guidelines**: Contributions are welcome! Feel free to submit bug reports, feature requests, or pull requests on the [GitHub repository](https://github.com/your-repo-url).
- **Issue Tracking**: If you encounter any issues or have questions about the package, please open an issue on the [GitHub repository](https://github.com/your-repo-url/issues).

I strive to respond to issues and pull requests promptly. Your feedback and contributions are appreciated!
