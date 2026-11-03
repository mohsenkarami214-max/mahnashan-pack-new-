import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color ink = Color(0xFF171411);
const Color gold = Color(0xFFD6AD62);
const Color cream = Color(0xFFF7F1E6);
const String adminPin = '1234';

void main() {
  runApp(const MahnashanApp());
}

class Product {
  String name;
  String category;
  String description;
  int price;

  Product({
    required this.name,
    required this.category,
    this.description = 'بسته‌بندی باکیفیت ماهنشان پک',
    this.price = 0,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'description': description,
        'price': price,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] ?? '',
        category: json['category'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? 0,
      );
}

class MahnashanApp extends StatelessWidget {
  const MahnashanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماهنشان پک',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(seedColor: gold),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  final Map<String, int> cart = {};
  int selectedTab = 0;
  String selectedCategory = 'همه محصولات';
  bool loading = true;

  final List<String> categories = [
    'همه محصولات',
    'جعبه‌ها',
    'سینی‌ها',
    'آبمیوه و بستنی',
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  List<Product> defaultProducts() {
    return [
      Product(name: 'جعبه تک پرس با سرویس', category: 'جعبه‌ها'),
      Product(name: 'جعبه ارکیده', category: 'جعبه‌ها'),
      Product(name: 'جعبه گلتاج', category: 'جعبه‌ها'),
      Product(name: 'جعبه خوشه', category: 'جعبه‌ها'),
      Product(name: 'جعبه زرین', category: 'جعبه‌ها'),
      Product(name: 'جعبه زیبا', category: 'جعبه‌ها'),
      Product(name: 'جعبه شیرین', category: 'جعبه‌ها'),
      Product(name: 'جعبه ۱۲ پرسی', category: 'جعبه‌ها'),
      Product(name: 'جعبه ساندویچ', category: 'جعبه‌ها'),
      Product(name: 'سینی تک پرسی', category: 'سینی‌ها'),
      Product(name: 'سینی تک پرس با سرویس', category: 'سینی‌ها'),
      Product(name: 'سینی دو پرس با سرویس', category: 'سینی‌ها'),
      Product(name: 'سینی سه پرس ارتفاع ۵', category: 'سینی‌ها'),
      Product(name: 'سینی سه پرس ارتفاع ۴', category: 'سینی‌ها'),
      Product(name: 'سینی شیرین', category: 'سینی‌ها'),
      Product(name: 'سینی نیم پرسی', category: 'سینی‌ها'),
      Product(name: 'جا لیوانی دو عددی', category: 'آبمیوه و بستنی'),
      Product(name: 'جا لیوانی ۴ عددی', category: 'آبمیوه و بستنی'),
      Product(name: 'سینی بستنی ۲ عددی', category: 'آبمیوه و بستنی'),
      Product(name: 'سینی بستنی ۴ عددی', category: 'آبمیوه و بستنی'),
      Product(name: 'سینی هرمی', category: 'آبمیوه و بستنی'),
      Product(name: 'جا لیوانی دسته‌دار', category: 'آبمیوه و بستنی'),
    ];
  }

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('mahnashan_products');

    if (saved == null) {
      products = defaultProducts();
      await saveProducts();
    } else {
      products = saved.map((item) {
        final decoded = Uri.decodeComponent(item);
        return Product.fromJson(
          Map<String, dynamic>.from(
            Uri.splitQueryString(decoded),
          ),
        );
      }).toList();
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final list = products.map((p) {
      final data = p.toJson();
      return Uri.encodeComponent(
        data.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&'),
      );
    }).toList();
    await prefs.setStringList('mahnashan_products', list);
  }

  List<Product> get visibleProducts {
    if (selectedCategory == 'همه محصولات') return products;
    return products.where((p) => p.category == selectedCategory).toList();
  }

  int get cartCount => cart.values.fold(0, (a, b) => a + b);

  int get cartTotal {
    int total = 0;
    for (final entry in cart.entries) {
      final product = products.firstWhere(
        (p) => p.name == entry.key,
        orElse: () => Product(name: '', category: ''),
      );
      total += product.price * entry.value;
    }
    return total;
  }

  String money(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }

  void addToCart(Product product) {
    setState(() {
      cart[product.name] = (cart[product.name] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} به سبد خرید اضافه شد'),
        duration: const Duration(seconds: 1),
        backgroundColor: ink,
      ),
    );
  }

  void showProduct(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 5,
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 22),
            productArtwork(product.category, height: 150),
            const SizedBox(height: 18),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 15),
            Text(
              product.price == 0
                  ? 'جهت استعلام قیمت تماس بگیرید'
                  : '${money(product.price)} تومان',
              style: const TextStyle(
                color: Color(0xFF98702F),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  addToCart(product);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('افزودن به سبد خرید'),
                style: goldButton(),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  ButtonStyle goldButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: gold,
      foregroundColor: ink,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget productArtwork(String category, {double height = 115}) {
    IconData icon = Icons.inventory_2_outlined;
    if (category == 'سینی‌ها') icon = Icons.restaurant_outlined;
    if (category == 'آبمیوه و بستنی') icon = Icons.local_cafe_outlined;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF34302A), Color(0xFF171411)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: gold.withOpacity(.65), width: 1.2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 8,
            right: 12,
            child: Icon(Icons.auto_awesome, color: gold.withOpacity(.5)),
          ),
          Icon(icon, color: gold, size: height * .48),
          Positioned(
            bottom: 8,
            left: 12,
            child: Icon(Icons.auto_awesome, color: gold.withOpacity(.5)),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      decoration: const BoxDecoration(
        color: ink,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.inventory_2, color: gold, size: 34),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ماهنشان پک',
                      style: TextStyle(
                        color: gold,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'چاپ و بسته‌بندی',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: showAdminLogin,
                icon: const Icon(Icons.admin_panel_settings_outlined, color: gold),
                tooltip: 'مدیریت',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              border: Border.all(color: gold.withOpacity(.6)),
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [gold.withOpacity(.18), Colors.transparent],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بسته‌بندی شیک، ماندگار و حرفه‌ای',
                  style: TextStyle(
                    color: gold,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'محصولات متنوع برای رستوران‌ها و فست‌فودها',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget catalogPage() {
    return Column(
      children: [
        header(),
        const SizedBox(height: 15),
        SizedBox(
          height: 45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: categories.map((category) {
              final selected = selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                  selectedColor: gold,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? ink : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(color: gold.withOpacity(.7)),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(14, 5, 14, 18),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: .73,
            ),
            itemCount: visibleProducts.length,
            itemBuilder: (context, index) {
              final product = visibleProducts[index];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => showProduct(product),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: gold.withOpacity(.55)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(child: productArtwork(product.category)),
                      const SizedBox(height: 9),
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: ink,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.price == 0
                            ? 'استعلام قیمت'
                            : '${money(product.price)} تومان',
                        style: const TextStyle(
                          color: Color(0xFF98702F),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => addToCart(product),
                          style: goldButton(),
                          child: const Text('افزودن به سبد'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget cartPage() {
    if (cart.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 75, color: gold),
            SizedBox(height: 15),
            Text(
              'سبد خرید شما خالی است',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('محصولات موردنظر خود را انتخاب کنید'),
          ],
        ),
      );
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            'سبد خرید شما',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: cart.entries.map((entry) {
              final product = products.firstWhere(
                (p) => p.name == entry.key,
              );
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: ListTile(
                  title: Text(
                    product.name,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    product.price == 0
                        ? 'قیمت: استعلام'
                        : 'قیمت واحد: ${money(product.price)} تومان',
                    textAlign: TextAlign.right,
                  ),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (entry.value <= 1) {
                              cart.remove(entry.key);
                            } else {
                              cart[entry.key] = entry.value - 1;
                            }
                          });
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('${entry.value}'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cart[entry.key] = entry.value + 1;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: gold)),
          ),
          child: Column(
            children: [
              Text(
                'مجموع قیمت محصولات: ${money(cartTotal)} تومان',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: sendOrderText,
                  icon: const Icon(Icons.copy),
                  label: const Text('کپی متن سفارش'),
                  style: goldButton(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> sendOrderText() async {
    final buffer = StringBuffer();
    buffer.writeln('سلام، برای محصولات ماهنشان پک سفارش دارم:');
    buffer.writeln('');
    for (final entry in cart.entries) {
      buffer.writeln('${entry.key} - تعداد: ${entry.value}');
    }
    buffer.writeln('');
    buffer.writeln('مجموع قیمت ثبت‌شده: ${money(cartTotal)} تومان');
    buffer.writeln('لطفاً برای تأیید سفارش راهنمایی بفرمایید.');

    await Clipboard.setData(ClipboardData(text: buffer.toString()));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('متن سفارش کپی شد؛ آن را در واتساپ ارسال کنید.'),
        backgroundColor: ink,
      ),
    );
  }

  Widget aboutPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: gold),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inventory_2, color: gold, size: 65),
              SizedBox(height: 18),
              Text(
                'ماهنشان پک',
                style: TextStyle(
                  color: gold,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'چاپ و بسته‌بندی',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'ارائه انواع جعبه و سینی بسته‌بندی برای رستوران، فست‌فود، آبمیوه و بستنی',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, height: 1.8),
              ),
              SizedBox(height: 18),
              Text(
                'تماس و سفارش: 09388462634',
                style: TextStyle(color: gold, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAdminLogin() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('ورود مدیریت', textAlign: TextAlign.right),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'رمز مدیریت',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text == adminPin) {
                Navigator.pop(dialogContext);
                showAdminPanel();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('رمز ورود اشتباه است')),
                );
              }
            },
            child: const Text('ورود'),
          ),
        ],
      ),
    );
  }

  void showAdminPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .82,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'پنل مدیریت محصولات',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          product.price == 0
                              ? 'قیمت ثبت نشده'
                              : '${money(product.price)} تومان',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF98702F)),
                          onPressed: () => editPrice(product),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await saveProducts();
                      if (mounted) setState(() {});
                      Navigator.pop(context);
                    },
                    style: goldButton(),
                    child: const Text('ذخیره تغییرات'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editPrice(Product product) {
    final controller = TextEditingController(
      text: product.price == 0 ? '' : product.price.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('قیمت ${product.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'قیمت به تومان',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () async {
              product.price = int.tryParse(controller.text) ?? 0;
              await saveProducts();
              if (mounted) setState(() {});
              Navigator.pop(context);
            },
            child: const Text('ذخیره'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: gold)),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: selectedTab,
            children: [
              catalogPage(),
              cartPage(),
              aboutPage(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: ink,
          indicatorColor: gold.withOpacity(.25),
          selectedIndex: selectedTab,
          onDestinationSelected: (index) {
            setState(() => selectedTab = index);
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.storefront_outlined, color: Colors.white70),
              selectedIcon: Icon(Icons.storefront, color: gold),
              label: 'محصولات',
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white70),
              selectedIcon: const Icon(Icons.shopping_bag, color: gold),
              label: cartCount == 0 ? 'سبد خرید' : 'سبد ($cartCount)',
            ),
            const NavigationDestination(
              icon: Icon(Icons.info_outline, color: Colors.white70),
              selectedIcon: Icon(Icons.info, color: gold),
              label: 'درباره ما',
            ),
          ],
        ),
      ),
    );
  }
}