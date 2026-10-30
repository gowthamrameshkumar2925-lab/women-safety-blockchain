import 'package:flutter/foundation.dart';

enum AppLanguage { en, ta }

class LocalizationService extends ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.ta; // Default to Tamil as requested

  AppLanguage get currentLanguage => _currentLanguage;
  bool get isTamil => _currentLanguage == AppLanguage.ta;

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == AppLanguage.ta ? AppLanguage.en : AppLanguage.ta;
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    _currentLanguage = lang;
    notifyListeners();
  }

  String tr(String key) {
    if (_currentLanguage == AppLanguage.ta) {
      return _tamilStrings[key] ?? _englishStrings[key] ?? key;
    }
    return _englishStrings[key] ?? key;
  }

  static const Map<String, String> _englishStrings = {
    // App Bar & Global
    'app_title': 'SafeGuard 3D AI',
    'app_subtitle': 'Multi-Agent & Blockchain Active',
    'lang_switch': 'தமிழ்',
    'easy_access': 'Easy Access',
    'manual_tab': 'User Manual',

    // Dashboard
    'risk_index': 'CURRENT RISK INDEX',
    'secure_status': 'SURROUNDINGS SECURE',
    'critical_status': 'CRITICAL THREAT DETECTED',
    'elevated_status': 'ELEVATED RISK LEVEL',
    'sos_tap_hint': 'HOLD OR TAP IN EMERGENCY',
    'sos_cancel': 'I AM SAFE / CANCEL SOS',
    'fake_call': 'Fake Call',
    'safe_walk': 'Safe Walk',
    'dial_112': 'Dial 112',
    'agent_mesh': 'Autonomous Agent Mesh',
    'agents_active': '7 Agents Active',
    'live_logs': 'Live Multi-Agent Activity Log',

    // Threat Agent
    'threat_title': 'Threat Detection Agent',
    'live_sensors': 'LIVE SENSORS',
    'sensor_desc': 'Autonomous Threat Agent calculates risk scores using on-device ML: keyword detection, sudden falls/jerks, and route anomalies.',
    'acc_label': '3-Axis Accelerometer (Fall / Struggle)',
    'voice_label': 'Distress Voice Keywords',
    'voice_sub': 'Listens for: "Help", "Kaapathunga", "Stop", "Don\'t touch"',
    'route_label': 'Geofence / Route Deviation',
    'route_sub': 'Unexpected detour into unlit dark zone',
    'reset_sensors': 'RESET SENSORS TO NORMAL',

    // Safe Route
    'route_title': 'Safe Route Agent',
    'route_corridor': 'Live Safe Corridor Map',
    'route_rec': 'Recommended: Commercial Corridor',
    'safe_havens': 'Nearby Safe Havens (Within 1.5 km)',
    'start_nav': 'START SAFE CORRIDOR NAVIGATION',

    // Blockchain
    'vault_title': 'Blockchain Evidence Vault',
    'vault_desc': 'Forensic evidence hashed with SHA-256 and anchored to Polygon Smart Contracts. Legally admissible under Bharatiya Sakshya Adhiniyam (BSA 65B).',
    'ledger_records': 'On-Chain Incident Ledger',
    'verify_btn': 'VERIFY ON BLOCKCHAIN',

    // Case Mgmt
    'case_title': 'Case Management & FIR Agent',
    'case_desc': 'Automated legal complaint drafting with BNS / IPC sections and Zero-Knowledge anonymous protection.',
    'draft_fir_btn': 'GENERATE LEGAL FIR DRAFT',

    // Counselor
    'counselor_title': 'Empathetic Counselor Agent',
    'counselor_desc': '24/7 AI companion offering trauma support, privacy guidance, and legal rights.',
    'type_placeholder': 'Type in Tamil or English (e.g. "Enaku bayama iruku")...',

    // Audit
    'audit_title': 'Audit & Accountability Watchdog',
    'audit_desc': 'Smart contract watchdog enforcing police response deadlines (SLA). Breaches auto-escalate to State Commission.',
    'escalate_btn': 'TRIGGER SMART CONTRACT ESCALATION',

    // User Manual
    'manual_title': 'Quick & Easy User Guide',
    'manual_sub': 'How SafeGuard protects you in 5 simple steps',
    'step1_title': '1. Emergency SOS Trigger',
    'step1_desc': 'Press the 3D Red SOS button or shake your phone violently 3 times. It immediately alerts Police (112) and 3 contacts with live GPS.',
    'step2_title': '2. Hands-Free Voice Detection',
    'step2_desc': 'When your hands are tied or phone is in bag, say "HELP" or "காப்பாத்துங்க" (Kaapathunga). Threat Agent automatically starts SOS.',
    'step3_title': '3. Blockchain Evidence Vault',
    'step3_desc': 'During SOS, audio & camera bursts are encrypted and locked on blockchain. Perpetrators or corrupt officials CANNOT delete or modify evidence.',
    'step4_title': '4. Safe Route Navigation',
    'step4_desc': 'Going home late? Safe Route highlights well-lit streets, crowd density, and safe havens like metro stations & 24x7 pharmacies.',
    'step5_title': '5. Zero FIR & Anonymity',
    'step5_desc': 'Draft official police complaints with full legal sections (BNS 78, 79). Use Zero-Knowledge mode to file complaints anonymously.',
  };

  static const Map<String, String> _tamilStrings = {
    // App Bar & Global
    'app_title': 'சேஃப்கார்ட் 3D AI',
    'app_subtitle': 'மல்டி-ஏஜென்ட் & பிளாக்செயின் பாதுகாப்பு',
    'lang_switch': 'English',
    'easy_access': 'எளிதான அணுகல்',
    'manual_tab': 'பயனர் வழிகாட்டி',

    // Dashboard
    'risk_index': 'தற்போதைய ஆபத்து மதிப்பீடு',
    'secure_status': 'சுற்றுப்புறம் பாதுகாப்பானது',
    'critical_status': 'அவசர ஆபத்து கண்டறியப்பட்டது!',
    'elevated_status': 'எச்சரிக்கை: அதிகரித்த ஆபத்து',
    'sos_tap_hint': 'அவசர உதவிக்கு தொடவும் அல்லது அழுத்தவும்',
    'sos_cancel': 'நான் பாதுகாப்பாக உள்ளேன் / ரத்து செய்',
    'fake_call': 'போலி அழைப்பு',
    'safe_walk': 'பாதுகாப்பு நடை',
    'dial_112': '112-க்கு அழையுங்கள்',
    'agent_mesh': 'தன்னாட்சி AI ஏஜென்ட் கட்டமைப்பு',
    'agents_active': '7 ஏஜென்ட்கள் தயார் நிலையில்',
    'live_logs': 'நேரலை AI ஏஜென்ட் செயல்பாடு',

    // Threat Agent
    'threat_title': 'ஆபத்து கண்டறிதல் ஏஜென்ட் (Threat AI)',
    'live_sensors': 'நேரலை சென்சார்கள்',
    'sensor_desc': 'மொபைல் சென்சார்கள், திடீர் அசைவு/விழுதல், குரல் ("காப்பாத்துங்க", "Help") மற்றும் வழித்தட மாற்றங்களை AI தொடர்ந்து கண்காணிக்கிறது.',
    'acc_label': 'அதிவேக அசைவு / தள்ளுமுள்ளு சென்சார்',
    'voice_label': 'குரல் வார்த்தை கண்டறிதல்',
    'voice_sub': '"காப்பாத்துங்க", "Help", "Stop", "விடாதீங்க" போன்ற வார்த்தைகளை கண்டறியும்',
    'route_label': 'திடீர் வழித்தட மாற்றம் / இருட்டான பகுதி',
    'route_sub': 'திட்டமிட்ட பாதையை விட்டு 400 மீட்டருக்கு மேல் விலகினால் எச்சரிக்கும்',
    'reset_sensors': 'சென்சார்களை இயல்பு நிலைக்கு மாற்று',

    // Safe Route
    'route_title': 'பாதுகாப்பான வழித்தட ஏஜென்ட்',
    'route_corridor': 'நேரலை பாதுகாப்பான பாதை வரைபடம்',
    'route_rec': 'பரிந்துரை: வெளிச்சம் & மக்கள் நடமாட்டம் உள்ள பாதை',
    'safe_havens': 'அருகிலுள்ள புகலிடங்கள் (1.5 கி.மீக்குள்)',
    'start_nav': 'பாதுகாப்பான வழித்தட பயணத்தைத் தொடங்கு',

    // Blockchain
    'vault_title': 'பிளாக்செயின் சான்று பெட்டகம் (Vault)',
    'vault_desc': 'பதிவான ஆடியோ, வீடியோ மற்றும் இருப்பிடத் தரவுகள் SHA-256 கிரிப்டோகிராஃபி மூலம் பாலிகான் பிளாக்செயினில் மாற்றமுடியாதவாறு பதியப்படும் (BSA 65B சட்ட ஏற்புடைமை).',
    'ledger_records': 'பிளாக்செயின் சான்று பதிவுகள்',
    'verify_btn': 'பிளாக்செயினில் உண்மைத்தன்மையை சரிபார்',

    // Case Mgmt
    'case_title': 'வழக்கு & FIR தயாரிப்பு ஏஜென்ட்',
    'case_desc': 'புதிய பாரதிய நியாய சன்ஹிதா (BNS) சட்டப் பிரிவுகளுடன் நீதிமன்றத்தில் ஏற்கத்தக்க FIR புகாரை நொடிகளில் உருவாக்கும்.',
    'draft_fir_btn': 'சட்டப்பூர்வ FIR புகார் மனு உருவாக்கு',

    // Counselor
    'counselor_title': 'ஆறுதல் & சட்ட உதவி ஏஜென்ட்',
    'counselor_desc': '24/7 மன தைரியம் தரும் உரையாடல் மற்றும் இலவச சட்ட உரிமைகள் வழிகாட்டி.',
    'type_placeholder': 'தமிழ் அல்லது ஆங்கிலத்தில் தட்டச்சு செய்யவும் (எ.கா: "எனக்கு பயமா இருக்கு")...',

    // Audit
    'audit_title': 'கண்காணிப்பு & பொறுப்புடைமை ஏஜென்ட் (Audit)',
    'audit_desc': 'காவல்துறையின் உடனடி நடவடிக்கையை பிளாக்செயின் கண்காணிக்கும். 6 மணி நேரத்திற்குள் நடவடிக்கை இல்லை எனில் மகளிர் ஆணையத்திற்கு தானாக மேல்முறையீடு செய்யும்.',
    'escalate_btn': 'ஸ்மார்ட் ஒப்பந்தம் மூலம் மேல்முறையீடு செய்',

    // User Manual
    'manual_title': 'எளிய பயனர் வழிகாட்டி (User Manual)',
    'manual_sub': 'சேஃப்கார்ட் செயலியை 5 எளிய படிகளில் பயன்படுத்துவது எப்படி?',
    'step1_title': '1. அவசர SOS பயன்பாடு',
    'step1_desc': '3D சிவப்பு SOS பட்டனை அழுத்தவும் அல்லது போனை வேகமாக 3 முறை அசைக்கவும். உடனே 112 காவல்துறைக்கும் குடும்பத்தினருக்கும் நேரலை GPS அனுப்பப்படும்.',
    'step2_title': '2. தொடாமல் பேசும் குரல் எச்சரிக்கை',
    'step2_desc': 'போனை எடுக்க முடியாத இக்கட்டான சூழலில் "HELP" அல்லது "காப்பாத்துங்க" என்று உரக்க கூறினால் AI தானாகவே ஆபத்தை உணர்ந்து SOS அனுப்பும்.',
    'step3_title': '3. பிளாக்செயின் சான்று பாதுகாப்பு',
    'step3_desc': 'SOS இயங்கியவுடன் 30 நொடி ஆடியோ/வீடியோ பதிவு செய்யப்பட்டு பிளாக்செயினில் பூட்டப்படும். குற்றவாளிகளோ அதிகாரிகளோ ஆதாரங்களை அழிக்கவே முடியாது.',
    'step4_title': '4. பாதுகாப்பான வழித்தடம்',
    'step4_desc': 'இரவு நேரத்தில் வீடு திரும்பும்போது, தெருவிளக்குகள், மக்கள் கூட்டம் மற்றும் மகளிர் காவல் நிலையங்கள் உள்ள பாதுகாப்பான பாதையை வழிகாட்டும்.',
    'step5_title': '5. ஜீரோ FIR மற்றும் அநாமதேய புகார்',
    'step5_desc': 'எந்த காவல் நிலையத்திலும் ஜீரோ FIR பதியலாம். உங்கள் அடையாளத்தை வெளிப்படுத்தாமல் (Zero-Knowledge) ரகசியமாகவும் புகார் அளிக்கலாம்.',
  };
}
