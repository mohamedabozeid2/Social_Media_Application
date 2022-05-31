import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_application4/styles/icons_broken.dart';
import 'package:social_application4/styles/themes.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10.0,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: const [
                  Image(
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://img.freepik.com/free-photo/horizontal-shot-happy-adult-man-points-index-finger-away-shows-advertisement-against-yellow-studio-background-wears-round-spectacles-casual-t-shirt-demonstrates-promo-look-this-please_273609-59011.jpg?w=1060",
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Communicate \n with friends",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Jannah",
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
          ListView.separated(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index)=> buildPostItem(context),
              separatorBuilder: (context, index)=> const SizedBox(
                height: 5,
              ),
              itemCount: 10
          )
        ],
      ),
    );
  }
  Widget buildPostItem(context){
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                    "https://scontent.fcai19-5.fna.fbcdn.net/v/t1.6435-9/132042006_2766054416944062_7836130104951523797_n.jpg?_nc_cat=107&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=GA1RZhQQI1oAX_Z_kGP&_nc_ht=scontent.fcai19-5.fna&oh=00_AT9E97ChkKF1SYx5mkaapyIAAwwsEjBwCqEV9aZr5BRzPQ&oe=629E5722"),
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
                            const Text(
                              "Mohamed Abo Zeid",
                              style: TextStyle(
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
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                        Text(
                          "March 24,2022 at 4:00 pm",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 18.0,
                      )),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesettin.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 10.0
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Software",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.blue,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 10.0
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Mobile_Developement",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.blue,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 10.0
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Flutter",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.blue,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 5.0
                        ),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                              minWidth: 1.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Text("#Software_Developer",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                    color: Colors.blue,
                                  ))),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/charming-positive-european-woman-presses-hands-chest-expresses-gratitude-gift-appreciates-help-wears-round-glasses-white-shirt_273609-39286.jpg?t=st=1648106935~exp=1648107535~hmac=0377a372f5a681c9988be99fe0b1b27e866b40c6bd5871cb7226e97d32db44c9&w=996"))),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
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
                              "122,058,541",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 20,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "126 comment",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 2,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                          child: const CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-photo/positive-delighted-bearded-man-appealing-you-points-fingers-makes-good-choice-has-funny-joyful-expression-chooses-someone-shows-its-up-you-gesture-picks-potential-client_273609-42154.jpg?w=996"),
                          ),
                          onTap: (){

                          },
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: InkWell(
                            child: Text(
                              "write a comment ....",
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  height: 3.5
                              ),
                            ),
                            onTap: (){},
                          ),
                        )
                      ],
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
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
                                  "Like",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: (){

                          },
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  IconBroken.Send,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "share",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          onTap: (){

                          },
                        ),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ));

  }
}
