// import 'package:flutter/material.dart';
//
// class CommentItem extends StatelessWidget {
//   String name;
//   String profileImage;
//   String comment;
//   String date;
//
//   CommentItem({
//     required this.name,
//     required this.profileImage,
//     required this.comment,
//     required this.date,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.blueGrey[200],
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 22.0,
//                     backgroundImage: NetworkImage(profileImage),
//                   ),
//                   const SizedBox(
//                     width: 15.0,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: const TextStyle(fontSize: 16.0),
//                       ),
//                       Text(comment,
//                           style: Theme.of(context)
//                               .textTheme
//                               .caption!
//                               .copyWith(fontSize: 14)),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(date ,style: Theme.of(context).textTheme.caption,),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
