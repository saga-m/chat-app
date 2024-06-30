import 'dart:math';
import 'package:chat1/constant.dart';
import 'package:chat1/pages/register_page.dart';
import 'package:chat1/widget/custom_text_filed.dart';
import 'package:chat1/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snakbar.dart';
import 'chat_page.dart';

class LoginPage  extends StatefulWidget {
  static String id ='login page';
  @override
  State<LoginPage> createState() => _LoginPageStateState();

}

class _LoginPageStateState extends State<LoginPage> {

  String? email;

  String? password;

  GlobalKey<FormState> formKey =GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75,),
                Image.asset('assets/images/meetme.png',
                height: 100,
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text
                       ('Scholar Chat',
                style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                ),
                ),
                   ],
                 ),
                SizedBox(height: 75,),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
            const SizedBox(
              height: 20,
            ),
                CustomFormTextFiled(
                  onChanged: (data){
                    email = data;
                  },
                  hintText: 'Email',
                ),
            const SizedBox(
              height: 16,
            ),
                CustomFormTextFiled(
                  obscureText: true,
                  onChanged: (data){
                    password = data;
                  },
                  hintText: 'Password',
                ),
            const SizedBox(
              height: 24,
            ),
                 CustomButton(
                   onTap: () async
                   {
                     if (formKey.currentState!.validate()) {
                       isLoading = true;
                       setState(() { });
                       try {
                         await loginUser();
                         // ignore: use_build_context_synchronously
                         Navigator.pushNamed(context, ChatPage.id , arguments: email);
                       }
                       on FirebaseAuthException
                       catch (e){
                         if (e.code == 'user-not-found')
                         {
                           showSnackBar(context, 'No user found for the email');
                         } else if (e.code == 'wrong-password') {
                           showSnackBar(context,'Wrong password' );
                         }
                       }

                       catch(e){
                         print(e);
                         showSnackBar(context, 'there was an error');
                       }
                       // await Future.delayed(Duration(seconds: 3));
                       isLoading = false ;
                       setState(() {

                       });
                     }
                     else{}
                   },
                  text: 'LOGIN',
                ),
            const SizedBox(
              height: 10,
            ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an acount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text
                        ('  Register',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}




