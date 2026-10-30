import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';
import '../models/app_models.dart';

class CaseManagementScreen extends StatefulWidget {
  const CaseManagementScreen({Key? key}) : super(key: key);

  @override
  State<CaseManagementScreen> createState() => _CaseManagementScreenState();
}

class _CaseManagementScreenState extends State<CaseManagementScreen> {
  final TextEditingController _descController = TextEditingController();
  String _selectedCategory = "Stalking & Following";
  bool _isAnonymous = true;

  final List<String> _categories = [
    "Stalking & Following",
    "Harassment & Eve-teasing",
    "Physical Assault & Battery",
    "Online Cyber Stalking / Blackmail",
    "Public Transport Misconduct",
  ];

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AgentEngine>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Case Management & FIR Agent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.gavel, color: Colors.amberAccent, size: 32),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "Automated legal drafting powered by BNS/IPC knowledge base. Formulates court-ready FIR drafts with cryptographic chain-of-custody verification.",
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Incident Category Selector
            const Text("Incident Classification", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  dropdownColor: const Color(0xFF1E293B),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  isExpanded: true,
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Anonymous Reporting Switch
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_moon_outlined, color: Colors.purpleAccent, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Zero-Knowledge Anonymous Filing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                        Text("Mask identity with cryptographic proof. Only courts/judges can decrypt with judicial warrant.", style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isAnonymous,
                    activeColor: Colors.purpleAccent,
                    onChanged: (val) => setState(() => _isAnonymous = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Incident Description
            const Text("Incident Narrative & Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: "State time, location, suspect description, or circumstances (e.g. Followed from bus stand to residence by person on black scooter)...",
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: const Color(0xFF1E293B),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 16),

            // Generate FIR Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final text = _descController.text.trim();
                  if (text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please write a brief description of the incident.")),
                    );
                    return;
                  }

                  engine.generateFIRDraft(
                    incidentType: _selectedCategory,
                    description: text,
                    isAnonymous: _isAnonymous,
                  );

                  _descController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("FIR Draft generated and registered on-chain!")),
                  );
                },
                icon: const Icon(Icons.description, size: 18),
                label: const Text("GENERATE LEGAL FIR DRAFT"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Generated FIR Drafts
            const Text("Generated Legal Drafts & FIRs", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            if (engine.firDrafts.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("No FIR drafts generated yet. Submit details above to create one.", style: TextStyle(color: Colors.white38, fontSize: 12)),
                ),
              )
            else
              ...engine.firDrafts.map((fir) => _buildFIRDraftCard(context, fir)).toList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFIRDraftCard(BuildContext context, FIRDraft fir) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amberAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fir.caseId, style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14)),
              Text(fir.generatedAt, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 8),
          Text("Complainant: ${fir.victimPseudonym}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text("Category: ${fir.incidentType}", style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(fir.description, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: fir.legalSections.map((sec) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.amberAccent.withOpacity(0.4)),
              ),
              child: Text(sec, style: const TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
          const SizedBox(height: 12),
          Text("Proof Hash: ${fir.blockchainProof.substring(0, 24)}...", style: const TextStyle(color: Colors.cyanAccent, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
