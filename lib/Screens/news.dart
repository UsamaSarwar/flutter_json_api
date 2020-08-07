// Imported Packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // URL of the API
  final String url =
      "http://ninanews.com/NinaNewsService/api/values/GetLastXBreakingNews?rowsToReturn=10";
  List news;

  // Setting App Initial State
  @override
  void initState() {
    super.initState();
    this.getNEWS();
  }

  // Function to get NEWS from API
  Future<String> getNEWS() async {
    // Getting API Response and filtering JSON only
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    // print(response.body); //// Just to make sure the connection

    // Updating the App State when getting Data from API
    setState(() {
      var newsJson = json.decode(response.body);
      news = newsJson['Data'];
    });

    // Returning a success message
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Setting App Bar
      appBar: AppBar(
        // Gradient Color in App Bar
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.red.shade600,
                Colors.red.shade900,
              ])),
        ),
        elevation: 5.0,
        // Refresh Button of the Page to get Latest NEWS
        leading: SizedBox(
          width: 60.0,
          child: InkWell(
              splashColor: Colors.white,
              // onTap: () => this.getNEWS(),
              onTap: () => runApp(App()),
              child: Icon(
                Icons.web,
              )),
        ),
        // LOGO of the NEWS Paper
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset('assets/Logo.png'),
          ),
        ],
        // Text of the App Bar
        title: Column(
          children: <Widget>[
            Text(
              'الوكالة الوطنية العراقية للأنباء',
              textDirection: TextDirection.rtl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Developer Credits
                Icon(Icons.developer_mode,size: 8.0,),
                Text(
                  'Developed by @csUsamaSarwar',
                  style: TextStyle(
                    fontSize: 8.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),

      // Setting News Content
      body: ListView.builder(
        // Checking/Setting Number of NEWS count
        itemCount: news == null ? 0 : news.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: ListTile(
                  onTap: () => null,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Setting NEWS Date
                      Card(
                        elevation: 8.0,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                Colors.red.shade600,
                                Colors.red.shade900,
                              ])),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                news[index]['Khabar_Date']
                                    .toString()
                                    .substring(0, 10),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),

                      // Setting NEWS Image
                      Card(
                        elevation: 6.0,
                        child: Image.network(
                          news[index]['Pic'],
                          fit: BoxFit.fitWidth,
                          // scale: 100.0,
                        ),
                      ),

                      // Setting NEWS Title
                      Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news[index]['Khabar_Title'],
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Setting NEWS Details
                      Card(
                        elevation: 4.0,
                        child: ListTile(
                          title: Text(
                            news[index]['Khabar_Details'],
                            textDirection: TextDirection.rtl,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
