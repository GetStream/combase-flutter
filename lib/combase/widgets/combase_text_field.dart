import 'package:flutter/material.dart';

class CombaseTextField extends StatefulWidget {
  const CombaseTextField({
    Key key,
    @required this.hintText,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  _CombaseTextFieldState createState() => _CombaseTextFieldState();
}

class _CombaseTextFieldState extends State<CombaseTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 42.0,
        maxHeight: 56.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xfff5f6f8),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please fill out all text fields.";
            } else {
              return null;
            }
          },
          controller: widget.controller,
          style: const TextStyle(
            color: Color(0xffafafaf),
          ),
          decoration: InputDecoration.collapsed(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0xffafafaf),
            ),
          ),
        ),
      ),
    );
  }
}
