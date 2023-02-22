import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const Review());
}

class Review extends StatelessWidget {
  const Review({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: const ReviewPage(title: 'Review'),
    );
  }
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.title});



  final String title;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController Review = TextEditingController();
 review(String R,S)
 async {
   final pref=await SharedPreferences.getInstance();
   String ip= pref.getString("ip").toString();
   String uid=pref.getString("lid").toString();
   String pid=pref.getString("pids").toString();
   print("-----ip");
   print(ip);
   var data = await http.post(Uri.parse("http://"+ip+":5000/and_sent_product_review"),body: { "review":R,"user":uid ,"rating":S , "pid":pid});
   var jsondata = json.decode(data.body);
   print(jsondata);

   String status = jsondata['status'];
   setState(() {
     Review.text='';
   });
 }

  double? _rating;
  IconData? _selectedIcon;

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
        // Here we take the value from the ReviewPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField( controller: Review, decoration: InputDecoration( hintText: 'Review'),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                String Review_v=Review.text;
                review(Review_v,_rating.toString());
              }, child: Text("Sent")),
            ),
            RatingBar.builder(
              initialRating: _rating ?? 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 50,
              itemPadding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, _) => Icon(
                _selectedIcon ?? Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {

                setState(() {
                  _rating = rating;
                });
              },
            ),
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build method
  }
}
