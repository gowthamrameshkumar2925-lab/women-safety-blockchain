import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/agent_engine.dart';

class ThreatScreen extends StatefulWidget {
  const ThreatScreen({Key? key}) : super(key: key);

  @override
  State<ThreatScreen> createState() => _ThreatScreenState();
}

class _ThreatScreenState extends State<ThreatScreen> {
  double _acceleration = 9.8;
  double _speed = 10.0;
  bool _voiceTrigger = false;
  bool _routeDeviation = false;

  void _syncTelemetry(AgentEngine engine) {
    List<String> kws = [];
    if (_voiceTrigger) {
      kws = ["help", "kaapathunga", "stop"];
    }
    engine.updateSensors(
      acc: _acceleration,
      spd: _speed,
      keywords: kws,
      deviated: _routeDeviation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<AgentEngine>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Threat Detection Agent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.greenAccent),
            ),
            child: Row(
              children: const [
                Icon(Icons.radio_button_checked, color: Colors.greenAccent, size: 12),
                SizedBox(width: 6),
                Text("LIVE SENSORS", style: TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Agent Description Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.psychology, color: Colors.cyanAccent, size: 36),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      "Autonomous Threat Agent actively calculates risk scores using on-device ML: keyword detection ('help', 'kaapathunga'), sudden jerks/drops, and route anomalies.",
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Live Risk Gauge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: engine.currentRiskScore > 75 ? Colors.redAccent : Colors.cyanAccent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Text("CALCULATED THREAT INDEX", style: TextStyle(color: Colors.white60, fontSize: 11, letterSpacing: 1.2)),
                    const SizedBox(height: 8),
                    Text(
                      "${engine.currentRiskScore} / 100",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: engine.currentRiskScore > 75
                            ? Colors.redAccent
                            : engine.currentRiskScore > 40
                                ? Colors.orangeAccent
                                : Colors.cyanAccent,
                      ),
                    ),
                    Text(
                      engine.currentRiskScore > 75
                          ? "CRITICAL RISK: SOS DISPATCH TRIGGERED"
                          : engine.currentRiskScore > 40
                              ? "CAUTION: UNUSUAL SENSOR SIGNALS"
                              : "NORMAL: ALL PARAMETERS SAFE",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: engine.currentRiskScore > 75 ? Colors.redAccent : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text("Live Telemetry & Multi-Modal Simulation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),

            // Acceleration Slider (Fall / Struggle)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("3-Axis Accelerometer Delta", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text("${_acceleration.toStringAsFixed(1)} m/s²", style: const TextStyle(color: Colors.cyanAccent, fontFamily: 'monospace')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: _acceleration,
                    min: 0.0,
                    max: 60.0,
                    activeColor: _acceleration > 35 ? Colors.redAccent : Colors.cyanAccent,
                    inactiveColor: Colors.white10,
                    onChanged: (val) {
                      setState(() => _acceleration = val);
                      _syncTelemetry(engine);
                    },
                  ),
                  Text(
                    _acceleration > 35 ? "⚠️ Sudden violent motion / physical struggle simulated" : "Normal walking / vehicle motion",
                    style: TextStyle(color: _acceleration > 35 ? Colors.redAccent : Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Voice Keyword Detection Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mic, color: Colors.purpleAccent, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Distress Voice Keywords", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                        Text("Listening for: 'help', 'kaapathunga', 'don't touch'", style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _voiceTrigger,
                    activeColor: Colors.purpleAccent,
                    onChanged: (val) {
                      setState(() => _voiceTrigger = val);
                      _syncTelemetry(engine);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Route Deviation Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.alt_route, color: Colors.amberAccent, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Geofence / Route Deviation", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                        Text("Simulate unexpected detour into dark or isolated area", style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _routeDeviation,
                    activeColor: Colors.amberAccent,
                    onChanged: (val) {
                      setState(() => _routeDeviation = val);
                      _syncTelemetry(engine);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Reset Simulation Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _acceleration = 9.8;
                    _speed = 10.0;
                    _voiceTrigger = false;
                    _routeDeviation = false;
                  });
                  _syncTelemetry(engine);
                },
                icon: const Icon(Icons.refresh, color: Colors.white70),
                label: const Text("RESET SENSORS TO NORMAL", style: TextStyle(color: Colors.white70)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
