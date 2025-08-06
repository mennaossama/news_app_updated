import 'package:go_router/go_router.dart';
import 'package:news_app_updated/core/routing/app_routes.dart';
import 'package:news_app_updated/features/article_details_screen/article_details_screen.dart';
import 'package:news_app_updated/features/home_screen/home_screen.dart';
import 'package:news_app_updated/features/home_screen/models/article_model.dart';
import 'package:news_app_updated/features/search_result_screen/search_result_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.homeScreen, routes: [
    GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen()),
    GoRoute(
        path: AppRoutes.searchResultScreen,
        name: AppRoutes.searchResultScreen,
        builder: (context, state) {
          final query = state.extra as String;
          return SearchResultScreen(
            query: query,
          );
        }),
    GoRoute(
        path: AppRoutes.articleDetailsScreen,
        name: AppRoutes.articleDetailsScreen,
        builder: (context, state) {
          final article = state.extra as Article;
          return ArticleDetailsScreen(article: article);
        }),
  ]);
}
