import 'package:flutter/material.dart';

class StreamLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 12.0,
        ),
        height: 30.0,
        child: Image.asset(
          "assets/stream_banner.png",
          height: 40.0,
          package: "combase_flutter",
        ),
      ),
    );
  }
}
