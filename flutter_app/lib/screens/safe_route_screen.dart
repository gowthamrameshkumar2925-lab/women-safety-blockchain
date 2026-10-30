import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';
import '../models/app_models.dart';

class SafeRouteScreen extends StatelessWidget {
  const SafeRouteScreen({Key? key}) : super(key: key);

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.greenAccent;
    if (score >= 60) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AgentEngine>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Safe Route Agent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.greenAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Recalculating corridor with real-time street lighting & CCTV feeds...")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Visualization Placeholder / Card
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    const Color(0xFF0F766E).withOpacity(0.3),
                    const Color(0xFF1E293B),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map, size: 48, color: Colors.greenAccent),
                        SizedBox(height: 8),
                        Text("Live Safe Corridor Map", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Sensors: 14 CCTV Nodes • 82% Streetlight Lumens", style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.shield_outlined, color: Colors.greenAccent, size: 14),
                          SizedBox(width: 4),
                          Text("AI Guard Active", style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text("AI-Evaluated Navigation Routes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            ...engine.routes.map((route) => _buildRouteCard(context, route)).toList(),

            const SizedBox(height: 20),

            const Text("Nearby Safe Havens (Within 1.5 km)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            _buildSafeHavenCard("All-Women Police Station (W-1)", "0.6 km away • Armed patrol available", Icons.local_police, Colors.blueAccent),
            _buildSafeHavenCard("Apollo 24x7 Pharmacy", "0.3 km away • Well-lit, active CCTV coverage", Icons.local_pharmacy, Colors.tealAccent),
            _buildSafeHavenCard("Metro Station Help Desk", "0.8 km away • CISF security post", Icons.train, Colors.purpleAccent),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteCard(BuildContext context, SafeRouteOption route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getScoreColor(route.safetyScore).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  route.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getScoreColor(route.safetyScore).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${route.safetyScore}% Safe",
                  style: TextStyle(color: _getScoreColor(route.safetyScore), fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(route.summary, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricChip(Icons.wb_incandescent, "${route.lightingScore}% Lighting", Colors.amberAccent),
              _buildMetricChip(Icons.people, "${route.crowdDensityScore}% Crowd", Colors.cyanAccent),
              _buildMetricChip(Icons.domain, "${route.safeHavensCount} Safe Havens", Colors.greenAccent),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Navigation started: ${route.title}")),
                );
              },
              icon: const Icon(Icons.navigation_outlined, size: 16),
              label: const Text("START SAFE CORRIDOR NAVIGATION"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _getScoreColor(route.safetyScore).withOpacity(0.8),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white60, fontSize: 11)),
      ],
    );
  }

  Widget _buildSafeHavenCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.directions, color: Colors.greenAccent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
