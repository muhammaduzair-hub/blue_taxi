class CommentSample {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentSample({ required this.postId, required this.id, required this.name, required this.email, required this.body});

  // CommentSample.fromJson(Map<String, dynamic> json,{
  //   postId = json['postId'];
  //   id = json['id'];
  //   name = json['name'];
  //   email = json['email'];
  //   body = json['body'];
  // }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}