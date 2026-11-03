
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MahnashanApp());
}

const Color gold = Color(0xFFD4AF37);
const Color dark = Color(0xFF111111);
const Color cardColor = Color(0xFF202020);

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

// صفحه شروع
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Widget productPicture(String url, IconData fallback) {
    return Container(
      height: 155,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gold, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(fallback, color: gold, size: 55);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.workspace_premium,
                color: gold,
                size: 75,
              ),
              const SizedBox(height: 12),
              const Text(
                'ماهنشان پک',
                style: TextStyle(
                  color: gold,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'بسته‌بندی خاص، کیفیت ماندگار',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: productPicture(
                      'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=600',
                      Icons.inventory_2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: productPicture(
                      'https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=600',
                      Icons.lunch_dining,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: productPicture(
                      'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=600',
                      Icons.restaurant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'کاتالوگ محصولات و بسته‌بندی‌های غذایی',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'ورود به اپلیکیشن',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
}

// صفحه اصلی
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
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> savePrice(int index, int price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('price_$index', price);

    if (mounted) {
      setState(() {
        products[index].price = price;
      });
    }
  }

  int get total => products.fold(
        0,
        (sum, p) => sum + p.price * p.quantity,
      );

  int get itemCount => products.fold(
        0,
        (sum, p) => sum + p.quantity,
      );

  List<Product> get visibleProducts {
    if (selectedCategory == 'همه') return products;

    return products
        .where((p) => p.category == selectedCategory)
        .toList();
  }

  List<Product> get selectedProducts {
    return products.where((p) => p.quantity > 0).toList();
  }

  String money(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  void changeQuantity(Product product, int amount) {
    setState(() {
      product.quantity += amount;
      if (product.quantity < 0) {
        product.quantity = 0;
      }
    });
  }

  // پنجره ورود تعداد دلخواه
  void enterQuantity(Product product) {
    final controller = TextEditingController(
      text: product.quantity == 0
          ? ''
          : product.quantity.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(
          product.name,
          style: const TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
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
                setState(() {
                  product.quantity = value;
                });
                Navigator.pop(dialogContext);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('لطفاً تعداد معتبر وارد کنید'),
                  ),
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
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        title: const Text(
          'ورود مدیریت',
          style: TextStyle(color: gold),
        ),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'رمز عبور',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
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
        const SnackBar(
          content: Text('رمز عبور اشتباه است'),
        ),
      );
    }
  }

  Future<void> copyOrder() async {
    final selected = selectedProducts;

    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('سبد خرید شما خالی است'),
        ),
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

    await Clipboard.setData(
      ClipboardData(text: text.toString()),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'متن سفارش کپی شد؛ آن را در واتساپ ارسال کنید.',
          ),
        ),
      );
    }
  }

  Widget quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: gold,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 18,
        ),
      ),
    );
  }

  // کارت محصول
  Widget productCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: gold.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: gold.withValues(alpha: 0.08),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Icon(
                product.icon,
                color: gold,
                size: 58,
              ),
            ),
          ),
          Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.price == 0
                ? 'قیمت: تماس بگیرید'
                : '${money(product.price)} تومان',
            style: const TextStyle(
              color: gold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              quantityButton(
                Icons.remove,
                () => changeQuantity(product, -1),
              ),
              InkWell(
                onTap: () => enterQuantity(product),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 45),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  child: Text(
                    '${product.quantity}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      color: gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              quantityButton(
                Icons.add,
                () => enterQuantity(product),
              ),
            ],
          ),
          const SizedBox(height: 3),
          const Text(
            'برای وارد کردن تعداد بزنید',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  // صفحه خانه و کاتالوگ
  Widget homeContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF3B3015),
                Color(0xFF17130A),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold, width: 1.3),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.workspace_premium,
                color: gold,
                size: 42,
              ),
              SizedBox(height: 8),
              Text(
                'بسته‌بندی خاص، کیفیت ماندگار',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: gold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'کاتالوگ محصولات ماهنشان پک',
                style: TextStyle(color: Colors.white70),
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
                  labelStyle: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: visibleProducts.length,
            itemBuilder: (context, index) {
              return productCard(visibleProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  // صفحه سبد خرید
  Widget cartContent() {
    final selected = selectedProducts;

    if (selected.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: gold,
              size: 75,
            ),
            SizedBox(height: 15),
            Text(
              'سبد خرید شما خالی است',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'از قسمت خانه محصولات را انتخاب کنید',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'سبد خرید شما',
            style: TextStyle(
              color: gold,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: selected.length,
            itemBuilder: (context, index) {
              final product = selected[index];

              return Card(
                color: cardColor,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.inventory_2,
                    color: gold,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    '${product.quantity} عدد × ${money(product.price)} تومان',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${money(product.price * product.quantity)} تومان',
                        style: const TextStyle(
                          color: gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => enterQuantity(product),
                        child: const Text(
                          'ویرایش تعداد',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: gold),
            ),
          ),
          child: Column(
            children: [
              Text(
                'تعداد کل: $itemCount عدد',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 5),
              Text(
                'مبلغ کل: ${money(total)} تومان',
                style: const TextStyle(
                  color: gold,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: copyOrder,
                  icon: const Icon(Icons.copy),
                  label: const Text('کپی سفارش برای واتساپ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // صفحه ارتباط با ما
  Widget contactContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gold),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.support_agent,
                color: gold,
                size: 80,
              ),
              const SizedBox(height: 18),
              const Text(
                'ارتباط با ماهنشان پک',
                style: TextStyle(
                  color: gold,
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
                  fontSize: 15,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                phoneNumber,
                style: TextStyle(
                  color: gold,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: phoneNumber),
                    );

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('شماره تماس کپی شد'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('کپی شماره تماس'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(14),
                  ),
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
        backgroundColor: Colors.black,
        title: const Text(
          'ماهنشان پک',
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: openAdmin,
            icon: const Icon(
              Icons.admin_panel_settings,
              color: gold,
            ),
            tooltip: 'مدیریت',
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
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(color: gold, width: 1),
          ),
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (index) {
              setState(() {
                currentTab = index;
              });
            },
            backgroundColor: Colors.black,
            selectedItemColor: gold,
            unselectedItemColor: Colors.white60,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
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
      (match) => '${match[1]},',
    );
  }

  void editPrice(int index) {
    final controller = TextEditingController(
      text: widget.products[index].price.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(
          widget.products[index].name,
          style: const TextStyle(color: gold),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            labelText: 'قیمت به تومان',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
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
          style: TextStyle(color: gold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];

          return Card(
            color: cardColor,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.inventory_2,
                color: gold,
              ),
              title: Text(product.name),
              subtitle: Text(
                product.price == 0
                    ? 'قیمت ثبت نشده'
                    : '${money(product.price)} تومان',
                style: const TextStyle(color: gold),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: gold,
                ),
                onPressed: () => editPrice(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
