    import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Sign Up.dart';
import 'staffHomePage.dart';
import 'HomePage.dart';
import 'main.dart';
  import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: const Login(title: 'Digit Dimes'),
      routes: {
        "/Signup":(BuildContext context)=> new SignUpPage(title: "Signup"),
        "/StaffHome":(BuildContext context)=> new StaffHome(),
        "/UserHome":(BuildContext context)=> new UserHomePage(title: "Home"),
        "/ipPage":(BuildContext context)=> new MyApp_IP(),
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});



  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController UserName = TextEditingController();
  TextEditingController Passwrd = TextEditingController();
Future<void> Login(String u,String p)
async {

  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
print("-----ip");
print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_Login_post"),body: {"name":u,"passwd":p});
  var jsondata = json.decode(data.body);
  print(jsondata);

  String status = jsondata['status'];
  if(status=="ok")
    {
      String type = jsondata['type'];
      String lid_s=jsondata["lid"].toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("lid", lid_s);

      if(type=="user")
        {
          // Navigator.pushNamed(context, "/UserHome");
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new UserHomePage(title: "User Home"),
            ),
          );
        }
      else if(type=="staff")
        {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new StaffHomePage(title: "Staff Home"),
            ),
          );
        }
      else
        {
          // Fluttertoast.showToast(
          //     msg: "Invalid username or Password",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
        }
    }
  else
      {
        // Fluttertoast.showToast(
        //     msg: "Invalid username or Password",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
      }
    }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Login object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 250, 15,1 ),
            child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40,0, 40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(decoration: InputDecoration(hintText: 'User Name'),
                    controller: UserName,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(decoration: InputDecoration(hintText: 'Password'),
                    controller: Passwrd,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(onPressed: () async {
                      String UserName_v=UserName.text;
                      String Passwrd_v=Passwrd.text;
                      Login(UserName_v,Passwrd_v);


                    }, child: Text("Login")),
                  ),

                ],
              ),
              ),
            ),
        ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
                child: ElevatedButton(onPressed: (){  Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new SignUpPage(title: "Signup"),
                  ),
                );}, child: Text("SignUp")),
              ),
        ],
          ),
          ),
      ),

    );
    // This trailing comma makes auto-formatting nicer for build method
  }
}
