import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bizpage/_extensions/build_context.dart';
import 'package:flutter_bizpage/_prefs.dart';
import 'package:flutter_bizpage/_utils/environment.dart';
import 'package:flutter_bizpage/_utils/preload.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/main_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Environment.init();

  await Future.wait(
    introData.values
        .map((entry) => AssetImage('images/${entry.asset}.jpg'))
        .map((assetImage) => preload(assetImage)),
  );

  runZonedGuarded<void>(
    () => runApp(const _App()),
    (error, stack) => log(
      'Some explosion here...',
      error: error,
      stackTrace: stack,
    ),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          fontFamily: fontFamily,
          textTheme: context.textTheme.apply(fontFamily: fontFamily),
        ),
        home: const MainPage(),
      ),
    );
  }
}
