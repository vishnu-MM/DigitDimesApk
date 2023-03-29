import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'review.dart';
import 'Complaint.dart';
import 'Purchase.dart';
import 'AddToCart.dart';
// import 'EditSingleProduct.dart';
void main() {
  runApp(const SingleProduct());
}

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: const SingleProductPage(title: ''),
      routes: {
         "/Complaint":(BuildContext context)=> new ComplaintPage(title: "Complaint"),
         "/review_":(BuildContext context)=> new ReviewPage(title: "review"),
         "/Purchase":(BuildContext context)=> new PurchasePage(title: "Purchase"),
         "/AddToCart":(BuildContext context)=> new AddToCartPage(title: "AddToCart"),
      },
    );
  }
}

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key, required this.title});

  final String title;

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {


  _SingleProductPageState(){
    viewSingleProduct();
  }


  String Name='';
  String Price='';
  String description='';
  String photo='';
  String ips='';
  String pids='';
  Int? rat;




  viewSingleProduct() async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String pid= pref.getString("pid_s").toString();

    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_View_SingleProduct_post"),body: { "pid":pid });
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {
      setState(() {
        Name=jsondata["Name"].toString();
        Price=jsondata["Price"].toString();
        description=jsondata["description"].toString();
        photo=jsondata["photo"].toString();
        ips=ip.toString();
      });
    }
  }
  //review_
  Future<List<Category>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String pid= pref.getString("pid_s").toString();

    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_product_review"),body: { "pid":pid });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<Category> clist = [];
    for (var nn in jsonData["data"]) {
      Category newname =
      Category(nn["review_id"].toString(), nn['review'].toString(), nn['naame'].toString(), nn['date'].toString(), nn['rating'].toString());
      clist.add(newname);
    }
    return clist;
  }
  //Add to cart
  addToCart()
  async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    print("Add to cart :  "+uid);
    String pid=pref.getString("pid_s").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/and_add_to_cart"),body: { "uid":uid , "pid":pid});
    var jsondata = json.decode(data.body);
    print(jsondata);
    String status = jsondata['status'];
  }



  IconData? _selectedIcon;
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
          // Here we take the value from the SingleProductPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Stack(
          alignment: Alignment.center,
          children:[
            Container(
              height:MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              child:SingleChildScrollView(
                child: Column(
                  children: [
                        ListTile(
                          title:Padding(
                            padding: const EdgeInsets.fromLTRB(1, 1, 0, 1),
                            child: Image(
                              width: 250,
                              height: 500,
                              image: NetworkImage(
                                  "http://"+ ips +":5000/"+photo
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            child:Container(
                              child: Text(Name,
                                style: TextStyle(
                                  fontSize: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Row(children: [Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                                width: (90.0),
                                child:Text(Price,
                                  style: TextStyle(
                                      fontSize: 22
                                  ),
                                )),
                          ),],),
                        ),
                        ListTile(
                          title: Row(children: [Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: (250),
                                child:Text(description)),
                          ), Padding(
                            padding: const EdgeInsets.all(8.0),
                          )],),
                        ),
                    ListTile(
                          title: Row(children: [Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: (250),
                                child:Text("Reviews",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.teal
                                )
                                ),
                            ),
                          ), Padding(
                            padding: const EdgeInsets.all(8.0),
                          )],),
                        ),


                    FutureBuilder(
                          future: _getNames(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            print("snapshot" + snapshot.toString());
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                  child: Text("Loading..."),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                // padding: EdgeInsets.all(5.0),
                                // shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: ()  {
                                    },
                                    onLongPress: () {
                                      print("long press" + index.toString());
                                    },
                                    title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: Text(snapshot.data[index].naame,
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w400
                                                                ),
                                                              ),
                                                            ), Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: Text(snapshot.data[index].date,
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ), Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text(snapshot.data[index].review,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        RatingBar.builder(
                                                          initialRating: double.parse(snapshot.data[index].rating) ,
                                                          minRating: double.parse(snapshot.data[index].rating),
                                                          // maxRating:double.parse(snapshot.data[index].rating) ,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                          itemBuilder: (context, _) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (double value) {},
                                                        ),


                                                        Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Text("  ",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              );
                            }
                          }),
                    SizedBox(height: 20),
                    OutlinedButton(onPressed: () async {
                      String pid_1= pid.toString();
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString("pid_1", pid_1);

                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ReviewPage(title: "review"),
                        ),
                      );

                    },
                        child: Container(
                          width: 200,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Share Your Review",
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),style: OutlinedButton.styleFrom(

                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(30),
                        ),
                        // elevation: 1,
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(" ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                  // Provide Your Widget here
                ),
              ),
            ),


            Positioned(
              // bottom:0,
              child:Align(
                alignment:Alignment.bottomRight,
                child:Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(3, 0, 1, 0),
                         child: SizedBox(
                           height: 50,
                           width: MediaQuery.of(context).size.width*0.49,
                           child: Container(
                             child: ElevatedButton(
                               onPressed: () {
                                 addToCart();
                                 Navigator.push(
                                   context,
                                   new MaterialPageRoute(
                                     builder: (context) => new AddToCartPage(title: "AddToCart"),
                                   ),
                                 );
                                 // Add your button press logic here
                               },
                               style: ElevatedButton.styleFrom(
                                 primary: Colors.green, // Set button
                                 shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),// color
                                 padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
                               ),
                               child: Text(
                                 "Add to cart",
                                 style: TextStyle(
                                   color: Colors.black87, // Set text color
                                   fontSize: 18.0,
                                   fontWeight: FontWeight.bold// Set text size
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 50,
                         width: MediaQuery.of(context).size.width*0.48,
                         child: Container(
                           child: ElevatedButton(
                             onPressed: () {
                               Navigator.push(
                                 context,
                                 new MaterialPageRoute(
                                   builder: (context) => new PurchasePage(title: "Purchase"),
                                 ),
                               );
                             },
                             style: ElevatedButton.styleFrom(
                               primary: Colors.orange, // Set button
                               shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),// color
                               padding: EdgeInsets.symmetric(vertical: 16.0), // Set vertical padding
                             ),
                             child: Text(
                               "Buy Now",
                               style: TextStyle(
                                 color: Colors.black87, // Set text color
                                 fontSize: 18.0,
                                 fontWeight: FontWeight.bold// Set text size
                               ),
                             ),
                           ),
                         ),
                       ),
                    ],
                  ),
                ),

              ),
            ),
          ],
        ),
    );
  }
}

class Category {
  late final String review_id;
  late final String review;
  late final String naame ;
  late final String date ;
  late final String rating ;

  Category(this.review_id, this.review, this.naame, this.date, this.rating);
}
