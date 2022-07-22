import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_application4/models/CommentModel.dart';
import 'package:social_application4/models/MessageModel.dart';
import 'package:social_application4/models/PostModel.dart';
import 'package:social_application4/models/Social_User_Model.dart';


dynamic uId = "";
SocialUserModel? userModel;
List<int> commentsNumber = [];
List<String> colorIcons = [];
List<PostModel> posts = [];
List<String> postsId = [];
List<int> likes = [];
List<SocialUserModel> users = [];
List<MessageModel> messages = [];
List <CommentModel> postComments = [];


String index = "";
String index2 = "";


