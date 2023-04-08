import 'package:digitdimes/ViewMyOrders.dart';
import 'package:digitdimes/ks.dart';
import 'package:flutter/material.dart';
import 'Catagory.dart';
import 'Products.dart';
import 'Profile.dart';
import 'Review.dart';
import 'Repy.dart';
import 'Complaint.dart';
import 'AddToCart.dart';
import 'CounterFiet.dart';
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
        "/AddToCart":(BuildContext context)=>new AddToCartPage(title: '',),
        "/CounterFiet":(BuildContext context)=>new CounterFietPage(title: '',),
        "/Complaint":(BuildContext context)=>ComplaintPage(title: 'Complaint'),

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
       body: Center(child: Text("Welcome")),
       // Container(
       //   margin: EdgeInsets.symmetric(vertical: 8.0),
       //   height: 400.0,
       //
       //   child: ListView(
       //     scrollDirection: Axis.horizontal,
       //     children: <Widget>[
       //       Container(
       //         width: 500.0,
       //         color: Colors.red,
       //       ),
       //       Container(
       //         width: 500.0,
       //         color: Colors.blue,
       //       ),
       //       Container(
       //         width: 500.0,
       //         color: Colors.green,
       //       ),
       //       Container(
       //         width: 500.0,
       //         color: Colors.yellow,
       //       ),
       //       Container(
       //         width: 500.0,
       //         color: Colors.orange,
       //       ),
       //     ],
       //   ),
       // ),
      // GridView.count(
      //   // Create a grid with 2 columns. If you change the scrollDirection to
      //   // horizontal, this produces 2 rows.
      //   crossAxisCount: 2,
      //   // Generate 100 widgets that display their index in the List.
      //   children: List.generate(100, (index) {
      //     return Center(
      //       child: Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Image.network("https://previews.123rf.com/images/aquir/aquir1307/aquir130700225/21083720-pending-stamp.jpg",
      //             height: 150,
      //               width: 150,
      //             ),
      //           ),
      //           Text(
      //             'Item $index',
      //             style: Theme.of(context).textTheme.headlineSmall,
      //           ),
      //         ],
      //       ),
      //     );
      //   }),
      // ),
      // Center(
      //   child: Text("User Home page"),
      // ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(" Digit Dimes",
                  style: TextStyle(
                      fontSize: 50,
                    color:  Colors.teal.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                  ),

                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white ,
                image: DecorationImage(fit: BoxFit.fitWidth,
                    image: NetworkImage("https://p0.pikist.com/photos/467/245/shopping-keyboard-enter-button-shopping-cart-shop-online-web-www.jpg")),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.photo_camera_rounded,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Scan Product",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CounFeit(),
                ),
              );
            },),

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
                  builder: (context) => new CatagoryPage(title: "Category"),
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
                    Icons.shopping_cart_outlined,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My cart",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>new AddToCartPage(title: '',),
                ),
              );
            },),

            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("My Orders",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ViewMyOrders(),
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
                    child: Text("My Profile",
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
                    Icons.comments_disabled_outlined,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Complaint ",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new ComplaintPage(title: 'Complaint'),
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


          ],
        ),
      ),
    );
  }
}
