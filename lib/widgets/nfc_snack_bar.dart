import 'package:flutter/material.dart';

class NfcSnackBar extends SnackBar {
  const NfcSnackBar({super.key, required super.content});

  @override
  State<NfcSnackBar> createState() => _NfcSnackBarState();
}

class _NfcSnackBarState extends State<NfcSnackBar> {


  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: widget.content,
      duration: Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
