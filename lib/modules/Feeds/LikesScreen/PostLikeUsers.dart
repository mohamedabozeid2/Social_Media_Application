import 'package:flutter/material.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/styles/icons_broken.dart';
import 'package:social_application4/styles/themes.dart';

class PostLikeUsers extends StatelessWidget {
  SocialUserModel model;

  PostLikeUsers({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              Stack(
                alignment: Alignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                  ),
                  CircleAvatar(
                    child: Icon(
                      IconBroken.Heart,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.red,
                    radius: 12,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${model.name}",
                      style: const TextStyle(
                        height: 1.0,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: defaultBlueColor,
                      size: 16.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
