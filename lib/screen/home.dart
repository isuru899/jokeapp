import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/screen/note.dart';

// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get('https://official-joke-api.appspot.com/random_joke');

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final String id;
//   final String title;

//   Album({this.userId, this.id, this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['id'],
//       id: json['type'],
//       title: json['setup'],
//     );
//   }
// }


class MyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<Album> futureAlbum;

  // @override
  // void initState() {
  //   super.initState();
  //   futureAlbum = fetchAlbum();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Fetch Data Example',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Fetch Data Example'),
  //       ),
  //       body: Center(
  //         child: FutureBuilder<Album>(
  //           future: futureAlbum,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               // return Text(snapshot.data.title);
  //                   var items = List<String>.generate(10, (index) => '$index');

  //               return ListView.builder(
  //                 itemCount: 10,
  //                 itemBuilder: (context, index){
  //                   return ListTile(
  //                     title: Text('${snapshot.data[index].name}'),
  //                   // title: Text(snapshot.data[index].name),
  //                   );
  //                 },
  //               );
  //             } else if (snapshot.hasError) {
  //               return Text("${snapshot.error}");
  //             }

  //             // By default, show a loading spinner.
  //             return CircularProgressIndicator();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  List<Note> _notes = List<Note>();
    // List<Note> _filter = List<Note>();
      List<Note> filteredUsers = List();



  Future<List<Note>> fetchNotes() async {
    var url = 'https://official-joke-api.appspot.com/jokes/ten';
    var response = await http.get(url);
    
    var notes = List<Note>();
    
    
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        filteredUsers.addAll(value);

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Daily Joks'),
      ),
      body: 
      Column(
        children: [
 
 // in the build method above list
 TextField(
  decoration:   InputDecoration(
    contentPadding: EdgeInsets.all(15.0),
    hintText: 'Filter Jok by type',
  ),
  onChanged: (string) {
      setState(() {
        _notes = filteredUsers
            .where((u) => (u.type
                    .toLowerCase()
                    .contains(string.toLowerCase()) ||
                u.type.toLowerCase().contains(string.toLowerCase())))
            .toList();


      });
      
    
  },
),
          Expanded(
                  child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _notes[index].title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            _notes[index].text,
                            style: TextStyle(
                              color: Colors.grey.shade600
                            ),
                          ),
                           Text(
                            _notes[index].type,
                            style: TextStyle(
                              color: Colors.grey.shade600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: _notes.length,
            ),
            
          ),
 
          
        ],
      )
    );
  }

}
