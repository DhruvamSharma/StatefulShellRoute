import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_demo/ui/my_home_page.dart';
import 'package:navigation_demo/ui/pages.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouteInformation<T> {
  final T? data;
  final bool maintainState;

  AppRouteInformation({
    this.data,
    this.maintainState = true,
  });
}

class AppRouter {
  // create a singleton
  static final AppRouter instance = AppRouter._internal();

  // create a private constructor
  AppRouter._internal();

  // create a GoRouter instance
  GoRouter? _router;

  GoRouter get router {
    if (_router == null) {
      _initRouter();
      return _router!;
    }
    return _router!;
  }

  void go<T>(String path, {T? data}) {
    _router?.go(
      path,
      extra: AppRouteInformation<T>(
        data: data,
      ),
    );
  }

  Future<T?>? push<T>(String path, {T? data}) {
    return _router?.push<T>(
      path,
      extra: AppRouteInformation<T>(
        data: data,
      ),
    );
  }

  void _initRouter() {
    _router = GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      navigatorKey: navigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => MyHomePage(
            navigationShell: navigationShell,
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const DemoPage(
                    title: 'Home',
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/search',
                  builder: (context, state) => const DemoPage(title: 'Search'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const DemoPage(title: 'Profile'),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => DemoPage(
            title: 'Login',
            child: ElevatedButton(
              onPressed: () {
                AppRouter.instance.go('/');
                // isLoggedIn.value = true;
              },
              child: const Text('Login'),
            ),
          ),
        ),
      ],
    );
  }

  Page buildPage(Widget child) {
    return MaterialPage(
      child: child,
    );
  }
}
