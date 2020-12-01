import 'package:combase_flutter/combase/networking/api_client.dart';
import 'package:combase_flutter/combase/screens/conversation_screen.dart';
import 'package:combase_flutter/combase/theme/theme_data.dart';
import 'package:combase_flutter/combase/widgets/stream_logo.dart';
import 'package:combase_flutter/combase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CombaseWelcome extends StatefulWidget {
  const CombaseWelcome({
    Key key,
  }) : super(key: key);

  @override
  _CombaseWelcomeState createState() => _CombaseWelcomeState();
}

class _CombaseWelcomeState extends State<CombaseWelcome> {
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
      final apiClient = ApiClient();
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
        combaseOrganizationKey: "Your-combase-key",
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
    return CombaseTheme(
      data: context.combaseTheme ??
          CombaseThemeData(
            brightness: Theme.of(context).brightness,
          ),
      child: Builder(builder: (BuildContext context) {
        return Material(
          color: context.combaseTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16.0),
          elevation: 6.0,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    _CombaseTextField(
                      controller: nameController,
                      hintText: "Name",
                    ),
                    const SizedBox(height: 24.0),
                    _CombaseTextField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(height: 24.0),
                    _CombaseTextField(
                      controller: messageController,
                      hintText: "Message",
                    ),
                    const SizedBox(height: 58.0),
                    ElevatedButton(
                      onPressed: startChat,
                      style: ButtonStyle(
                        elevation:
                            MaterialStateProperty.resolveWith((_) => 2.0),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (_) => context.combaseTheme.primaryColor,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 10.0),
                        child: Text(
                          "Start Chat",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    StreamLogo(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CombaseTextField extends StatelessWidget {
  const _CombaseTextField({
    Key key,
    @required this.hintText,
    this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 42.0,
        maxHeight: 56.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xfff5f6f8),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please fill out all text fields.";
            } else {
              return null;
            }
          },
          controller: controller,
          style: const TextStyle(
            color: Color(0xffafafaf),
          ),
          decoration: InputDecoration.collapsed(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xffafafaf),
            ),
          ),
        ),
      ),
    );
  }
}
