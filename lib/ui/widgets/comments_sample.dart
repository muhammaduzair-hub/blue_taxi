import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/data/model/comment_sample.dart';
import 'package:bluetaxiapp/viewmodels/widgets/comments_model_sample.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';

class CommentsSample extends StatelessWidget {
  final int postId;
  CommentsSample(this.postId);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommentsModelSample>(
        onModelReady: (model) => model.fetchComments(postId),
        model: CommentsModelSample(api: Provider.of(context)),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: model.comments.length,
                  itemBuilder: (context, index) =>
                      CommentItem(model.comments[index]),
                ),
              ));
  }
}

/// Renders a single comment given a comment model
class CommentItem extends StatelessWidget {
  final CommentSample comment;
  const CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall,
          Text(comment.body),
        ],
      ),
    );
  }
}