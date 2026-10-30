import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/localization_service.dart';

class UserManualScreen extends StatelessWidget {
  const UserManualScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationService>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.tr('manual_title'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => loc.toggleLanguage(),
            icon: const Icon(Icons.language, color: Colors.cyanAccent, size: 18),
            label: Text(
              loc.isTamil ? "English" : "தமிழ்",
              style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4338CA), Color(0xFF1E1B4B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigoAccent.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigoAccent.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                      border: Border.all(color: Colors.cyanAccent),
                    ),
                    child: const Icon(Icons.auto_stories, color: Colors.cyanAccent, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.tr('manual_title'),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loc.tr('manual_sub'),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 5 Step Visual Manual Cards
            _buildManualCard(
              context,
              number: "01",
              title: loc.tr('step1_title'),
              desc: loc.tr('step1_desc'),
              icon: Icons.touch_app,
              color: Colors.redAccent,
              badge: loc.isTamil ? "அதிவேக உதவி" : "Quick Action",
            ),

            _buildManualCard(
              context,
              number: "02",
              title: loc.tr('step2_title'),
              desc: loc.tr('step2_desc'),
              icon: Icons.mic_none,
              color: Colors.purpleAccent,
              badge: loc.isTamil ? "தொடாமல் குரல் வழி" : "Hands-Free Voice",
            ),

            _buildManualCard(
              context,
              number: "03",
              title: loc.tr('step3_title'),
              desc: loc.tr('step3_desc'),
              icon: Icons.security,
              color: Colors.indigoAccent,
              badge: loc.isTamil ? "நீதிமன்ற சான்று" : "Court Admissible",
            ),

            _buildManualCard(
              context,
              number: "04",
              title: loc.tr('step4_title'),
              desc: loc.tr('step4_desc'),
              icon: Icons.alt_route,
              color: Colors.greenAccent,
              badge: loc.isTamil ? "ஒளிரும் வழித்தடம்" : "Safe Corridors",
            ),

            _buildManualCard(
              context,
              number: "05",
              title: loc.tr('step5_title'),
              desc: loc.tr('step5_desc'),
              icon: Icons.privacy_tip_outlined,
              color: Colors.amberAccent,
              badge: loc.isTamil ? "100% ரகசியத்தன்மை" : "100% Anonymous",
            ),

            const SizedBox(height: 20),

            // Emergency Contacts Quick Reference Sheet
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone_in_talk, color: Colors.greenAccent, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        loc.isTamil ? "அவசர எண்கள் நினைவூட்டல்" : "Emergency Speed Dial Directory",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildHelplineRow("112", loc.isTamil ? "தேசிய அவசர உதவி (காவல்துறை & ஆம்புலன்ஸ்)" : "National Emergency Helpline"),
                  _buildHelplineRow("1091", loc.isTamil ? "மகளிர் உதவி எண் (24 மணி நேர சேவை)" : "Women Helpline (Toll Free)"),
                  _buildHelplineRow("181", loc.isTamil ? "குடும்ப வன்முறை & இக்கட்டான சூழல் உதவி" : "Women in Distress Helpline"),
                  _buildHelplineRow("15100", loc.isTamil ? "இலவச சட்ட உதவி ஆணையம்" : "Free Legal Services Authority"),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildManualCard(
    BuildContext context, {
    required String number,
    required String title,
    required String desc,
    required IconData icon,
    required Color color,
    required String badge,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 13, fontFamily: 'monospace'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: color.withOpacity(0.15),
                    child: Icon(icon, color: color, size: 16),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(badge, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildHelplineRow(String num, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(num, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'monospace')),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12))),
        ],
      ),
    );
  }
}
