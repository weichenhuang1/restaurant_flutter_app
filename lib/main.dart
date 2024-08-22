import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/restaurant_provider.dart';
import 'models/restaurant.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

//root widget, sets up theme and home screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant List',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RestaurantListScreen(),
    );
  }
}

//displays the list of restaurants and the search bar
class RestaurantListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(filteredRestaurantsProvider);
    final searchQuery = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Restaurant List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Restaurants',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                isDense: true,
              ),
              onChanged: (value) {
                ref.read(searchProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: restaurants.isEmpty
                ? Center(child: Text('No restaurants found'))
                : ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(Icons.restaurant, color: Colors.deepOrangeAccent),
                          title: Text(
                            restaurants[index].name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            restaurants[index].cuisine,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepOrangeAccent),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
