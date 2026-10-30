import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import 'blockchain_service.dart';

class AgentEngine extends ChangeNotifier {
  final BlockchainService blockchainService;

  // Real-time sensor state
  double _acceleration = 9.8;
  double _speed = 12.0;
  List<String> _detectedKeywords = [];
  bool _routeDeviated = false;
  int _currentRiskScore = 15; // 0-100
  bool _isAutoThreatActive = true;
  bool _isSosTriggered = false;

  // Logs from all 7 agents
  final List<AgentLog> _agentLogs = [];

  // Counseling Chat history
  final List<ChatMessage> _chatMessages = [];

  // Generated FIRs
  final List<FIRDraft> _firDrafts = [];

  // Safe Routes
  final List<SafeRouteOption> _routes = [];

  AgentEngine(this.blockchainService) {
    _initAgents();
  }

  // Getters
  double get acceleration => _acceleration;
  double get speed => _speed;
  List<String> get detectedKeywords => List.unmodifiable(_detectedKeywords);
  bool get routeDeviated => _routeDeviated;
  int get currentRiskScore => _currentRiskScore;
  bool get isAutoThreatActive => _isAutoThreatActive;
  bool get isSosTriggered => _isSosTriggered;
  List<AgentLog> get agentLogs => List.unmodifiable(_agentLogs);
  List<ChatMessage> get chatMessages => List.unmodifiable(_chatMessages);
  List<FIRDraft> get firDrafts => List.unmodifiable(_firDrafts);
  List<SafeRouteOption> get routes => List.unmodifiable(_routes);

  void _initAgents() {
    _log("System", "BOOT", "All 7 Agents (Threat, SOS, Evidence, SafeRoute, CaseMgmt, Counseling, Audit) loaded.");
    _log("Threat Detection Agent", "MONITORING", "Listening to sensor delta, geofence, and mic stream.", isAlert: false);
    _log("Audit Agent", "SLA_WATCHDOG", "Monitoring authority response times on active incidents.", isAlert: false);

    _chatMessages.add(ChatMessage(
      sender: 'counselor_agent',
      message: 'Hello! I am your 24/7 AI Safety & Legal Companion. You are in a safe space. You can speak to me in Tamil or English. How can I help you today?',
      timestamp: DateTime.now(),
    ));

    _generateSafeRoutes();
  }

  void _log(String agent, String action, String detail, {bool isAlert = false}) {
    _agentLogs.insert(0, AgentLog(
      agentName: agent,
      action: action,
      detail: detail,
      timestamp: DateTime.now(),
      isAlert: isAlert,
    ));
    notifyListeners();
  }

  /// AGENT 1: Threat Detection Agent
  void updateSensors({
    required double acc,
    required double spd,
    required List<String> keywords,
    required bool deviated,
  }) {
    _acceleration = acc;
    _speed = spd;
    _detectedKeywords = keywords;
    _routeDeviated = deviated;

    int score = 10;

    // Evaluate sudden acceleration / jerk / fall
    if (_acceleration > 35.0 || _acceleration < 3.0) {
      score += 35;
      _log("Threat Detection Agent", "ANOMALY", "Abnormal sudden jerk or fall detected (${_acceleration.toStringAsFixed(1)} m/s²).", isAlert: true);
    }

    // Evaluate keywords
    if (_detectedKeywords.isNotEmpty) {
      score += 45;
      _log("Threat Detection Agent", "VOICE_TRIGGER", "Critical distress keywords recognized: ${_detectedKeywords.join(', ')}", isAlert: true);
    }

    // Evaluate route deviation
    if (_routeDeviated) {
      score += 25;
      _log("Threat Detection Agent", "GEO_DEVIATION", "User deviated 500m+ from intended corridor into low-illumination zone.", isAlert: true);
    }

    _currentRiskScore = score.clamp(0, 100);

    if (_currentRiskScore >= 75 && !_isSosTriggered) {
      _log("Threat Detection Agent", "THRESHOLD_BREACHED", "Risk Score: $_currentRiskScore/100. Auto-invoking SOS Response Agent!", isAlert: true);
      triggerSOS(source: "Automated Threat Agent");
    } else {
      notifyListeners();
    }
  }

  /// AGENT 2: SOS Response Agent & AGENT 3: Evidence Agent
  void triggerSOS({String source = "Manual SOS Button"}) {
    _isSosTriggered = true;
    _currentRiskScore = 98;

    _log("SOS Response Agent", "DISPATCH", "CRITICAL ALERT! Contacting Emergency 112, Dial 100, and 3 Trusted Contacts with live GPS (13.0827° N, 80.2707° E).", isAlert: true);

    // Trigger Evidence Agent
    _captureAndSecureEvidence();

    notifyListeners();
  }

  void cancelSOS() {
    _isSosTriggered = false;
    _currentRiskScore = 15;
    _detectedKeywords = [];
    _log("SOS Response Agent", "STANDBY", "SOS dismissed by user with biometric/PIN confirmation.");
    notifyListeners();
  }

  /// AGENT 3: Evidence Agent
  void _captureAndSecureEvidence() {
    final mockAudio = "EncryptedAudioChunk_${DateTime.now().millisecondsSinceEpoch}";
    final mockVideo = "360_FrontBackCamStream_${DateTime.now().millisecondsSinceEpoch}";
    final rawTelemetry = "Accel: $_acceleration | Speed: $_speed | Keywords: $_detectedKeywords";

    _log("Evidence Agent", "TAMPER_PROOF_SEAL", "Capturing 30-sec ambient audio & dual-camera snap. Generating cryptographic hashes...");

    final incident = blockchainService.commitIncident(
      threat: ThreatLevel.critical,
      rawEvidenceData: "$mockAudio-$mockVideo-$rawTelemetry",
      isAnonymous: false,
      locationTag: "Anna Salai, Chennai (GPS: 13.0827, 80.2707)",
      evidenceFiles: ["ambient_audio_001.opus.enc", "cam_evidence_front.jpg.enc", "telemetry_dump.json"],
      slaHours: 4,
    );

    _log("Evidence Agent", "BLOCKCHAIN_COMMITTED", "Pinned to IPFS (${incident.ipfsHash.substring(0, 14)}...). Recorded on Polygon Smart Contract #Tx: ${incident.commitmentHash.substring(0, 16)}...", isAlert: false);
  }

  /// AGENT 4: Safe Route Agent
  void _generateSafeRoutes() {
    _routes.clear();
    _routes.addAll([
      SafeRouteOption(
        title: "Recommended: Green Corridor (Well-lit, High Crowd)",
        distanceKm: 3.4,
        safetyScore: 94,
        lightingScore: 92,
        crowdDensityScore: 88,
        safeHavensCount: 6,
        summary: "Passes through active commercial street, 2 metro stations, and 1 police outpost.",
      ),
      SafeRouteOption(
        title: "Fastest: Main Arterial Highway",
        distanceKm: 2.8,
        safetyScore: 78,
        lightingScore: 85,
        crowdDensityScore: 60,
        safeHavensCount: 3,
        summary: "High vehicle traffic, moderate pedestrian density. Moderate safe-haven coverage.",
      ),
      SafeRouteOption(
        title: "Avoid: Short-cut via Cross Roads",
        distanceKm: 2.1,
        safetyScore: 38,
        lightingScore: 25,
        crowdDensityScore: 18,
        safeHavensCount: 0,
        summary: "Low lighting, deserted alleys, blind spots. Not advised after 8 PM.",
      ),
    ]);
  }

  /// AGENT 5: Case Management Agent (Generates FIR drafts with Indian Legal sections)
  FIRDraft generateFIRDraft({
    required String incidentType,
    required String description,
    required bool isAnonymous,
  }) {
    List<String> sections = [];
    if (incidentType.contains("Stalking") || incidentType.contains("Following")) {
      sections.add("BNS Section 78 / IPC 354D (Stalking)");
    }
    if (incidentType.contains("Harassment") || incidentType.contains("Eve-teasing")) {
      sections.add("BNS Section 79 / IPC 509 (Insulting modesty of a woman)");
    }
    if (incidentType.contains("Assault") || incidentType.contains("Physical")) {
      sections.add("BNS Section 74 / IPC 354 (Assault with intent to outrage modesty)");
    }
    if (sections.isEmpty) {
      sections.add("BNS Section 79 / IPC 509");
    }

    final draft = FIRDraft(
      caseId: "FIR-SAFE-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
      victimPseudonym: isAnonymous ? "Protected Citizen (ZK-Verified #89a)" : "Registered User",
      incidentType: incidentType,
      description: description,
      legalSections: sections,
      generatedAt: DateTime.now().toLocal().toString().split('.')[0],
      blockchainProof: blockchainService.generateEvidenceHash("FIR-$incidentType-$description"),
      isAnonymous: isAnonymous,
    );

    _firDrafts.insert(0, draft);
    _log("Case Management Agent", "FIR_DRAFTED", "Legal draft prepared under ${sections.join(', ')}. Tamper-proof hash attached.", isAlert: false);
    notifyListeners();
    return draft;
  }

  /// AGENT 6: Counseling Agent
  void sendCounselingMessage(String userMsg) {
    _chatMessages.add(ChatMessage(
      sender: 'user',
      message: userMsg,
      timestamp: DateTime.now(),
    ));

    String reply = "I am listening to you. You are completely safe and supported here.";
    final lower = userMsg.toLowerCase();

    if (lower.contains("bayama") || lower.contains("fear") || lower.contains("scared") || lower.contains("threat")) {
      reply = "Please take a deep breath. You are not alone. Your location is being monitored by our agents. If you feel immediate danger, press the SOS button right away, or call the 112 emergency helpline. Would you like me to connect you to a trusted contact or volunteer?";
    } else if (lower.contains("fir") || lower.contains("police") || lower.contains("complain") || lower.contains("rights")) {
      reply = "Under Indian Law (Zero FIR principle), you have the right to file an FIR at ANY police station regardless of jurisdiction. Furthermore, women have the right to confidential statements and cannot be called to a police station at night. Our Case Management Agent can auto-draft your FIR.";
    } else if (lower.contains("anonymous") || lower.contains("privacy") || lower.contains("identity")) {
      reply = "Your privacy is protected with Zero-Knowledge proofs and decentralized identity (DID). You can submit reports and tamper-proof evidence to authorities without public disclosure of your personal identity.";
    } else {
      reply = "Thank you for reaching out. We have registered your input. Our counseling support and legal guidance agents are active 24/7. Remember you can dial 1091 (Women Helpline) or 181 anytime.";
    }

    Timer(const Duration(milliseconds: 600), () {
      _chatMessages.add(ChatMessage(
        sender: 'counselor_agent',
        message: reply,
        timestamp: DateTime.now(),
      ));
      _log("Counseling Agent", "SUPPORT_PROVIDED", "Empathy & legal response provided to user query.");
      notifyListeners();
    });

    notifyListeners();
  }

  /// AGENT 7: Audit Agent
  void triggerAuditEscalation(int incidentId) {
    final success = blockchainService.escalateIncident(incidentId, "SLA SLA_BREACH: No initial investigation report logged within statutory time limit.");
    if (success) {
      _log("Audit Agent", "ESCALATION_FIRED", "Incident #$incidentId escalated to Higher Supervisory Officer / State Women Commission due to response delay.", isAlert: true);
      notifyListeners();
    }
  }
}
