import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/localization_service.dart';

class SafetyProduct {
  final String id;
  final String nameEn;
  final String nameTa;
  final String icon;
  final String categoryEn;
  final String categoryTa;
  final String range;
  final String legalBadge;
  final String descEn;
  final String descTa;
  final String price;
  final String integrationTipEn;
  final String integrationTipTa;

  const SafetyProduct({
    required this.id,
    required this.nameEn,
    required this.nameTa,
    required this.icon,
    required this.categoryEn,
    required this.categoryTa,
    required this.range,
    required this.legalBadge,
    required this.descEn,
    required this.descTa,
    required this.price,
    required this.integrationTipEn,
    required this.integrationTipTa,
  });
}

class SafetyProductsScreen extends StatelessWidget {
  const SafetyProductsScreen({Key? key}) : super(key: key);

  static const List<SafetyProduct> products = [
    SafetyProduct(
      id: "prod_1",
      nameEn: "Tactical Cobra Pepper Spray (10% OC)",
      nameTa: "தற்காப்பு மிளகாய் ஸ்ப்ரே",
      icon: "🌶️",
      categoryEn: "Self Defense Spray",
      categoryTa: "தற்காப்பு ஸ்ப்ரே",
      range: "12 Feet Stream Range",
      legalBadge: "100% Legal in India (IPC 96-106 Private Defence)",
      descEn: "Pure Oleoresin Capsicum formula causes involuntary eye closure and intense coughing for 30-45 minutes. Gives you crucial time to escape.",
      descTa: "தாக்குபவரை 30-45 நிமிடங்கள் தற்காலிகமாக நிலைதடுமாறச் செய்து தப்பிக்கும் அவகாசத்தை தரும். இந்தியாவில் பெண்கள் தற்காப்புக்கு சட்டப்பூர்வமானது.",
      price: "₹499",
      integrationTipEn: "App pairs with your route: Keeps pepper spray ready during unlit corridors.",
      integrationTipTa: "இருட்டான பகுதிகளில் நடக்கும்போது ஸ்ப்ரேயை தயார் நிலையில் வைக்க AI நினைவூட்டும்.",
    ),
    SafetyProduct(
      id: "prod_2",
      nameEn: "130dB Personal Panic Keychain Alarm",
      nameTa: "130dB பாதுகாப்பு அலாரம் சாவிக்கொத்து",
      icon: "🔊",
      categoryEn: "Acoustic Deterrent",
      categoryTa: "அதிவேக ஒலி எச்சரிக்கை",
      range: "Audible up to 600 Feet",
      legalBadge: "Non-lethal & Airport Security Approved",
      descEn: "Pull the metal pin to unleash an ear-splitting 130dB siren with strobe LED. Shocks attackers and alerts everyone within a 200m radius.",
      descTa: "அவசரத்தில் பின்னை இழுத்தால் காதை பிளக்கும் 130dB சைரன் ஒலியும் LED வெளிச்சமும் உடனடியாக பொதுமக்களின் கவனத்தை ஈர்க்கும்.",
      price: "₹349",
      integrationTipEn: "The loud siren immediately triggers our Threat Agent's audio spike listener.",
      integrationTipTa: "இதன் அதிரடி சத்தம் கேட்டவுடனே Threat Agent தானாக SOS தொடங்கும்.",
    ),
    SafetyProduct(
      id: "prod_3",
      nameEn: "SafeGuard Bluetooth Smart SOS Ring",
      nameTa: "ஸ்மார்ட் SOS மோதிரம் (Smart Ring)",
      icon: "💍",
      categoryEn: "Wearable Hardware",
      categoryTa: "அணியக்கூடிய சாதனம்",
      range: "Bluetooth 5.2 Direct Sync",
      legalBadge: "Covert Protection Wearable",
      descEn: "Jewelry-grade stylish ring with a tactile stealth panic button underneath. Press twice to secretly trigger SafeGuard SOS without touching your phone.",
      descTa: "மோதிரத்தின் அடிப்பகுதியில் மறைந்துள்ள பட்டனை 2 முறை அழுத்தினால் போனைத் தொடாமலேயே SafeGuard SOS மற்றும் பிளாக்செயின் பதிவு இயங்கும்.",
      price: "₹1,499",
      integrationTipEn: "Direct hardware trigger for the SOS Response & Blockchain Evidence Agents.",
      integrationTipTa: "போன் கையில் இல்லாதபோதும் SOS மற்றும் பிளாக்செயின் ஏஜென்ட்டை இயக்கும்.",
    ),
    SafetyProduct(
      id: "prod_4",
      nameEn: "RF Hidden Camera & Bug Detector Wand",
      nameTa: "ரகசிய கேமரா கண்டறியும் கருவி",
      icon: "👁️",
      categoryEn: "Anti-Voyeurism / Privacy",
      categoryTa: "தனிநபர் பாதுகாப்பு",
      range: "1MHz - 6.5GHz Radio Frequency",
      legalBadge: "Hotel & Changing Room Essential",
      descEn: "High-grade optical viewfinder with red laser LEDs exposes pinhole hidden cameras in clothing trial rooms, Airbnb stays, and public washrooms.",
      descTa: "துணிக்கடை ட்ரையல் ரூம்கள், ஹோட்டல் அறைகளில் மறைத்து வைக்கப்பட்ட ரகசிய கேமராக்களை உடனடியாக கண்டறியும் லேசர் சாதனம்.",
      price: "₹1,299",
      integrationTipEn: "Allows one-tap reporting of voyeurism directly to Case Management Agent.",
      integrationTipTa: "கேமரா கண்டறியப்பட்டால் BNS 77 பிரிவின் கீழ் உடனே FIR தயாரிக்கலாம்.",
    ),
    SafetyProduct(
      id: "prod_5",
      nameEn: "Heavy-Duty Portable Door Jammer Lock",
      nameTa: "அறை கதவு பாதுகாப்பு பூட்டு",
      icon: "🚪",
      categoryEn: "Hostel & Travel Defense",
      categoryTa: "விடுதி & பயண பாதுகாப்பு",
      range: "Resists 350+ lbs Force",
      legalBadge: "No Installation / Tool-Free",
      descEn: "Slides under any inward-opening door in 5 seconds. Uses floor displacement force to prevent intruders even if they have a master key.",
      descTa: "ஹோட்டல் அல்லது ஹாஸ்டல் அறைக் கதவின் அடியில் பொருத்திவிட்டால் மாஸ்டர் சாவி இருந்தாலும் யாராலும் கதவை உடைத்து உள்ளே வர முடியாது.",
      price: "₹599",
      integrationTipEn: "Recommended by Safe Route Agent for solo female travellers.",
      integrationTipTa: "தனியாக பயணம் செய்யும் பெண்களுக்கு Safe Route Agent பரிந்துரைக்கும்.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocalizationService>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.isTamil ? "பெண்கள் பாதுகாப்பு உபகரணங்கள்" : "Ladies Safety Products & Gear",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBE185D), Color(0xFF500724)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.pinkAccent.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(color: Colors.pinkAccent.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 6)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white12,
                      border: Border.all(color: Colors.pinkAccent),
                    ),
                    child: const Center(child: Text("🛡️", style: TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.isTamil ? "சட்டப்பூர்வ தற்காப்பு சாதனங்கள்" : "Verified Self-Defense Hardware",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loc.isTamil
                              ? "இந்திய சட்டம் (IPC 96-106 / BNS 34-44) படி பெண்கள் தற்காப்புக்காக இவை 100% அனுமதிக்கப்பட்டவை."
                              : "100% legal under the Right of Private Defence in India. Integrates with SafeGuard AI agents.",
                          style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              loc.isTamil ? "பரிந்துரைக்கப்பட்ட பாதுகாப்பு கருவிகள்" : "Curated Protective Equipment",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 12),

            ...products.map((prod) => _buildProductCard(context, prod, loc)).toList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, SafetyProduct prod, LocalizationService loc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pinkAccent.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.pinkAccent.withOpacity(0.4)),
                ),
                child: Center(child: Text(prod.icon, style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.isTamil ? prod.nameTa : prod.nameEn,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          loc.isTamil ? prod.categoryTa : prod.categoryEn,
                          style: const TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Text("•  ${prod.range}", style: const TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                prod.price,
                style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Legal badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.gavel, color: Colors.greenAccent, size: 12),
                const SizedBox(width: 6),
                Text(
                  prod.legalBadge,
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            loc.isTamil ? prod.descTa : prod.descEn,
            style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),

          const SizedBox(height: 10),

          // AI Agent Integration Highlight
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: Colors.amberAccent, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    loc.isTamil ? prod.integrationTipTa : prod.integrationTipEn,
                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      loc.isTamil
                          ? "${prod.nameTa} பயனர் கையேடு & வாங்கும் இணைப்பு திறக்கப்பட்டது."
                          : "User guide & order portal opened for ${prod.nameEn}.",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined, size: 16),
              label: Text(loc.isTamil ? "வாங்கு / விரிவான வழிகாட்டி" : "VIEW GUIDE & GET GEAR"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
