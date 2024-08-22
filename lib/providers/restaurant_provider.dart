//defines providers to manage restaurant data and search function
//includes providers for fetching restaurants data, search query, and filtering the data

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart';

final restaurantProvider = FutureProvider<List<Restaurant>>((ref) async {
  final data = await rootBundle.loadString('assets/restaurants.json');
  final List<dynamic> jsonResult = json.decode(data);
  return jsonResult.map((json) => Restaurant.fromJson(json)).toList();
});

final searchProvider = StateProvider<String>((ref) => '');

final filteredRestaurantsProvider = Provider<List<Restaurant>>((ref) {
  final searchQuery = ref.watch(searchProvider);
  final restaurants = ref.watch(restaurantProvider).asData?.value ?? [];

  if (searchQuery.isEmpty) return restaurants;

  return restaurants
      .where((restaurant) =>
          restaurant.name.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();
});
