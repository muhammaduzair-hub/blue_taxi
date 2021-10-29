import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/model/comment_sample.dart';
import 'package:bluetaxiapp/data/remote/api_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class CommentsModelSample extends BaseModel {
  ApiSample _api;

  CommentsModelSample({
    @required ApiSample api,
  }) : _api = api;

  List<CommentSample> comments;

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
