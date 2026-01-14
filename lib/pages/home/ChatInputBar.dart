
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/assets.gen.dart';
import '../../providers/chat_input_provider.dart';
import '../../providers/speech_provider.dart';
import '../../utils/wave_text.dart';

class ChatInputBar extends ConsumerWidget {
  const ChatInputBar({
    super.key,
    required TextEditingController textController,
    required Future<void> Function() onChatActionTap,
  }) : _textController = textController,
        _onChatActionTap = onChatActionTap;

  final TextEditingController _textController;
  final Future<void> Function() _onChatActionTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatInputText = ref.watch(chatInputProvider);
    final speechState = ref.watch(speechRecognitionProvider);
    final isLoading = ref.watch(isNeedLoadingProvider);

    return Positioned(
      bottom: 12,
      left: 16,
      right: 16,
      child: isLoading
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.icon.loadingIcon.image(height: 65, width: 65),
          SizedBox(width: 5),
          WaveText(
            text: 'Just a few moments....',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // 文字輸入框
            Expanded(
              child: TextField(
                controller: _textController,
                onChanged: (value) =>
                    ref.read(chatInputProvider.notifier).setText(value),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  hintText: speechState.isListening
                      ? 'Listening...'
                      : 'Ask me anything...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            // 分隔線
            Container(
              width: 1,
              height: 24,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            const SizedBox(width: 8),
            // 功能按鈕
            GestureDetector(
              onTap: _onChatActionTap,
              child: Icon(
                chatInputText.isNotEmpty
                    ? Icons.send_rounded
                    : (speechState.isListening
                    ? Icons.stop_rounded
                    : Icons.mic_rounded),
                color: chatInputText.isNotEmpty
                    ? Color(0xFF7461a3)
                    : (speechState.isListening)
                    ? Colors.red
                    : Color(0xFF7461a3),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
