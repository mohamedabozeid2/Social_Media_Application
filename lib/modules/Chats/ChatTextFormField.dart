import 'package:flutter/material.dart';

class ChatTextFormField extends StatelessWidget {

  TextEditingController controller;
  ChatTextFormField({
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width*0.4,
        height: 40,
        child: TextFormField(
          controller: controller,
          maxLines: 2,

          decoration: InputDecoration(
              hintText: "type your message ....",
              hintStyle: Theme.of(context).textTheme.caption,
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              enabledBorder: const OutlineInputBorder(
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
