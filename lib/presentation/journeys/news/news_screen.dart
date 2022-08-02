import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/news/detail_screen.dart';
import 'package:movieapp/presentation/journeys/news/model/post.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

Future<Post> fetchPostEntertainment() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=47ada2986be0434699996aaf4902169b'));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    //var responseData = Post.fromJson(json.decode(response.body));
    var responseData = json.decode(response.body);
    var post = Post.fromJson(responseData);
    return post;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Entertainment extends StatelessWidget {
  final bool isAppbar;
  final Future<Post> post;

  Entertainment({required this.post, this.isAppbar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: fetchPostEntertainment,
      child: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemExtent: 150,
                  itemCount: snapshot.data!.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataStored = "";
                    var imageUrl = "";
                    dataStored = snapshot.data!.articles[index].title;
                    var finalData = "";
                    if (dataStored.length < 80) {
                      finalData = dataStored;
                    } else {
                      finalData = dataStored.substring(0, 80) + "...";
                    }
                    if (snapshot.data!.articles[index].urlToImage == null) {
                      imageUrl = 'assets/placeholder';
                    } else {
                      imageUrl = snapshot.data!.articles[index].urlToImage;
                    }
                    return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                            elevation: 5,
                            color: Colors.black38,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                    child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(
                                    finalData,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        new MaterialPageRoute(
                                            builder: (context) {
                                      var article =
                                          snapshot.data!.articles[index];
                                      return DetailPage(
                                          title: article.title,
                                          image: article.urlToImage,
                                          author: article.author,
                                          description: article.description,
                                          url: article.url);
                                    }));
                                  },
                                ))
                              ],
                            )));
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
