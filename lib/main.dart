import 'package:ashwinkart/Screens/registration_Screen.dart';
import 'package:ashwinkart/Screens/shopping_screen.dart';
import 'package:flutter/material.dart';
import 'package:ashwinkart/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ashwinkart/Screens/login_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ashwinkart/Screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:ashwinkart/Controllers/cartController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ashwinkart());
}

class ashwinkart extends StatelessWidget {
  const ashwinkart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => cartController(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          shoppingScreen.id: (context) => shoppingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          cartScreen.id: (context) => cartScreen(),
        },
      ),
    );
  }
}
