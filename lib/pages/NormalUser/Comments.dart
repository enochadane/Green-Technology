import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/model/Comment.dart';
import 'package:flutter_firestore_example/services/comment_service.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  CommentServices _commentServices = CommentServices();
  //    Future getComments;

  // @override
  // void initState() {
  //    getComments= fetchComments();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserRepository>(builder: (context, value, child) {
        final String userId = value.authenticatedUser!.uid;
        return FutureBuilder(
            future: fetchComments(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: _comments_cards(snapshot.data as List<Comment>),
                      ),
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            });
      }),
    );
  }

  fetchComments(String userId) async {
    late var data;
    try {
      data = await _commentServices.getComments(userId);
      print("data is ${data.length}");
    } catch (error) {
      print("error $error");
    }

    // final user_data =  as Map<String, Object>;

    return data;
  }
}

Widget _comments_cards(List<Comment> comments) {
  return Card(
      elevation: 0,
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (comment, index) {
            final comment = comments[index];
            return Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check),
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 8, 15),
                    child: Text(comment.commentBy),
                  ),
                  subtitle: Text(
                    comment.body,
                    style:
                        TextStyle(color: true ? Colors.black : Colors.black38),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text(comment.createdAt.toString())),
                ),
                ButtonBar(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text('Clear'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
          }));
}
