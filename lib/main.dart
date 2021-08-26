import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bizpage/_util/environment.dart';
import 'package:flutter_bizpage/_util/preload.dart';
import 'package:flutter_bizpage/pages/main/a_intro/_data.dart';
import 'package:flutter_bizpage/pages/main/main_page.dart';
import 'package:flutter_bizpage/prefs.dart';
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
        .map((entry) => entry.asset)
        .map((asset) => preload(AssetImage('images/$asset.jpg'))),
  );

  runZonedGuarded<void>(
    () => runApp(const _App()),
    (dynamic error, dynamic stack) {
      log('Some explosion here...', error: error, stackTrace: stack);
    },
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
          fontFamily: 'Open Sans',
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        ),
        home: const MainPage(),
      ),
    );
  }
}
