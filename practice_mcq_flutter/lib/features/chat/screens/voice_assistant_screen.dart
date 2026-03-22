import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Voice Assistant', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildListeningStatus(),
            const Spacer(),
            _buildPulseAnimation(),
            const Spacer(),
            _buildTranscriptSection(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00B074),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.send, size: 20), SizedBox(width: 8), Text('Send Question', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary, fontSize: 14))),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Ask AI tab
    );
  }

  Widget _buildListeningStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(20)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: Color(0xFF00B074), size: 10),
          SizedBox(width: 8),
          Text('LISTENING...', style: TextStyle(color: Color(0xFF00695C), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        ],
      ),
    );
  }

  Widget _buildPulseAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE3F2FD).withOpacity(0.5 * (1 - _pulseController.value)),
                border: Border.all(color: const Color(0xFFE3F2FD), width: 40 * _pulseController.value),
              ),
            );
          },
        ),
        Container(
          width: 220,
          height: 220,
          decoration: const BoxDecoration(color: Color(0xFFE3F2FD), shape: BoxShape.circle),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: 30 + (index % 2 == 0 ? 10 : 0),
                decoration: BoxDecoration(color: const Color(0xFF00B074), borderRadius: BorderRadius.circular(3)),
              )),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(color: const Color(0xFF004D40), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]),
            child: const Icon(Icons.mic, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildTranscriptSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome_motion, color: Color(0xFF00B074), size: 16),
              SizedBox(width: 8),
              Text('REAL-TIME TRANSCRIPT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600, height: 1.4),
              children: [
                TextSpan(text: '"What are the core subjects for the 45th BCS Preliminary exam?" '),
                WidgetSpan(child: VerticalDivider(width: 2, thickness: 2, color: Color(0xFFE0F2F1))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
