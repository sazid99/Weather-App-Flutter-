import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/themes/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider();
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.updateTheme,
          home: HomePage(),
        );
      },
    );
  }
}
