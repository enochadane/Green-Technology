import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/model/pininfo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MapPinPill extends StatefulWidget {
  final double pinPillPosition;
  final PinInformation currentlySelectedPin;

  MapPinPill(
      {required this.pinPillPosition, required this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillState();
}

class MapPinPillState extends State<MapPinPill> {
  Map<String, dynamic> _formData = <String, dynamic>{
    'comment': 'sample comment',
    'rating': 4,
  };
  final _commentTextController = TextEditingController();
  late bool _isTapped = false;
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isTapped = !_isTapped;
            });
          },
          child: Card(
            color: Theme.of(context).cardTheme.color,
            child: Column(
              children: [
                SizedBox(
                  height: 100.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(left: 10, right: 10.0),
                        child: ClipOval(
                            child: Image.asset("assets/images/avatar.jpeg",
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    widget.currentlySelectedPin.name,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Text(
                                    widget.currentlySelectedPin.houseNo,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.currentlySelectedPin.rating
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0)),
                                      RatingBar.builder(
                                        itemSize: 15.0,
                                        initialRating:
                                            widget.currentlySelectedPin.rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(widget.currentlySelectedPin.phone,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2.0,
                  color: Colors.black38,
                ),
                SizedBox(
                  child: _isTapped ? (buildFeedBack()) : SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFeedBack() {
    return Form(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rate & Comment"),
              _buildRatingBar(),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          buildCommentBox(),
        ],
      ),
    ));
  }

  void handleSubmit() {
    print('submit clicked');
    _formData['comment'] = _commentTextController.text;
    setState(() {
      _isTapped = false;
    });
  }

  buildCommentBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: TextFormField(
          controller: _commentTextController,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 1,
          decoration: InputDecoration(
              fillColor: Colors.blue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _commentTextController.clear();
                },
              ),
              hintText: "Enter the comment",
              labelText: "Comments"),
        ),
      ),
      SizedBox(
        width: 5.0,
      ),
      InkWell(
        child: Icon(
          Icons.send,
          size: 40.0,
          color: Colors.green,
        ),
        onTap: handleSubmit,
      ),
    ]);
  }

  Widget _buildRatingBar() {
    return RatingBar.builder(
      itemSize: 40.0,
      initialRating: 1,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        _formData['rating'] = rating;
      },
    );
  }
}
