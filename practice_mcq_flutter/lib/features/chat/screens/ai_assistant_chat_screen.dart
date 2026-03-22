import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AIAssistantChatScreen extends StatefulWidget {
  const AIAssistantChatScreen({super.key});

  @override
  State<AIAssistantChatScreen> createState() => _AIAssistantChatScreenState();
}

class _AIAssistantChatScreenState extends State<AIAssistantChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Can you explain the difference between direct and indirect taxes in Bangladesh economy?",
      isUser: true,
      time: "10:30 AM",
    ),
    ChatMessage(
      text: "Certainly! In the context of the Bangladesh economy and BCS preparation, here is the breakdown:\n\n1. Direct Tax: These are paid directly by the individual to the government (e.g., Income Tax, Corporate Tax). You cannot shift the burden to someone else.\n\n2. Indirect Tax: These are collected by an intermediary (like a shopkeeper) from the person who bears the ultimate economic burden (e.g., VAT, Customs Duty). The burden can be shifted to the consumer.",
      isUser: false,
      time: "10:31 AM",
    ),
    ChatMessage(
      text: "What is the current VAT rate in Bangladesh?",
      isUser: true,
      time: "10:32 AM",
    ),
    ChatMessage(
      text: "The standard VAT rate in Bangladesh is 15%, though there are reduced rates for certain essential goods and services (e.g., 5%, 7.5%, 10%). For your exam, remember the VAT Act 2012 is the primary regulation.",
      isUser: false,
      time: "10:32 AM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text('Sarkari Assistant', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                if (_messages.isEmpty) _buildWelcomeSection(),
                ..._messages.map((m) => _buildChatBubble(m)),
              ],
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.psychology, color: Color(0xFF00695C), size: 32)),
        const SizedBox(height: 24),
        const Text('How can I help your\nstudy today?', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
        const SizedBox(height: 12),
        const Text('Ask about BCS, Bank Jobs, or any Primary\nSchool syllabus.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
        const SizedBox(height: 32),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildSuggestionChip('Explain Math Ratio'),
            _buildSuggestionChip('BCS English Syllabus'),
            _buildSuggestionChip('Summarize Chapter 1'),
            _buildSuggestionChip('General Knowledge Bangladesh'),
          ],
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Text(text, style: const TextStyle(color: Color(0xFF00695C), fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
             Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF00695C).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.psychology, color: Color(0xFF00695C), size: 16)),
             const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: message.isUser ? const Color(0xFFE0F2F1) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(message.isUser ? 20 : 4),
                  bottomRight: Radius.circular(message.isUser ? 4 : 20),
                ),
                boxShadow: message.isUser ? null : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.text, style: TextStyle(color: message.isUser ? const Color(0xFF004D40) : Colors.black87, fontSize: 14, height: 1.5)),
                  if (!message.isUser) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.copy, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        const Text('COPY', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        const Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.textSecondary),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
          ],
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: AppColors.background,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))]),
        child: Row(
          children: [
            const Icon(Icons.add_circle_outline, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Ask Sarkari Assistant', hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14), border: InputBorder.none),
              ),
            ),
            const Icon(Icons.mic_none, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Color(0xFF00695C), shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}
