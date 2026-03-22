import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class SubscriptionPackagesScreen extends StatelessWidget {
  const SubscriptionPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Premium Access', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline, color: Colors.black)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildCurrentStatus(),
            const SizedBox(height: 32),
            _buildPlanCard('Monthly', '299', 'BDT', ['30 Days Access', 'Full DB Access'], false),
            const SizedBox(height: 16),
            _buildPlanCard('6-Month', '1,499', 'BDT', ['180 Days Access', 'Priority Support', 'Performance Reports'], true),
            const SizedBox(height: 16),
            _buildPlanCard('Yearly', '2,499', 'BDT', ['365 Days Access', 'All Pro Features'], false),
            const SizedBox(height: 48),
            const Text('Compare Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildComparisonTable(),
            const SizedBox(height: 48),
            _buildSupportSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Premium tab
    );
  }

  Widget _buildCurrentStatus() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFFF0F7FF), shape: BoxShape.circle), child: const Icon(Icons.person, color: Color(0xFF0D47A1))),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CURRENT STATUS', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
              Text('Free Member', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String title, String price, String currency, List<String> features, bool isPopular) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isPopular ? const Color(0xFF00695C) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: isPopular ? null : Border.all(color: AppColors.border.withOpacity(0.5)),
            boxShadow: isPopular ? [BoxShadow(color: const Color(0xFF00695C).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))] : null,
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(title == 'Monthly' ? Icons.calendar_today_outlined : (title == '6-Month' ? Icons.auto_awesome : Icons.card_membership_outlined), color: isPopular ? Colors.white : const Color(0xFF0D47A1), size: 28),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isPopular ? Colors.white : Colors.black87)),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: price, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isPopular ? Colors.white : Colors.black87)),
                    TextSpan(text: ' $currency', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isPopular ? Colors.white70 : AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: isPopular ? Colors.white70 : const Color(0xFF00B050), size: 14),
                    const SizedBox(width: 8),
                    Text(f, style: TextStyle(color: isPopular ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              )).toList(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: isPopular ? Colors.white : const Color(0xFFF0F7FF),
                  foregroundColor: isPopular ? const Color(0xFF00695C) : const Color(0xFF0D47A1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Select Plan', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        if (isPopular)
          Positioned(
            top: -12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
              child: const Text('MOST POPULAR', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(color: Color(0xFFF0F7FF), borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: const Row(
              children: [
                Expanded(child: Text('Features', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary))),
                SizedBox(width: 60, child: Center(child: Text('Free', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)))),
                SizedBox(width: 60, child: Center(child: Text('Pro', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)))),
              ],
            ),
          ),
          _buildComparisonRow('Unlimited Mock Tests', false, true),
          _buildComparisonRow('AI Performance Analysis', false, true),
          _buildComparisonRow('Previous Year Solutions', null, true), // null for 'limited'
          _buildComparisonRow('Ad-Free Experience', false, true),
          _buildComparisonRow('Offline Access', false, true),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String feature, bool? free, bool pro) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5))),
      child: Row(
        children: [
          Expanded(child: Text(feature, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          SizedBox(width: 60, child: Center(
            child: free == null 
                ? const Text('Limited', style: TextStyle(fontSize: 10, color: AppColors.textSecondary))
                : Icon(free ? Icons.check_circle : Icons.cancel, color: free ? const Color(0xFF00B050) : Colors.red.withOpacity(0.3), size: 18),
          )),
          SizedBox(width: 60, child: Center(child: Icon(pro ? Icons.check_circle : Icons.cancel, color: pro ? const Color(0xFF00B050) : AppColors.textSecondary, size: 18))),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Column(
      children: [
        const Text('Need help with payment?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Our support team is available 24/7 to assist you with any billing inquiries or technical issues.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.5)),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(minimumSize: const Size(200, 48), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.mail_outline, size: 18), SizedBox(width: 8), Text('Contact Support')]),
        ),
        const SizedBox(height: 12),
        TextButton(onPressed: () {}, child: const Text('Refund Policy', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, decoration: TextDecoration.underline))),
      ],
    );
  }
}
