import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color bg = Color(0xFF090909);
const Color panel = Color(0xFF171513);
const Color gold = Color(0xFFD6AD55);
const Color paleGold = Color(0xFFFFE3A0);

void main() => runApp(const MahnashanApp());

class MahnashanApp extends StatelessWidget {
  const MahnashanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماهنشان پک',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
          primary: gold,
          surface: panel,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: paleGold,
          centerTitle: true,
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String category;
  final IconData icon;
  final String code;

  const Product(this.id, this.name, this.category, this.icon, this.code);
}

const List<Product> products = [
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

String toman(int value) {
  final s = value.toString();
  final out = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    out.write(s[i]);
    final left = s.length - i - 1;
    if (left > 0 && left % 3 == 0) out.write(',');
  }
  return '${out.toString()} تومان';
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _WelcomeFallback(),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
              ),
            ),
          ),
          Positioned(
            left: 28,
            right: 28,
            bottom: 70,
            child: Column(
              children: [
                const Text(
                  'ماهنشان پک',
                  style: TextStyle(
                    color: paleGold,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: gold, blurRadius: 18)],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'بسته‌بندی شیک، انتخابی ماندگار',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 28),
                GoldButton(
                  text: 'ورود به فروشگاه',
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const StorePage()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeFallback extends StatelessWidget {
  const _WelcomeFallback();

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.25),
            radius: 1.1,
            colors: [Color(0xFF4A3518), bg, Colors.black],
          ),
        ),
        child: const Center(
          child: Icon(Icons.inventory_2_outlined, size: 130, color: gold),
        ),
      );
}

class GoldButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [paleGold, gold, Color(0xFF8A6428)],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x665E4216),
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF211707),
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
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
  final TextEditingController searchController = TextEditingController();
  final Map<int, int> quantities = {};
  final Map<int, int> prices = {};

  final List<String> categories = [
    'همه',
    'جعبه‌ها',
    'سینی‌ها',
    'آبمیوه و بستنی'
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
    if (!mounted) return;
    setState(() {
      for (final p in products) {
        prices[p.id] = prefs.getInt('price_${p.id}') ?? 0;
      }
    });
  }

  int priceOf(Product p) => prices[p.id] ?? 0;
  int get itemCount => quantities.values.fold(0, (a, b) => a + b);
  int get total => quantities.entries.fold(
      0, (sum, e) => sum + e.value * (prices[e.key] ?? 0));

  void changeQuantity(Product p, int delta) {
    setState(() {
      final next = (quantities[p.id] ?? 0) + delta;
      if (next <= 0) {
        quantities.remove(p.id);
      } else {
        quantities[p.id] = next;
      }
    });
  }

  List<Product> get filteredProducts => products.where((p) {
        final matchCategory =
            category == 'همه' || p.category == category;
        final matchSearch = p.name.contains(search) ||
            p.code.toLowerCase().contains(search.toLowerCase());
        return matchCategory && matchSearch;
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ماهنشان پک',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: paleGold)),
          actions: [
            IconButton(
              tooltip: 'سبد خرید',
              onPressed: () => setState(() => tab = 1),
              icon: Stack(clipBehavior: Clip.none, children: [
                const Icon(Icons.shopping_bag_outlined, color: gold),
                if (itemCount > 0)
                  Positioned(
                    top: -7,
                    left: -8,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: gold,
                      child: Text('$itemCount',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10)),
                    ),
                  ),
              ]),
            ),
          ],
        ),

        // پس‌زمینه مشترک صفحات فروشگاه، سبد خرید و تماس
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'background.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: bg),
            ),
            Container(
              color: Colors.black.withOpacity(0.72),
            ),
            IndexedStack(
              index: tab,
              children: [
                buildHome(),
                buildCart(),
                buildContact(),
              ],
            ),
          ],
        ),

        bottomNavigationBar: NavigationBar(
          backgroundColor: panel,
          indicatorColor: const Color(0x553D2D12),
          selectedIndex: tab,
          onDestinationSelected: (v) => setState(() => tab = v),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront, color: gold),
                label: 'فروشگاه'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart, color: gold),
                label: 'سبد خرید'),
            NavigationDestination(
                icon: Icon(Icons.phone_outlined),
                selectedIcon: Icon(Icons.phone, color: gold),
                label: 'تماس'),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: gold,
          foregroundColor: Colors.black,
          onPressed: openAdmin,
          tooltip: 'مدیریت قیمت‌ها',
          child: const Icon(Icons.admin_panel_settings),
        ),
      ),
    );
  }

  Widget buildHome() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(14, 8, 14, 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold.withOpacity(.65)),
            gradient: const LinearGradient(
                colors: [Color(0xFF302416), Color(0xFF12100D)]),
          ),
          child: const Row(
            children: [
              Icon(Icons.workspace_premium,
                  color: paleGold, size: 38),
              SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('بسته‌بندی حرفه‌ای',
                      style: TextStyle(
                          color: paleGold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text('محصولات ماه‌نشان پک را ببینید',
                      style: TextStyle(color: Colors.white70)),
                ],
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            controller: searchController,
            onChanged: (v) => setState(() => search = v.trim()),
            decoration: InputDecoration(
              hintText: 'جست‌وجوی محصول یا کد کالا',
              prefixIcon: const Icon(Icons.search, color: gold),
              filled: true,
              fillColor: panel,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: gold.withOpacity(.35))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: gold.withOpacity(.35))),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 43,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: categories
                .map((c) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(c),
                        selected: category == c,
                        onSelected: (_) =>
                            setState(() => category = c),
                        selectedColor: gold,
                        backgroundColor: panel,
                        labelStyle: TextStyle(
                            color: category == c
                                ? Colors.black
                                : paleGold,
                            fontWeight: FontWeight.w600),
                        side: BorderSide(
                            color: gold.withOpacity(.5)),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: filteredProducts.isEmpty
              ? const Center(child: Text('محصولی پیدا نشد'))
              : GridView.builder(
                  padding:
                      const EdgeInsets.fromLTRB(12, 5, 12, 16),
                  itemCount: filteredProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .76,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, i) =>
                      productCard(filteredProducts[i]),
                ),
        ),
      ],
    );
  }

  Widget productCard(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: gold.withOpacity(.55)),
        boxShadow: const [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: p.id == 9
                  ? Image.asset(
                      'assets/images/tray_single.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => productIcon(p))
                  : productIcon(p),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(p.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 4),
          Text(p.code,
              style: const TextStyle(color: gold, fontSize: 11)),
          Text(
              priceOf(p) == 0
                  ? 'برای قیمت تماس بگیرید'
                  : toman(priceOf(p)),
              style: const TextStyle(
                  color: paleGold, fontSize: 12)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
            child: Row(
              children: [
                _qtyButton(
                    Icons.remove, () => changeQuantity(p, -1)),
                Expanded(
                    child: Center(
                        child: Text('${quantities[p.id] ?? 0}',
                            style: const TextStyle(
                                color: Colors.white)))),
                _qtyButton(
                    Icons.add, () => changeQuantity(p, 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productIcon(Product p) => Container(
        width: double.infinity,
        color: const Color(0xFF211C14),
        child: Icon(p.icon, size: 66, color: gold),
      );

  Widget _qtyButton(IconData icon, VoidCallback action) =>
      InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: gold.withOpacity(.7)),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 18, color: paleGold),
        ),
      );
    Widget buildCart() {
    final selected = products
        .where((p) => (quantities[p.id] ?? 0) > 0)
        .toList();
    return Column(
      children: [
        Expanded(
          child: selected.isEmpty
              ? const Center(
                  child: Text('سبد خرید شما خالی است',
                      style: TextStyle(color: paleGold)))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: selected.length,
                  itemBuilder: (_, i) {
                    final p = selected[i];
                    return Card(
                      color: panel,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: gold.withOpacity(.45)),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: ListTile(
                        leading:
                            Icon(p.icon, color: gold, size: 30),
                        title: Text(p.name,
                            style: const TextStyle(
                                color: Colors.white)),
                        subtitle: Text(
                            '${quantities[p.id]} عدد • ${priceOf(p) == 0 ? 'قیمت نامشخص' : toman(priceOf(p) * quantities[p.id]!)}',
                            style: const TextStyle(
                                color: paleGold)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: gold),
                          onPressed: () => setState(
                              () => quantities.remove(p.id)),
                        ),
                      ),
                    );
                  },
                ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: panel,
              border: Border(top: BorderSide(color: gold))),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('جمع کل',
                        style: TextStyle(
                            color: paleGold, fontSize: 16)),
                    Text(toman(total),
                        style: const TextStyle(
                            color: paleGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ]),
              const SizedBox(height: 12),
              GoldButton(
                  text: 'کپی متن سفارش', onPressed: copyOrder),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> copyOrder() async {
    final selected = products
        .where((p) => (quantities[p.id] ?? 0) > 0)
        .toList();

    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('سبد خرید خالی است')));
      return;
    }

    final lines = selected
        .map((p) =>
            '${p.name} (${p.code}) - ${quantities[p.id]} عدد - ${priceOf(p) == 0 ? 'استعلام قیمت' : toman(priceOf(p) * quantities[p.id]!)}')
        .join('\n');

    final text =
        'سفارش از ماهنشان پک\n$lines\nجمع کل: ${toman(total)}\nشماره تماس: 09388462634';

    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('متن سفارش کپی شد')));
  }

  Widget buildContact() => Center(
        child: Container(
          margin: const EdgeInsets.all(22),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: gold)),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.support_agent, color: gold, size: 64),
              SizedBox(height: 14),
              Text('ارتباط با ماهنشان پک',
                  style: TextStyle(
                      color: paleGold,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('09388462634',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22)),
              SizedBox(height: 8),
              Text(
                  'برای ثبت سفارش و دریافت قیمت تماس بگیرید',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );

  Future<void> openAdmin() async {
    final pinController = TextEditingController();

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: panel,
          title: const Text('ورود مدیریت',
              style: TextStyle(color: paleGold)),
          content: TextField(
            controller: pinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(hintText: 'رمز عبور'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('انصراف')),
            TextButton(
                onPressed: () => Navigator.pop(
                    ctx, pinController.text == '1234'),
                child: const Text('ورود')),
          ],
        ),
      ),
    );

    pinController.dispose();

    if (ok == true && mounted) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AdminPage(
              initialPrices: Map<int, int>.from(prices),
              onSave: (newPrices) =>
                  setState(() => prices.addAll(newPrices)),
            ),
          ));
    }
  }
}

class AdminPage extends StatefulWidget {
  final Map<int, int> initialPrices;
  final ValueChanged<Map<int, int>> onSave;

  const AdminPage({
    super.key,
    required this.initialPrices,
    required this.onSave,
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
      for (final p in products)
        p.id: TextEditingController(
          text: (widget.initialPrices[p.id] ?? 0) == 0
              ? ''
              : '${widget.initialPrices[p.id]}',
        ),
    };
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final values = <int, int>{};

    for (final p in products) {
      final value = int.tryParse(
              controllers[p.id]!.text.replaceAll(',', '').trim()) ??
          0;

      values[p.id] = value;
      await prefs.setInt('price_${p.id}', value);
    }

    widget.onSave(values);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('قیمت‌ها ذخیره شدند')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('مدیریت قیمت محصولات')),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text(
                'قیمت هر محصول را به تومان وارد کنید؛ برای استعلام قیمت، کادر را خالی بگذارید.',
                style: TextStyle(color: paleGold),
              ),
              const SizedBox(height: 12),
              ...products.map((p) => Card(
                    color: panel,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(p.name,
                                  style: const TextStyle(
                                      color: Colors.white))),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 125,
                            child: TextField(
                              controller: controllers[p.id],
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: 'تومان',
                                  isDense: true),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              GoldButton(
                  text: 'ذخیره همه قیمت‌ها', onPressed: save),
              const SizedBox(height: 25),
            ],
          ),
        ),
      );
}
