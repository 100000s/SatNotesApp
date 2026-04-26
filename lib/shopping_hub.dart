import 'package:flutter/material.dart';

final List<Map<String, dynamic>> masterCategoryList = [
  {
    "name": "Shopping",
    "isDigitalOnly": false,
    "sub": [
      {
        "name": "Clothing & Fashion",
        "items": ["Farfetch", "Gucci", "Local Boutiques"]
      },
      {
        "name": "Electronics",
        "items": ["Microsoft", "Newegg", "Local Repair"]
      },
    ]
  },
  {
    "name": "Household",
    "isDigitalOnly": false,
    "sub": [
      {
        "name": "Kitchen",
        "items": ["Appliances", "Cutlery", "Local Hardware"]
      },
      {
        "name": "Living Room",
        "items": ["Furniture", "Lighting", "Art"]
      }
    ]
  },
  {
    "name": "Digital Services",
    "isDigitalOnly": true,
    "sub": [
      {
        "name": "Media",
        "items": ["VPN", "Email", "Streaming"]
      },
      {
        "name": "Domains",
        "items": ["Namecheap", "Cloudflare"]
      }
    ]
  },
  {
    "name": "Travel",
    "isDigitalOnly": true,
    "sub": [
      {
        "name": "Airlines",
        "items": ["Alternative Airlines", "Travala"]
      }
    ]
  }
];

const Map<String, Map<String, String>> _localizedValues = {
  'en': {
    'shopping_hub_title': 'Shopping Hub',
    'shopping_search_hint': 'Search categories, items, stores',
    'shopping_gemini_hint': 'Ask for a smart shopping suggestion',
    'shopping_no_results': 'No results found. Try a different query.',
    'shopping_selected': 'Selected',
    'shopping_asap': 'ASAP',
    'shopping_online': 'Online',
    'shopping_digital_only_note':
        'This category is digital-only.\nTriggering Online Protocol.',
  },
  'es': {
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
  },
};

String _shoppingHubString(String language, String key) {
  return _localizedValues[language]?[key] ?? key;
}

class ShoppingSelection {
  final String category;
  final String subcategory;
  final String item;
  final bool isDigitalOnly;
  final bool isOnlineMode;

  ShoppingSelection({
    required this.category,
    required this.subcategory,
    required this.item,
    required this.isDigitalOnly,
    required this.isOnlineMode,
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
  Map<String, dynamic>? _selectedCategory;
  String? _selectedSubcategory;
  String? _selectedItem;
  bool _isAsap = false;
  bool _isOnline = false;

  List<Map<String, dynamic>> get _filteredCategoryList {
    final filter = (_searchText + ' ' + _geminiText).trim().toLowerCase();
    if (filter.isEmpty) {
      return masterCategoryList;
    }

    return masterCategoryList
        .map((category) {
          final sub = (category['sub'] as List<dynamic>)
              .map((subentry) {
                final subName = (subentry['name'] as String).toLowerCase();
                final items = (subentry['items'] as List<dynamic>)
                    .where((item) =>
                        (item as String).toLowerCase().contains(filter))
                    .toList();

                if (subName.contains(filter) || items.isNotEmpty) {
                  return {
                    'name': subentry['name'],
                    'items': items,
                  };
                }
                return null;
              })
              .whereType<Map<String, dynamic>>()
              .toList();

          if (category['name'].toString().toLowerCase().contains(filter) ||
              sub.isNotEmpty) {
            return {
              'name': category['name'],
              'isDigitalOnly': category['isDigitalOnly'],
              'sub': sub,
            };
          }

          return null;
        })
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  void _selectItem(
    Map<String, dynamic> category,
    String subcategory,
    String item,
  ) {
    final isDigitalOnly = category['isDigitalOnly'] as bool;

    setState(() {
      _selectedCategory = category;
      _selectedSubcategory = subcategory;
      _selectedItem = item;
      _isAsap = false;
      _isOnline = false;
    });

    if (isDigitalOnly) {
      debugPrint('Triggering Online Protocol');
      widget.onSelection(ShoppingSelection(
        category: category['name'] as String,
        subcategory: subcategory,
        item: item,
        isDigitalOnly: true,
        isOnlineMode: true,
      ));
    }
  }

  void _selectMode(bool asap) {
    if (_selectedCategory == null || _selectedItem == null) {
      return;
    }

    setState(() {
      _isAsap = asap;
      _isOnline = !asap;
    });

    widget.onSelection(ShoppingSelection(
      category: _selectedCategory!['name'] as String,
      subcategory: _selectedSubcategory ?? '',
      item: _selectedItem ?? '',
      isDigitalOnly: false,
      isOnlineMode: !asap,
    ));
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
                            _selectedCategory!['name'] == category['name'];
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.white12,
                          ),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    category['name'] as String,
                                    style: TextStyle(
                                      color: isSelectedCategory
                                          ? Colors.white
                                          : Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (category['isDigitalOnly'] as bool)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Digital',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            children: (category['sub'] as List<dynamic>)
                                .map<Widget>((subentry) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.white12,
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    subentry['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  tilePadding: const EdgeInsets.only(
                                      left: 12, right: 0, top: 0, bottom: 0),
                                  children: (subentry['items'] as List<dynamic>)
                                      .map<Widget>((item) {
                                    final isSelected = isSelectedCategory &&
                                        _selectedSubcategory ==
                                            subentry['name'] &&
                                        _selectedItem == item;
                                    return ListTile(
                                      dense: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 28, right: 8),
                                      title: Text(
                                        item as String,
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
                                        subentry['name'] as String,
                                        item as String,
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
                              '${_shoppingHubString(widget.language, 'shopping_selected')}: ${_selectedCategory!['name']} > ${_selectedSubcategory ?? ''} > ${_selectedItem ?? ''}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      if (_selectedCategory != null &&
                          !(_selectedCategory!['isDigitalOnly'] as bool))
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
                          (_selectedCategory!['isDigitalOnly'] as bool))
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
}
