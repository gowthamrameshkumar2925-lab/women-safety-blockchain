import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';
import '../services/localization_service.dart';
import '../models/app_models.dart';

class CounselingScreen extends StatefulWidget {
  const CounselingScreen({Key? key}) : super(key: key);

  @override
  State<CounselingScreen> createState() => _CounselingScreenState();
}

class _CounselingScreenState extends State<CounselingScreen> {
  final TextEditingController _chatController = TextEditingController();
  bool _isGenerating = false;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _sendMessage(AgentEngine engine) {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      setState(() => _isGenerating = true);
      engine.sendCounselingMessage(text);
      _chatController.clear();
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) setState(() => _isGenerating = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AgentEngine>();
    final loc = context.watch<LocalizationService>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.isTamil ? "சகி (Sakhi) AI ஆறுதல் தோழி" : "Sakhi AI Counselor",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
            ),
            Row(
              children: const [
                Icon(Icons.auto_awesome, color: Colors.pinkAccent, size: 11),
                SizedBox(width: 4),
                Text(
                  "Specialized Trauma & Legal AI Model v2.4",
                  style: TextStyle(fontSize: 10, color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.privacy_tip_outlined, color: Colors.pinkAccent),
            onPressed: () => _showLegalRightsSheet(context, loc),
          ),
        ],
      ),
      body: Column(
        children: [
          // Emergency Helpline Speed Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1E293B),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildHelplineChip("🚨 112 (National Police)"),
                  const SizedBox(width: 8),
                  _buildHelplineChip("📞 1091 (Women Helpline)"),
                  const SizedBox(width: 8),
                  _buildHelplineChip("🛡️ 181 (Women in Distress)"),
                  const SizedBox(width: 8),
                  _buildHelplineChip("⚖️ Legal Aid 15100"),
                ],
              ),
            ),
          ),

          // Suggested Prompts
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSuggestionChip(loc.isTamil ? "எனக்கு பயமா இருக்கு" : "I feel scared / followed", engine),
                  const SizedBox(width: 8),
                  _buildSuggestionChip(loc.isTamil ? "ஜீரோ FIR சட்டம் என்ன?" : "What is Zero FIR right?", engine),
                  const SizedBox(width: 8),
                  _buildSuggestionChip(loc.isTamil ? "மிளகாய் ஸ்ப்ரே சட்டப்பூர்வமானதா?" : "Is Pepper Spray legal in India?", engine),
                ],
              ),
            ),
          ),

          // Chat Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: engine.chatMessages.length,
              itemBuilder: (context, index) {
                final msg = engine.chatMessages[index];
                final isUser = msg.sender == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isUser ? Colors.transparent : Colors.pinkAccent.withOpacity(0.35),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isUser)
                          Row(
                            children: const [
                              Icon(Icons.psychology, size: 14, color: Colors.pinkAccent),
                              SizedBox(width: 6),
                              Text("Sakhi AI (Trauma & Legal Model)", style: TextStyle(color: Colors.pinkAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        if (!isUser) const SizedBox(height: 6),
                        Text(
                          msg.message,
                          style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(color: Colors.white38, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          if (_isGenerating)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: const [
                  SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.pinkAccent)),
                  SizedBox(width: 8),
                  Text("Sakhi AI is formulating an empathetic response...", style: TextStyle(color: Colors.pinkAccent, fontSize: 11)),
                ],
              ),
            ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: loc.isTamil ? "தமிழ் அல்லது ஆங்கிலத்தில் கேளுங்கள்..." : "Type here (Tamil or English)...",
                      hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(engine),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFFEC4899),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(engine),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text, AgentEngine engine) {
    return InkWell(
      onTap: () {
        _chatController.text = text;
        _sendMessage(engine);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.pinkAccent, fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildHelplineChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11)),
    );
  }

  void _showLegalRightsSheet(BuildContext context, LocalizationService loc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.isTamil ? "இந்தியாவில் பெண்களுக்கான அடிப்படை சட்ட உரிமைகள்" : "Fundamental Women Rights in India",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                loc.isTamil
                    ? "1. ஜீரோ FIR: எந்த காவல் நிலையத்திலும் நீங்கள் FIR பதிவு செய்யலாம். எல்லைப் பிரச்சனை கூறி மறுக்க முடியாது."
                    : "1. Zero FIR: You can file an FIR at ANY police station regardless of jurisdiction.",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                loc.isTamil
                    ? "2. ரகசியத்தன்மை: பாதிக்கப்பட்ட பெண்ணின் பெயரை வெளியிட IPC 228A / BNS 72 படி கடும் தடை உள்ளது."
                    : "2. Privacy: Victim identity cannot be disclosed under Section 228A IPC / BNS 72.",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                loc.isTamil
                    ? "3. மாலைக்கு மேல் கைது செய்ய தடை: சூரிய அஸ்தமனத்திற்குப் பிறகு பெண்களை காவல் நிலையத்திற்கு அழைக்கவோ கைது செய்யவோ முடியாது."
                    : "3. No Arrest after Sunset: Women cannot be arrested or summoned to station at night.",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                loc.isTamil
                    ? "4. தற்காப்பு உரிமை: IPC 96-106 படி ஆபத்து நேரும் போது பெண்கள் மிளகாய் ஸ்ப்ரே அல்லது அலாரம் பயன்படுத்துவது 100% சட்டப்பூர்வமானது."
                    : "4. Right of Private Defence: Using pepper spray or defensive gear is 100% legal under IPC 96-106.",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
