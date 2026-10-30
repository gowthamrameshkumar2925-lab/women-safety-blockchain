import 'package:flutter/foundation.dart';

enum ThreatLevel { low, medium, high, critical }
enum IncidentStatus { reported, investigating, firFiled, escalated, resolved }

class SensorTelemetry {
  final double acceleration; // m/s^2
  final double speed;        // km/h
  final double latitude;
  final double longitude;
  final List<String> detectedKeywords;
  final bool isRouteDeviated;
  final DateTime timestamp;

  SensorTelemetry({
    required this.acceleration,
    required this.speed,
    required this.latitude,
    required this.longitude,
    required this.detectedKeywords,
    required this.isRouteDeviated,
    required this.timestamp,
  });
}

class AgentLog {
  final String agentName;
  final String action;
  final String detail;
  final DateTime timestamp;
  final bool isAlert;

  AgentLog({
    required this.agentName,
    required this.action,
    required this.detail,
    required this.timestamp,
    this.isAlert = false,
  });
}

class BlockchainIncident {
  final int id;
  final String commitmentHash;
  final String ipfsHash;
  final ThreatLevel threat;
  final IncidentStatus status;
  final DateTime timestamp;
  final DateTime lastUpdated;
  final DateTime escalationDeadline;
  final bool isAnonymous;
  final bool isEscalated;
  final String locationTag;
  final List<String> evidenceFiles;

  BlockchainIncident({
    required this.id,
    required this.commitmentHash,
    required this.ipfsHash,
    required this.threat,
    required this.status,
    required this.timestamp,
    required this.lastUpdated,
    required this.escalationDeadline,
    required this.isAnonymous,
    required this.isEscalated,
    required this.locationTag,
    required this.evidenceFiles,
  });
}

class SafeRouteOption {
  final String title;
  final double distanceKm;
  final int safetyScore; // 0 - 100
  final int lightingScore; // 0 - 100
  final int crowdDensityScore; // 0 - 100
  final int safeHavensCount;
  final String summary;

  SafeRouteOption({
    required this.title,
    required this.distanceKm,
    required this.safetyScore,
    required this.lightingScore,
    required this.crowdDensityScore,
    required this.safeHavensCount,
    required this.summary,
  });
}

class FIRDraft {
  final String caseId;
  final String victimPseudonym;
  final String incidentType;
  final String description;
  final List<String> legalSections;
  final String generatedAt;
  final String blockchainProof;
  final bool isAnonymous;

  FIRDraft({
    required this.caseId,
    required this.victimPseudonym,
    required this.incidentType,
    required this.description,
    required this.legalSections,
    required this.generatedAt,
    required this.blockchainProof,
    required this.isAnonymous,
  });
}

class ChatMessage {
  final String sender; // 'user' or 'counselor_agent'
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}
