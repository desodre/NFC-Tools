import 'package:flutter/material.dart';

class TagScanDialog extends StatefulWidget {
  const TagScanDialog({
    super.key,
  });

  @override
  State<TagScanDialog> createState() => _TagScanDialogState();
}

class _TagScanDialogState extends State<TagScanDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      backgroundColor: Colors.white,
      content: Image.asset(
          'lib/assets/images/nfc_animated_icon.gif'),
          
    );
  }
}
