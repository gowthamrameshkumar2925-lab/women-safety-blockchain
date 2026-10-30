import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';
import '../services/blockchain_service.dart';

class AuditScreen extends StatelessWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AgentEngine>();
    final bcService = context.watch<BlockchainService>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Audit & Accountability Agent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accountability Mission Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.query_stats, color: Colors.purpleAccent, size: 36),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "The Audit Agent holds authorities accountable. If police/responders fail to act on a verified incident within SLA deadlines, the smart contract auto-escalates to state supervisory bodies.",
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // SLA Performance Metrics
            Row(
              children: [
                _buildMetricCard("Avg Police Response", "8.4 Mins", Icons.timer, Colors.greenAccent),
                const SizedBox(width: 12),
                _buildMetricCard("Escalation Rate", "4.2%", Icons.trending_down, Colors.cyanAccent),
                const SizedBox(width: 12),
                _buildMetricCard("SLA Compliance", "95.8%", Icons.verified_user, Colors.purpleAccent),
              ],
            ),

            const SizedBox(height: 28),

            const Text("Active Cases Under SLA Watchdog", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            ...bcService.ledger.map((incident) {
              final isBreached = DateTime.now().isAfter(incident.escalationDeadline) && !incident.isEscalated;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: incident.isEscalated
                        ? Colors.redAccent.withOpacity(0.5)
                        : isBreached
                            ? Colors.orangeAccent.withOpacity(0.5)
                            : Colors.white12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Incident #${incident.id}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: incident.isEscalated ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            incident.isEscalated ? "ESCALATED TO DGP" : "SLA ACTIVE",
                            style: TextStyle(
                              color: incident.isEscalated ? Colors.redAccent : Colors.greenAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Location: ${incident.locationTag}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    Text("Escalation Deadline: ${incident.escalationDeadline.hour}:${incident.escalationDeadline.minute.toString().padLeft(2, '0')}", style: const TextStyle(color: Colors.white54, fontSize: 11)),
                    const SizedBox(height: 12),

                    if (!incident.isEscalated)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            engine.triggerAuditEscalation(incident.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Incident #${incident.id} auto-escalated on-chain!")),
                            );
                          },
                          icon: const Icon(Icons.flash_on, size: 16, color: Colors.orangeAccent),
                          label: const Text("TRIGGER SMART CONTRACT ESCALATION", style: TextStyle(color: Colors.orangeAccent, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.orangeAccent),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: const [
                            Icon(Icons.warning, color: Colors.redAccent, size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Escalation registered on blockchain block #4819230. Notice served to State Women's Commission.",
                                style: TextStyle(color: Colors.redAccent, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
