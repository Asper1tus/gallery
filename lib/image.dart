class UnsplashImage {
  final String name;
  final String author;
  final String thumbnailUrl;
  final String regularUrl;

  UnsplashImage({this.name, this.author, this.thumbnailUrl, this.regularUrl});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      name: json['id'] as String,
      author: json['user']['name'] as String,
      thumbnailUrl: json['urls']['regular'] as String,
      regularUrl: json['urls']['full'] as String,
    );
  }
}


