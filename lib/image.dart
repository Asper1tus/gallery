class UnsplashImage {
  final String name;
  final String author;
  final String thumbnailUrl;
  final String fullUrl;

  UnsplashImage({this.name, this.author, this.thumbnailUrl, this.fullUrl});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      name: json['id'] as String,
      author: json['user']['name'] as String,
      thumbnailUrl: json['urls']['thumb'] as String,
      fullUrl: json['urls']['full'] as String,
    );
  }
}


