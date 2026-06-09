import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/chatbot/data/datasources/chatbot_remote_datasource.dart';
import 'package:rafiq/features/chatbot/data/repositories/chatbot_repository_impl.dart';
import 'package:rafiq/features/chatbot/presentation/bloc/chatbot_cubit.dart';
import 'package:rafiq/features/chatbot/presentation/bloc/chatbot_state.dart';
import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/chat_bubble.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/chatbot_app_bar.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/custom_chat_input.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/welcome_body.dart';
import 'package:rafiq/core/services/chatbot_socket_service.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        ChatRepositoryImpl(
          remoteDataSource: ChatRemoteDataSourceImpl(
            socketService: ChatSocketService(),
            wsUrl: AppConstants.aiSocketUrl,
          ),
        ),
      ),
      child: const _ChatBotView(),
    );
  }
}

class _ChatBotView extends StatefulWidget {
  const _ChatBotView();

  @override
  State<_ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<_ChatBotView> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSend() {
    final cubit = context.read<ChatCubit>();
    final text = _chatController.text.trim();
    if (text.isEmpty || cubit.isTyping) return;
    _chatController.clear();
    cubit.sendMessage(text);
  }

  void _showEndChatDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
            SizedBox(width: 8),
            Text(
              'تأكيد انهاء المحادثة',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'سيتم انهاء هذه المحادثة وحذف جميع الرسائل الموجودة فيها.\nهل تريد المتابعة ؟',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.read<ChatCubit>().clearChat();
                Navigator.pop(ctx);
                context.navigateAndRemoveUntil('/patientHome');
              },
              child: const Text(
                'انهاء المحادثة',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(ctx),
              child: const Text('الغاء'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatStreaming || state is ChatActive) {
          _scrollToBottom();
        }
      },
      builder: (context, state) {
        final messages = switch (state) {
          ChatStreaming(:final messages) => messages,
          ChatActive(:final messages) => messages,
          ChatError(:final messages) => messages,
          _ => <MessageEntity>[],
        };

        final isTyping = state is ChatStreaming;
        final isChatStarted = messages.isNotEmpty;

        // فلتر الرسايل — متعرضش الـ bot bubble لو لسه فاضية
        final visibleMessages = messages
            .where((m) => !(m.sender == 'bot' && m.text.isEmpty))
            .toList();

        // عدد الـ items في الـ ListView:
        // الرسايل + typing indicator لو شغال (بيتعرض كـ item جوا الـ list)
        final itemCount = visibleMessages.length + (isTyping ? 1 : 0);

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            bottomNavigationBar: Container(height: 0),
            backgroundColor: AppColors.backGround,
            appBar: ChatBotAppBar(
              title: 'رفيقك الصحي',
              onBackPressed: isChatStarted
                  ? _showEndChatDialog
                  : () => context.navigateAndRemoveUntil('/patientHome'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: !isChatStarted
                        ? const BuildWelcomeBody()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            itemCount: itemCount,
                            itemBuilder: (_, index) {
                              // آخر item هو الـ typing indicator
                              if (isTyping && index == visibleMessages.length) {
                                return _TypingIndicator();
                              }
                              return ChatBubble(
                                message: visibleMessages[index],
                              );
                            },
                          ),
                  ),

                  // error banner
                  if (state is ChatError)
                    Container(
                      width: double.infinity,
                      color: Colors.red.shade50,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  CustomChatInput(
                    controller: _chatController,
                    sendButton: FloatingActionButton(
                      onPressed: isTyping ? null : _onSend,
                      backgroundColor: isTyping
                          ? Colors.grey
                          : AppColors.primary,
                      child: const Icon(Icons.send_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Typing Indicator Widget ──────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final delay = i / 3;
                final t = (_controller.value - delay).clamp(0.0, 1.0);
                final opacity = (0.3 + 0.7 * (t < 0.5 ? t * 2 : (1 - t) * 2))
                    .clamp(0.3, 1.0);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(opacity),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
