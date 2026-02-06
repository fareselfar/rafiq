import 'package:flutter/material.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/chat_bubble.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/chatbot_app_bar.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/custom_chat_input.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/welcome_body.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    chatController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  bool isChatStarted = false;
  List<MessageEntity> messages = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: Container(height: 0),
        backgroundColor: AppColors.backGround,
        appBar: ChatBotAppBar(
          title: "رفيقك الصحي",
          onBackPressed: () => context.navigateAndRemoveUntil("/home"),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: !isChatStarted
                    ? const BuildWelcomeBody()
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return ChatBubble(message: message);
                        },
                      ),
              ),
              CustomChatInput(
                controller: chatController,
                sendButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isChatStarted = true;
                      if (chatController.text.isNotEmpty) {
                        messages.add(
                          MessageEntity(
                            text: chatController.text,
                            sender: "user",
                            time: DateTime.now(),
                          ),
                        );
                        chatController.clear();
                      }
                    });
                  },
                  child: const Icon(Icons.send_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
