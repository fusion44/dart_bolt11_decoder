import 'dart:convert';

import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Highlighter.initialize(['json']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(child: BoltForm()),
    );
  }
}

class BoltForm extends StatefulWidget {
  const BoltForm({super.key});

  @override
  State<BoltForm> createState() => _BoltFormState();
}

class _BoltFormState extends State<BoltForm> {
  final _textCtrl = TextEditingController();
  TextSpan _decoded = const TextSpan(text: 'Nothing here yet');
  final _jsonEncoder = const JsonEncoder.withIndent('  ');
  late final Highlighter _highlighter;
  bool _ready = false;

  @override
  void initState() {
    _initHighligher();
    _textCtrl.addListener(() {
      setState(() {
        try {
          final r = Bolt11PaymentRequest(_textCtrl.text);
          _decoded = _highlighter.highlight(_jsonEncoder.convert(r.toJson()));
        } catch (e) {
          _decoded = TextSpan(text: "Error: ${e.toString()}");
        }
      });
    });
    super.initState();
  }

  void _initHighligher() async {
    var theme = await HighlighterTheme.loadLightTheme();
    _highlighter = Highlighter(language: 'json', theme: theme);
    setState(() => _ready = true);
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return Container();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              minLines: 3,
              maxLines: 6,
              controller: _textCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a Bolt11 invoice',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: SelectableText.rich(_decoded),
          ),
        ],
      ),
    );
  }
}
