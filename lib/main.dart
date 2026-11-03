
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MahnashanApp());
}

const Color gold = Color(0xFFD4AF37);
const Color lightGold = Color(0xFFFFE9A3);
const Color darkGold = Color(0xFF80621B);
const Color dark = Color(0xFF090909);
const Color cardColor = Color(0xFF191919);
const Color panelColor = Color(0xFF242018);
const String phoneNumber = '09388462634';

class Product {
  final String name;
  final String category;
  final IconData icon;
  int price;
  int quantity;

  Product(
    this.name,
    this.category,
    this.icon, {
    this.price = 0,
    this.quantity = 0,
  });
}

class MahnashanApp extends StatelessWidget {
  const MahnashanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ماهنشان پک',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: dark,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: dark,
          foregroundColor: gold,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: dark,
          labelStyle: const TextStyle(color: lightGold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: gold.withValues(alpha: 0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: gold, width: 1.5),
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}

// ابزارهای طراحی مشکی و طلایی
class Luxury {
  static BoxDecoration panel({
    double radius = 20,
    bool highlighted = false,
  }) {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF29251B),
          Color(0xFF171717),
          Color(0xFF101010),
        ],
      ),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: gold.withValues(alpha: highlighted ? 0.95 : 0.55),
        width: highlighted ? 1.7 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: gold.withValues(alpha: highlighted ? 0.13 : 0.06),
          blurRadius: 14,
          spreadRadius: 1,
        ),
        const BoxShadow(
          color: Colors.black,
          blurRadius: 8,
          offset: Offset(3, 4),
        ),
      ],
    );
  }

  static Widget goldButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    double height = 52,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [lightGold, gold, darkGold],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: gold.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, color: Colors.black),
          label: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  static Widget sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: gold, size: 23),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            color: lightGold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// صفحه شروع
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF282113),
              Color(0xFF11100D),
              Color(0xFF050505),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(23),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [lightGold, gold, darkGold],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: gold.withValues(alpha: 0.25),
                        blurRadius: 28,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.all_inbox_rounded,
                    color: Colors.black,
                    size: 65,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'ماهنشان پک',
                  style: TextStyle(
                    color: lightGold,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: gold, blurRadius: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'چاپ و بسته‌بندی',
                  style: TextStyle(
                    color: gold,
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'بسته‌بندی خاص، کیفیت ماندگار',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 35),

                // تصویر نمادین بسته‌بندی بیرون‌بر
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: Luxury.panel(highlighted: true),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.takeout_dining_rounded,
                        size: 95,
                        color: gold,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'بسته‌بندی حرفه‌ای رستورانی',
                        style: TextStyle(
                          color: lightGold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'جعبه‌ها و سینی‌های بیرون‌بر',
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Luxury.goldButton(
                  text: 'ورود به اپلیکیشن',
                  icon: Icons.arrow_forward_rounded,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
                  height: 58,
                ),
                const SizedBox(height: 22),
                const Text(
                  'MAHNASHAN PACK',
                  style: TextStyle(
                    color: gold,
                    letterSpacing: 4,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// صفحه اصلی برنامه
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = [
    Product('جعبه تک پرس با سرویس', 'جعبه‌ها', Icons.inventory_2),
    Product('جعبه ارکیده', 'جعبه‌ها', Icons.all_inbox),
    Product('جعبه گلتاج', 'جعبه‌ها', Icons.inventory),
    Product('جعبه خوشه', 'جعبه‌ها', Icons.widgets),
    Product('جعبه زرین', 'جعبه‌ها', Icons.card_giftcard),
    Product('جعبه زیبا', 'جعبه‌ها', Icons.redeem),
    Product('جعبه شیرین', 'جعبه‌ها', Icons.cake),
    Product('جعبه ۱۲ پرسی', 'جعبه‌ها', Icons.grid_view),
    Product('جعبه ساندویچ', 'جعبه‌ها', Icons.lunch_dining),
    Product('سینی تک پرسی', 'سینی‌ها', Icons.restaurant),
    Product('سینی تک پرس با سرویس', 'سینی‌ها', Icons.dining),
    Product('سینی دو پرس با سرویس', 'سینی‌ها', Icons.restaurant_menu),
    Product('سینی سه پرس ارتفاع ۵', 'سینی‌ها', Icons.table_restaurant),
    Product('سینی سه پرس ارتفاع ۴', 'سینی‌ها', Icons.table_bar),
    Product('سینی شیرین', 'سینی‌ها', Icons.breakfast_dining),
    Product('سینی نیم پرسی', 'سینی‌ها', Icons.ramen_dining),
    Product('جا لیوانی دو عددی', 'آبمیوه و بستنی', Icons.local_cafe),
    Product('جا لیوانی ۴ عددی', 'آبمیوه و بستنی', Icons.local_drink),
    Product('سینی بستنی ۲ عددی', 'آبمیوه و بستنی', Icons.icecream),
    Product('سینی بستنی ۴ عددی', 'آبمیوه و بستنی', Icons.icecream_outlined),
    Product('سینی هرمی', 'آبمیوه و بستنی', Icons.takeout_dining),
    Product('جا لیوانی دسته‌دار', 'آبمیوه و بستنی', Icons.coffee),
  ];

  final List<String> categories = [
    'همه',
    'جعبه‌ها',
    'سینی‌ها',
    'آبمیوه و بستنی',
  ];

  String selectedCategory = 'همه';
  bool loading = true;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    loadPrices();
  }

  Future<void> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < products.length; i++) {
      products[i].price = prefs.getInt('price_$i') ?? 0;
    }
    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> savePrice(int index, int price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('price_$index', price);
    if (mounted) {
      setState(() => products[index].price = price);
    }
  }

  int get total =>
      products.fold(0, (sum, p) => sum + p.price * p.quantity);

  int get itemCount =>
      products.fold(0, (sum, p) => sum + p.quantity);

  List<Product> get visibleProducts {
    if (selectedCategory == 'همه') return products;
    return products.where((p) => p.category == selectedCategory).toList();
  }

  List<Product> get selectedProducts =>
      products.where((p) => p.quantity > 0).toList();

  String money(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  void changeQuantity(Product product, int amount) {
    setState(() {
      product.quantity += amount;
      if (product.quantity < 0) product.quantity = 0;
    });
  }

  void enterQuantity(Product product) {
    final controller = TextEditingController(
      text: product.quantity == 0 ? '' : product.quantity.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: gold),
        ),
        title: Text(
          product.name,
          style: const TextStyle(color: lightGold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'تعداد موردنظر',
            hintText: 'مثلاً 2000',
            suffixText: 'عدد',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value >= 0) {
                setState(() => product.quantity = value);
                Navigator.pop(dialogContext);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تعداد معتبر وارد کنید')),
                );
              }
            },
            child: const Text('ثبت تعداد'),
          ),
        ],
      ),
    );
  }

  Future<void> openAdmin() async {
    final controller = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: gold),
        ),
        title: const Text(
          'ورود مدیریت',
          style: TextStyle(color: lightGold),
        ),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'رمز عبور'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: Colors.black,
            ),
            onPressed: () => Navigator.pop(dialogContext, controller.text),
            child: const Text('ورود'),
          ),
        ],
      ),
    );

    if (password == '1234' && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AdminPage(
            products: products,
            onSave: savePrice,
          ),
        ),
      );
    } else if (password != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رمز عبور اشتباه است')),
      );
    }
  }

  Future<void> copyOrder() async {
    final selected = selectedProducts;
    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('سبد خرید شما خالی است')),
      );
      return;
    }

    final text = StringBuffer();
    text.writeln('سلام، سفارش من از ماهنشان پک:');
    text.writeln();

    for (final p in selected) {
      text.writeln(
        '${p.name} - تعداد: ${p.quantity} - قیمت: ${money(p.price * p.quantity)} تومان',
      );
    }

    text.writeln();
    text.writeln('مبلغ کل: ${money(total)} تومان');
    text.writeln('شماره تماس: $phoneNumber');

    await Clipboard.setData(ClipboardData(text: text.toString()));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('متن سفارش کپی شد؛ آن را در واتساپ ارسال کنید.'),
        ),
      );
    }
  }

  Widget quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [lightGold, gold, darkGold],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 17),
      ),
    );
  }

  Widget productCard(Product product) {
    return InkWell(
      onTap: () => enterQuantity(product),
      borderRadius: BorderRadius.circular(19),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: Luxury.panel(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF100F0C),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: gold.withValues(alpha: 0.3),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      product.icon,
                      color: gold.withValues(alpha: 0.14),
                      size: 100,
                    ),
                    Icon(product.icon, color: lightGold, size: 55),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              product.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.price == 0
                  ? 'قیمت: تماس بگیرید'
                  : '${money(product.price)} تومان',
              style: const TextStyle(
                color: lightGold,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quantityButton(
                  Icons.remove,
                  () => changeQuantity(product, -1),
                ),
                const SizedBox(width: 10),
                Container(
                  constraints: const BoxConstraints(minWidth: 35),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '${product.quantity}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: lightGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                quantityButton(Icons.add, () => enterQuantity(product)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget homeContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          padding: const EdgeInsets.all(18),
          decoration: Luxury.panel(highlighted: true),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ماهنشان پک',
                      style: TextStyle(
                        color: lightGold,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'بسته‌بندی خاص، کیفیت ماندگار',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'کاتالوگ محصولات',
                      style: TextStyle(
                        color: gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3D321A), Color(0xFF111111)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: gold.withValues(alpha: 0.5)),
                ),
                child: const Icon(
                  Icons.takeout_dining,
                  color: gold,
                  size: 65,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: categories.map((category) {
              final selected = selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  selectedColor: gold,
                  backgroundColor: cardColor,
                  side: BorderSide(
                    color: selected ? lightGold : gold.withValues(alpha: 0.4),
                  ),
                  labelStyle: TextStyle(
                    color: selected ? Colors.black : lightGold,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 7),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: visibleProducts.length,
            itemBuilder: (context, index) =>
                productCard(visibleProducts[index]),
          ),
        ),
      ],
    );
  }

  Widget cartContent() {
    final selected = selectedProducts;

    if (selected.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(28),
          decoration: Luxury.panel(highlighted: true),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag_outlined, color: gold, size: 75),
              SizedBox(height: 18),
              Text(
                'سبد خرید شما خالی است',
                style: TextStyle(
                  color: lightGold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 9),
              Text(
                'از قسمت خانه محصولات را انتخاب کنید',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Luxury.sectionTitle('سبد خرید شما', Icons.shopping_bag),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: selected.length,
            itemBuilder: (context, index) {
              final product = selected[index];

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                padding: const EdgeInsets.all(12),
                decoration: Luxury.panel(),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: dark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: gold.withValues(alpha: 0.5)),
                      ),
                      child: Icon(product.icon, color: gold, size: 29),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              color: lightGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${product.quantity} عدد',
                            style: const TextStyle(color: Colors.white60),
                          ),
                          Text(
                            '${money(product.price * product.quantity)} تومان',
                            style: const TextStyle(
                              color: gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => enterQuantity(product),
                      icon: const Icon(Icons.edit, color: gold),
                      tooltip: 'ویرایش تعداد',
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => product.quantity = 0);
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      tooltip: 'حذف',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(17, 15, 17, 18),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border(
              top: BorderSide(color: gold.withValues(alpha: 0.7)),
            ),
          ),
          child: Column(
            children: [
              Text(
                'تعداد کل: $itemCount عدد',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 7),
              Text(
                'مبلغ کل: ${money(total)} تومان',
                style: const TextStyle(
                  color: lightGold,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              Luxury.goldButton(
                text: 'کپی متن سفارش برای واتساپ',
                icon: Icons.copy,
                onTap: copyOrder,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget contactContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: Luxury.panel(highlighted: true),
          child: Column(
            children: [
              Container(
                width: 105,
                height: 105,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [lightGold, gold, darkGold],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withValues(alpha: 0.2),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.support_agent,
                  color: Colors.black,
                  size: 65,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ارتباط با ماهنشان پک',
                style: TextStyle(
                  color: lightGold,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'برای اطلاع از قیمت‌ها، ثبت سفارش و دریافت راهنمایی با ما تماس بگیرید.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.9,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: dark,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: gold.withValues(alpha: 0.5)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.phone, color: gold, size: 30),
                    const SizedBox(height: 8),
                    const Text(
                      phoneNumber,
                      style: TextStyle(
                        color: lightGold,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Luxury.goldButton(
                text: 'کپی شماره تماس',
                icon: Icons.copy,
                onTap: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: phoneNumber),
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('شماره تماس کپی شد')),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'MAHNASHAN PACK',
                style: TextStyle(
                  color: gold,
                  letterSpacing: 3,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: gold),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ماهنشان پک',
          style: TextStyle(
            color: lightGold,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            onPressed: openAdmin,
            icon: const Icon(Icons.admin_panel_settings, color: gold),
            tooltip: 'پنل مدیریت',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentTab,
        children: [
          homeContent(),
          cartContent(),
          contactContent(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF101010),
          border: Border(
            top: BorderSide(color: gold.withValues(alpha: 0.7), width: 1.2),
          ),
          boxShadow: [
            BoxShadow(
              color: gold.withValues(alpha: 0.08),
              blurRadius: 12,
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (index) => setState(() => currentTab = index),
            backgroundColor: const Color(0xFF101010),
            selectedItemColor: lightGold,
            unselectedItemColor: Colors.white54,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_bag_rounded),
                    if (itemCount > 0)
                      Positioned(
                        right: -9,
                        top: -7,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$itemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'سبد خرید',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.headset_mic_rounded),
                label: 'ارتباط با ما',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// پنل مدیریت قیمت‌ها
class AdminPage extends StatefulWidget {
  final List<Product> products;
  final Future<void> Function(int, int) onSave;

  const AdminPage({
    super.key,
    required this.products,
    required this.onSave,
  });

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String money(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  void editPrice(int index) {
    final controller = TextEditingController(
      text: widget.products[index].price.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: gold),
        ),
        title: Text(
          widget.products[index].name,
          style: const TextStyle(color: lightGold),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(labelText: 'قیمت به تومان'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              foregroundColor: Colors.black,
            ),
            onPressed: () async {
              final price = int.tryParse(controller.text);
              if (price != null && price >= 0) {
                await widget.onSave(index, price);
                if (mounted) {
                  setState(() {});
                  Navigator.pop(dialogContext);
                }
              }
            },
            child: const Text('ذخیره قیمت'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'پنل مدیریت ماهنشان پک',
          style: TextStyle(color: lightGold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: Luxury.panel(highlighted: true),
            child: Luxury.sectionTitle(
              'ویرایش قیمت محصولات',
              Icons.price_change,
            ),
          ),
          ...List.generate(widget.products.length, (index) {
            final product = widget.products[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 9),
              decoration: Luxury.panel(),
              child: ListTile(
                leading: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: gold.withValues(alpha: 0.5)),
                  ),
                  child: Icon(product.icon, color: gold),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  product.price == 0
                      ? 'قیمت ثبت نشده'
                      : '${money(product.price)} تومان',
                  style: const TextStyle(color: lightGold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: gold),
                  onPressed: () => editPrice(index),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
