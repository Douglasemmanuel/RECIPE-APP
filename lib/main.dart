import 'package:flutter/material.dart';
import '../widgets/common/responsive_navigation.dart';
import '../../utils/route_generator.dart';
import '../../utils/favourites.dart'; // correct import
import '../data/receipe_data.dart';
import '../../utils/cart.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
 final allRecipes = sampleRecipes; // Your real loader
  await FavoritesManager.instance.load(allRecipes);
  await CartManager.instance.loadCartItems(allRecipes);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: RouteGenerator.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
      
    );
  }
}



