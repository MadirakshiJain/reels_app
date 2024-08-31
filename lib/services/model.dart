class Post {
      final int id;
      final String title;
      final String videoLink;
      final String thumbnailUrl;
      final String firstName;
      final String lastName;
      final String username;

   Post({
        required this.id,
        required this.title,
        required this.videoLink,
        required this.thumbnailUrl,
        required this.firstName,
        required this.lastName,
        required this.username,
   });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      videoLink: json['video_link'],
      thumbnailUrl: json['thumbnail_url'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
    );
  }
}


