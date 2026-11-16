import 'package:flutter/material.dart';

void main() {
  runApp(const MinisoApp());
}

class Product {
  final String name;
  final String category;
  final double price;
  final String code;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.code,
    required this.imageUrl,
  });
}

class MinisoApp extends StatelessWidget {
  const MinisoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MINISO Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF5F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE91E63),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const MinisoHomePage(),
    );
  }
}

class MinisoHomePage extends StatefulWidget {
  const MinisoHomePage({super.key});

  @override
  State<MinisoHomePage> createState() => _MinisoHomePageState();
}

class _MinisoHomePageState extends State<MinisoHomePage> {
  int selectedIndex = 0;
  int sortColumnIndex = 2;
  bool sortAscending = true;

  // PRODUCT IMAGES
  final List<Product> products = [
    Product(
      name: 'Cute Teddy Bear',
      category: 'Plush Toys',
      price: 1500,
      code: 'M001',
      imageUrl:
      'https://miniso.bg/uploads/product-image/image/original/6937237457267-1.jpg',
    ),
    Product(
      name: 'Pink Water Bottle',
      category: 'Accessories',
      price: 850,
      code: 'M002',
      imageUrl:
      'https://i5.walmartimages.com/seo/ENQIZN-transparent-Tritan-plastic-water-bottle-straw-cup-fashionable-direct-drinking-cup-lid-leak-proof-sealing-gasket-bouncing-cup-BPA-free-sports-w_ab942f0f-0a98-4e08-a60e-2b03231b5b53.fff3c9b721751028f71a31e4ddd5242d.jpeg',
    ),
    Product(
      name: 'Beauty Mirror',
      category: 'Beauty',
      price: 650,
      code: 'M003',
      imageUrl:
      'https://i5.walmartimages.com/seo/TINKER-Portable-Round-Handle-Small-Mirror-for-Makeup-and-Go-Out-Small-Mirror_ca51f00c-34df-4aa4-9fe5-08f7a58ddc65.7cdf8e390529d60459d25eea2ab06892.jpeg',
    ),
    Product(
      name: 'Cute Handbag',
      category: 'Accessories',
      price: 2200,
      code: 'M004',
      imageUrl:
      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/6f0c348b339d2593934ee2b6727ceae1.jpg',
    ),
    Product(
      name: 'Lip Gloss Set',
      category: 'Beauty',
      price: 950,
      code: 'M005',
      imageUrl:
      'https://nikolbeauty.com/cdn/shop/products/Champs-For-Website.png?crop=center&height=800&v=1681859063&width=800',
    ),
    Product(
      name: 'Mini Plush Bunny',
      category: 'Plush Toys',
      price: 1200,
      code: 'M006',
      imageUrl:
      'https://cdn.shopify.com/s/files/1/0604/0675/9575/products/Ha33e9cec44184e49afd89faa2500d96f1.jpg?v=1677748025',
    ),
  ];

  // PRODUCT IMAGE WIDGET
  Widget productImage(String imageUrl, {double size = 75}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;

          return Container(
            width: size,
            height: size,
            color: const Color(0xFFFCE4EC),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: const Color(0xFFFCE4EC),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.pink,
              size: 30,
            ),
          );
        },
      ),
    );
  }

  // SORT PRODUCTS
  void sortProducts(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      products.sort((a, b) {
        int result;

        if (columnIndex == 0) {
          result = a.name.compareTo(b.name);
        } else if (columnIndex == 1) {
          result = a.category.compareTo(b.category);
        } else {
          result = a.price.compareTo(b.price);
        }

        return ascending ? result : -result;
      });
    });
  }

  // DRAWER MESSAGE
  void showDrawerMessage(String title, String message) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  // MAIN PAGE SELECTION
  Widget getSelectedPage() {
    if (selectedIndex == 0) {
      return buildHomePage();
    } else if (selectedIndex == 1) {
      return buildShopPage();
    } else {
      return buildPricePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MINISO #264',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),

      // DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFE91E63),
              ),
              accountName: const Text(
                'Welcome to MINISO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('Cute things, happy life!'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.store,
                  color: Colors.pink,
                  size: 35,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.pink),
              title: const Text('Home'),
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.pink),
              title: const Text('About MINISO'),
              onTap: () {
                showDrawerMessage(
                  'About MINISO',
                  'MINISO is a lifestyle store offering toys, '
                      'beauty products and everyday accessories.',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.pink),
              title: const Text('Store Information'),
              onTap: () {
                showDrawerMessage(
                  'Store Information',
                  'Visit a MINISO store for more lovely products!\n'
                      'Sample opening hours: 10 AM - 10 PM.',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.pink),
              title: const Text('Customer Support'),
              onTap: () {
                showDrawerMessage(
                  'Customer Support',
                  'Email: support@miniso.com',
                );
              },
            ),
          ],
        ),
      ),

      body: getSelectedPage(),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Prices',
          ),
        ],
      ),
    );
  }

  // HOME PAGE
  Widget buildHomePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // STACK BANNER
        Stack(
          children: [
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF80AB),
                    Color(0xFFF8BBD0),
                    Color(0xFFE1BEE7),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 95,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'NEW ARRIVALS',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 18,
              bottom: 18,
              child: Text(
                'Find Your Happy Place!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 22),

        const Text(
          'Welcome to MINISO 💗',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE91E63),
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Explore cute products for your everyday life.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Popular Products',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        // LISTVIEW OF PRODUCT LISTTILES
        ...products.map((product) {
          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: productImage(product.imageUrl, size: 65),
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(product.category),
              trailing: Text(
                'Rs. ${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 10),

        const Text(
          'Store Code: MINISO-264',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        const SelectableText(
          'MINISO #264 | Customer Help: support@miniso.com',
          style: TextStyle(
            color: Color(0xFFE91E63),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // SHOP PAGE WITH TABS
  Widget buildShopPage() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: const Color(0xFFFCE4EC),
            child: const TabBar(
              labelColor: Color(0xFFE91E63),
              unselectedLabelColor: Colors.black54,
              indicatorColor: Color(0xFFE91E63),
              tabs: [
                Tab(
                  icon: Icon(Icons.toys),
                  text: 'Toys',
                ),
                Tab(
                  icon: Icon(Icons.face),
                  text: 'Beauty',
                ),
                Tab(
                  icon: Icon(Icons.shopping_bag),
                  text: 'Accessories',
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                buildCategoryList('Plush Toys'),
                buildCategoryList('Beauty'),
                buildCategoryList('Accessories'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CATEGORY PRODUCT LIST
  Widget buildCategoryList(String category) {
    final categoryProducts = products
        .where((product) => product.category == category)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: categoryProducts.length,
      itemBuilder: (context, index) {
        final product = categoryProducts[index];

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: productImage(product.imageUrl, size: 70),
            title: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Code: ${product.code}'),
            trailing: Text(
              'Rs. ${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  // PRICE PAGE WITH SORTABLE DATATABLE
  Widget buildPricePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MINISO Product Price List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),

          const SizedBox(height: 15),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              headingRowColor: MaterialStateProperty.all(
                const Color(0xFFF8BBD0),
              ),
              columns: [
                DataColumn(
                  label: const Text('Product'),
                  onSort: (columnIndex, ascending) {
                    sortProducts(columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: const Text('Category'),
                  onSort: (columnIndex, ascending) {
                    sortProducts(columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: const Text('Price'),
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    sortProducts(columnIndex, ascending);
                  },
                ),
              ],
              rows: products.map((product) {
                return DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.category)),
                    DataCell(
                      Text(
                        'Rs. ${product.price.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 15),

          const SelectableText(
            'Reference: MINISO-264\n'
                'Select this text to copy the store reference.',
            style: TextStyle(
              color: Color(0xFFE91E63),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}