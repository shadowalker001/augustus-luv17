import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luvit/configs/size_config.dart';
import 'package:luvit/firebase_options.dart';
import 'package:luvit/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Luvit',
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      });
    });
  }
}
