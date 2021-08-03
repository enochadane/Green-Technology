import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Hacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Amazing Life Hacks',
          style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: _videoData.map((data) => _buildVideoCards(data)).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _videoData = [
  {
    "vidId": 'cPmby4roo3g',
    "title": "Promote Litter-Less Lunches",
    "desc": 'At CleanRiver, every new employee receives their own reusable lunch bag including'
        'Tupperware. This is just one proactive step your office can take to encourage employees'
        ' to avoid bringing their lunch in paper or plastic bags which are used once and then tossed.'
        'At CleanRiver, we encourage our employees to be mindful of what they bring into the office.'
        'Like elementary classrooms, a litter-less lunch is just one initiative your organization can '
        'adopt to reduce the amount of daily waste coming into the facility.'
  },
  {
    "vidId": 'JS4f8ssIXtY',
    "title": "Promote Litter-Less Lunches",
    "desc": 'At CleanRiver, every new employee receives their own reusable lunch bag including'
        'Tupperware. This is just one proactive step your office can take to encourage employees'
        ' to avoid bringing their lunch in paper or plastic bags which are used once and then tossed.'
        'At CleanRiver, we encourage our employees to be mindful of what they bring into the office.'
        'Like elementary classrooms, a litter-less lunch is just one initiative your organization can '
        'adopt to reduce the amount of daily waste coming into the facility.'
  },
  {
    "vidId": 'c4B7U1QG1i8',
    "title": "Promote Litter-Less Lunches",
    "desc": 'At CleanRiver, every new employee receives their own reusable lunch bag including'
        'Tupperware. This is just one proactive step your office can take to encourage employees'
        ' to avoid bringing their lunch in paper or plastic bags which are used once and then tossed.'
        'At CleanRiver, we encourage our employees to be mindful of what they bring into the office.'
        'Like elementary classrooms, a litter-less lunch is just one initiative your organization can '
        'adopt to reduce the amount of daily waste coming into the facility.'
  },
  {
    "vidId": 'oRQLilXLAIU',
    "title": "Promote Litter-Less Lunches",
    "desc": 'At CleanRiver, every new employee receives their own reusable lunch bag including'
        'Tupperware. This is just one proactive step your office can take to encourage employees'
        ' to avoid bringing their lunch in paper or plastic bags which are used once and then tossed.'
        'At CleanRiver, we encourage our employees to be mindful of what they bring into the office.'
        'Like elementary classrooms, a litter-less lunch is just one initiative your organization can '
        'adopt to reduce the amount of daily waste coming into the facility.'
  }
];

Widget _buildVideoCards(Map data) {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: data.values.first,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
      controlsVisibleAtStart: true,
      enableCaption: true,
    ),
  );
  return (Card(
    child: Column(children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(bufferedColor: Colors.amberAccent, playedColor: Colors.amber),
        ),
      ),
      ListTile(
        title: Text(data.values.elementAt(1)),
        subtitle: Text(data.values.last),
      ),
      ButtonBar(
        children: [
          TextButton(
            onPressed: null,
            child: Text('45 likes'),
            // style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.thumb_up_alt_outlined),
            color: Colors.blueAccent,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: Colors.blueAccent,
          )
        ],
      )
    ]),
  ));
}
