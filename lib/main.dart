import 'package:chat1/pages/chat_page.dart';
import 'package:chat1/pages/login_page.dart';
import 'package:chat1/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(ScholarChat());
}
class ScholarChat  extends StatelessWidget {
  const ScholarChat ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id : (context) => LoginPage(),
        RegisterPage.id : (context) =>RegisterPage(),
        ChatPage.id : (context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }

}

