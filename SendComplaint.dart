import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const SendComplaint());
}

class SendComplaint extends StatelessWidget {
  const SendComplaint({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: const SendComplaintPage(title: 'Complaint'),
    );
  }
}

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key, required this.title});



  final String title;

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  TextEditingController Complaint = TextEditingController();
complaint(String C)
async {
  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
  String uid=pref.getString("lid").toString();
  print("-----ip");
  print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_sent_complaints"),body: {"complaint":C,"user":uid});
  var jsondata = json.decode(data.body);
  print(jsondata);

  String status = jsondata['status'];
  if(status=="ok")
    {
      String lid_s=jsondata["lid"].toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("lid", lid_s);
      // Fluttertoast.showToast(
      //   msg: "Success",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.blue,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );



    }
  else
    {
      // Fluttertoast.showToast(
      //     msg: "Status is not ok",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0,
      // );
    }

}


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
        // Here we take the value from the ComplaintPage object that was created by
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
                  child: TextField( controller: Complaint, decoration: InputDecoration( hintText: 'Complaints'),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  String Complaint_v=Complaint.text;
                  complaint(Complaint_v);
                }, child: Text("Sent")),
              )
                      ],
                    ),
                  ),
              );
    // This trailing comma makes auto-formatting nicer for build method
  }
}
