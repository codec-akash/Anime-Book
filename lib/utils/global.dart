import 'package:flutter/cupertino.dart';

class Global {
  static BorderRadius borderRadius = BorderRadius.circular(10.0);

  static const String defaultText =
      "Awww Man, Your Internet Sucks \n Creator of this app \n Real life anime";

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
