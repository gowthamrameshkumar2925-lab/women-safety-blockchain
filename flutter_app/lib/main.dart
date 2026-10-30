import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/blockchain_service.dart';
import 'services/agent_engine.dart';
import 'services/localization_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/threat_screen.dart';
import 'screens/safe_route_screen.dart';
import 'screens/blockchain_vault_screen.dart';
import 'screens/case_management_screen.dart';
import 'screens/safety_products_screen.dart';
import 'screens/counseling_screen.dart';
import 'screens/audit_screen.dart';
import 'screens/user_manual_screen.dart';

void main() {
  runApp(const SafeGuardApp());
}

class SafeGuardApp extends StatelessWidget {
  const SafeGuardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blockchainService = BlockchainService();

    return MultiProvider(
      providers: [
        Provider<BlockchainService>.value(value: blockchainService),
        ChangeNotifierProvider<LocalizationService>(
          create: (_) => LocalizationService(),
        ),
        ChangeNotifierProvider<AgentEngine>(
          create: (_) => AgentEngine(blockchainService),
        ),
      ],
      child: MaterialApp(
        title: 'SafeGuard 3D AI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF6366F1),
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6366F1),
            secondary: Color(0xFFEC4899),
            surface: Color(0xFF1E293B),
            background: Color(0xFF0F172A),
          ),
          fontFamily: 'Segoe UI',
          useMaterial3: true,
        ),
        home: const MainNavigationShell(),
      ),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({Key? key}) : super(key: key);

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    UserManualScreen(),
    SafetyProductsScreen(),
    ThreatScreen(),
    SafeRouteScreen(),
    BlockchainVaultScreen(),
    CaseManagementScreen(),
    CounselingScreen(),
    AuditScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationService>();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0B1120),
          indicatorColor: Colors.purple.withOpacity(0.3),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white70),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.shield_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.shield, color: Colors.purpleAccent),
              label: loc.isTamil ? 'முகப்பு' : 'SOS Guard',
            ),
            NavigationDestination(
              icon: const Icon(Icons.menu_book_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.menu_book, color: Colors.indigoAccent),
              label: loc.isTamil ? 'வழிகாட்டி' : 'Manual',
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.shopping_bag, color: Colors.pinkAccent),
              label: loc.isTamil ? 'பாதுகாப்பு சாதனங்கள்' : 'Safety Gear',
            ),
            NavigationDestination(
              icon: const Icon(Icons.sensors, color: Colors.white60),
              selectedIcon: const Icon(Icons.sensors, color: Colors.cyanAccent),
              label: loc.isTamil ? 'சென்சார் AI' : 'Threat AI',
            ),
            NavigationDestination(
              icon: const Icon(Icons.map_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.map, color: Colors.greenAccent),
              label: loc.isTamil ? 'வழித்தடம்' : 'Safe Route',
            ),
            NavigationDestination(
              icon: const Icon(Icons.link, color: Colors.white60),
              selectedIcon: const Icon(Icons.link, color: Colors.indigoAccent),
              label: loc.isTamil ? 'பிளாக்செயின்' : 'Blockchain',
            ),
            NavigationDestination(
              icon: const Icon(Icons.description_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.description, color: Colors.amberAccent),
              label: loc.isTamil ? 'FIR புகார்' : 'FIR Agent',
            ),
            NavigationDestination(
              icon: const Icon(Icons.support_agent, color: Colors.white60),
              selectedIcon: const Icon(Icons.support_agent, color: Colors.pinkAccent),
              label: loc.isTamil ? 'ஆறுதல் AI' : 'Counseling',
            ),
            NavigationDestination(
              icon: const Icon(Icons.timer_outlined, color: Colors.white60),
              selectedIcon: const Icon(Icons.timer, color: Colors.orangeAccent),
              label: loc.isTamil ? 'கண்காணிப்பு' : 'Audit SLA',
            ),
          ],
        ),
      ),
    );
  }
}
