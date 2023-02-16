import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'EditProfile.dart';
void main() {
  runApp(const Profile());
}

class Profile extends StatelessWidget {
  const Profile({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: const ProfilePage(title: 'Profile'),
      routes: {
        "/EditProfile":(BuildContext context)=> new EditProfilePage(title: "Edit Profile"),
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  _ProfilePageState(){
    viewProfile();
  }
String Name='';
String Age='';
String Gender='';
String Place='';
String Post='';
String Pin='';
String Email='';
String Phone='';

viewProfile()
async {
  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
  String uid=pref.getString("lid").toString();
  print("-----ip");
  print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_View_Profile_post"),body: { "lid":uid });
  var jsondata = json.decode(data.body);
  print(jsondata);

  String status = jsondata['status'];
  if(status=="ok")
    {

      setState(() {
        Name=jsondata["Name"].toString();
        Age=jsondata["Age"].toString();
        Gender=jsondata["Gender"].toString();
        Place=jsondata["Place"].toString();
        Post=jsondata["Post"].toString();
        Pin=jsondata["Pin"].toString();
        Email=jsondata["Email"].toString();
        Phone=jsondata["Phone"].toString();
      });



    }
  else{
    Fluttertoast.showToast(
        msg: "Status is not ok",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  }
}





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
          // Here we take the value from the ProfilePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:
        ListView(

          children: [
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: (90.0),
                    child:Text("Name")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Name),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
    child: SizedBox(
    width: (90.0),
    child:Text("Age")),
    ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Age),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Gender")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Gender),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Place")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Place),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Post")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Post),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Pin")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Pin),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                  padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Email")),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Email),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: (90.0),
                    child:Text("Phone")),
              ),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Phone),
              )],),
              
            ),
            ListTile(
              title: Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new EditProfilePage(title: "EditProfile"),
                    ),
                  );
                }, child: Text("Edit"),),
              ),
            )
          ],
        )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
