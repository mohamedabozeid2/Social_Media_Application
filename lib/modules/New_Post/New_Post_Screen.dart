import 'package:flutter/material.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/styles/icons_broken.dart';

class NewPostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context,
      title: "Add Post")
    );
  }
}
