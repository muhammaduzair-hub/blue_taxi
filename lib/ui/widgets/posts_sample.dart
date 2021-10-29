import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/data/model/user_sample.dart';
import 'package:bluetaxiapp/viewmodels/widgets/posts_model_sample.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/postlist_item_sample.dart';

class PostsSample extends StatelessWidget {
  const PostsSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostsModelSample>(
        model: PostsModelSample(api: Provider.of(context)),
        onModelReady: (model) => model.getPosts(Provider.of<UserSample>(context).id),
        builder: (context, model, child) => model.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.posts.length,
                itemBuilder: (context, index) => PostListItemSample(
                      post: model.posts[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutePaths.Post,
                          arguments: model.posts[index],
                        );
                      },
                    ),
              ));
  }
}
