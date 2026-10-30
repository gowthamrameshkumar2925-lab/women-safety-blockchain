import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';
import '../services/localization_service.dart';
import '../models/app_models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Color _getRiskColor(int score) {
    if (score < 30) return Colors.greenAccent;
    if (score < 70) return Colors.orangeAccent;
    return Colors.redAccent;
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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
              ),
              child: const Icon(Icons.shield, color: Colors.purpleAccent, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.tr('app_title'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
                Text(loc.tr('app_subtitle'), style: const TextStyle(fontSize: 10, color: Colors.greenAccent)),
              ],
            ),
          ],
        ),
        actions: [
          // 3D Glassmorphic Language Toggle Button
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              onTap: () => loc.toggleLanguage(),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.purpleAccent.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 3)),
                  ],
                  border: Border.all(color: Colors.white30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.language, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      loc.isTamil ? "English" : "தமிழ்",
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // 3D Beveled Risk Meter Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E293B),
                    _getRiskColor(engine.currentRiskScore).withOpacity(0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: _getRiskColor(engine.currentRiskScore).withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: _getRiskColor(engine.currentRiskScore).withOpacity(0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: CircularProgressIndicator(
                          value: engine.currentRiskScore / 100,
                          strokeWidth: 9,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation<Color>(_getRiskColor(engine.currentRiskScore)),
                        ),
                      ),
                      Text(
                        "${engine.currentRiskScore}%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getRiskColor(engine.currentRiskScore),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          engine.currentRiskScore >= 75
                              ? loc.tr('critical_status')
                              : engine.currentRiskScore >= 40
                                  ? loc.tr('elevated_status')
                                  : loc.tr('secure_status'),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getRiskColor(engine.currentRiskScore),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          engine.isSosTriggered
                              ? (loc.isTamil ? "காவல்துறைக்கு நேரலை GPS அனுப்பப்பட்டது. சான்றுகள் பிளாக்செயினில் பூட்டப்பட்டன." : "Police alerted with live GPS. Evidence anchored to blockchain.")
                              : (loc.isTamil ? "சென்சார்கள், ஆடியோ மற்றும் வழிகளை AI தொடர்ச்சியாக கண்காணிக்கிறது." : "Threat Agent monitoring audio, motion & route deviations in real-time."),
                          style: const TextStyle(fontSize: 11, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Giant 3D Skeuomorphic SOS Sphere
            Center(
              child: engine.isSosTriggered
                  ? Column(
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(0.2),
                            border: Border.all(color: Colors.redAccent, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.7),
                                blurRadius: 50,
                                spreadRadius: 15,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.warning_amber_rounded, size: 75, color: Colors.redAccent),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => engine.cancelSOS(),
                          icon: const Icon(Icons.check_circle_outline),
                          label: Text(loc.tr('sos_cancel')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white12,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () => engine.triggerSOS(source: "Manual Touch"),
                      child: Container(
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            center: Alignment(-0.3, -0.4),
                            colors: [Color(0xFFFF5277), Color(0xFFD6002F), Color(0xFF700018)],
                            stops: [0.1, 0.6, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF2A55).withOpacity(0.55),
                              blurRadius: 35,
                              spreadRadius: 8,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 15),
                            ),
                          ],
                          border: Border.all(color: Colors.white.withOpacity(0.35), width: 2.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.touch_app, size: 42, color: Colors.white),
                            const SizedBox(height: 6),
                            const Text(
                              "S O S",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                                color: Colors.white,
                                shadows: [Shadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 4)],
                              ),
                            ),
                            Text(
                              loc.tr('sos_tap_hint'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 9, color: Colors.white70, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 32),

            // Easy Access Tools Row with 3D Bevels
            Row(
              children: [
                _buildQuickAction(
                  context,
                  icon: Icons.phone_in_talk,
                  label: loc.tr('fake_call'),
                  color: Colors.blueAccent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.isTamil ? "அம்மாவிடமிருந்து போலி அழைப்பு தொடங்கப்பட்டது..." : "Simulating Fake Call from 'Mom'...")),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  context,
                  icon: Icons.directions_walk,
                  label: loc.tr('safe_walk'),
                  color: Colors.tealAccent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.isTamil ? "பாதுகாப்பு நடை வழிகாட்டி செயல்படுத்தப்பட்டது." : "Safe Walk Guardian activated.")),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  context,
                  icon: Icons.local_police_outlined,
                  label: loc.tr('dial_112'),
                  color: Colors.amberAccent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.isTamil ? "112 அவசர உதவி மையம் தொடர்பு கொள்ளப்படுகிறது." : "Connecting to Emergency 112 Dispatch...")),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Autonomous Agent Mesh
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loc.tr('agent_mesh'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                Text(loc.tr('agents_active'), style: const TextStyle(color: Colors.purpleAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            _buildAgentTile(loc.isTamil ? "ஆபத்து கண்டறிதல் ஏஜென்ட்" : "Threat Detection Agent", loc.isTamil ? "குரல் & சென்சார் தொலைநிலை கண்காணிப்பு" : "Real-time voice & acceleration telemetry", Icons.sensors, Colors.cyanAccent),
            _buildAgentTile(loc.isTamil ? "SOS மீட்பு ஏஜென்ட்" : "SOS Response Agent", loc.isTamil ? "112 காவல்துறை & தன்னார்வலர் இணைப்பு" : "Emergency police dispatch & volunteer mesh", Icons.emergency, Colors.redAccent),
            _buildAgentTile(loc.isTamil ? "சான்று ஏஜென்ட் (பிளாக்செயின்)" : "Evidence Agent (Blockchain)", loc.isTamil ? "IPFS & பாலிகான் ஸ்மார்ட் ஒப்பந்தம்" : "IPFS hashing & Polygon smart contracts", Icons.link, Colors.indigoAccent),
            _buildAgentTile(loc.isTamil ? "பாதுகாப்பான வழித்தட ஏஜென்ட்" : "Safe Route Agent", loc.isTamil ? "தெருவிளக்கு & குற்ற விகித பகுப்பாய்வு" : "Street lighting & crime heatmaps", Icons.map_outlined, Colors.greenAccent),
            _buildAgentTile(loc.isTamil ? "FIR வழக்கு தயாரிப்பு ஏஜென்ட்" : "Case Management Agent", loc.isTamil ? "BNS/IPC பிரிவுகளுடன் தானியங்கி புகார்" : "Automated FIR drafts & BNS legal sections", Icons.description_outlined, Colors.amberAccent),
            _buildAgentTile(loc.isTamil ? "ஆறுதல் தரும் AI ஏஜென்ட்" : "Empathetic Counselor", loc.isTamil ? "மன தைரியம் & ஜீரோ FIR உரிமைகள்" : "Trauma support & zero-knowledge legal rights", Icons.support_agent, Colors.pinkAccent),
            _buildAgentTile(loc.isTamil ? "கண்காணிப்பு ஏஜென்ட் (Audit)" : "Audit Watchdog Agent", loc.isTamil ? "அதிகாரிகள் காலக்கெடு & மேல்முறையீடு" : "Authorities SLA & non-action auto-escalations", Icons.timer_outlined, Colors.purpleAccent),

            const SizedBox(height: 24),

            // Live Activity Stream
            Row(
              children: [
                const Icon(Icons.terminal, color: Colors.white70, size: 18),
                const SizedBox(width: 8),
                Text(loc.tr('live_logs'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF020617),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: engine.agentLogs.isEmpty
                  ? const Text("No events recorded yet.", style: TextStyle(color: Colors.white54))
                  : Column(
                      children: engine.agentLogs.take(5).map((log) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "[${log.timestamp.hour.toString().padLeft(2, '0')}:${log.timestamp.minute.toString().padLeft(2, '0')}] ",
                                style: const TextStyle(color: Colors.cyanAccent, fontSize: 11, fontFamily: 'monospace'),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                                    children: [
                                      TextSpan(
                                        text: "${log.agentName}: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: log.isAlert ? Colors.redAccent : Colors.purpleAccent,
                                        ),
                                      ),
                                      TextSpan(text: log.detail),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF1E293B), const Color(0xFF131D31)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.35)),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgentTile(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ],
      ),
    );
  }
}
