import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/model/comment.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class CommentsModel extends BaseModel {
  Api _api;

  CommentsModel({
    @required Api api,
  }) : _api = api;

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setBusy(true);
    comments = await _api.getCommentsForPost(postId);
    setBusy(false);
  }

  @override
  void dispose() {
    print('I have been disposed!!');
    super.dispose();
  }
}
