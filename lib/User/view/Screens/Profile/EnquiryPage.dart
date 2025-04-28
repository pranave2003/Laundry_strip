import 'package:flutter/material.dart';

class EnquiryPage extends StatelessWidget {
  const EnquiryPage({super.key});

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 16, color: Colors.black)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estimate Weight Chart"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("📦 Individual Item Weights (Approx.)"),
            _bullet("👕 Shirt – 0.3 kg"),
            _bullet("👖 Jeans – 0.7 kg"),
            _bullet("🧥 Jacket – 1.2 kg"),
            _bullet("👚 T-Shirt – 0.2 kg"),
            _bullet("👗 Saree – 0.5 kg"),
            _bullet("🧣 Shawl/Dupatta – 0.3 kg"),
            _bullet("🩳 Pajama/Leggings – 0.25 kg"),
            _bullet("🛏 Bedsheet – 0.8 kg"),
            _bullet("🧼 Towel – 0.4 kg"),
            _bullet("🪟 Curtain – 0.7 kg"),
            _bullet("🛏 Blanket/Quilt – 1.8 kg"),
            _bullet("🎒 Backpack – 1.2 kg"),
            _bullet("👜 Handbag – 0.8 kg"),
            _bullet("👟 Shoes (Pair) – 0.9 kg"),
            const Divider(),

            _sectionTitle("👕 Men"),
            _bullet("3 Jeans + 4 Shirts ≈ 5.1 kg ✅"),
            _bullet("2 Jackets + 2 T-Shirts + 1 Pants ≈ 5.6 kg ✅"),
            _bullet("4 T-Shirts + 2 Pants + 1 Towel ≈ 5.0 kg ✅"),
            _bullet("3 Kurtas + 3 Pajamas ≈ 5.2 kg ✅"),
            _bullet("5 T-Shirts + 1 Jeans ≈ 3.5 kg ❌"),

            _sectionTitle("👗 Women"),
            _bullet("5 Sarees + 1 Shawl ≈ 5.2 kg ✅"),
            _bullet("4 Tops + 3 Leggings + 1 Dress ≈ 5.0 kg ✅"),
            _bullet("2 Sarees + 2 Leggings + 1 Dupatta + 1 Top ≈ 5.3 kg ✅"),
            _bullet("6 Leggings + 3 Tops ≈ 5.0 kg ✅"),
            _bullet("1 Gown + 2 Sarees + 1 Shawl ≈ 5.5 kg ✅"),

            _sectionTitle("🧒 Kids"),
            _bullet("5 School Uniforms ≈ 5.0 kg ✅"),
            _bullet("3 Frocks + 3 Shorts + 2 T-Shirts ≈ 4.8 kg ❌"),
            _bullet("6 Pajamas + 4 Shirts ≈ 5.2 kg ✅"),

            _sectionTitle("🏠 Household Items"),
            _bullet("2 Bedsheets + 2 Towels ≈ 5.4 kg ✅"),
            _bullet("1 Bedsheet + 2 Towels + 2 Curtains ≈ 5.8 kg ✅"),
            _bullet("2 Bedsheets + 1 Blanket ≈ 6.5 kg ✅"),
            _bullet("1 Quilt + 2 Pillow Covers ≈ 5.7 kg ✅"),

            _sectionTitle("👞 Shoes & Bags (by piece)"),
            _bullet("1 Pair Sneakers ≈ 0.9 kg"),
            _bullet("1 Backpack ≈ 1.2 kg"),
            _bullet("1 Handbag ≈ 0.8 kg"),
            _bullet("1 Pair Boots ≈ 1.5 kg"),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "*Note: Shoe and Bag services are calculated per item. No minimum kg requirement.*",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "💡 Minimum clothes weight required for booking: 5 kg",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
