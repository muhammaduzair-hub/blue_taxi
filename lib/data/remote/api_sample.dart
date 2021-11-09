import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bluetaxiapp/data/model/comment_sample.dart';
import 'package:bluetaxiapp/data/model/post_sample.dart';
import 'package:bluetaxiapp/data/model/user_sample.dart';

/// The service responsible for networking requests
class ApiSample {
  static const endpoint = 'https://jsonplaceholder.typicode.com';
  
  var client = new http.Client();

  Future<UserSample> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get(Uri.parse(Uri.encodeFull("$endpoint/users/$userId")));

    // Convert and return
    return UserSample.fromJson(json.decode(response.body));
  }

  Future<List<PostSample>> getPostsForUser(int userId) async {
    var posts = <PostSample>[];
    // Get user posts for id
    var response = await client.get(Uri.parse(Uri.encodeFull("$endpoint/posts?userId=$userId")));

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(PostSample.fromJson(post));
    }

    return posts;
  }

  Future<List<CommentSample>> getCommentsForPost(int postId) async {
    var comments = <CommentSample>[];

    // Get comments for post
    var response = await client.get(Uri.parse(Uri.encodeFull("$endpoint/comments?postId=$postId")));

    // Parse into List
    var parsed = json.decode(response.body) as List<dynamic>;
    
    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(CommentSample.fromJson(comment));
    }

    return comments;
  }
}
