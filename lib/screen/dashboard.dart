import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://official-joke-api.appspot.com/jokes/ten');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final String id;
  final String title;
  final String punchline;

  Album({this.userId, this.id, this.title, this.punchline});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['id'],
      id: json['type'],
      title: json['setup'],
      punchline: json['punchline'],
    );
  }
}
class Dashboard extends StatefulWidget {
    Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    Future<Album> futureAlbum;

@override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Joke"),
      ),

      
      body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var items = List<String>.generate(10, (index) => '$index');

              
                // return Text(snapshot.data.title);
                // print(snapshot.data[1]['title']);
                  return Expanded(
                   child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 12,
                      offset: Offset(0,6)
                    )
                  ]

                ),
              )
            ,
            Positioned.fill(
                          child: Row(
                children: [
                  Expanded(
                                      child: Image.asset('assets/images/joke.png',
                    height: 100,
                    width: 100,),
                  flex: 2,
                  ),
                  
                Expanded(
                  flex: 4,
                                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    
                    children: [
                      Text(snapshot.data.title,
                      style: TextStyle(
                        
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                      
                      ),
                      SizedBox(height: 7,),
                      Text(snapshot.data.id,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                                            SizedBox(height: 7,),

                      Text(snapshot.data.punchline,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                      ),
                    ],
                  ),
                )
                ],
              ),
            )
            ],
          ),
        ),
                );
              } else if (snapshot.hasError) {
                // return Text("${snapshot.error}");
                print("${snapshot.error}");

              
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}
