import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

const String apiKey= "sc9yck3acu5u";


var logger = log.Logger();


extension StreamChatContext on BuildContext{
  String? get currentUserImage => currentUser!.image;
  User? get currentUser => StreamChatCore.of(this).currentUser;

}