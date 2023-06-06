import '/view/recoveryPasswordScreen.dart';
import '/view/registerScreen.dart';
import '/view/userUpdateProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'view/homeScreen.dart';
import 'view/loginScreen.dart';
import 'view/homeapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/recoveryPass', page: () => RecoveryPassScreen()),
        GetPage(name: '/signed', page: () => HomeScreenApp()),
        GetPage(name: '/userUpdate', page: () => UserUpdateScreen()),
      ],
      debugShowCheckedModeBanner: false,
      home: HomeScreen()));
}