import 'package:combase_flutter/combase/theme/theme_data.dart';
import 'package:flutter/material.dart';
import './theme/theme.dart';

class CombaseWelcome extends StatefulWidget {
  const CombaseWelcome({
    Key key,
  }) : super(key: key);

  @override
  _CombaseWelcomeState createState() => _CombaseWelcomeState();
}

class _CombaseWelcomeState extends State<CombaseWelcome> {
  @override
  Widget build(BuildContext context) {
    return CombaseTheme(
      data: context.combaseTheme ?? CombaseThemeData(),
      child: Builder(builder: (BuildContext context) {
        return Material(
          color: context.combaseTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16.0),
          elevation: 6.0,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24.0),
                  Ink(
                    height: 72.0,
                    width: 72.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: context.combaseTheme.combaseGradient,
                    ),
                    child: Center(
                      child: Text(
                        "C",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Welcome 👋",
                    style: context.combaseTheme.primaryTextStyle,
                  ),
                  Text(
                    "Description for the organization goes here",
                    style: context.combaseTheme.secondaryTextStyle,
                  ),
                  const SizedBox(height: 48.0),
                  _CombaseTextField(
                    hintText: "Name",
                  ),
                  const SizedBox(height: 24.0),
                  _CombaseTextField(
                    hintText: "Email",
                  ),
                  const SizedBox(height: 24.0),
                  _CombaseTextField(
                    hintText: "Message",
                  ),
                  const SizedBox(height: 64.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith((_) => 2.0),
                      backgroundColor: MaterialStateColor.resolveWith(
                        (_) => context.combaseTheme.primaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 10.0),
                      child: Text(
                        "Start Chat",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CombaseTextField extends StatelessWidget {
  const _CombaseTextField({
    Key key,
    @required this.hintText,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xfff5f6f8),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: const Color(0xffafafaf),
          ),
          decoration: InputDecoration.collapsed(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xffafafaf),
            ),
          ),
        ),
      ),
    );
  }
}
