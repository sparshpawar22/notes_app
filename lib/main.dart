import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'models/note_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('note_database');
  await Hive.openBox('themeBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteData()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: themeProvider.themeData,
      home: HomePage(),
    );
  }
}
