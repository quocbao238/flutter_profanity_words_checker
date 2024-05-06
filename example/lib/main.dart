import 'package:flutter/material.dart';
import 'package:flutter_profanity_words_checker/flutter_profanity_words_checker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profanity Words Checker',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const MyHomePage(title: 'Flutter Profanity Words Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Language currentLanguage = Language.en;
  late final FlutterProfanityChecker _flutterProfanityChecker;
  final TextEditingController _textEditingController = TextEditingController();
  String? safe;
  String? error;
  bool isHasCurseWords = false;

  @override
  void initState() {
    _flutterProfanityChecker = FlutterProfanityChecker(language: Language.getByLanguageCode('en'));
    _flutterProfanityChecker.init();
    _textEditingController.addListener(() {
      error = null;
      safe = null;
      error = null;
      isHasCurseWords = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter your text here',
              ),
            ),
            if (safe != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  safe!,
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  error!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          error = null;
                          safe = null;
                          isHasCurseWords = false;
                        });

                        final listWords = _flutterProfanityChecker.all(_textEditingController.text);
                        if (listWords.isNotEmpty) {
                          error = 'Found ${listWords.length} profanity words: [${listWords.join(', ')}]';
                        } else {
                          safe = 'This text is safe';
                        }

                        setState(() {});
                      },
                      child: const Text(
                        'Find profanity words',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          error = null;
                          safe = null;
                          isHasCurseWords = false;
                        });
                        isHasCurseWords = await _flutterProfanityChecker.hasCurseWords(_textEditingController.text);
                        if (isHasCurseWords) {
                          error = 'This text has profanity words';
                        } else {
                          safe = 'This text is safe';
                        }
                        setState(() {});
                      },
                      child: const Text(
                        'Check if has profanity words',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Show selector languages from Language enum
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ListTile(
                tileColor: Theme.of(context).colorScheme.background,
                title: const Text('Select language'),
                trailing: DropdownButton<Language>(
                  value: currentLanguage,
                  onChanged: (Language? value) async {
                    if (value != null) {
                      currentLanguage = value;
                      await _flutterProfanityChecker.changeLanguage(value);
                      setState(() {});
                    }
                  },
                  items: Language.values
                      .map((e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Text(e.title),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
