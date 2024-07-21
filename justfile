format:
	dart format .
	alejandra -qq .

run-example:
	cd example/ && dart run main.dart

run-flutter-example:
	cd example/flutter_example/ && flutter run
