import 'package:flutter/material.dart';

class ShoppingCategory {
  final String category;
  final bool isDigitalOnly;
  final bool forceMapOn;
  final List<ShoppingSubcategory> subcategories;

  const ShoppingCategory({
    required this.category,
    this.isDigitalOnly = false,
    this.forceMapOn = false,
    required this.subcategories,
  });
}

class ShoppingSubcategory {
  final String name;
  final List<String> items;
  final bool isDigitalOnly;

  const ShoppingSubcategory({
    required this.name,
    required this.items,
    this.isDigitalOnly = false,
  });
}

final List<ShoppingCategory> shoppingHierarchy = [
  ShoppingCategory(
    category: 'Fashion & Apparel',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Luxury',
        items: ['Gucci', 'Farfetch', 'Designers'],
      ),
      ShoppingSubcategory(
        name: 'Everyday',
        items: ['Local Boutiques', 'Department Stores'],
      ),
      ShoppingSubcategory(
        name: 'Footwear',
        items: ['Sneakers', 'Formal Shoes', 'Repair'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Tech & Electronics',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Hardware',
        items: ['Newegg', 'Computer Parts', 'Peripherals'],
      ),
      ShoppingSubcategory(
        name: 'Software',
        items: ['Microsoft', 'SaaS', 'Licenses'],
      ),
      ShoppingSubcategory(
        name: 'Repair',
        items: ['Phone Screen', 'Laptop Fix', 'Local Techs'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Food & Essentials',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Groceries',
        items: ['Supermarkets', 'Farmers Markets'],
      ),
      ShoppingSubcategory(
        name: 'Dining',
        items: ['Restaurants', 'Takeout', 'Cafes'],
      ),
      ShoppingSubcategory(
        name: 'Health',
        items: ['Pharmacy', 'Vitamins', 'Personal Care'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Home & Living',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Kitchen',
        items: ['Appliances', 'Cutlery', 'Cookware'],
      ),
      ShoppingSubcategory(
        name: 'Furniture',
        items: ['Living Room', 'Bedroom', 'Office'],
      ),
      ShoppingSubcategory(
        name: 'Garden',
        items: ['Nurseries', 'Outdoor Decor', 'Tools'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Professional Services',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Digital',
        items: ['Namecheap (Domains)', 'VPN', 'Cloud Email'],
        isDigitalOnly: true,
      ),
      ShoppingSubcategory(
        name: 'Maintenance',
        items: ['Plumbers', 'Electricians', 'HVAC'],
      ),
      ShoppingSubcategory(
        name: 'Business',
        items: ['Legal', 'Accounting', 'Consulting'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Travel & Leisure',
    isDigitalOnly: false,
    forceMapOn: true,
    subcategories: [
      ShoppingSubcategory(
        name: 'Transport',
        items: ['Alternative Airlines', 'Travala', 'Car Rental'],
      ),
      ShoppingSubcategory(
        name: 'Lodging',
        items: ['Hotels', 'Vacation Rentals'],
      ),
      ShoppingSubcategory(
        name: 'Planning',
        items: ['Routes', 'Local Tours'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Media & Entertainment',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Gaming',
        items: ['Digital Downloads', 'Physical Games', 'Consoles'],
      ),
      ShoppingSubcategory(
        name: 'Streaming',
        items: ['Movies', 'Music Subscriptions'],
      ),
      ShoppingSubcategory(
        name: 'Books',
        items: ['eBooks', 'Physical Books', 'Audiobooks'],
      ),
    ],
  ),
  ShoppingCategory(
    category: 'Auto & Industrial',
    isDigitalOnly: false,
    forceMapOn: false,
    subcategories: [
      ShoppingSubcategory(
        name: 'Parts',
        items: ['Tires', 'Batteries', 'Engine Parts'],
      ),
      ShoppingSubcategory(
        name: 'Services',
        items: ['Mechanics', 'Body Work', 'Oil Change'],
      ),
      ShoppingSubcategory(
        name: 'Sales',
        items: ['Car Dealers', 'Equipment'],
      ),
    ],
  ),
];

const Map<String, Map<String, String>> _localizedValues = {
  'en': {
    'shopping_hub_title': 'Shopping Hub',
    'shopping_search_hint': 'Search categories, items, stores',
    'shopping_gemini_hint': 'Ask Gemini anything...',
    'shopping_no_results': 'No results found. Try a different query.',
    'shopping_selected': 'Selected',
    'shopping_asap': 'ASAP',
    'shopping_online': 'Online',
    'shopping_digital_only_note':
        'Digital-only category selected. Triggering the escrow placeholder.',
    'shopping_how_soon_prompt': 'How soon do you need it?',
    'shopping_route_planning': 'Route Planning',
    'shopping_route_preview': 'Route preview active. Map stays visible.',
    'shopping_digital_badge': 'Digital',
    'shopping_online_fallback':
        'Hide map and show the BTC Escrow payment flow for online purchases.',
  },
  'es': {
    'shopping_hub_title': 'Centro de Compras',
    'shopping_search_hint': 'Buscar categorías, artículos, tiendas',
    'shopping_gemini_hint': 'Pide a Gemini cualquier cosa...',
    'shopping_no_results':
        'No se encontraron resultados. Prueba otra búsqueda.',
    'shopping_selected': 'Seleccionado',
    'shopping_asap': 'YA',
    'shopping_online': 'En línea',
    'shopping_digital_only_note':
        'Categoría solo digital seleccionada. Activando el marcador de depósito.',
    'shopping_how_soon_prompt': '¿Qué tan pronto lo necesitas?',
    'shopping_route_planning': 'Planificación de ruta',
    'shopping_route_preview':
        'Vista previa de ruta activa. El mapa sigue visible.',
    'shopping_digital_badge': 'Digital',
    'shopping_online_fallback':
        'Oculta el mapa y muestra el flujo de pago BTC Escrow.',
  },
};

const Map<String, String> _shoppingEntryTranslationsEs = {
  'Fashion & Apparel': 'Moda y Ropa',
  'Tech & Electronics': 'Tecnología & Electrónica',
  'Food & Essentials': 'Alimentos y Esenciales',
  'Home & Living': 'Hogar y Vida',
  'Professional Services': 'Servicios Profesionales',
  'Travel & Leisure': 'Viajes y Ocio',
  'Media & Entertainment': 'Medios y Entretenimiento',
  'Auto & Industrial': 'Auto e Industrial',
  'Luxury': 'Lujo',
  'Everyday': 'Diario',
  'Footwear': 'Calzado',
  'Hardware': 'Hardware',
  'Software': 'Software',
  'Repair': 'Reparación',
  'Groceries': 'Comestibles',
  'Dining': 'Comida',
  'Health': 'Salud',
  'Kitchen': 'Cocina',
  'Furniture': 'Muebles',
  'Garden': 'Jardín',
  'Digital': 'Digital',
  'Maintenance': 'Mantenimiento',
  'Business': 'Negocios',
  'Transport': 'Transporte',
  'Lodging': 'Alojamiento',
  'Planning': 'Planificación',
  'Gaming': 'Juegos',
  'Streaming': 'Streaming',
  'Books': 'Libros',
  'Parts': 'Repuestos',
  'Services': 'Servicios',
  'Sales': 'Ventas',
  'Gucci': 'Gucci',
  'Farfetch': 'Farfetch',
  'Designers': 'Diseñadores',
  'Local Boutiques': 'Boutiques Locales',
  'Department Stores': 'Grandes Almacenes',
  'Sneakers': 'Zapatillas',
  'Formal Shoes': 'Zapatos Formales',
  'Newegg': 'Newegg',
  'Computer Parts': 'Componentes de PC',
  'Peripherals': 'Periféricos',
  'Microsoft': 'Microsoft',
  'SaaS': 'SaaS',
  'Licenses': 'Licencias',
  'Phone Screen': 'Pantalla de Teléfono',
  'Laptop Fix': 'Reparación de Portátil',
  'Local Techs': 'Técnicos Locales',
  'Supermarkets': 'Supermercados',
  'Farmers Markets': 'Mercados de Agricultores',
  'Restaurants': 'Restaurantes',
  'Takeout': 'Para Llevar',
  'Cafes': 'Cafeterías',
  'Pharmacy': 'Farmacia',
  'Vitamins': 'Vitaminas',
  'Personal Care': 'Cuidado Personal',
  'Appliances': 'Electrodomésticos',
  'Cutlery': 'Cubiertos',
  'Cookware': 'Utensilios de Cocina',
  'Living Room': 'Sala de Estar',
  'Bedroom': 'Dormitorio',
  'Office': 'Oficina',
  'Nurseries': 'Viveros',
  'Outdoor Decor': 'Decoración Exterior',
  'Tools': 'Herramientas',
  'Namecheap (Domains)': 'Namecheap (Dominios)',
  'VPN': 'VPN',
  'Cloud Email': 'Correo en la Nube',
  'Plumbers': 'Plomeros',
  'Electricians': 'Electricistas',
  'HVAC': 'HVAC',
  'Legal': 'Legal',
  'Accounting': 'Contabilidad',
  'Consulting': 'Consultoría',
  'Alternative Airlines': 'Aerolíneas Alternativas',
  'Travala': 'Travala',
  'Car Rental': 'Alquiler de Coches',
  'Hotels': 'Hoteles',
  'Vacation Rentals': 'Alojamientos Vacacionales',
  'Routes': 'Rutas',
  'Local Tours': 'Tours Locales',
  'Digital Downloads': 'Descargas Digitales',
  'Physical Games': 'Juegos Físicos',
  'Consoles': 'Consolas',
  'Movies': 'Películas',
  'Music Subscriptions': 'Suscripciones de Música',
  'eBooks': 'eBooks',
  'Physical Books': 'Libros Físicos',
  'Audiobooks': 'Audiolibros',
  'Tires': 'Neumáticos',
  'Batteries': 'Baterías',
  'Engine Parts': 'Piezas de Motor',
  'Mechanics': 'Mecánicos',
  'Body Work': 'Chapa y Pintura',
  'Oil Change': 'Cambio de Aceite',
  'Car Dealers': 'Concesionarios',
  'Equipment': 'Equipamiento',
};

String localizeShoppingText(String text, String language) {
  if (language == 'es') {
    return _shoppingEntryTranslationsEs[text] ?? text;
  }
  return text;
}

String _shoppingHubString(String language, String key) {
  return _localizedValues[language]?[key] ?? key;
}

class ShoppingSelection {
  final String category;
  final String subcategory;
  final String item;
  final bool isDigitalOnly;
  final bool isOnlineMode;
  final bool forceMapOn;

  ShoppingSelection({
    required this.category,
    required this.subcategory,
    required this.item,
    required this.isDigitalOnly,
    required this.isOnlineMode,
    required this.forceMapOn,
  });
}

typedef ShoppingSelectionCallback = void Function(ShoppingSelection selection);

class ShoppingHub extends StatefulWidget {
  final String language;
  final ShoppingSelectionCallback onSelection;
  const ShoppingHub(
      {super.key, required this.language, required this.onSelection});

  @override
  State<ShoppingHub> createState() => _ShoppingHubState();
}

class _ShoppingHubState extends State<ShoppingHub> {
  String _searchText = '';
  String _geminiText = '';
  ShoppingCategory? _selectedCategory;
  ShoppingSubcategory? _selectedSubcategory;
  String? _selectedItem;
  bool _isAsap = false;
  bool _isOnline = false;

  List<ShoppingCategory> get _filteredCategoryList {
    final filter = (_searchText + ' ' + _geminiText).trim().toLowerCase();
    if (filter.isEmpty) return shoppingHierarchy;

    return shoppingHierarchy
        .map((category) {
          final localizedCategory =
              localizeShoppingText(category.category, widget.language);
          final filteredSubs = category.subcategories
              .map((sub) {
                final localizedSub =
                    localizeShoppingText(sub.name, widget.language);
                final subMatches = sub.name.toLowerCase().contains(filter) ||
                    localizedSub.toLowerCase().contains(filter);
                final matchingItems = sub.items.where((item) {
                  final localizedItem =
                      localizeShoppingText(item, widget.language);
                  return item.toLowerCase().contains(filter) ||
                      localizedItem.toLowerCase().contains(filter);
                }).toList();

                if (subMatches) {
                  return ShoppingSubcategory(
                    name: sub.name,
                    items: sub.items,
                    isDigitalOnly: sub.isDigitalOnly,
                  );
                }

                if (matchingItems.isNotEmpty) {
                  return ShoppingSubcategory(
                    name: sub.name,
                    items: matchingItems,
                    isDigitalOnly: sub.isDigitalOnly,
                  );
                }
                return null;
              })
              .whereType<ShoppingSubcategory>()
              .toList();

          final categoryMatches =
              category.category.toLowerCase().contains(filter) ||
                  localizedCategory.toLowerCase().contains(filter);
          if (categoryMatches && filteredSubs.isEmpty) {
            return ShoppingCategory(
              category: category.category,
              isDigitalOnly: category.isDigitalOnly,
              forceMapOn: category.forceMapOn,
              subcategories: category.subcategories,
            );
          }

          if (filteredSubs.isNotEmpty) {
            return ShoppingCategory(
              category: category.category,
              isDigitalOnly: category.isDigitalOnly,
              forceMapOn: category.forceMapOn,
              subcategories: filteredSubs,
            );
          }
          return null;
        })
        .whereType<ShoppingCategory>()
        .toList();
  }

  void _selectItem(
    ShoppingCategory category,
    ShoppingSubcategory subcategory,
    String item,
  ) {
    final isDigitalOnly = category.isDigitalOnly || subcategory.isDigitalOnly;
    final isTravel = category.category == 'Travel & Leisure';

    setState(() {
      _selectedCategory = category;
      _selectedSubcategory = subcategory;
      _selectedItem = item;
      _isAsap = false;
      _isOnline = false;
    });

    if (isTravel) {
      planTravelRoute(item);
      widget.onSelection(ShoppingSelection(
        category: category.category,
        subcategory: subcategory.name,
        item: item,
        isDigitalOnly: false,
        isOnlineMode: false,
        forceMapOn: category.forceMapOn,
      ));
      return;
    }

    if (isDigitalOnly) {
      triggerSDTP();
      widget.onSelection(ShoppingSelection(
        category: category.category,
        subcategory: subcategory.name,
        item: item,
        isDigitalOnly: true,
        isOnlineMode: true,
        forceMapOn: category.forceMapOn,
      ));
      return;
    }

    _showUrgencyChoicePopup(category, subcategory, item);
  }

  void _showUrgencyChoicePopup(
    ShoppingCategory category,
    ShoppingSubcategory subcategory,
    String item,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _shoppingHubString(widget.language, 'shopping_how_soon_prompt'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ChoiceChip(
                    label: Text(
                      _shoppingHubString(widget.language, 'shopping_asap'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    selected: false,
                    selectedColor: Colors.orangeAccent,
                    backgroundColor: Colors.white10,
                    onSelected: (_) {
                      Navigator.of(context).pop();
                      updateSatNotesMap(item, isAsap: true);
                      setState(() {
                        _isAsap = true;
                        _isOnline = false;
                      });
                      widget.onSelection(ShoppingSelection(
                        category: category.category,
                        subcategory: subcategory.name,
                        item: item,
                        isDigitalOnly: false,
                        isOnlineMode: false,
                        forceMapOn: category.forceMapOn,
                      ));
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      _shoppingHubString(widget.language, 'shopping_online'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    selected: false,
                    selectedColor: Colors.blueAccent,
                    backgroundColor: Colors.white10,
                    onSelected: (_) {
                      Navigator.of(context).pop();
                      triggerSDTP();
                      setState(() {
                        _isAsap = false;
                        _isOnline = true;
                      });
                      widget.onSelection(ShoppingSelection(
                        category: category.category,
                        subcategory: subcategory.name,
                        item: item,
                        isDigitalOnly: false,
                        isOnlineMode: true,
                        forceMapOn: category.forceMapOn,
                      ));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                _shoppingHubString(widget.language, 'shopping_online_fallback'),
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        hintText: _shoppingHubString(widget.language, 'shopping_search_hint'),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) => setState(() {
        _searchText = value;
      }),
    );
  }

  Widget _buildGeminiInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white70),
          hintText: _shoppingHubString(widget.language, 'shopping_gemini_hint'),
          hintStyle: const TextStyle(color: Colors.white60),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value) => setState(() {
          _geminiText = value;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCategoryList;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.68,
        minChildSize: 0.38,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  _shoppingHubString(widget.language, 'shopping_hub_title'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                _buildSearchBar(),
                const SizedBox(height: 12),
                _buildGeminiInput(),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      if (filtered.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              _shoppingHubString(
                                  widget.language, 'shopping_no_results'),
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ...filtered.map((category) {
                        final isSelectedCategory = _selectedCategory != null &&
                            _selectedCategory!.category == category.category;
                        final isTravel =
                            category.category == 'Travel & Leisure';
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.white12,
                          ),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    localizeShoppingText(
                                        category.category, widget.language),
                                    style: TextStyle(
                                      color: isSelectedCategory
                                          ? Colors.white
                                          : Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (category.isDigitalOnly)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _shoppingHubString(widget.language,
                                          'shopping_digital_badge'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                if (isTravel)
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _shoppingHubString(widget.language,
                                          'shopping_route_planning'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            children: category.subcategories.map((subentry) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.white12,
                                ),
                                child: ExpansionTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          localizeShoppingText(
                                              subentry.name, widget.language),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (subentry.isDigitalOnly)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            _shoppingHubString(widget.language,
                                                'shopping_digital_badge'),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  tilePadding: const EdgeInsets.only(
                                      left: 12, right: 0, top: 0, bottom: 0),
                                  children: subentry.items.map((item) {
                                    final isSelected = isSelectedCategory &&
                                        _selectedSubcategory?.name ==
                                            subentry.name &&
                                        _selectedItem == item;
                                    return ListTile(
                                      dense: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 28, right: 8),
                                      title: Text(
                                        localizeShoppingText(
                                            item, widget.language),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white70,
                                        ),
                                      ),
                                      trailing: isSelected
                                          ? const Icon(Icons.check,
                                              color: Colors.greenAccent)
                                          : null,
                                      onTap: () => _selectItem(
                                        category,
                                        subentry,
                                        item,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                      if (_selectedCategory != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_shoppingHubString(widget.language, 'shopping_selected')}: ${localizeShoppingText(_selectedCategory!.category, widget.language)} > ${localizeShoppingText(_selectedSubcategory?.name ?? '', widget.language)} > ${localizeShoppingText(_selectedItem ?? '', widget.language)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      if (_selectedCategory != null &&
                          !_selectedCategory!.isDigitalOnly)
                        Wrap(
                          spacing: 10,
                          children: [
                            ChoiceChip(
                              label: Text(_shoppingHubString(
                                  widget.language, 'shopping_asap')),
                              selected: _isAsap,
                              selectedColor: Colors.orangeAccent,
                              onSelected: (_) => _selectMode(true),
                            ),
                            ChoiceChip(
                              label: Text(_shoppingHubString(
                                  widget.language, 'shopping_online')),
                              selected: _isOnline,
                              selectedColor: Colors.blueAccent,
                              onSelected: (_) => _selectMode(false),
                            ),
                          ],
                        ),
                      if (_selectedCategory != null &&
                          _selectedCategory!.isDigitalOnly)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              _shoppingHubString(widget.language,
                                  'shopping_digital_only_note'),
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _selectMode(bool asap) {
    if (_selectedCategory == null || _selectedItem == null) {
      return;
    }

    setState(() {
      _isAsap = asap;
      _isOnline = !asap;
    });

    if (asap) {
      updateSatNotesMap(_selectedItem!, isAsap: true);
    } else {
      triggerSDTP();
    }

    widget.onSelection(ShoppingSelection(
      category: _selectedCategory!.category,
      subcategory: _selectedSubcategory?.name ?? '',
      item: _selectedItem ?? '',
      isDigitalOnly: false,
      isOnlineMode: !asap,
      forceMapOn: _selectedCategory!.forceMapOn,
    ));
  }
}

void triggerSDTP() {
  debugPrint('triggerSDTP() called: digital-only flow started.');
}

void updateSatNotesMap(String item, {bool isAsap = false}) {
  debugPrint(
      'updateSatNotesMap() called for $item; ASAP mode = $isAsap. Updating SatNotes pins.');
}

void planTravelRoute(String item) {
  debugPrint(
      'planTravelRoute() called for $item. Route Planning mode active and map stays visible.');
}
