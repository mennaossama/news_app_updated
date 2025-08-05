import 'package:go_router/go_router.dart';
import 'package:news_app_updated/core/routing/app_routes.dart';
import 'package:news_app_updated/features/home_screen/home_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.homeScreen, routes: [
    GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen()),
  ]);
}
