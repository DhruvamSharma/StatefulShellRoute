import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_demo/ui/bottom_navigation_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _switchBranch,
      ),
      body: Stack(
        children: [
          widget.navigationShell,
          Positioned(
            top: 120,
            right: 10,
            child: IconButton(
              alignment: Alignment.center,
              onPressed: () {
                context.go('/login');
              },
              icon: const Icon(Icons.account_circle_rounded),
            ),
          ),
        ],
      ),
    );
  }

  void _switchBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
