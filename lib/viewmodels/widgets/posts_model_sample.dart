import 'package:meta/meta.dart';
import 'package:bluetaxiapp/data/model/post_sample.dart';
import 'package:bluetaxiapp/data/remote/api_sample.dart';

import '../base_model.dart';

class PostsModelSample extends BaseModel {
  ApiSample _api;

  PostsModelSample({
    @required ApiSample api,
  }) : _api = api;

  List<PostSample> posts;

  Future getPosts(int userId) async {
    setBusy(true);
    posts = await _api.getPostsForUser(userId);
    setBusy(false);
  }
}
