
import 'package:flutter/material.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/modules/Chat/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: .2,
        automaticallyImplyLeading: false,
        flexibleSpace: chatAppBar(),

      ),
      body: Container(
        color: backGroundColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //chat body
            chatBody(),
            //textfield
            chatTextField()
            
          ],
        ),
      ),
    );
  }
}