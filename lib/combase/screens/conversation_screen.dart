import 'package:combase_flutter/combase/constans.dart';
import 'package:combase_flutter/combase/theme/theme.dart';
import 'package:combase_flutter/combase/widgets/stream_logo.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    Key key,
  }) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  Client client;

  @override
  void didChangeDependencies() {
    client = StreamChat.of(context).client;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    client.disconnect(flushOfflineStorage: true);
    super.dispose();
  }

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
