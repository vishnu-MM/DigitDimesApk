import 'dart:convert';
import 'Purchase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;





class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

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
      home: const AddToCartPage(title: 'Add To Cart'),
      routes: {
        "/Purchase":(BuildContext context)=> new PurchasePage(title: " "),

      },
    );
  }
}

Future<List<Cart>> _getNames() async {
  final pref = await SharedPreferences.getInstance();
  String ip = pref.getString("ip").toString();
  String uid=pref.getString("lid").toString();
  print("view cart: "+uid);
  var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_add_to_cart"),body: { "uid":uid });
  print("------------------------------hoiiiiiii---------------");
  print(data);
  var jsonData = json.decode(data.body);

  print(jsonData);
  List<Cart> clist = [];
  for (var nn in jsonData["data"]) {
    Cart newname =
    Cart( nn['cart_id'].toString(),nn['qty'].toString(),nn['pid'].toString(),nn['product_name'].toString(),nn['price'].toString(),nn['photo'].toString(),);
    clist.add(newname);
  }
  return clist;
}


//remove from cart
String pid_v='';
Remove(String pid) async {
  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
  String uid=pref.getString("lid").toString();
  // String pid=pref.getString("pid_s").toString();
  print("-----ip");
  print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_remove_cart"),body: {"uid":uid,"pid":pid});
  var jsondata = json.decode(data.body);
  print(jsondata);
  String status = jsondata['status'];
}



class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
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

        // Here we take the value from the AddToCartPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("My cart"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
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
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.all(5.0),
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onLongPress: () {
                          print("long press" + index.toString());
                        },
                        title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Table( children:[
                                  TableRow(
                                    children:[ Text("Product:", style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),
                                      Text(snapshot.data[index].product_name),
                                  ]),
                                ]
                                ),
                                Row(
                                  children: [
                                    Padding(padding: const EdgeInsets.all(8.0),
                                      child:
                                      Text("Price :", style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                    Padding(padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data[index].price),
                                    ),
                                  ],
                                ),
                                Row(
                                    children: [
                                      Padding(padding: const EdgeInsets.all(8.0),
                                        child: Text("Quantity :", style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                      Padding(padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot.data[index].qty),
                                      ),
                                    ]),
                                Row(children: [
                                  Padding(padding: const EdgeInsets.all(8.0),
                                    child: ButtonBar(children: [Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OutlinedButton(onPressed: (){
                                              Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) => new PurchasePage(title: " "),
                                                ),
                                              );
                                            }, child: Text("Buy Now",
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: OutlinedButton(onPressed: (){
                                              pid_v=snapshot.data[index].pid;
                                              Remove(pid_v);
                                            }, child: Text("Remove",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                            ),
                                          )
                                        ])
                                    ]),
                                  )
                                ],)

                              ],
                            ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),

    );
  }
}
class Cart{
  late final String cart_id;
  late final String qty;
  late final String pid;
  late final String product_name;
  late final String price;
  late final String photo;
  Cart(this.cart_id,this.qty,this.pid,this.product_name,this.price,this.photo);
}
