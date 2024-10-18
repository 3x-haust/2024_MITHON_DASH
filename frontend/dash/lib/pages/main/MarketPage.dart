import 'package:dash/pages/setting/SettingPage.dart';
import 'package:dash/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final List<String> _categories = ['신발', '상의', '하의', '장신구'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          onNotificationPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingPage()),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xffEDEEF1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCharacterImage(),
                const SizedBox(height: 26),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      int index = _categories.indexOf(category);
                      return _buildCategoryItem(category, index);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 11),
                _buildProductRow(0),
                const SizedBox(height: 11),
                _buildProductRow(1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterImage() {
    return GestureDetector(
      child: Container(
        height: 307,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
        ),
        child: const Center(
          child: Image(image: AssetImage('assets/icons/character.png')),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: ShapeDecoration(
            color: _selectedIndex == index ? const Color(0xFF0053FF) : const Color(0x333572EF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : const Color(0xFF0053FF),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProductItem(index == 0 ? 92 : 94),
        const SizedBox(width: 11), 
        _buildProductItem(index == 0 ? 93 : 91),
      ],
    );
  }

  Widget _buildProductItem(int num) {
    return Container(
      width: 149,
      height: 140,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
      ),
      child: Center(
        child: Image(image: AssetImage('assets/characters/$num.png'),)
      ),
    );
  }
}