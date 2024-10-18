import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("랭크 페이지"),
    );
  }
}