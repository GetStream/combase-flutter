import 'package:combase_flutter/combase/widgets/stream_logo.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > Constants.kBreakpoint) {
          return Scaffold(
            backgroundColor: context.combaseTheme.surfaceColor,
            appBar: ChannelHeader(),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: MessageListView(),
                  ),
                  const Spacer(),
                  MessageInput(),
                  const StreamLogo(),
                ],
              ),
            ),
          );
        } else {
          return Material(
            color: context.combaseTheme.surfaceColor,
            elevation: 6.0,
            borderRadius: BorderRadius.circular(
              context.combaseTheme.borderRadius,
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                    child: ChannelHeader(),
                  ),
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
      },
    );
  }
}
