import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30,15 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.app_registration_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.person, color: Colors.white),),
                  style: TextStyle(color: Colors.white),
                  controller: name,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintText: 'Age',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.numbers, color: Colors.white),
                ),
                controller: Age,
                  style: TextStyle(color: Colors.white),

                ),
              ),


              RadioListTile(
                title: Text("Male",
                  style: TextStyle(color: Colors.white),
                ),
                selectedTileColor: Colors.lightGreenAccent,
                value: "male",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),

              RadioListTile(
                title: Text("Female",
                  style: TextStyle(color: Colors.white),),
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
                child: TextFormField(decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.location_pin, color: Colors.white),
                    hintText: 'Place'),
                  style: TextStyle(color: Colors.white),
                  controller: Place,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.location_city_sharp, color: Colors.white),
                    hintText: 'post'),
                  style: TextStyle(color: Colors.white),
                  controller: Post,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.pin, color: Colors.white),
                    hintText: 'Pin'),
                  style: TextStyle(color: Colors.white),
                  controller: Pin,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.mail, color: Colors.white),
                    hintText: 'Email'),
                  style: TextStyle(color: Colors.white),
                  controller: Email,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.phone, color: Colors.white),
                    hintText: 'Phone'),
                  style: TextStyle(color: Colors.white),
                  controller: Phone,),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.password, color: Colors.white),
                      hintText: 'Password'),
                    style: TextStyle(color: Colors.white),
                    controller: Passwrd,),
                ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.password, color: Colors.white),
                        hintText: 'Confirm Password'),
                      style: TextStyle(color: Colors.white),
                      controller: CPasswrd,),
                  ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

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
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new Login(title: "Login"),
                      ),
                    );
                    // Navigate to the sign-up page
                  },
                  child: Text(
                    'Already have an account? Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],),
          )
        ),
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
