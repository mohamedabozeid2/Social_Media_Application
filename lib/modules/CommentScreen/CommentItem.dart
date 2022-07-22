import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  String name;
  String profileImage;
  String comment;
  String date;
  String commentImage;

  CommentItem(
      {required this.name,
      required this.profileImage,
      required this.comment,
      required this.date,
      required this.commentImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.0,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Text(comment,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      if (commentImage != "")
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(commentImage))),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage(commentImage)
                                    )
                                  ),
                                ),
                              ),
                              barrierDismissible: false,
                            );
                          },
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }
}
