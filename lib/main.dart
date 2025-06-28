import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        .map(preload),
  );

  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) => ProviderScope(
    child: MaterialApp(
      title: title,
      theme: ThemeData(fontFamily: fontFamily),
      home: const MainPage(),
    ),
  );
}
