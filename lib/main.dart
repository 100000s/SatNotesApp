import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:vibration/vibration.dart';

import 'shopping_hub.dart';

// ================== LOCALIZATION ==================
class AppLocalizations {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'shopping': 'Shopping',
      'selling': 'Selling',
      'get_satnotes': 'Get SatNotes',
      'redeem_satnotes': 'Redeem SatNotes',
      'sdtp_balance': 'SDTP Balance',
      'verify_satnote': 'Verify a SatNote',
      'join_community': 'Join the Community',
      'report_issue': 'Report an Issue/Bug',
      'purchase': 'Purchase',
      'redemption': 'Redemption',
      'atm': 'ATM',
      'business': 'Business',
      'language': 'Español',
      'language_en': 'English',
      'shopping_hub_title': 'Shopping Hub',
      'shopping_search_hint': 'Search categories, items, stores',
      'shopping_gemini_hint': 'Ask for a smart shopping suggestion',
      'shopping_no_results': 'No results found. Try a different query.',
      'shopping_selected': 'Selected',
      'shopping_asap': 'ASAP',
      'shopping_online': 'Online',
      'shopping_digital_only_note':
          'This category is digital-only.\nTriggering Online Protocol.',
      'shopping_online_mode_active': 'Online shopping mode active',
      'shopping_online_placeholder_1': 'Express Marketplace',
      'shopping_online_placeholder_1_desc':
          'Fast delivery choices from top stores.',
      'shopping_online_placeholder_2': 'Digital Deals',
      'shopping_online_placeholder_2_desc':
          'Curated online offers for your selection.',
      'shopping_online_placeholder_3': 'Checkout Ready',
      'shopping_online_placeholder_3_desc': 'Save time with one-tap ordering.',
      'shopping_online_fallback':
          'Browse digital options while the map is disabled.',
      'trigger_online_protocol': 'Triggering Online Protocol',
      'online_mode_enabled': 'Online shopping mode enabled. Map view disabled.',
      'asap_selection_message':
          'ASAP selection applied. Updating nearby shopping pins.',
    },
    'es': {
      'shopping': 'Compras',
      'selling': 'Venta',
      'get_satnotes': 'Obtener SatNotes',
      'redeem_satnotes': 'Canjear SatNotes',
      'sdtp_balance': 'Saldo SDTP',
      'verify_satnote': 'Verificar un SatNote',
      'join_community': 'Únete a la Comunidad',
      'report_issue': 'Reportar un Problema/Error',
      'purchase': 'Compra',
      'redemption': 'Canje',
      'atm': 'Cajero',
      'business': 'Negocio',
      'language': 'English',
      'language_en': 'Español',
      'shopping_hub_title': 'Centro de Compras',
      'shopping_search_hint': 'Buscar categorías, artículos, tiendas',
      'shopping_gemini_hint': 'Pide una sugerencia de compra inteligente',
      'shopping_no_results':
          'No se encontraron resultados. Prueba otra búsqueda.',
      'shopping_selected': 'Seleccionado',
      'shopping_asap': 'YA',
      'shopping_online': 'En línea',
      'shopping_digital_only_note':
          'Esta categoría es solo digital.\nActivando el protocolo en línea.',
      'shopping_online_mode_active': 'Modo de compra en línea activo',
      'shopping_online_placeholder_1': 'Mercado Exprés',
      'shopping_online_placeholder_1_desc':
          'Opciones de entrega rápida de tiendas principales.',
      'shopping_online_placeholder_2': 'Ofertas digitales',
      'shopping_online_placeholder_2_desc':
          'Ofertas en línea seleccionadas para ti.',
      'shopping_online_placeholder_3': 'Listo para pagar',
      'shopping_online_placeholder_3_desc':
          'Ahorra tiempo con pedidos de un solo toque.',
      'shopping_online_fallback':
          'Navega opciones digitales mientras el mapa está deshabilitado.',
      'trigger_online_protocol': 'Activando el protocolo en línea',
      'online_mode_enabled':
          'Modo de compra en línea activado. Vista de mapa deshabilitada.',
      'asap_selection_message':
          'Selección YA aplicada. Actualizando pines cercanos.',
    },
  };

  static String getString(String key, String language) {
    return _localizedValues[language]?[key] ?? key;
  }
}

void main() => runApp(const SatNotesApp());

class SatNotesApp extends StatelessWidget {
  const SatNotesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'SatNotes',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFA500),
            secondary: Color(0xFF00FFC6),
          ),
        ),
        home: const AnimationScreen(),
        debugShowCheckedModeBanner: false,
      );
}

// ================== ANIMATION (unchanged) ==================
class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3900), vsync: this);
    _scale = Tween<double>(begin: 0.03, end: 1.8).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)));

    _controller.forward().then((_) async {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => Opacity(
              opacity: _opacity.value,
              child: Transform.scale(
                  scale: _scale.value,
                  child: Image.asset('assets/logo.png', width: 280)),
            ),
          ),
        ),
      );
}

// ================== UNLOCK SCREEN ==================
class UnlockScreen extends StatefulWidget {
  const UnlockScreen({super.key});
  @override
  State<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<UnlockScreen>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  // final LocalAuthentication auth = LocalAuthentication();

  List<int> selected = [];
  List<int> savedPattern = [];
  bool isFirstTime = true;
  String language = "en";
  int failureCount = 0;
  DateTime? lockoutEndTime;
  // bool useFingerprintLater = false;
  late Map<int, AnimationController> dotAnimations;

  final dots = [
    Offset(65, 45),
    Offset(175, 45),
    Offset(35, 115),
    Offset(120, 115),
    Offset(205, 115),
    Offset(65, 185),
    Offset(175, 185),
  ];

  @override
  void initState() {
    super.initState();
    dotAnimations = {
      for (int i = 0; i < dots.length; i++)
        i: AnimationController(
          duration: const Duration(milliseconds: 100),
          vsync: this,
        )
    };
    _loadPattern();
    _checkLockout();
    // _checkBiometricAvailability();
  }

  @override
  void dispose() {
    for (var controller in dotAnimations.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _checkLockout() async {
    final lockoutStr = await storage.read(key: "lockoutEndTime");
    if (lockoutStr != null) {
      final endTime = DateTime.parse(lockoutStr);
      if (DateTime.now().isBefore(endTime)) {
        setState(() => lockoutEndTime = endTime);
      } else {
        await storage.delete(key: "lockoutEndTime");
        final failStr = await storage.read(key: "failureCount");
        if (failStr != null) {
          await storage.delete(key: "failureCount");
        }
      }
    }

    final failStr = await storage.read(key: "failureCount");
    if (failStr != null) {
      setState(() => failureCount = int.parse(failStr));
    }
  }

  Future<void> _loadPattern() async {
    final saved = await storage.read(key: "userPattern");
    if (saved == null) {
      setState(() => isFirstTime = true);
    } else {
      setState(() {
        savedPattern = saved.split('-').map(int.parse).toList();
        isFirstTime = false;
      });
    }
  }

  void _onPatternComplete() async {
    if (selected.length < 4) {
      setState(() => selected = []);
      return;
    }

    final current = selected.join('-');

    if (isFirstTime) {
      await storage.write(key: "userPattern", value: current);
      setState(() => isFirstTime = false);
      setState(() => selected = []);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Pattern saved! Draw it again to unlock.")),
        );
      }
      return;
    }

    if (current != savedPattern.join('-')) {
      await Vibration.vibrate(duration: 500);
      setState(() => selected = []);
      failureCount++;
      await storage.write(key: "failureCount", value: failureCount.toString());

      if (failureCount >= 2) {
        final lockoutEnd = DateTime.now().add(const Duration(minutes: 10));
        await storage.write(
            key: "lockoutEndTime", value: lockoutEnd.toIso8601String());
        setState(() => lockoutEndTime = lockoutEnd);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Too many failed attempts. Locked out for 10 minutes."),
                duration: Duration(seconds: 4)),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Incorrect pattern. ${2 - failureCount} attempts remaining.")),
          );
        }
      }
      return;
    }

    // Correct pattern
    await Vibration.vibrate(duration: 200);
    await storage.write(key: "failureCount", value: "0");
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Language Button
            Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                onTap: () =>
                    setState(() => language = language == "en" ? "es" : "en"),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF00FFC6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(language == "en" ? "Español" : "English",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (lockoutEndTime != null &&
                      DateTime.now().isBefore(lockoutEndTime!))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          const Text(
                            "Account Locked",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          StreamBuilder<int>(
                            stream: Stream.periodic(const Duration(seconds: 1))
                                .map((_) {
                              final remaining =
                                  lockoutEndTime!.difference(DateTime.now());
                              return remaining.inSeconds > 0
                                  ? remaining.inSeconds
                                  : 0;
                            }),
                            builder: (context, snapshot) {
                              final seconds = snapshot.data ?? 600;
                              final minutes = seconds ~/ 60;
                              final secs = seconds % 60;
                              if (seconds <= 0) {
                                Future.microtask(() {
                                  setState(() {
                                    lockoutEndTime = null;
                                    failureCount = 0;
                                  });
                                  storage.delete(key: "lockoutEndTime");
                                  storage.delete(key: "failureCount");
                                });
                              }
                              return Text(
                                "Try again in ${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  if (lockoutEndTime == null ||
                      DateTime.now().isAfter(lockoutEndTime!))
                    Column(
                      children: [
                        Text(
                          isFirstTime
                              ? "Draw your unlock pattern to get started"
                              : "Draw your pattern to unlock",
                          style: const TextStyle(
                              fontSize: 20, color: Color(0xFFFFA500)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        GestureDetector(
                          onPanUpdate: (details) {
                            final box = context.findRenderObject() as RenderBox;
                            final local =
                                box.globalToLocal(details.globalPosition);
                            for (int i = 0; i < dots.length; i++) {
                              if ((local - dots[i]).distance < 50 &&
                                  !selected.contains(i)) {
                                setState(() => selected.add(i));
                                // Animate the selected dot
                                dotAnimations[i]!.forward(from: 0.3);
                              }
                            }
                          },
                          onPanEnd: (_) => _onPatternComplete(),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: const Size(300, 280),
                                painter: PatternPainter(
                                    dots: dots, selected: selected),
                              ),
                              // Animated dots overlay
                              ...List.generate(dots.length, (i) {
                                return Positioned(
                                  left: dots[i].dx - 32,
                                  top: dots[i].dy - 32,
                                  width: 64,
                                  height: 64,
                                  child: AnimatedBuilder(
                                    animation: dotAnimations[i]!,
                                    builder: (context, child) {
                                      final glowValue =
                                          0.3 + (dotAnimations[i]!.value * 0.7);
                                      final scale =
                                          1.0 + (glowValue - 0.3) * 0.4 / 0.7;
                                      final opacity =
                                          0.7 + (glowValue - 0.3) * 0.6 / 0.7;

                                      return Transform.scale(
                                        scale: scale,
                                        child: Opacity(
                                          opacity: opacity,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xFF00FFC6),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("Draw at least 4 dots",
                            style: TextStyle(color: Colors.white70)),
                        // Biometric disabled for now
                        // if (!isFirstTime && useFingerprintLater) ...[
                        //   const SizedBox(height: 40),
                        //   const Divider(color: Colors.white30),
                        //   const SizedBox(height: 20),
                        //   const Text("Or use fingerprint",
                        //       style: TextStyle(color: Colors.white70)),
                        //   const SizedBox(height: 15),
                        //   GestureDetector(
                        //     onTap: _authenticateWithBiometric,
                        //     child: Container(
                        //       padding: const EdgeInsets.all(16),
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xFF00FFC6),
                        //         shape: BoxShape.circle,
                        //       ),
                        //       child: const Icon(Icons.fingerprint,
                        //           color: Colors.black, size: 40),
                        //     ),
                        //   ),
                        // ],
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}

class PatternPainter extends CustomPainter {
  final List<Offset> dots;
  final List<int> selected;
  PatternPainter({required this.dots, required this.selected});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF00FFC6)
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    // Draw connecting lines only (dots are animated overlays)
    for (int i = 1; i < selected.length; i++) {
      canvas.drawLine(dots[selected[i - 1]], dots[selected[i]], linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ================== HOME SCREEN - Orange buttons with Google Maps ==================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class LocationMarkerInfo {
  final String id;
  final LatLng location;
  final String name;
  final String type; // 'purchase', 'redemption', 'atm', 'business'
  final String address;

  LocationMarkerInfo({
    required this.id,
    required this.location,
    required this.name,
    required this.type,
    required this.address,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();
  bool showMenu = true;
  bool showLanguageButton = true;
  late GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<String> activeFilters = {'purchase', 'redemption', 'atm', 'business'};
  String language = 'en';
  bool shoppingOnlineMode = false;
  String shoppingSelectionLabel = '';
  String shoppingSelectionDetails = '';
  String shoppingSelectionCategory = '';
  String shoppingSelectionSubcategory = '';
  String shoppingSelectionItem = '';

  List<String> get actions => [
        AppLocalizations.getString('shopping', language),
        AppLocalizations.getString('selling', language),
        AppLocalizations.getString('get_satnotes', language),
        AppLocalizations.getString('redeem_satnotes', language),
        AppLocalizations.getString('sdtp_balance', language),
        AppLocalizations.getString('verify_satnote', language),
        AppLocalizations.getString('join_community', language),
        AppLocalizations.getString('report_issue', language),
      ];

  // Sample location data - replace with API calls later
  final List<LocationMarkerInfo> allLocations = [
    LocationMarkerInfo(
      id: 'p1',
      location: const LatLng(20.6597, -103.3496),
      name: 'Centro SatNotes',
      type: 'purchase',
      address: 'Centro, Guadalajara',
    ),
    LocationMarkerInfo(
      id: 'r1',
      location: const LatLng(20.6700, -103.3400),
      name: 'Redemption Hub',
      type: 'redemption',
      address: 'Chapultepec, Guadalajara',
    ),
    LocationMarkerInfo(
      id: 'a1',
      location: const LatLng(20.6500, -103.3600),
      name: 'SatNotes ATM',
      type: 'atm',
      address: 'Providencia, Guadalajara',
    ),
    LocationMarkerInfo(
      id: 'b1',
      location: const LatLng(20.6650, -103.3350),
      name: 'Partner Business',
      type: 'business',
      address: 'Zapopan, Guadalajara',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // _loadSavedLanguage();
    _updateMarkers();
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await storage.read(key: 'preferredLanguage');
    if (savedLanguage != null &&
        (savedLanguage == 'en' || savedLanguage == 'es')) {
      setState(() {
        language = savedLanguage;
        showLanguageButton = false;
      });
    }
  }

  void _updateMarkers() {
    final filteredLocations =
        allLocations.where((loc) => activeFilters.contains(loc.type)).toList();

    markers = filteredLocations.map((loc) {
      final markerColor = _getMarkerColor(loc.type);
      return Marker(
        markerId: MarkerId(loc.id),
        position: loc.location,
        infoWindow: InfoWindow(
          title: loc.name,
          snippet: loc.address,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(markerColor),
      );
    }).toSet();

    setState(() {});
  }

  void _openShoppingHub() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ShoppingHub(
        language: language,
        onSelection: _handleShoppingSelection,
      ),
    );
  }

  void _handleShoppingSelection(ShoppingSelection selection) {
    Navigator.of(context).pop();

    setState(() {
      shoppingOnlineMode = selection.isOnlineMode || selection.isDigitalOnly;
      shoppingSelectionCategory = selection.category;
      shoppingSelectionSubcategory = selection.subcategory;
      shoppingSelectionItem = selection.item;
      shoppingSelectionLabel =
          localizeShoppingText(selection.category, language);
      shoppingSelectionDetails =
          '${localizeShoppingText(selection.subcategory, language)} • ${localizeShoppingText(selection.item, language)}';

      if (shoppingOnlineMode) {
        activeFilters = {};
      } else {
        activeFilters = {'purchase', 'business', 'atm'};
      }
    });

    if (selection.isDigitalOnly) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.getString(
              'trigger_online_protocol', language))));
    } else if (selection.isOnlineMode) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.getString('online_mode_enabled', language))));
    } else {
      _updateMarkers();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.getString('asap_selection_message', language))));
    }
  }

  String get currentLanguage => language;

  void _toggleLanguage() async {
    final newLanguage = language == 'en' ? 'es' : 'en';
    // await storage.write(key: 'preferredLanguage', value: newLanguage);
    setState(() {
      language = newLanguage;
      showLanguageButton = false;
      if (shoppingSelectionCategory.isNotEmpty) {
        shoppingSelectionLabel =
            localizeShoppingText(shoppingSelectionCategory, language);
        shoppingSelectionDetails =
            '${localizeShoppingText(shoppingSelectionSubcategory, language)} • ${localizeShoppingText(shoppingSelectionItem, language)}';
      }
    });
    _updateMarkers();
  }

  double _getMarkerColor(String type) {
    switch (type) {
      case 'purchase':
        return BitmapDescriptor.hueGreen; // Green for purchase
      case 'redemption':
        return BitmapDescriptor.hueBlue; // Blue for redemption
      case 'atm':
        return BitmapDescriptor.hueYellow; // Yellow for ATM
      case 'business':
        return BitmapDescriptor.hueOrange; // Orange for business
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  void _toggleFilter(String type) {
    setState(() {
      if (activeFilters.contains(type)) {
        activeFilters.remove(type);
      } else {
        activeFilters.add(type);
      }
    });
    _updateMarkers();
  }

  Widget _buildOnlinePlaceholderCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(20.6597, -103.3496), zoom: 14),
              myLocationEnabled: true,
              markers: markers,
              onMapCreated: (controller) => mapController = controller,
              onTap: (_) => setState(() => showMenu = !showMenu),
            ),
            if (shoppingOnlineMode)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.78),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.getString(
                            'shopping_online_mode_active', language),
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        shoppingSelectionLabel.isNotEmpty
                            ? '$shoppingSelectionLabel • $shoppingSelectionDetails'
                            : AppLocalizations.getString(
                                'shopping_online_fallback', language),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildOnlinePlaceholderCard(
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_1', language),
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_1_desc',
                                    language)),
                            _buildOnlinePlaceholderCard(
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_2', language),
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_2_desc',
                                    language)),
                            _buildOnlinePlaceholderCard(
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_3', language),
                                AppLocalizations.getString(
                                    'shopping_online_placeholder_3_desc',
                                    language)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Location filter chips
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                        AppLocalizations.getString('purchase', language),
                        'purchase',
                        Colors.green),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                        AppLocalizations.getString('redemption', language),
                        'redemption',
                        Colors.blue),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                        AppLocalizations.getString('atm', language),
                        'atm',
                        Colors.yellow),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                        AppLocalizations.getString('business', language),
                        'business',
                        Colors.orange),
                  ],
                ),
              ),
            ),

            if (showMenu)
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    // Semi-transparent background
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showLanguageButton) ...[
                            Center(
                              child: GestureDetector(
                                onTap: _toggleLanguage,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.16),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.28),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.getString(
                                        'language', language),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                          ...actions
                              .map((text) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final shoppingLabel =
                                            AppLocalizations.getString(
                                                'shopping', language);
                                        if (text == shoppingLabel) {
                                          _openShoppingHub();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("$text tapped")));
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFA500)
                                              .withOpacity(0.54),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black45,
                                                blurRadius: 10,
                                                offset: Offset(0, 4))
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            text,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );

  Widget _buildFilterChip(String label, String type, Color color) {
    final isActive = activeFilters.contains(type);
    return GestureDetector(
      onTap: () => _toggleFilter(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? color : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
