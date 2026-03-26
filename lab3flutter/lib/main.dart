import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

Future<void> main() async {
  print("=== Exercise 1 ===");
  await exercise1();

  await Future.delayed(Duration(milliseconds: 100));

  print("\n=== Exercise 2 ===");
  await exercise2();

  print("\n=== Exercise 3 ===");
  exercise3();

  await Future.delayed(Duration(milliseconds: 100));

  print("\n=== Exercise 4 ===");
  await exercise4();

  print("\n=== Exercise 5 ===");
  exercise5();
}

/// Exercise 1 – Product Model & Repository

class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => "$name - \$${price}";
}

class ProductRepository {
  final List<Product> _products = [
    Product(1, "Phone", 500),
    Product(2, "Laptop", 1200),
  ];

  final _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }

  Stream<Product> liveAdded() => _controller.stream;

  void add(Product p) {
    _products.add(p);
    _controller.add(p);
  }
}

Future<void> exercise1() async {
  final repo = ProductRepository();

  final products = await repo.getAll();
  print(products);

  repo.liveAdded().listen((p) => print("New product: $p"));

  repo.add(Product(3, "Tablet", 700));
}

/// Exercise 2 – JSON

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() => "$name ($email)";
}

Future<void> exercise2() async {
  String jsonString = '''
  [
    {"name":"John","email":"john@mail.com"},
    {"name":"Anna","email":"anna@mail.com"}
  ]
  ''';

  await Future.delayed(Duration(seconds: 1));

  List data = jsonDecode(jsonString);

  List<User> users = data.map((e) => User.fromJson(e)).toList();

  users.forEach(print);
}

/// Exercise 3 – Microtask

void exercise3() {
  print("Start");

  scheduleMicrotask(() => print("Microtask"));

  Future(() => print("Future"));

  print("End");
}

/// Exercise 4 – Stream transform

Future<void> exercise4() async {
  await for (var value in Stream.fromIterable([1, 2, 3, 4, 5])
      .map((e) => e * e)
      .where((e) => e % 2 == 0)) {
    print(value);
  }
}

/// Exercise 5 – Factory Singleton

class Settings {
  static final Settings _instance = Settings._internal();

  factory Settings() => _instance;

  Settings._internal();
}

void exercise5() {
  var a = Settings();
  var b = Settings();

  print(identical(a, b)); // true
}
