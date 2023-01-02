import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'main.dart';

final emailsingup = TextEditingController();
final passwordsignup = TextEditingController();
class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up'),
      backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 40.0),
                height: 220,
                width: 4000,
                alignment: Alignment.center,
                child: SizedBox(
                  width: 180,
                  height: 220,
                  child: Card(
                    child: Image(image: AssetImage('assets/icons8-avatar-48.png')),
                    color: Colors.blue[400],
                    elevation: 4,
                  ),
                )


            ),
            Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 50,bottom: 4),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: emailsingup,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText:'Enter your email',
                        labelText: 'Email Address',

                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: passwordsignup,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText:'Enter Password',
                          labelText: 'Password',

                        )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Container(
                        width: 400,
                        height: 48,
                        child: ElevatedButton  (
                          onPressed: ()async{
                          try{
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email : emailsingup.text.trim(),
                                password: passwordsignup.text.trim(),
                            );
                            Navigator.of(context).pop(context);

                          }on FirebaseAuthException catch(e){
                              if(e.code == 'week-password'){
                                const snackBar = SnackBar(
                                  content: Text('week-password'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else if(e.code == 'email-already-in-use'){
                                const snackBar = SnackBar(
                                  content: Text('email-already-in-use'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              }
                          }catch(e){
                            const snackBar = SnackBar(
                              content: Text('something gone wrong try  again with other email and(or) password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                        },
                          child: Text('Sign-Up'),)

                    ),
                  ),

                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
