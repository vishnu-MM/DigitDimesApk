import 'package:flutter/material.dart';
import 'Catagory.dart';
import 'Products.dart';
import 'Profile.dart';
import 'Review.dart';
import 'Repy.dart';
import 'Complaint.dart';

void main() {
  runApp(const Home_user());
}

class Home_user extends StatelessWidget {
  const Home_user({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
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
        primarySwatch: Colors.teal,
      ),
      home: const UserHomePage(title: 'Home'),
      routes: {
        "/ViewCatagory":(BuildContext context)=> new CatagoryPage(title: 'Catagory',),
        "/ViewProduct":(BuildContext context)=>new ProductsPage(title: ''),
        "/ViewProfile":(BuildContext context)=>new ProfilePage(title: '',),
        "/ViewReview":(BuildContext context)=>new ReviewPage(title: '',),
        "/ViewReply":(BuildContext context)=>new ReplyPage(title: '',),
        "/Viewcomplaints":(BuildContext context)=>new ComplaintPage(title: '',),

      },
    );
  }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

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

        // Here we take the value from the UserHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Digit Dimes"),
      ),
      body: Center(
        child: Text("User Home page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(" Digit Dimes",
                  style: TextStyle(
                      fontSize: 50,
                    color:  Colors.white54,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal ,
                // image: DecorationImage(fit: BoxFit.scaleDown, image: MemoryImage(),),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.category,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Category",style: TextStyle(
                        fontSize: 18
                    ),
                    ),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CatagoryPage(title: "Catagory"),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.phone_android,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Products",
                    style: TextStyle(
                      fontSize: 18
                    ),
                    ),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ProductsPage(title: "Product"),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Profile",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ProfilePage(title: "Profile"),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                  Icons.star,
                  color: Colors.teal,
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Review",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ReviewPage(title: "Review"),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Reply",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ReplyPage(title: "Reply"),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Complaints",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ComplaintPage(title: "Complaints"),
                ),
              );
            },),


          ],
        ),

      ),
    );
  }
}
