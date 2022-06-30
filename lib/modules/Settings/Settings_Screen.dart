import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/EditProfile/Edit_Profile_Screen.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var userModel = SocialLayoutCubit.get(context).userModel;
        print("userModel==> ${userModel!.uId}");
        return ConditionalBuilder(
            condition: userModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${userModel!.cover}"))),
                              ),
                              alignment: Alignment.topCenter,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: CircleAvatar(
                                radius: 58,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      NetworkImage("${userModel!.image}"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${userModel!.name}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${userModel!.bio}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      "100",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      "Photos",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      "146",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      "Posts",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      "134",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      "Followings",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      "10k",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      "Followers",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                            child: const Text("Add Photos"),
                            onPressed: () {
                              print(FirebaseAuth
                                  .instance.currentUser!.emailVerified);
                            },
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                navigateTo(context, EditProfileScreen());
                              },
                              child: const Icon(
                                IconBroken.Edit,
                                size: 18,
                              ))
                        ],
                      ),
///////////////////////////////////////////////
                      const Spacer(),
                      if (!FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          color: Colors.amber.withOpacity(0.6),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                const Icon(Icons.warning_amber_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                  child: Text(
                                    "Please verify your email",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification()
                                          .then((value) {
                                        showToast(
                                            msg: "Please Check Your mail");
                                      }).catchError((error) {});
                                    },
                                    child: Text(
                                      "Send".toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      buttonBuilder(
                          fun: () {
                            debugPrint("Before: $uId");
                            SocialLayoutCubit.get(context).signOut(context);
                            debugPrint("After $uId");
                          },
                          text: "Sign Out"),
                      buttonBuilder(
                          fun: () {
                            debugPrint("Uid: $uId");
                          },
                          text: "uId")
                    ],
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
//           Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 190,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Align(
//                       child: Container(
//                         height: 160,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(4.0),
//                               topRight: Radius.circular(4.0),
//                             ),
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage("${userModel!.cover}"))),
//                       ),
//                       alignment: Alignment.topCenter,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                       ),
//                       child: CircleAvatar(
//                         radius: 58,
//                         backgroundColor:
//                             Theme.of(context).scaffoldBackgroundColor,
//                         child: CircleAvatar(
//                           radius: 55,
//                           backgroundImage: NetworkImage("${userModel.image}"),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 5.0,
//               ),
//               Text(
//                 "${userModel.name}",
//                 style: Theme.of(context).textTheme.bodyText1,
//               ),
//               Text(
//                 "${userModel.bio}",
//                 style: Theme.of(context).textTheme.caption,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         child: Column(
//                           children: [
//                             Text(
//                               "100",
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             Text(
//                               "Photos",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                           ],
//                         ),
//                         onTap: () {},
//                       ),
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         child: Column(
//                           children: [
//                             Text(
//                               "146",
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             Text(
//                               "Posts",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                           ],
//                         ),
//                         onTap: () {},
//                       ),
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         child: Column(
//                           children: [
//                             Text(
//                               "134",
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             Text(
//                               "Followings",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                           ],
//                         ),
//                         onTap: () {},
//                       ),
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         child: Column(
//                           children: [
//                             Text(
//                               "10k",
//                               style: Theme.of(context).textTheme.subtitle2,
//                             ),
//                             Text(
//                               "Followers",
//                               style: Theme.of(context).textTheme.caption,
//                             ),
//                           ],
//                         ),
//                         onTap: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: OutlinedButton(
//                     child: const Text("Add Photos"),
//                     onPressed: () {
//                       print(FirebaseAuth.instance.currentUser!.emailVerified);
//                     },
//                   )),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   OutlinedButton(onPressed: () {
//                     navigateTo(context, EditProfileScreen());
//                   }, child: const Icon(IconBroken.Edit,
//                   size: 18,))
//                 ],
//               ),
// ///////////////////////////////////////////////
//               const Spacer(),
//               if(!FirebaseAuth.instance.currentUser!.emailVerified)
//                 Container(
//                 color: Colors.amber.withOpacity(0.6),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.warning_amber_outlined),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       const Expanded(
//                         child: Text(
//                           "Please verify your email",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20.0,
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
//                               showToast(msg: "Please Check Your mail");
//                             }).catchError((error){
//
//                             });
//                           },
//                           child: Text(
//                             "Send".toUpperCase(),
//                             style: const TextStyle(color: Colors.blue),
//                           ))
//                     ],
//                   ),
//                 ),
//               ),
//               buttonBuilder(
//                   fun: () {
//                     debugPrint("Before: $uId");
//                     SocialLayoutCubit.get(context).signOut(context);
//                     debugPrint("After $uId");
//                   },
//                   text: "Sign Out"),
//               buttonBuilder(
//                   fun: () {
//                     debugPrint("Uid: $uId");
//                   },
//                   text: "uId")
//             ],
//           ),
//         );
      },
    );
  }
}
