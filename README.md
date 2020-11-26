[![Usama Sarwar](https://img.shields.io/badge/Portfolio-Usama_Sarwar-000000?logo=opsgenie&logoColor=ffffff)](https://csusamasarwar.github.io) [![Usama Sarwar](https://img.shields.io/badge/Github-211F1F?logo=GitHub&logoColor=ffffff)](https://github.com/usamasarwar/) [![Usama Sarwar](https://img.shields.io/badge/Subscribe-FF0000?logo=Youtube&logoColor=ffffff)](https://www.youtube.com/UsamaSarwar?sub_confirmation=1) [![Usama Sarwar](https://img.shields.io/badge/Connect-0077B5?logo=Linkedin&logoColor=ffffff)](https://www.linkedin.com/in/UsamaSarwarOfficial/)  [![Usama Sarwar](https://img.shields.io/badge/Follow-1877F2?logo=Facebook&logoColor=ffffff)](https://www.facebook.com/UsamaSarwarOfficial/)  [![Usama Sarwar](https://img.shields.io/badge/Follow-08A0E9?logo=Twitter&logoColor=ffffff)](https://www.twitter.com/UsamaSarwarPro/)  [![Usama Sarwar](https://img.shields.io/badge/Follow-DD2A7B?logo=Instagram&logoColor=ffffff)](https://www.instagram.com/UsamaSarwarOfficial/) [![Usama Sarwar](https://img.shields.io/badge/Gmail-D44638?logo=gmail&logoColor=ffffff)](mailto:UsamaSarwarOfficial@gmail.com) [![Usama Sarwar](https://img.shields.io/badge/Chat-1877F2?logo=Messenger&logoColor=ffffff)](https://m.me/UsamaSarwarOfficial/) [![Usama Sarwar](https://img.shields.io/badge/Chat-25D366?logo=WhatsApp&logoColor=ffffff)](https://wa.me/923100007773?text=%23Github) [![Usama Sarwar](https://img.shields.io/badge/Support_Me-784fff?logo=buy-me-a-coffee&logoColor=ffffff)](https://wa.me/923100007773?text=Thank%20you%20for%20supporting%20me%20%E2%9D%A4%0ABank%20Account%20Details%0ATitle%3A%20USAMA%20SARWAR%0AIBAN%3A%20PK90HABB0022417901576303)

![Flutter](https://i.imgur.com/tq2qQaH.jpg)

# Flutter get JSON Data from API
Fetching data from the internet is necessary for most apps. In this project JSON data is fetched from an API. In this way we made a simple app that shows NEWS directly from the website. Luckily, Dart and Flutter provide tools, such as the  `http`  package, for this type of work.

This recipe uses the following steps:

1.  Add the  `http`  package.
2.  Make a network request using the  `http`  package.
3.  Convert the response into a custom Dart object.
4.  Fetch and display the data with Flutter.

## Screenshoot
![Flutter](https://i.imgur.com/hiAeeWY.png)

# Simple Steps to follow

## 1. Add the  `http`  package

The  [`http`](https://pub.dev/packages/http)  package provides the simplest way to fetch data from the internet.

To install the  `http`  package, add it to the dependencies section of the  `pubspec.yaml`  file. You can find the latest version of the  [`http`  package](https://pub.dev/packages/http#-installing-tab-)  the pub.dev.


```
dependencies:
  http: <latest_version>

```

Import the http package.
```
import 'package:http/http.dart' as http;

```

## 2. Make a network request

This recipe covers how to fetch a sample album from the  [JSONPlaceholder](https://jsonplaceholder.typicode.com/)  using the  [`http.get()`](https://pub.dev/documentation/http/latest/http/get.html)  method.

```
Future<http.Response> fetchAlbum() {
  return http.get('https://jsonplaceholder.typicode.com/albums/1');
}

```

The  `http.get()`  method returns a  `Future`  that contains a  `Response`.

-   [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html)  is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
-   The  `http.Response`  class contains the data received from a successful http call.

## 3. Convert the response into a custom Dart object

While it’s easy to make a network request, working with a raw  `Future<http.Response>`  isn’t very convenient. To make your life easier, convert the  `http.Response`  into a Dart object.

### Create an  `Album`  class

First, create an  `Album`  class that contains the data from the network request. It includes a factory constructor that creates an  `Album`  from JSON.

Converting JSON by hand is only one option. For more information, see the full article on  [JSON and serialization](https://flutter.dev/docs/development/data-and-backend/json).

```
class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

```

### Convert the  `http.Response`  to an  `Album`

Now, use the following steps to update the  `fetchAlbum()`  function to return a  `Future<Album>`:

1.  Convert the response body into a JSON  `Map`  with the  `dart:convert`  package.
2.  If the server does return an OK response with a status code of 200, then convert the JSON  `Map`  into an  `Album`  using the  `fromJson()`  factory method.
3.  If the server does not return an OK response with a status code of 200, then throw an exception. (Even in the case of a “404 Not Found” server response, throw an exception. Do not return  `null`. This is important when examining the data in  `snapshot`, as shown below.)

```
Future<Album> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

```

Hooray! Now you’ve got a function that fetches an album from the internet.

## 4. Fetch the data

Call the  `fetch()`  method in either the  [`initState()`](https://api.flutter.dev/flutter/widgets/State/initState.html)  or  [`didChangeDependencies()`](https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html)  methods.

The  `initState()`  method is called exactly once and then never again. If you want to have the option of reloading the API in response to an  [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)  changing, put the call into the  `didChangeDependencies()`  method. See  [`State`](https://api.flutter.dev/flutter/widgets/State-class.html)  for more details.

```
class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

```

This Future is used in the next step.

## 5. Display the data

To display the data on screen, use the  [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)  widget. The  `FutureBuilder`  widget comes with Flutter and makes it easy to work with asynchronous data sources.

You must provide two parameters:

1.  The  `Future`  you want to work with. In this case, the future returned from the  `fetchAlbum()`  function.
2.  A  `builder`  function that tells Flutter what to render, depending on the state of the  `Future`: loading, success, or error.

Note that  `snapshot.hasData`  only returns  `true`  when the snapshot contains a non-null data value. This is why the  `fetchAlbum`  function should throw an exception even in the case of a “404 Not Found” server response. If  `fetchAlbum`  returns  `null`  then the spinner displays indefinitely.



```
FutureBuilder<Album>(
  future: futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data.title);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
);

```

## Why is fetchAlbum() called in initState()?

Although it’s convenient, it’s not recommended to put an API call in a  `build()`  method.

Flutter calls the  `build()`  method every time it needs to change anything in the view, and this happens surprisingly often. Leaving the  `fetch`  call in your  `build()`  method floods the API with unnecessary calls and slows down your app.

## Testing

For information on how to test this functionality, see the following recipes:

-   [Introduction to unit testing](https://flutter.dev/docs/cookbook/testing/unit/introduction)
-   [Mock dependencies using Mockito](https://flutter.dev/docs/cookbook/testing/unit/mocking)

## Complete example

```
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

```



#### S E E  A L S O

- [HTTP Request](#http-request)
- [Async Await](#async-await)
- [Arrays](#arrays)
- [JSON](#json)



## HTTP Request
```yaml
dependencies:
  http: ^0.12.0
```
```dart
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

http.get(API_URL).then((http.Response res) {
    final data = json.decode(res.body);
    print(data);
});
```
## Async Await
```dart
Future<int> doSmthAsync() async {
  final result = await Future.value(42);
  return result;
}

class SomeClass {
  method() async {
    final result = await Future.value(42);
    return result;
  }
}
```
## JSON

```dart
import 'dart:convert' show json;

json.decode(someString);
json.encode(encodableObject);

```

`json.decode`  returns a  `dynamic`  type, which is probably not very useful

You should describe each entity as a Dart class with  `fromJson`  and  `toJson`  methods

```dart
class User {
    String displayName;
    String photoUrl;

    User({this.displayName, this.photoUrl});

    User.fromJson(Map<String, dynamic> json)
      : displayName = json['displayName'],
        photoUrl = json['photoUrl'];

    Map<String, dynamic> toJson() {
      return {
        'displayName': displayName,
        'photoUrl': photoUrl,
      };
    }
}

final user = User.fromJson(json.decode(jsonString));
json.encode(user.toJson());

```

However this approach is error-prone (e.g. you can forget to update map key after class field was renamed), so you can use  `json_serializable`  as an alternative

Add  `json_annotation`,  `build_runner`  and  `json_serializable`  to dependencies

```yaml
dependencies:
  json_annotation: ^2.0.0

dev_dependencies:
  build_runner: ^1.0.0
  json_serializable: ^2.0.0

```

Update your code

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String displayName;
  String photoUrl;

  User({this.displayName this.photoUrl});

  // _$UserFromJson is generated and available in user.g.dart
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  // _$UserToJson is generated and available in user.g.dart
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

final user = User.fromJson(json.decode(jsonString));
json.encode(user); // toJson is called by encode

```

Run  `flutter packages pub run build_runner build`  to generate serialization/deserialization code

To watch for changes run  `flutter packages pub run build_runner watch`

[Read more about JSON and serialization here](https://flutter.dev/docs/development/data-and-backend/json)
