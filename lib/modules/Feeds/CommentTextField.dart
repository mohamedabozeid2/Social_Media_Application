import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {

  TextEditingController controller;
  CommentTextField({
    required this.controller,
});


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
        height: 30,
        child: TextFormField(
          controller: controller,
          maxLines: 1,

          decoration: InputDecoration(
            hintText: "write a comment ....",
            hintStyle: Theme.of(context).textTheme.caption,
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).scaffoldBackgroundColor
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).scaffoldBackgroundColor
              )
            )
          ),
        )));
  }
}
