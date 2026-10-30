import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/app_models.dart';

class BlockchainService {
  final List<BlockchainIncident> _ledger = [];
  int _counter = 1000;

  List<BlockchainIncident> get ledger => List.unmodifiable(_ledger);

  BlockchainService() {
    // Seed initial on-chain incidents
    _seedInitialData();
  }

  void _seedInitialData() {
    _ledger.add(BlockchainIncident(
      id: 1001,
      commitmentHash: "0x7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069",
      ipfsHash: "QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco",
      threat: ThreatLevel.high,
      status: IncidentStatus.investigating,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 45)),
      escalationDeadline: DateTime.now().add(const Duration(hours: 3)),
      isAnonymous: true,
      isEscalated: false,
      locationTag: "Anna Nagar, Chennai (Geo-hash: 8f28)",
      evidenceFiles: ["audio_encrypted_01.aac", "cctv_frame_clip.mp4"],
    ));

    _ledger.add(BlockchainIncident(
      id: 1002,
      commitmentHash: "0x11e4d3c6c7b94cf9e3f94a4c568f5662bb1e245a47e62a5b6f1f4569abec711a",
      ipfsHash: "QmZtmD2qt8fJpq3CLDHyt58MZhRjyba26zbG214N6H6XPN",
      threat: ThreatLevel.critical,
      status: IncidentStatus.firFiled,
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      lastUpdated: DateTime.now().subtract(const Duration(hours: 8)),
      escalationDeadline: DateTime.now().subtract(const Duration(hours: 2)),
      isAnonymous: false,
      isEscalated: false,
      locationTag: "Velachery Main Rd, Chennai",
      evidenceFiles: ["tamper_proof_route_trace.json", "microphone_stream.raw"],
    ));
  }

  /// Calculates SHA-256 hash of arbitrary digital evidence string/bytes
  String generateEvidenceHash(String inputData) {
    final bytes = utf8.encode(inputData);
    final digest = sha256.convert(bytes);
    return "0x${digest.toString()}";
  }

  /// Generates a mock IPFS CID v0/v1
  String generateIpfsCid(String rawData) {
    final bytes = utf8.encode(rawData);
    final digest = sha256.convert(bytes);
    return "Qm${digest.toString().substring(0, 44)}";
  }

  /// Commits a new incident to the blockchain ledger
  BlockchainIncident commitIncident({
    required ThreatLevel threat,
    required String rawEvidenceData,
    required bool isAnonymous,
    required String locationTag,
    required List<String> evidenceFiles,
    int slaHours = 6,
  }) {
    _counter++;
    final timestamp = DateTime.now();
    final commitmentHash = generateEvidenceHash("$rawEvidenceData-$timestamp-$_counter");
    final ipfsHash = generateIpfsCid(rawEvidenceData);

    final incident = BlockchainIncident(
      id: _counter,
      commitmentHash: commitmentHash,
      ipfsHash: ipfsHash,
      threat: threat,
      status: IncidentStatus.reported,
      timestamp: timestamp,
      lastUpdated: timestamp,
      escalationDeadline: timestamp.add(Duration(hours: slaHours)),
      isAnonymous: isAnonymous,
      isEscalated: false,
      locationTag: locationTag,
      evidenceFiles: evidenceFiles,
    );

    _ledger.insert(0, incident);
    return incident;
  }

  /// Verifies if a given piece of evidence matches its recorded on-chain hash
  bool verifyIntegrity(String rawData, String onChainHash) {
    final computed = generateEvidenceHash(rawData);
    return computed.toLowerCase() == onChainHash.toLowerCase();
  }

  /// Escalates an incident if SLA has expired or manual audit trigger
  bool escalateIncident(int id, String reason) {
    final index = _ledger.indexWhere((item) => item.id == id);
    if (index != -1) {
      final current = _ledger[index];
      _ledger[index] = BlockchainIncident(
        id: current.id,
        commitmentHash: current.commitmentHash,
        ipfsHash: current.ipfsHash,
        threat: current.threat,
        status: IncidentStatus.escalated,
        timestamp: current.timestamp,
        lastUpdated: DateTime.now(),
        escalationDeadline: current.escalationDeadline,
        isAnonymous: current.isAnonymous,
        isEscalated: true,
        locationTag: current.locationTag,
        evidenceFiles: current.evidenceFiles,
      );
      return true;
    }
    return false;
  }
}
