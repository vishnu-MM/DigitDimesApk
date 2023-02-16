import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Signup());
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const SignUpPage(title: 'Sign Up'),
      routes: {
        "/Login":(BuildContext context)=> new Login(title: "Login"),
        "/IpPage":(BuildContext context)=> new MyHomePage(title: "IpPage"),
      },
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


 TextEditingController name = TextEditingController();
 var Gender ;
 TextEditingController Age = TextEditingController();
 TextEditingController Place = TextEditingController();
 TextEditingController Post = TextEditingController();
 TextEditingController Pin = TextEditingController();
 TextEditingController Email = TextEditingController();
 TextEditingController Phone = TextEditingController();
 TextEditingController Passwrd = TextEditingController();
 TextEditingController CPasswrd = TextEditingController();



Future<void> Signup(String name_v,String Gender_v,String Age_v,String Place_v,String Post_v,String Pin_v,String Email_v,String Phone_v,String Passwrd_v,String CPasswrd_v)
async {
  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
  print("-----ip");
  print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_signup_post"),body: {
    "name":name_v,"age":Age_v,"gender":Gender_v,"place":Place_v,"post":Post_v,"pin":Pin_v,"phone":Phone_v,"email":Email_v,"passwd":Passwrd_v });
  var jsondata = json.decode(data.body);
  print(jsondata);

  String status = jsondata['status'];
  if(status=="ok")
    {
      Navigator.pushNamed(context, "/Login" );
    }
  else
  {
   Navigator.pushNamed(context, "/IpPage") ;
  }
}


String? gender;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been
    // optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SignUpPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30,15 ),
          child: Column(children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Name'),
              controller: name,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Age'),
              controller: Age,),
            ),


            RadioListTile(
              title: Text("Male"),
              value: "male",
              groupValue: gender,
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            ),

            RadioListTile(
              title: Text("Female"),
              value: "female",
              groupValue: gender,
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            ),





            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Place'),
              controller: Place,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'post'),
              controller: Post,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Pin'),
              controller: Pin,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Email'),
              controller: Email,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(hintText: 'Phone'),
              controller: Phone,),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(hintText: 'Password'),
                controller: Passwrd,),
              ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Confirm Password'),
                  controller: CPasswrd,),
                ),                                                                          

            Padding(padding: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){

                  String Passwrd_v=Passwrd.text;
                  String CPasswrd_v=CPasswrd.text;
                  if(CPasswrd_v==Passwrd_v)
                    {
                      String name_v=name.text;

                      String Gender_v=gender!;
                      String Age_v=Age.text;
                      String Place_v=Place.text;
                      String Post_v=Post.text;
                      String Pin_v=Pin.text;
                      String Email_v=Email.text;
                      String Phone_v=Phone.text;
                  Signup(name_v,Gender_v,Age_v,Place_v,Post_v,Pin_v,Email_v,Phone_v,Passwrd_v,CPasswrd_v);
                }
                  else{
                    Fluttertoast.showToast(
                        msg: "PAsswords Missmatch",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                }, child: Text("Sign in"),),
              ),

          ],),
        )
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
