import 'dart:math';

import 'package:flutter/material.dart';

class OthersStatus extends StatelessWidget {
  const OthersStatus(
      {Key? key,
      required this.imageName,
      required this.time,
      required this.name,
        required this.isSeen,
        required this.statusNum})
      : super(key: key);
  final String imageName;
  final String time;
  final String name;
  final bool isSeen;
  final int statusNum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(statusNum: statusNum,isSeen: isSeen),
        child: CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(imageName),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "Today, ${time}",
        style: TextStyle(fontSize: 13.0, color: Colors.grey[900]),
      ),
    );
  }
}

DegreeToAngle(double degree) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int statusNum;
  StatusPainter({required this.isSeen,required this.statusNum});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen?Color(0xff21bfa6):Colors.green
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if(statusNum==1) {
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          DegreeToAngle(0), DegreeToAngle(360), false, paint);
    }
    else
      {
        double arc = 360/statusNum;
        double degree = -90;
        for(int i=0;i<statusNum;i++)
          {
            canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
                DegreeToAngle(degree+4), DegreeToAngle(arc-8), false, paint);
            degree+=arc;
          }
      }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
