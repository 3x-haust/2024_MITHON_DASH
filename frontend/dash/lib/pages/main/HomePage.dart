import 'package:dash/api/User.dart';
import 'package:dash/pages/main/MainPage.dart';
import 'package:dash/pages/main/MarketPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _currentDistance = 9;
  final double _maxDistance = 10.0;
  final List<bool> _buttonPressed = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    //_fetchHealthData();
  }

  Future<void> _fetchHealthData() async {
    if (await Permission.activityRecognition.request().isGranted) {
      final healthData = Health();
      final types = [
        HealthDataType.DISTANCE_WALKING_RUNNING,
      ];

      final hasPermissions = await healthData.hasPermissions(types);
      if (hasPermissions != null && hasPermissions) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final healthDataList = await healthData.getHealthDataFromTypes(
          types: types,
          startTime: today,
          endTime: now,
        );

        double totalDistance = 0;
        for (final data in healthDataList) {
          totalDistance += data.value as double;
        }

        setState(() {
          _currentDistance = (totalDistance / 1000).clamp(0.0, _maxDistance);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEEF1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDistanceIndicator(),
                const SizedBox(height: 24),
                _buildCharacterImage(),
                const SizedBox(height: 24),
                _buildDailyQuestTitle(),
                const SizedBox(height: 24),
                _buildQuestList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistanceIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_currentDistance.toStringAsFixed(1)} km',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10.0,
                activeTrackColor: const Color(0xFF0053FF),
                inactiveTrackColor: const Color(0xFFEDEEF1),
                thumbColor: const Color(0xFF0053FF),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
              ),
              child: Slider(
                value: _currentDistance,
                max: _maxDistance,
                onChanged: (double value) {},
              ),
            ),
          ),
          Text(
            '${_maxDistance.toStringAsFixed(0)} km',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterImage() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const MarketPage());
      },
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

  Widget _buildDailyQuestTitle() {
    return Text(
      '일일 퀘스트',
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildQuestList() {
    return Column(
      children: List.generate(4, (index) => _buildQuestItem(index)),
    );
  }

  Widget _buildQuestItem(int index) {
    final questDistances = [0.1, 3.0, 7.0, 10.0];
    bool isCompleted = _currentDistance >= questDistances[index];
    final Color buttonColor = _buttonPressed[index]
        ? const Color.fromRGBO(53, 114, 239, 0.2)
        : (isCompleted ? const Color(0xFF0053FF) : const Color(0xFFD9D9D9));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${questDistances[index].toStringAsFixed(1)} km',
            style: const TextStyle(
              color: Color(0xFF0053FF),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          ElevatedButton(
            onPressed: isCompleted && !_buttonPressed[index]
                ? () {
                    UserApi().updateUser(
                        FirebaseAuth.instance.currentUser!.uid,
                        index == 0 ? 100 : index == 1 ? 200 : index == 2 ? 500 : 1000);
                    setState(() {
                      _buttonPressed[index] = true;
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ), 
              disabledBackgroundColor: isCompleted ? const Color.fromRGBO(53, 114, 239, 0.2) : const Color(0xffD9D9D9),
            ),
            child: RichText(
              text: TextSpan(
                text: index == 0
                    ? '100 O'
                    : index == 1
                        ? '200 O'
                        : index == 2
                            ? '500 O'
                            : '1000 O',
                style: TextStyle(
                  color: _buttonPressed[index]
                      ? const Color.fromRGBO(0, 84, 255, 1)
                      : !isCompleted ? const Color(0xff717C8C) : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, 3),
                      child: Text(
                        '2',
                        textScaleFactor: 0.8,
                        style: TextStyle(
                          color: _buttonPressed[index]
                              ? const Color.fromRGBO(0, 84, 255, 1)
                              : !isCompleted ? const Color(0xff717C8C) : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}