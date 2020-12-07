import 'package:combase_flutter/combase/networking/api_client.dart';
import 'package:combase_flutter/combase/screens/conversation_screen.dart';
import 'package:combase_flutter/combase/theme/theme_data.dart';
import 'package:combase_flutter/combase/widgets/combase_text_field.dart';
import 'package:combase_flutter/combase/widgets/stream_logo.dart';
import 'package:combase_flutter/combase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Combase extends StatefulWidget {
  Combase({
    Key key,
    @required final String organizationKey,
  })  : apiClient = ApiClient(organizationKey),
        super(key: key);

  final ApiClient apiClient;

  @override
  _CombaseState createState() => _CombaseState();
}

class _CombaseState extends State<Combase> {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController messageController;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey(debugLabel: "Combase welcome form");
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
  }

  Future<void> startChat() async {
    if (_formKey.currentState.validate()) {
      final apiClient = widget.apiClient;

      final String name = nameController.value.text;
      final String email = emailController.value.text;
      final String message = messageController.value.text;

      final user = await apiClient.createUser(name: name, email: email);
      final orgStreamAPIKey = await apiClient.retrieveOrganizationApiKey();
      final client = await apiClient.configureUser(
        streamAPIKey: orgStreamAPIKey,
        userJWT: user.streamToken,
        userId: user.userId,
        name: user.name,
      );
      final String channelId = await apiClient.createTicket(
        userId: user.userId,
      );

      final channel = client.channel("messaging", id: channelId);
      await channel.watch();
      await channel.sendMessage(
        Message(
          text: message,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StreamChat(
              client: client,
              child: StreamChannel(
                channel: channel,
                child: const ConversationPage(),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.combaseTheme ??
        CombaseThemeData(brightness: Theme.of(context).brightness);

    return CombaseTheme(
      data: theme,
      child: _CombaseWelcome(
        formKey: _formKey,
        emailController: emailController,
        messageController: messageController,
        nameController: nameController,
        onStartChatPressed: startChat,
      ),
    );
  }
}

class _CombaseWelcome extends StatelessWidget {
  const _CombaseWelcome({
    Key key,
    @required this.formKey,
    @required this.nameController,
    @required this.emailController,
    @required this.messageController,
    @required this.onStartChatPressed,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback onStartChatPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.combaseTheme.surfaceColor,
      borderRadius: BorderRadius.circular(context.combaseTheme.borderRadius),
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24.0),
              Ink(
                height: 72.0,
                width: 72.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: context.combaseTheme.combaseGradient,
                ),
                child: const Center(
                  child: Text(
                    "C",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Welcome 👋",
                style: context.combaseTheme.primaryTextStyle,
              ),
              Text(
                "Description for the organization goes here",
                style: context.combaseTheme.secondaryTextStyle,
              ),
              const SizedBox(height: 48.0),
              Flexible(
                flex: 2,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    CombaseTextField(
                      controller: nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(height: 24.0),
                    CombaseTextField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(height: 24.0),
                    CombaseTextField(
                      controller: messageController,
                      hintText: "Message",
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: onStartChatPressed,
                      style: ButtonStyle(
                        elevation:
                            MaterialStateProperty.resolveWith((_) => 2.0),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (_) => context.combaseTheme.primaryColor,
                        ),
                      ),
                      child: Text(
                        "Start Chat",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: StreamLogo(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
