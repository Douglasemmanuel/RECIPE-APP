
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_list_screen.dart';
import '../screens/favourites_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/recipe_details_screen.dart';
import '../models/recipe.dart';
import '../../widgets/common/responsive_navigation.dart';
import '../screens/cart_screen.dart';

class RouteGenerator {
   static const String initial = '/';
  static const String home = '/home';
  static const String recipes = '/recipes';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String recipedetails = '/recipe-details';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => ResponsiveNavigation());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case recipes:
        return MaterialPageRoute(builder: (_) => RecipeListScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => FavoritesScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case recipedetails:
        final recipeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RecipeDetailsScreen(recipeId: recipeId),
        );
      default:
        return _errorRoute();
    }
  }

  // This method is outside the generateRoute method — at class level!
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}







