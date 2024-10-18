import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RankPage extends StatelessWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEEF1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildRankingCard('일간 거리 랭킹', [
              RankingItem('Jun', '50', 'km', 1),
              RankingItem('마맘맘', '10', 'km', 2),
              RankingItem('물음표', '9', 'km', 3),
            ], RankingItem('나', '9', 'km', 3)),
            const SizedBox(height: 16),
            _buildRankingCard('주간 산소 랭킹', [
              RankingItem('물음표', '10502', 'O₂', 1),
              RankingItem('마맘맘', '8800', 'O₂', 2),
              RankingItem('미림짱', '8083', 'O₂', 3),
            ], RankingItem('나', '10502', 'O₂', 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingCard(String title, List<RankingItem> topItems, RankingItem userItem) {
    return Card(
      color: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF020202),
              ),
            ),
            const SizedBox(height: 16),
            ...topItems.map((item) => _buildRankingRow(item)).toList(),
            const Divider(color: Color(0xFF8F98A8), thickness: 1),
            _buildRankingRow(userItem),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingRow(RankingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: item.rank != 0 
              ? SvgPicture.asset('assets/icons/${item.rank}.svg')
              : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF555E70),
              ),
            ),
          ),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101012),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            item.unit,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101012),
            ),
          ),
        ],
      ),
    );
  }
}

class RankingItem {
  final String name;
  final String value;
  final String unit;
  final int rank;

  RankingItem(this.name, this.value, this.unit, this.rank);
}