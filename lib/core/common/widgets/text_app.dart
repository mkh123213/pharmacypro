import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  const TextApp({
    required this.text,
    this.theme,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  final String text;
  final TextStyle? theme;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
