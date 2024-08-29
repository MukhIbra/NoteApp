import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_database.dart';
import 'package:mynotes/theme/theme.dart';
import 'package:mynotes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await NotesDatabase.initalize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NotesDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
    );
  }
}


