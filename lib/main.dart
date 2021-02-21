import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './views/bootstrap_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await const FlutterSecureStorage().deleteAll();
  //#### A RETIRER ####
  ImageCache().clear();
  //###################
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      // title: 'Potager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BootstrapView(),
    );
  }
}
