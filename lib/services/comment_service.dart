import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/model/Comment.dart';

class CommentServices {
  static final CollectionReference commentservice =
      FirebaseFirestore.instance.collection('comments');

  Future<List<Comment>> getComments(String userId) async {
    final data = await commentservice
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) => value.docs
            .map((e) => new Comment(
                uid: e.id,
                body: e['body'] as String,
                userId: e['userId'] as String,
                commentBy: e['commentedBy'] as String,
                createdAt: DateTime.now()))
            .toList());
    print("data is s ${data.length}");
    // .map((e) => e.data())
    // .toList()
    // .map((e) => e as Map<String, dynamic>)
    // .toList());
    return data;
  }

  Future<void> deleteComment(String commentId) async {
    await commentservice.doc(commentId).delete();
  }

  Future<void> addComment(Comment comment) async {
    await commentservice.add(Comment);
  }

  Future<void> updateComment(Comment comment) async {
    await commentservice.doc(comment.uid).update(comment.toJson());
  }
}
