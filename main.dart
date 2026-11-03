import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MahnashanPackApp());
}

const Color brandColor = Color(0xFF8B4E2F);
const Color brandDark = Color(0xFF60351F);
const Color creamColor = Color(0xFFFFF8EF);
const Color cardColor = Colors.white;

class Product {
  final int id;
  final String name;
  final String category;
  final IconData icon;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
  });
}

const List<Product> products = [
  Product(id: 0, name: 'جعبه تک پرس با سرویس', category: 'جعبه‌ها', icon: Icons.lunch_dining),
  Product(id: 1, name: 'جعبه ارکیده', category: 'جعبه‌ها', icon: Icons.inventory_2_outlined),
  Product(id: 2, name: 'جعبه گلتاج', category: 'جعبه‌ها', icon: Icons.inventory_2_outlined),
  Product(id: 3, name: 'جعبه خوشه', category: 'جعبه‌ها', icon: Icons.inventory_2_outlined),
  Product(id: 4, name: 'جعبه زرین', category: 'جعبه‌ها', icon: Icons.inventory_2_outlined),
  Product(id: 5, name: 'جعبه زیبا', category: 'جعبه‌ها', icon: Icons.inventory_2_outlined),
  Product(id: 6, name: 'جعبه شیرین', category: 'جعبه‌ها', icon: Icons.cake_outlined),
  Product(id: 7, name: 'جعبه ۱۲ پرسی', category: 'جعبه‌ها', icon: Icons.grid_view_rounded),
  Product(id: 8, name: 'جعبه ساندویچ', category: 'جعبه‌ها', icon: Icons.lunch_dining),
  Product(id: 9, name: 'سینی تک پرسی', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 10, name: 'سینی تک پرس با سرویس', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 11, name: 'سینی دو پرس با سرویس', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 12, name: 'سینی سه پرس ارتفاع ۵', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 13, name: 'سینی سه پرس ارتفاع ۴', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 14, name: 'سینی شیرین', category: 'سینی‌ها', icon: Icons.cake_outlined),
  Product(id: 15, name: 'سینی نیم پرسی', category: 'سینی‌ها', icon: Icons.restaurant),
  Product(id: 16, name: 'جا لیوانی دو عددی', category: 'آبمیوه و بستنی', icon: Icons.local_cafe_outlined),
  Product(id: 17, name: 'جا لیوانی ۴ عددی', category: 'آبمیوه و بستنی', icon: Icons.local_cafe_outlined),
  Product(id: 18, name: 'سینی بستنی ۲ عددی', category: 'آبمیوه و بستنی', icon: Icons.icecream_outlined),
  Product(id: 19, name: 'سینی بستنی ۴ عددی', category: 'آبمیوه و بستنی', icon: Icons.icecream_outlined),
  Product(id: 20, name: 'سینی هرمی', category: 'سینی‌ها', icon: Icons.view_in_ar_outlined),
  Product(id: 21, name: 'جا لیوانی دسته‌دار', category: 'آبمیوه و بستنی', icon: Icons.local_cafe_outlined),
];

class MahnashanPackApp extends StatelessWidget {
  const MahnashanPackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ماهنشان پک',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: creamColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandColor,
          primary: brandColor,
          surface: creamColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: creamColor,
          foregroundColor: brandDark,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8EF), Color(0xFFF0D8C1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(36),
                      boxShadow: [
                        BoxShadow(
                          color: brandColor.withOpacity(0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      size: 95,
                      color: brandColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'ماهنشان پک',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: brandDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'بسته‌بندی حرفه‌ای برای غذای بیرون‌بر',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF795B48),
                    ),
                  ),
                  const SizedBox(height: 42),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StorePage(),
                          ),
                        );
                      },
                      child: const Text(
                        'ورود به اپلیکیشن',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int selectedTab = 0;
  String selectedCategory = 'همه محصولات';

  final Map<int, int> quantities = {};
  final Map<int, double> prices = {};

  final List<String> categories = [
    'همه محصولات',
    'جعبه‌ها',
    'سینی‌ها',
    'آبمیوه و بستنی',
  ];

  @override
  void initState() {
    super.initState();
    loadPrices();
  }

  Future<void> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();

    for (final product in products) {
      prices[product.id] = prefs.getDouble('price_${product.id}') ?? 0;
    }

    if (mounted) setState(() {});
  }

  double get totalPrice {
    double total = 0;
    quantities.forEach((id, quantity) {
      total += (prices[id] ?? 0) * quantity;
    });
    return total;
  }

  int get totalItems {
    return quantities.values.fold(0, (sum, value) => sum + value);
  }

  void changeQuantity(int id, int value) {
    setState(() {
      final newValue = (quantities[id] ?? 0) + value;
      if (newValue <= 0) {
        quantities.remove(id);
      } else {
        quantities[id] = newValue;
      }
    });
  }

  List<Product> get visibleProducts {
    if (selectedCategory == 'همه محصولات') return products;

    return products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ماهنشان پک',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            tooltip: 'مدیریت قیمت‌ها',
            icon: const Icon(Icons.admin_panel_settings_outlined),
            onPressed: openAdmin,
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          buildHome(),
          buildCart(),
          buildContact(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'فروشگاه',
          ),
          NavigationDestination(
            icon: const Icon(Icons.shopping_basket_outlined),
            selectedIcon: const Icon(Icons.shopping_basket),
            label: totalItems == 0 ? 'سبد خرید' : 'سبد ($totalItems)',
          ),
          const NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            selectedIcon: Icon(Icons.support_agent),
            label: 'تماس',
          ),
        ],
      ),
    );
  }

  Widget buildHome() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              colors: [Color(0xFF9D5C36), Color(0xFF60351F)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بسته‌بندی خوشمزه‌ها',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'جعبه و سینی بیرون‌بر با کیفیت مناسب رستوران‌ها',
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.lunch_dining_rounded,
                size: 72,
                color: Color(0xFFFFD9A8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'دسته‌بندی محصولات',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: brandDark,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((category) {
              final selected = selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                  selectedColor: brandColor,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : brandDark,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(
                    color: selected ? brandColor : const Color(0xFFE5D5C7),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'محصولات',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: brandDark,
              ),
            ),
            Text(
              '${visibleProducts.length} محصول',
              style: const TextStyle(color: Colors.brown),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.77,
          ),
          itemBuilder: (context, index) {
            return productCard(visibleProducts[index]);
          },
        ),
      ],
    );
  }
    Widget productCard(Product product) {
    final price = prices[product.id] ?? 0;
    final quantity = quantities[product.id] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF0E3D8)),
        boxShadow: [
          BoxShadow(
            color: brandColor.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0DF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomPaint(
                  painter: TakeawayPackagePainter(
                    productId: product.id,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: brandDark,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              price == 0
                  ? 'تماس برای استعلام قیمت'
                  : '${formatPrice(price)} تومان',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.brown,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            if (quantity == 0)
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () => changeQuantity(product.id, 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'افزودن به سبد',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  quantityButton(
                    icon: Icons.remove,
                    onTap: () => changeQuantity(product.id, -1),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  quantityButton(
                    icon: Icons.add,
                    onTap: () => changeQuantity(product.id, 1),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE8D4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: brandColor),
      ),
    );
  }

  String formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

class TakeawayPackagePainter extends CustomPainter {
  final int productId;

  TakeawayPackagePainter({required this.productId});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final cardboard = const Color(0xFFC99560);
    final cardboardLight = const Color(0xFFE4BD8B);
    final cardboardDark = const Color(0xFF9C673A);
    final foodColors = [
      const Color(0xFFB94B2E),
      const Color(0xFFE3A33C),
      const Color(0xFF6D8B43),
      const Color(0xFFF0D28C),
    ];

    final shadowPaint = Paint()
      ..color = Colors.brown.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final boxPaint = Paint()..color = cardboard;
    final lightPaint = Paint()..color = cardboardLight;
    final darkPaint = Paint()..color = cardboardDark;
    final foodPaint = Paint();

    final centerX = w * 0.5;
    final topY = h * 0.30;
    final boxW = w * 0.62;
    final boxH = h * 0.42;

    final topRect = Rect.fromCenter(
      center: Offset(centerX, topY + boxH * 0.25),
      width: boxW,
      height: boxH * 0.55,
    );

    final sidePath = Path()
      ..moveTo(topRect.left, topRect.top)
      ..lineTo(topRect.left + boxW * 0.12, topRect.bottom)
      ..lineTo(topRect.right + boxW * 0.12, topRect.bottom)
      ..lineTo(topRect.right, topRect.top)
      ..close();

    final bottomPath = Path()
      ..moveTo(topRect.left, topRect.bottom)
      ..lineTo(topRect.left + boxW * 0.12, topRect.bottom + boxH * 0.55)
      ..lineTo(topRect.right + boxW * 0.12, topRect.bottom + boxH * 0.55)
      ..lineTo(topRect.right, topRect.bottom)
      ..close();

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          centerX - boxW * 0.55,
          topRect.bottom + boxH * 0.45,
          boxW * 1.2,
          boxH * 0.12,
        ),
        const Radius.circular(8),
      ),
      shadowPaint,
    );

    canvas.drawPath(sidePath, darkPaint);
    canvas.drawPath(bottomPath, boxPaint);
    canvas.drawRect(topRect, lightPaint);

    final lidPath = Path()
      ..moveTo(topRect.left - boxW * 0.06, topRect.top)
      ..lineTo(centerX, topRect.top - boxH * 0.18)
      ..lineTo(topRect.right + boxW * 0.06, topRect.top)
      ..lineTo(centerX, topRect.top + boxH * 0.18)
      ..close();

    canvas.drawPath(lidPath, boxPaint);

    final isTray = productId >= 9 && productId <= 15;
    final isCupHolder = productId >= 16 && productId <= 19 ||
        productId == 21;

    if (isTray) {
      final dividerPaint = Paint()
        ..color = cardboardDark
        ..strokeWidth = 3;

      canvas.drawLine(
        Offset(centerX, topRect.top),
        Offset(centerX, topRect.bottom),
        dividerPaint,
      );

      canvas.drawLine(
        Offset(topRect.left, topRect.center.dy),
        Offset(topRect.right, topRect.center.dy),
        dividerPaint,
      );
    }

    if (isCupHolder) {
      for (int i = 0; i < 2; i++) {
        final cupX = centerX - boxW * 0.18 + i * boxW * 0.36;

        canvas.drawCircle(
          Offset(cupX, topRect.center.dy),
          boxW * 0.13,
          darkPaint,
        );

        canvas.drawCircle(
          Offset(cupX, topRect.center.dy),
          boxW * 0.10,
          lightPaint,
        );
      }
    }

    for (int i = 0; i < 4; i++) {
      final foodX = topRect.left + boxW * (0.18 + i * 0.17);
      final foodY = topRect.center.dy +
          (i.isEven ? -boxH * 0.05 : boxH * 0.04);

      foodPaint.color = foodColors[(i + productId) % foodColors.length];

      canvas.drawCircle(
        Offset(foodX, foodY),
        boxW * 0.075,
        foodPaint,
      );
    }

    final wrapPaint = Paint()
      ..color = Colors.white.withOpacity(0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawLine(
      Offset(topRect.left + 5, topRect.top + 3),
      Offset(topRect.right - 5, topRect.bottom - 3),
      wrapPaint,
    );

    final logoPaint = Paint()..color = brandDark;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX + boxW * 0.12, topRect.bottom + boxH * 0.30),
          width: boxW * 0.40,
          height: boxH * 0.20,
        ),
        const Radius.circular(4),
      ),
      logoPaint,
    );

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'MP',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        centerX + boxW * 0.12 - textPainter.width / 2,
        topRect.bottom + boxH * 0.30 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant TakeawayPackagePainter oldDelegate) {
    return oldDelegate.productId != productId;
  }
}
extension StorePageHelpers on _StorePageState {
  Widget buildCart() {
    final selectedProducts = products
        .where((product) => (quantities[product.id] ?? 0) > 0)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'سبد خرید شما',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: brandDark,
          ),
        ),
        const SizedBox(height: 16),
        if (selectedProducts.isEmpty)
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.shopping_basket_outlined,
                  size: 65,
                  color: Color(0xFFD2B49B),
                ),
                SizedBox(height: 12),
                Text(
                  'سبد خرید شما خالی است',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: brandDark,
                  ),
                ),
              ],
            ),
          ),
        ...selectedProducts.map((product) {
          final quantity = quantities[product.id] ?? 0;
          final price = prices[product.id] ?? 0;

          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFF0E3D8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0DF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(product.icon, color: brandColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: brandDark,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${formatPrice(price * quantity)} تومان',
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  quantityButton(
                    icon: Icons.remove,
                    onTap: () => changeQuantity(product.id, -1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  quantityButton(
                    icon: Icons.add,
                    onTap: () => changeQuantity(product.id, 1),
                  ),
                ],
              ),
            ),
          );
        }),
        if (selectedProducts.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'مبلغ کل',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: brandDark,
                      ),
                    ),
                    Text(
                      '${formatPrice(totalPrice)} تومان',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: brandColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: copyOrder,
                    icon: const Icon(Icons.copy),
                    label: const Text('کپی متن سفارش'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Future<void> copyOrder() async {
    final buffer = StringBuffer();

    buffer.writeln('سفارش از ماهنشان پک');
    buffer.writeln('--------------------');

    for (final product in products) {
      final quantity = quantities[product.id] ?? 0;

      if (quantity > 0) {
        buffer.writeln('${product.name} : $quantity عدد');
      }
    }

    buffer.writeln('--------------------');
    buffer.writeln('مبلغ کل: ${formatPrice(totalPrice)} تومان');
    buffer.writeln('شماره تماس: 09388462634');

    await Clipboard.setData(
      ClipboardData(text: buffer.toString()),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('متن سفارش کپی شد؛ می‌توانید آن را در واتساپ بفرستید.'),
      ),
    );
  }

  Widget buildContact() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.support_agent_rounded,
                size: 75,
                color: brandColor,
              ),
              SizedBox(height: 16),
              Text(
                'ارتباط با ماهنشان پک',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: brandDark,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'برای ثبت سفارش و دریافت اطلاعات محصولات با ما تماس بگیرید.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.8,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 18),
              SelectableText(
                '09388462634',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: brandColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openAdmin() async {
    final controller = TextEditingController();

    final pin = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ورود مدیریت'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'رمز مدیریت',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('ورود'),
            ),
          ],
        );
      },
    );

    if (!mounted || pin == null) return;

    if (pin != '1234') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رمز مدیریت اشتباه است.')),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminPage(
          products: products,
          currentPrices: prices,
          onPriceChanged: (id, price) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setDouble('price_$id', price);

            if (mounted) {
              setState(() {
                prices[id] = price;
              });
            }
          },
        ),
      ),
    );

    if (mounted) await loadPrices();
  }
}
class AdminPage extends StatefulWidget {
  final List<Product> products;
  final Map<int, double> currentPrices;
  final Future<void> Function(int id, double price) onPriceChanged;

  const AdminPage({
    super.key,
    required this.products,
    required this.currentPrices,
    required this.onPriceChanged,
  });

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late final Map<int, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    controllers = {
      for (final product in widget.products)
        product.id: TextEditingController(
          text: (widget.currentPrices[product.id] ?? 0).toStringAsFixed(0),
        ),
    };
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت قیمت محصولات'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brandDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controllers[product.id],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'قیمت به تومان',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () async {
                        final price = double.tryParse(
                          controllers[product.id]!.text.trim(),
                        );

                        if (price == null || price < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('قیمت واردشده معتبر نیست.'),
                            ),
                          );
                          return;
                        }

                        await widget.onPriceChanged(product.id, price);

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('قیمت ذخیره شد.'),
                          ),
                        );
                      },
                      child: const Text('ذخیره قیمت'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
