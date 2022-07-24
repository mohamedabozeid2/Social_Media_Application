import 'package:flutter/material.dart';

import 'package:social_application4/styles/icons_broken.dart';

class ShowLikesButton extends StatelessWidget {
  int index;
  int likesNumber;
  final fun;
  List<String> colorIcons;



  ShowLikesButton({
    required this.index,
    required this.likesNumber,
    required this.fun,
    required this.colorIcons,
  });


  @override
  Widget build(BuildContext context) {

    return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                IconBroken.Heart,
                size: 20,
                color: Colors.red,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                "$likesNumber",
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        onTap: fun
    );
  }
}
