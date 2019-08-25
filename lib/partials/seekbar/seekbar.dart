import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/gestures.dart';
import 'package:music_player/partials/seekbar/circle-clipper.dart';
import 'package:music_player/songs.dart';
import 'package:music_player/theme.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({
    Key key,
  }) : super(key: key);
  void _onRadialDragEnd(){

  }
  void _onRadialDargStart(PolarCoord coord){

  }
  void _onRadialDragUpdate(PolarCoord coord){

  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadialDragGestureDetector(
        onRadialDragEnd: _onRadialDragEnd,
        onRadialDragStart: _onRadialDargStart,
        onRadialDragUpdate: _onRadialDragUpdate,
              child: Container(
          width: double.infinity, 
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 140.0,
              height: 140.0,
              child: RadialProgressBar(
                progressPercentage: 0.25,
                thumbPosition: 0.25,
                progressColor: accentColor,
                trackColor: const Color(0xFFDDDDDD),
                innerPadding: EdgeInsets.all(10.0),
                thumbColor: lightAccentColor ,
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Image.network(demoPlaylist.songs[0].albumArtUrl,
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialProgressBar extends StatefulWidget {

  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double thumbSize;
  final Color thumbColor;
  final double progressPercentage;
  final double thumbPosition;
  final Widget child;
  final EdgeInsets innerPadding;
  final EdgeInsets outerPadding;


  RadialProgressBar({
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.thumbSize = 10.0,
    this.thumbColor = Colors.black,
    this.progressPercentage = 0.0,
    this.thumbPosition = 0.0,
    this.child,
    this.innerPadding = const EdgeInsets.all(0.0),
    this.outerPadding = const EdgeInsets.all(0.0)
  });

  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> {

  EdgeInsets _insetsForPainter(){
    // make room for painted track progress and thumb . we divide by 2.0 
    // because we want to allow flush painting 
    final outerThickness = max(
      widget.trackWidth,
      max(widget.progressWidth, widget.thumbSize)
    ) / 2.0;

    return EdgeInsets.all(outerThickness);

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: CustomPaint(
        foregroundPainter: RadialSeekBarPainter(
            progressColor: widget.progressColor,
            progressPercentage: widget.progressPercentage,
            progressWidth: widget.progressWidth,
            thumbColor: widget.thumbColor,
            thumbPosition: widget.thumbPosition,
            thumbSize: widget.thumbSize,
            trackColor: widget.trackColor,
            trackWidth: widget.trackWidth),
        child: Padding(
          padding: _insetsForPainter() + widget.innerPadding,
          child: widget.child,
        ) ,
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final double trackWidth;
  final double progressWidth;
  final double thumbSize;
  final double progressPercentage;
  final double thumbPosition;
  final Paint trackPaint;
  final Paint progressPaint;
  final Paint thumbPaint;

  RadialSeekBarPainter({
    @required this.trackWidth,
    @required trackColor,
    @required this.progressWidth,
    @required progressColor,
    @required this.thumbSize,
    @required thumbColor,
    @required this.progressPercentage,
    @required this.thumbPosition,
  })  : trackPaint = new Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    Size constrainedSize =
        Size(size.width - outerThickness, size.height - outerThickness);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    canvas.drawCircle(
      //circle
      center,
      //radius
      radius,
      //paint
      trackPaint,
    );

    // paint progress
    final progressAngle = 2 * pi * progressPercentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );

    // paint thumb
    // print(2 * pi * thumbPosition - (pi / 2));
    final thumbRadius = thumbSize / 2;
    final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX, thumbY) + center;
    canvas.drawCircle(thumbCenter, thumbRadius, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
