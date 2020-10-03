import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullImagePage extends StatelessWidget {
  final title;
  final fullUrl;

  FullImagePage({this.title, this.fullUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Image.network(fullUrl, loadingBuilder: (BuildContext context,
              Widget child, ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          }),
        ));
  }
}
