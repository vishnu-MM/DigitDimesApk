import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      home: const Payment(title: 'Digit Dimes'),
      routes: {
        "/StaffHome":(BuildContext context)=> new StaffHome(),
        "/UserHome":(BuildContext context)=> new UserHomePage(title: "Home"),
      },
    );
  }
}

class Payment extends StatefulWidget {
  const Payment({super.key, required this.title});



  final String title;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController edAccNo = TextEditingController();
  TextEditingController edPriKey = TextEditingController();
  TextEditingController edAmount = TextEditingController();
  Future<void> Payment(String u,String p)
  async {


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
            SizedBox(height: 20),
            Text(
              'Pay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Amount',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                controller: edAmount,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'AccNo',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                controller: edAccNo,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Private Key',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
                controller:edPriKey ,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async{
                String accno=edAccNo.text;
                String prikey=edPriKey.text;
                String amount=edAmount.text;
                final pref=await SharedPreferences.getInstance();
                // String ip = "192.168.29.66";
                String ip= pref.getString("ip").toString();
                String qty= pref.getString("pqty").toString();
                String lid= pref.getString("lid").toString();
                String pid= pref.getString("pid_s").toString();
                print("-----ip");
                print(ip);
                var data = await http.post(Uri.parse("http://"+ip+":5000/and_make_payment_one"),body: {"accno":accno,"prikey":prikey,"amount":amount,'qty':qty,'lid':lid,'pid':pid});
                var jsondata = json.decode(data.body);
                print(jsondata);

                String status = jsondata['status'];
                if(status=="ok")
                {
                  final prefs = await SharedPreferences.getInstance();
                  String lid = prefs.getString("lid").toString();

                  // Navigator.pushNamed(context, "/UserHome");
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new UserHomePage(title: "User Home"),
                    ),
                  );
                }
                else
                {
                  print("Tost");
                  Fluttertoast.showToast(msg: 'Insufficient balance');
                }
              },
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
