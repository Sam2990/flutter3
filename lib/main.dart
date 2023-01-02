import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myapp());
}

final emaillogin = TextEditingController();
final passwordlogin = TextEditingController();

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  final emaillogin = TextEditingController();
  final passwordlogin = TextEditingController();

  void dispose(){
    emaillogin.dispose();
    passwordlogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.white60,
        appBar: AppBar(title: Text('Login'),
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
                      controller: emaillogin,
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
                        controller: passwordlogin,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){}, child: Text('Forgot Password',style: TextStyle(
                          fontSize: 12,color: Colors.blueGrey,
                        ),))

                      ],
                    ),
                    Container(
                        width: 400,
                        height: 48,
                        child: Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: ()async{
                                try{
                                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(

                                      email: emaillogin.text.trim(),
                                      password: passwordlogin.text.trim(),
                                  );  print(emaillogin.toString());
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>home()));
                                } on FirebaseAuthException catch(e){
                                  if(e.code=='user-not-found'){
                                    const snackBar = SnackBar(
                                      content: Text('user-not-found'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }else if(e.code == 'wrong-password'){
                                    const snackBar = SnackBar(
                                      content: Text('wrong-password'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                            },
                              child: Text('Login'),);
                          }
                        )

                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                            child: Text('Have no Account?',style: TextStyle(color: Colors.blueGrey),)),
                        Spacer(),
                        SizedBox(
                          height: 32,
                          child: Builder(
                            builder: (context) {
                              return TextButton(onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const signin()),
                                );
                              }, child: Text('Sign up'));
                            }
                          ),
                        )
                      ],
                    )
                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
