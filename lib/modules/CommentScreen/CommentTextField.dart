import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {

  TextEditingController controller;
  CommentTextField({
    required this.controller,
});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.4,
    height: 40,
    child: TextFormField(
      controller: controller,
      maxLines: 1,

      decoration: InputDecoration(
        hintText: "write a comment ....",
        hintStyle: Theme.of(context).textTheme.caption,
        contentPadding: const EdgeInsets.symmetric(vertical: 2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent
          )
        )
      ),
    ));
  }
}
