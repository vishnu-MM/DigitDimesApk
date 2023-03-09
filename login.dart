import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      debugShowCheckedModeBanner: false,
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
        print("Tost");
      }
    }
    else
    {
      print("Tost");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_rounded,
              size: 70,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                controller: UserName,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller:Passwrd ,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                String UserName_v=UserName.text;
                String Passwrd_v=Passwrd.text;
                Login(UserName_v,Passwrd_v);
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
                primary: Colors.purple,
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
                    builder: (context) => new SignUpPage(title: "Signup"),
                  ),
                );
                // Navigate to the sign-up page
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
