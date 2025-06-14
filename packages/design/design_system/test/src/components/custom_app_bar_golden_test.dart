import 'package:design_system/src/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('CustomAppBar Golden Tests', () {
    testGoldens('CustomAppBar with default avatar and EN language',
        (tester) async {
      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            appBar: const CustomAppBar(
              userName: 'John Doe',
              languageCode: 'EN',
            ),
            body: Container(),
          ),
        ),
        surfaceSize: const Size(400, kToolbarHeight),
      );

      await screenMatchesGolden(tester, 'custom_app_bar_default');
    });
  });
}
