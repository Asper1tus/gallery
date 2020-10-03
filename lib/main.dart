import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery/fullImagePage.dart';
import 'package:http/http.dart' as http;

import 'image.dart';

Future<List<UnsplashImage>> fetchImages(http.Client client) async {
  final response = await client.get(
      'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9');
  
  return compute(parseImages, response.body);
}

List<UnsplashImage> parseImages(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<UnsplashImage>((json) => UnsplashImage.fromJson(json))
      .toList();
}

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Gallery';

    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<UnsplashImage>>(
        future: fetchImages(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? UnsplashImagesList(images: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UnsplashImagesList extends StatelessWidget {
  final List<UnsplashImage> images;

  UnsplashImagesList({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) => ListTile(
          leading: Container(
              child: Image.network(images[index].thumbnailUrl),
              alignment: Alignment.center,
              width: 100),
          title: Text(images[index].name),
          subtitle: Text(images[index].author),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullImagePage(
                        title: images[index].name,
                        fullUrl: images[index].regularUrl,
                      )))),
    );
  }
}
