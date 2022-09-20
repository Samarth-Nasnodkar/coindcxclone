import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatefulWidget {
  final String coinName;
  const PriceChart({Key? key, required this.coinName}) : super(key: key);

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart> {
  Stream<List<dynamic>> getPrices() {
    return FirebaseFirestore.instance
        .collection('coins')
        .doc(widget.coinName)
        .snapshots()
        .map((event) => event.data()!['prices']);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: getPrices(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          final prices = snapshot.data!
              .map((e) => {
                    'ts': e['ts'],
                    'price': e['price'],
                  })
              .toList();
          double maxPrice = prices[0]['price'];
          double minPrice = prices[0]['price'];
          for (var p in prices) {
            if (p['price'] > maxPrice) maxPrice = p['price'];
            if (p['price'] < minPrice) minPrice = p['price'];
          }
          final minTime = (prices.first['ts'] as Timestamp).seconds.toDouble();
          final maxTime = (prices.last['ts'] as Timestamp).seconds.toDouble();
          final __spots = prices
              .map((e) =>
                  FlSpot((e['ts'] as Timestamp).seconds.toDouble(), e['price']))
              .toList();
          return SizedBox(
            height: 500,
            width: 300,
            child: LineChart(
              LineChartData(
                minY: minPrice,
                maxY: maxPrice,
                minX: minTime,
                maxX: maxTime,
                gridData: FlGridData(
                  show: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: __spots,
                    isCurved: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
