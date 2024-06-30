// ignore: avoid_web_libraries_in_flutter
import 'package:chat1/constant.dart';
import 'package:chat1/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snakbar.dart';
import '../widget/custom_text_filed.dart';
import '../widget/custom_button.dart';
import 'chat_page.dart';
class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});
   static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                     Text('Scholar Chat',
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
                      'SINUP',
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
                  onChanged:(data)
                  {
                    email = data;
                  } ,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomFormTextFiled(
                  obscureText: true,
                  onChanged: (data)
                  {
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
                       setState(() {

                       });
                       try {
                         await sinupUser();
                         // ignore: use_build_context_synchronously
                         Navigator.pushNamed(context, ChatPage.id,arguments: email) ;
                       }
                       on FirebaseAuthException
                       catch (e){
                         if (e.code == 'weak-password')
                         {
                           showSnackBar(context, 'weak password');
                         } else if (e.code == 'email-already-in-use') {
                           showSnackBar(context,'email-already-in-use' );
                         }
                       }

                       catch(e){
                         showSnackBar(context, 'there was an error');
                       }
                       await Future.delayed(Duration(seconds: 3));
                       isLoading = false ;
                       setState(() {

                       });
                     }
                     else{}
                   },
                  text: 'SINUP',
                ),
                const SizedBox(
                  height: 10,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an acount?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const
                      Text(' Login',
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



  Future<void> sinupUser() async {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
