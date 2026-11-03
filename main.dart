
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MahnashanPackApp());
}

// Industrial brand identity
const Color ink = Color(0xFF20262B);
const Color ink2 = Color(0xFF303940);
const Color orange = Color(0xFFFF7626);
const Color paper = Color(0xFFF3F4F4);
const Color white = Colors.white;
const Color muted = Color(0xFF7C858C);
const Color line = Color(0xFFE1E5E7);

String money(double value) {
  return value.toStringAsFixed(0).replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
}

class Product {
  final int id;
  final String name;
  final String category;
  final IconData icon;
  final String code;

  const Product(
    this.id,
    this.name,
    this.category,
    this.icon,
    this.code,
  );
}

const products = <Product>[
  Product(0, 'جعبه تک پرس با سرویس', 'جعبه‌ها', Icons.lunch_dining, 'BOX-01'),
  Product(1, 'جعبه ارکیده', 'جعبه‌ها', Icons.inventory_2, 'BOX-02'),
  Product(2, 'جعبه گلتاج', 'جعبه‌ها', Icons.inventory_2, 'BOX-03'),
  Product(3, 'جعبه خوشه', 'جعبه‌ها', Icons.inventory_2, 'BOX-04'),
  Product(4, 'جعبه زرین', 'جعبه‌ها', Icons.inventory_2, 'BOX-05'),
  Product(5, 'جعبه زیبا', 'جعبه‌ها', Icons.inventory_2, 'BOX-06'),
  Product(6, 'جعبه شیرین', 'جعبه‌ها', Icons.cake, 'BOX-07'),
  Product(7, 'جعبه ۱۲ پرسی', 'جعبه‌ها', Icons.grid_view, 'BOX-08'),
  Product(8, 'جعبه ساندویچ', 'جعبه‌ها', Icons.lunch_dining, 'BOX-09'),
  Product(9, 'سینی تک پرسی', 'سینی‌ها', Icons.restaurant, 'TRY-01'),
  Product(10, 'سینی تک پرس با سرویس', 'سینی‌ها', Icons.restaurant, 'TRY-02'),
  Product(11, 'سینی دو پرس با سرویس', 'سینی‌ها', Icons.restaurant, 'TRY-03'),
  Product(12, 'سینی سه پرس ارتفاع ۵', 'سینی‌ها', Icons.dashboard, 'TRY-04'),
  Product(13, 'سینی سه پرس ارتفاع ۴', 'سینی‌ها', Icons.dashboard, 'TRY-05'),
  Product(14, 'سینی شیرین', 'سینی‌ها', Icons.cake, 'TRY-06'),
  Product(15, 'سینی نیم پرسی', 'سینی‌ها', Icons.restaurant, 'TRY-07'),
  Product(16, 'جا لیوانی دو عددی', 'آبمیوه و بستنی', Icons.local_cafe, 'CUP-01'),
  Product(17, 'جا لیوانی ۴ عددی', 'آبمیوه و بستنی', Icons.local_cafe, 'CUP-02'),
  Product(18, 'سینی بستنی ۲ عددی', 'آبمیوه و بستنی', Icons.icecream, 'ICE-01'),
  Product(19, 'سینی بستنی ۴ عددی', 'آبمیوه و بستنی', Icons.icecream, 'ICE-02'),
  Product(20, 'سینی هرمی', 'سینی‌ها', Icons.view_in_ar, 'TRY-08'),
  Product(21, 'جا لیوانی دسته‌دار', 'آبمیوه و بستنی', Icons.local_cafe, 'CUP-03'),
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
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: orange,
          primary: orange,
          surface: white,
        ),
      ),
      home: const StorePage(),
    );
  }
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int tab = 0;
  String category = 'همه';
  String search = '';

  final Map<int, int> quantities = {};
  final Map<int, double> prices = {};
  final searchController = TextEditingController();

  final categories = const [
    'همه',
    'جعبه‌ها',
    'سینی‌ها',
    'آبمیوه و بستنی',
  ];

  @override
  void initState() {
    super.initState();
    loadPrices();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    for (final p in products) {
      prices[p.id] = prefs.getDouble('price_${p.id}') ?? 0;
    }
    if (mounted) setState(() {});
  }

  int get itemCount =>
      quantities.values.fold(0, (sum, value) => sum + value);

  double get total {
    double result = 0;
    quantities.forEach((id, count) {
      result += (prices[id] ?? 0) * count;
    });
    return result;
  }

  void changeQuantity(int id, int change) {
    setState(() {
      final next = (quantities[id] ?? 0) + change;
      if (next <= 0) {
        quantities.remove(id);
      } else {
        quantities[id] = next;
      }
    });
  }

  List<Product> get filteredProducts {
    return products.where((p) {
      final matchesCategory =
          category == 'همه' || p.category == category;
      final matchesSearch =
          p.name.toLowerCase().contains(search.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: paper,
        appBar: AppBar(
          backgroundColor: ink,
          foregroundColor: white,
          elevation: 0,
          titleSpacing: 18,
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.inventory_2_rounded,
                  color: white,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ماهنشان پک',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'PACKAGING SOLUTIONS',
                    style: TextStyle(
                      fontSize: 8,
                      letterSpacing: 1.2,
                      color: Color(0xFFB8C0C5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'مدیریت قیمت‌ها',
              onPressed: openAdmin,
              icon: const Icon(Icons.settings_outlined),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: IndexedStack(
          index: tab,
          children: [
            buildHome(),
            buildCart(),
            buildContact(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: white,
          indicatorColor: orange.withOpacity(.15),
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.grid_view_rounded),
              selectedIcon: Icon(Icons.grid_view_rounded, color: orange),
              label: 'محصولات',
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_bag_outlined),
              selectedIcon:
                  const Icon(Icons.shopping_bag, color: orange),
              label: itemCount == 0 ? 'سبد سفارش' : 'سبد ($itemCount)',
            ),
            const NavigationDestination(
              icon: Icon(Icons.headset_mic_outlined),
              selectedIcon:
                  Icon(Icons.headset_mic, color: orange),
              label: 'ارتباط',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHome() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        // Industrial hero banner
        Container(
          height: 190,
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ink.withOpacity(.12),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: -25,
                top: -35,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(.07),
                      width: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 18,
                child: Icon(
                  Icons.inventory_2_rounded,
                  size: 105,
                  color: orange.withOpacity(.9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'MAHNASHAN PACK',
                        style: TextStyle(
                          color: white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'بسته‌بندی حرفه‌ای،\nامضای کسب‌وکار شما',
                      style: TextStyle(
                        color: white,
                        fontSize: 21,
                        height: 1.6,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'جعبه و سینی مخصوص رستوران و بیرون‌بر',
                      style: TextStyle(
                        color: Color(0xFFBFC7CC),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Brand facts
        Row(
          children: [
            Expanded(
              child: infoTile(
                Icons.inventory_2_outlined,
                '۲۲ مدل',
                'محصول متنوع',
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: infoTile(
                Icons.storefront_outlined,
                'فروش عمده',
                'ثبت سفارش',
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: infoTile(
                Icons.support_agent,
                'پشتیبانی',
                'ارتباط مستقیم',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        const SectionTitle(
          title: 'دسته‌بندی محصولات',
          subtitle: 'انتخاب گروه موردنظر',
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            categoryBox(
              'جعبه‌ها',
              Icons.inventory_2_rounded,
              const Color(0xFF35434D),
            ),
            const SizedBox(width: 9),
            categoryBox(
              'سینی‌ها',
              Icons.dashboard_rounded,
              const Color(0xFF59666F),
            ),
            const SizedBox(width: 9),
            categoryBox(
              'آبمیوه و بستنی',
              Icons.local_cafe_rounded,
              orange,
            ),
          ],
        ),
        const SizedBox(height: 25),

        const SectionTitle(
          title: 'کاتالوگ محصولات',
          subtitle: 'محصول موردنظر را انتخاب کنید',
        ),
        const SizedBox(height: 12),

        TextField(
          controller: searchController,
          onChanged: (v) => setState(() => search = v),
          decoration: InputDecoration(
            hintText: 'جست‌وجوی نام محصول...',
            prefixIcon: const Icon(Icons.search, color: muted),
            filled: true,
            fillColor: white,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(color: line),
            ),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((c) {
              final selected = category == c;
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ChoiceChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (_) => setState(() => category = c),
                  backgroundColor: white,
                  selectedColor: ink,
                  side: BorderSide(
                    color: selected ? ink : line,
                  ),
                  labelStyle: TextStyle(
                    color: selected ? white : ink,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  showCheckmark: false,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${filteredProducts.length} محصول',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: ink,
              ),
            ),
            const Text(
              'قیمت‌ها به تومان',
              style: TextStyle(color: muted, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (filteredProducts.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('محصولی پیدا نشد')),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              childAspectRatio: .69,
            ),
            itemBuilder: (context, index) =>
                productCard(filteredProducts[index]),
          ),
      ],
    );
  }

  Widget infoTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: line),
      ),
      child: Column(
        children: [
          Icon(icon, color: orange, size: 22),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 11,
              color: ink,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(color: muted, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget categoryBox(String title, IconData icon, Color color) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => category = title),
        borderRadius: BorderRadius.circular(13),
        child: Container(
          height: 92,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: white, size: 29),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard(Product p) {
    final price = prices[p.id] ?? 0;
    final qty = quantities[p.id] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PackageVisual(product: p),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.code,
                  style: const TextStyle(
                    color: orange,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  p.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price == 0
                      ? 'تماس برای استعلام قیمت'
                      : '${money(price)} تومان',
                  style: const TextStyle(
                    color: muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 9),
                if (qty == 0)
                  SizedBox(
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () => changeQuantity(p.id, 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ink,
                        foregroundColor: white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 15),
                          SizedBox(width: 4),
                          Text(
                            'افزودن به سفارش',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      qtyButton(Icons.remove, () => changeQuantity(p.id, -1)),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          color: ink,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      qtyButton(Icons.add, () => changeQuantity(p.id, 1)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyButton(IconData icon, VoidCallback action) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 29,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xFFFFEEE3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: orange, size: 18),
      ),
    );
  }

  Widget buildCart() {
    final selected = products
        .where((p) => (quantities[p.id] ?? 0) > 0)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(
          title: 'سبد سفارش',
          subtitle: 'محصولات انتخاب‌شده شما',
        ),
        const SizedBox(height: 16),
        if (selected.isEmpty)
          Container(
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 60,
                  color: muted,
                ),
                SizedBox(height: 12),
                Text(
                  'هنوز محصولی انتخاب نکرده‌اید',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'از بخش محصولات، کالاهای موردنظر را اضافه کنید.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          )
        else ...[
          ...selected.map((p) {
            final qty = quantities[p.id] ?? 0;
            final price = prices[p.id] ?? 0;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: line),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: ink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(p.icon, color: orange),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            color: ink,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          price == 0
                              ? 'استعلام قیمت'
                              : '${money(price * qty)} تومان',
                          style: const TextStyle(
                            color: muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  qtyButton(Icons.remove, () => changeQuantity(p.id, -1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      '$qty',
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  qtyButton(Icons.add, () => changeQuantity(p.id, 1)),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: ink,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'مبلغ کل سفارش',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  '${money(total)} تومان',
                  style: const TextStyle(
                    color: white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: copyOrder,
                    icon: const Icon(Icons.copy),
                    label: const Text('کپی متن سفارش'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: white,
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
    buffer.writeln('----------------------');

    for (final p in products) {
      final qty = quantities[p.id] ?? 0;
      if (qty > 0) {
        final price = prices[p.id] ?? 0;
        buffer.writeln(
          '${p.name} : $qty عدد | ${money(price * qty)} تومان',
        );
      }
    }

    buffer.writeln('----------------------');
    buffer.writeln('مبلغ کل: ${money(total)} تومان');
    buffer.writeln('شماره تماس: 09388462634');

    await Clipboard.setData(ClipboardData(text: buffer.toString()));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('متن سفارش کپی شد.')),
    );
  }

  Widget buildContact() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            children: [
              Icon(Icons.support_agent, color: orange, size: 65),
              SizedBox(height: 14),
              Text(
                'ارتباط با ماهنشان پک',
                style: TextStyle(
                  color: white,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'برای ثبت سفارش، استعلام قیمت و دریافت اطلاعات محصولات با ما در ارتباط باشید.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.8,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: line),
          ),
          child: const Column(
            children: [
              Icon(Icons.phone_in_talk, color: orange, size: 32),
              SizedBox(height: 10),
              Text(
                'شماره تماس',
                style: TextStyle(color: muted),
              ),
              SizedBox(height: 6),
              SelectableText(
                '09388462634',
                style: TextStyle(
                  color: ink,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> openAdmin() async {
    final controller = TextEditingController();

    final pin = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('لغو'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(dialogContext, controller.text),
            child: const Text('ورود'),
          ),
        ],
      ),
    );

    controller.dispose();

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
          onSave: (id, price) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setDouble('price_$id', price);
            if (mounted) {
              setState(() => prices[id] = price);
            }
          },
        ),
      ),
    );

    if (mounted) loadPrices();
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 38,
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: ink,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(
                color: muted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Individual graphic illustration for product categories
class PackageVisual extends StatelessWidget {
  final Product product;

  const PackageVisual({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isBox = product.category == 'جعبه‌ها';
    final isCup = product.category == 'آبمیوه و بستنی';

    final background = isBox
        ? const Color(0xFFE8ECEE)
        : isCup
            ? const Color(0xFFFFE9DC)
            : const Color(0xFFE5E9EB);

    return Container(
      color: background,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Text(
              product.code,
              style: const TextStyle(
                color: Color(0xFF89939A),
                fontSize: 8,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          Center(
            child: CustomPaint(
              size: const Size(125, 105),
              painter: PackagePainter(
                id: product.id,
                isBox: isBox,
                isCup: isCup,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 9,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: ink,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'MAHNASHAN',
                style: TextStyle(
                  color: white,
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PackagePainter extends CustomPainter {
  final int id;
  final bool isBox;
  final bool isCup;

  PackagePainter({
    required this.id,
    required this.isBox,
    required this.isCup,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final body = Paint()..color = const Color(0xFFC18C5C);
    final top = Paint()..color = const Color(0xFFE0B783);
    final dark = Paint()..color = const Color(0xFF91623D);
    final stroke = Paint()
      ..color = const Color(0xFF795333)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final shadow = Paint()..color = const Color(0x26000000);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w / 2, h * .83),
        width: w * .75,
        height: h * .13,
      ),
      shadow,
    );

    if (isBox) {
      final front = Path()
        ..moveTo(w * .20, h * .38)
        ..lineTo(w * .80, h * .38)
        ..lineTo(w * .75, h * .78)
        ..lineTo(w * .25, h * .78)
        ..close();

      final lid = Path()
        ..moveTo(w * .20, h * .38)
        ..lineTo(w * .50, h * .19)
        ..lineTo(w * .80, h * .38)
        ..lineTo(w * .50, h * .55)
        ..close();

      canvas.drawPath(front, body);
      canvas.drawPath(lid, top);
      canvas.drawPath(lid, stroke);

      final side = Path()
        ..moveTo(w * .50, h * .55)
        ..lineTo(w * .80, h * .38)
        ..lineTo(w * .75, h * .78)
        ..lineTo(w * .50, h * .87)
        ..close();

      canvas.drawPath(side, dark);
      canvas.drawPath(front, stroke);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(w * .48, h * .62),
            width: w * .24,
            height: h * .12,
          ),
          const Radius.circular(4),
        ),
        Paint()..color = orange,
      );
    } else if (isCup) {
      for (int i = 0; i < (id == 17 || id == 19 ? 4 : 2); i++) {
        final count = id == 17 || id == 19 ? 4 : 2;
        final x = count == 2
            ? w * (.38 + i * .24)
            : w * (.28 + (i % 2) * .38);
        final y = count == 2
            ? h * .50
            : h * (.40 + (i ~/ 2) * .27);

        canvas.drawCircle(
          Offset(x, y),
          w * .12,
          dark,
        );
        canvas.drawCircle(
          Offset(x, y),
          w * .09,
          top,
        );
        canvas.drawCircle(
          Offset(x, y),
          w * .06,
          Paint()..color = orange,
        );
      }

      final base = Path()
        ..moveTo(w * .16, h * .29)
        ..lineTo(w * .84, h * .29)
        ..lineTo(w * .78, h * .78)
        ..lineTo(w * .22, h * .78)
        ..close();

      canvas.drawPath(base, body);
      canvas.drawPath(base, stroke);
    } else {
      final tray = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * .12, h * .27, w * .76, h * .48),
        const Radius.circular(12),
      );

      canvas.drawRRect(tray, dark);

      final inner = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * .17, h * .32, w * .66, h * .38),
        const Radius.circular(9),
      );

      canvas.drawRRect(inner, top);
      canvas.drawRRect(inner, stroke);

      final divisions = id == 12 || id == 13 || id == 11;
      if (divisions) {
        canvas.drawLine(
          Offset(w * .50, h * .34),
          Offset(w * .50, h * .68),
          stroke,
        );
        canvas.drawLine(
          Offset(w * .18, h * .51),
          Offset(w * .82, h * .51),
          stroke,
        );
      }

      for (int i = 0; i < 3; i++) {
        canvas.drawCircle(
          Offset(w * (.32 + i * .18), h * .50),
          w * .055,
          Paint()
            ..color = [
              const Color(0xFFB94B2E),
              const Color(0xFF6D8B43),
              const Color(0xFFE3A33C),
            ][(i + id) % 3],
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PackagePainter oldDelegate) {
    return oldDelegate.id != id;
  }
}

class AdminPage extends StatefulWidget {
  final Future<void> Function(int, double) onSave;

  const AdminPage({super.key, required this.onSave});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late final Map<int, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = {
      for (final p in products)
        p.id: TextEditingController(),
    };
    loadCurrentPrices();
  }

  Future<void> loadCurrentPrices() async {
    final prefs = await SharedPreferences.getInstance();
    for (final p in products) {
      controllers[p.id]!.text =
          (prefs.getDouble('price_${p.id}') ?? 0).toStringAsFixed(0);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: paper,
        appBar: AppBar(
          backgroundColor: ink,
          foregroundColor: white,
          title: const Text('مدیریت قیمت محصولات'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${p.code}  |  ${p.name}',
                    style: const TextStyle(
                      color: ink,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controllers[p.id],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'قیمت به تومان',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.payments_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ink,
                        foregroundColor: white,
                      ),
                      onPressed: () async {
                        final value = double.tryParse(
                          controllers[p.id]!.text.trim(),
                        );

                        if (value == null || value < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('قیمت معتبر وارد کنید.'),
                            ),
                          );
                          return;
                        }

                        await widget.onSave(p.id, value);

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
            );
          },
        ),
      ),
    );
  }
}
