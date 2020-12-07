import 'package:combase_flutter/combase/widgets/stream_logo.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: MessageListView(),
            ),
            MessageInput(),
            const StreamLogo(),
          ],
        ),
      ),
    );
  }
}
