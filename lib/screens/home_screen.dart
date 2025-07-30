// screens/home_screen.dart
import 'package:flutter/material.dart';
// import 'widgets/responsive_navigation.dart';
import '../utils/responsive_breakpoints.dart';
import '../../widgets/component/receipecard.dart';
import '../data/receipe_data.dart';
import '../utils/route_generator.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            SizedBox(height: 32),
            _buildFeaturedRecipes(context),
            SizedBox(height: 32),
            _buildQuickCategories(context),
            SizedBox(height: 32),
            _buildRecentlyViewed(context),
          ],
        ),
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Recipe Book'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => _showSearch(context),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () => _navigateToShoppingList(context),
        ),
      ],
    );
  }
  
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: ResponsiveBreakpoints.isMobile(context) ? 200 : 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange[400]!, Colors.deepOrange[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Recipe Book',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Discover amazing recipes for every occasion',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _exploreRecipes(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange[600],
              ),
              child: Text('Explore Recipes'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeaturedRecipes(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Featured Recipes',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(

            onPressed: () => _viewAllRecipes(context),
            child: Text('View All'),
          ),
        ],
      ),
      SizedBox(height: 16),

      // ✅ Replace Expanded with SizedBox of fixed height
      SizedBox(
        height: 400, // Adjust height as needed
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: sampleRecipes.length,
          itemBuilder: (context, index) {
            final recipe = sampleRecipes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RecipeCard(
                recipe: recipe,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
      RouteGenerator.recipedetails,
      arguments: recipe.id, // pass your ID here
    );

          },
              ),
            );
          },
        ),
      ),
    ],
  );
  }

      
    
  
  Widget _buildQuickCategories(BuildContext context) {
  final categories = [
    {'label': 'Breakfast', 'route': RouteGenerator.recipes},
    {'label': 'Lunch', 'route': RouteGenerator.recipes},
    {'label': 'Dinner', 'route': RouteGenerator.recipes},
    {'label': 'Snacks', 'route': RouteGenerator.recipes},
    {'label': 'Dessert', 'route': RouteGenerator.recipes},
  ];

  return Container(
    // color: Colors.grey.shade200,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(category['route']!);
                },
                style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFD2B48C),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // ✅ No const here
                ),
              ),

                child: Text(
                  category['label']!,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


 Widget _buildRecentlyViewed(BuildContext context) {
  return Container(
    height: 100,
    color: Colors.grey.shade300,
    child: Center(child: Text('Recently Viewed Placeholder')),
  );
}

  // Helper methods
  void _showSearch(BuildContext context) {
    // Implement search functionality
  }
  
  void _navigateToShoppingList(BuildContext context) {
    // Navigate to shopping list
     Navigator.of(context, rootNavigator: true).pushNamed(
      RouteGenerator.cart,
    );
  }
  
  void _exploreRecipes(BuildContext context) {
    // Navigate to recipe list
     Navigator.of(context, rootNavigator: true).pushNamed(
      RouteGenerator.recipes,
    );
  }
  
  void _viewAllRecipes(BuildContext context) {
    // Navigate to all recipes
    Navigator.of(context, rootNavigator: true).pushNamed(
      RouteGenerator.recipes,
      // arguments: recipe.id, // pass your ID here
    );
    
   

  }
}
