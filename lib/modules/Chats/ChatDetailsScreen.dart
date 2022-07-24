import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/models/MessageModel.dart';
import 'package:social_application4/models/Social_User_Model.dart';
import 'package:social_application4/modules/Chats/ChatTextFormField.dart';
import 'package:social_application4/modules/Social_Layout/cubit/cubit.dart';
import 'package:social_application4/modules/Social_Layout/cubit/states.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/styles/icons_broken.dart';
import 'package:social_application4/styles/themes.dart';

class ChatDetailsScreen extends StatefulWidget {
  SocialUserModel receiverUserModel;

  ChatDetailsScreen({
    required this.receiverUserModel,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();

    return Builder(
      builder: (BuildContext context) {
        // SocialLayoutCubit.get(context)
        //     .getAllMessages(receiverId: widget.receiverUserModel.uId!);

        SocialLayoutCubit.get(context)
            .getMessages(receiverId: widget.receiverUserModel.uId!);
        return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(widget.receiverUserModel.image!),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(widget.receiverUserModel.name!)
                  ],
                ),
              ),
              body: state is! SocialGetMessagesLoadingState
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: messages.isNotEmpty
                                      ? ListView.separated(

                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var message = messages[index];
                                            if (userModel!.uId ==
                                                message.senderId) {
                                              return receiverMessage(message);
                                            } else {
                                              return senderMessage(message);
                                            }
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 15.0,
                                            );
                                          },
                                          itemCount: messages.length)
                                      : Center(
                                          child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text('No Chat'),
                                            Icon(IconBroken.Message)
                                          ],
                                        )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: ChatTextFormField(
                                        controller: messageController)),
                                Container(
                                  height: 40,
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (messageController.text.isNotEmpty) {
                                      SocialLayoutCubit.get(context)
                                          .sendMessage(
                                              receiverId:
                                                  widget.receiverUserModel.uId!,
                                              text: messageController.text,
                                              dateTime:
                                                  DateTime.now().toString());
                                      messageController.text = "";
                                    }
                                    print(messages.length);
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: messageController.text.isEmpty
                                        ? Colors.grey
                                        : defaultBlueColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget senderMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Text("${messageModel.text}"),
        ),
      ),
    );
  }

  Widget receiverMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: defaultBlueColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Text("${messageModel.text}"),
        ),
      ),
    );
  }
}
