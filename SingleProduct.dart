import 'dart:convert';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'Review.dart';
import 'Complaint.dart';
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
         "/Review":(BuildContext context)=> new ReviewPage(title: "Review"),
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
        body:
        ListView(
          children: [
            ListTile(
              title:Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 0, 1),
                child: Image(
                  width: 250,
                  height: 500,
                  image: NetworkImage(
                      "http://" + ips + ":5000/"+photo
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
              // ), Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: Container(
              //       width: (200.0),
              //       child:DropdownButton<String>(
              //         items: <String>['A', 'B', 'C', 'D'].map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList(),
              //         onChanged: (_) {},
              //       )
              //   ),
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
              title: Padding(
                padding: const EdgeInsets.fromLTRB(28, 1, 8, 1),
                child: Row( children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      child: Text(
                        "Reviews",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {

                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>new ReviewPage(title: "Review"),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: OutlinedButton(
                        child: Text(
                          "Complaints",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () async {

                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new ComplaintPage(title: "Complaint"),
                            ),
                          );
                        },
                      ),
                  ),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: OutlinedButton(
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {

                        },
                      ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: OutlinedButton(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {},
                      ),
                   ),
                   ],),
              ),

              ),
          ],
        )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
