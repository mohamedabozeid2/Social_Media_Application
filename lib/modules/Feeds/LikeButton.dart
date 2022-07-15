import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/styles/icons_broken.dart';

class LikeButton extends StatelessWidget {
  int index;
  int likesNumber;
  final fun;
  List<String> colorIcons;



  LikeButton({
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
              Icon(
                IconBroken.Heart,
                size: 20,
                color: colorIcons[index] == "red"? Colors.red: Colors.grey,
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
