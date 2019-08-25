
import 'package:flutter/material.dart';
import 'package:music_player/partials/seekbar/seekbar.dart';
import 'package:music_player/partials/visualizer.dart';

import 'bottom_controls.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // seek bar
        new SeekBar(),

        // visualizer
        new Visualizer(),

        // song title, artist name, and controlls
        new BottomControl()
      ],
    );
  }
}