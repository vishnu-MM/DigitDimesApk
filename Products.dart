import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SingleProduct.dart';

void main() {
  runApp(const Products ());
}

class Products  extends StatelessWidget {
  const Products ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
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
      home: const ProductsPage(title: 'Products'),
      routes: {
        "/SingleProduct":(BuildContext context)=> new SingleProductPage(title: "SingleProduct"),

      },
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
   String ips='';

  Future<List<Category>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_product"));
    // print("------------------------------hoiiiiiii---------------");
    // print(data);
    var jsonData = json.decode(data.body);
    setState(() {
      ips=ip.toString();
    });

    // print(jsonData);
    List<Category> clist = [];
    for (var nn in jsonData["data"]) {
      Category newname =
      Category(nn["pid"].toString(),nn["description"].toString(),nn["price"].toString(), nn['product_name'].toString(),nn['photo'].toString());
      clist.add(newname);
    }
    return clist;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder(
            future: _getNames(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print("snapshot" + snapshot.toString());
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
                      onTap: () async {
                        String pid_s=snapshot.data[index].pid;
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("pid_s", pid_s);

                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new SingleProductPage(title: "SingleProduct"),
                          ),
                        );
                      },
                      onLongPress: () {
                        print("long press" + index.toString()+" "+snapshot.data[index].pid);
                      },
                      title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Text(snapshot.data[index].image),

                              Container(
                                child: Row(
                                  children: [

                                     Image(
                                      width: 100,
                                      image: NetworkImage(
                                          "http://"+ips+":5000/"+snapshot.data[index].photo),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(snapshot.data[index].product_name ,
                                            style: TextStyle(
                                              fontSize: 25,

                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 1, 5, 1),
                                            child: Text(snapshot.data[index].description,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300
                                            ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                   Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child:  Column(
                                          children: [
                                            Container(
                                              width: 75,
                                              child: Text(snapshot.data[index].price,
                                            style: TextStyle(
                                              fontSize: 20,
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
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Category {
  late final String pid;
  late final String product_name;
  late final String price;
  late final String description;
  late final String photo;

  Category(this.pid,this.description,this.price, this.product_name,this.photo);
}