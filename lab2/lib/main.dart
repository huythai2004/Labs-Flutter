
void main() async {
  print("==== Excercise 1 ====");
  excercise1();
  print("\n==== Excercise 2 ====");
  excercise2();
  print("\n==== Excercise 3 ====");
  excercise3();
  print("\n==== Excercise 4 ====");
  excercise4();
  print("\n==== Excercise 5 ====");
  await excercise5();
}

// Ex 1.	Basic Syntax & Data Types
void excercise1() {
  int age = 22;
  double height = 1.80;
  String name = "Pham Huy Thai";
  bool isStudent = true;
  print("Name: $name");
  print("Age: $age");
  print("Height: $height");
  print("Is Student: $isStudent");
}

// Ex 2: Collection and operations - manipulate list, set

void excercise2() {
  List<int> listNum = [1, 2, 3, 4, 5];
  int sum = listNum[0] + listNum[1];

  bool isEqual = listNum[0] == listNum[1];
  bool logicCheck = (listNum[2] > 2 && listNum[3] < 10);

  print("sum: &sum");
  print("isEqual: $isEqual");
  print("logicCheck: $logicCheck");

  //Set
  Set<int> setNum = {1, 8, 3, 6};
  setNum.add(10);
  setNum.remove(3);
  print("Set contents: $setNum");

  //Map
  Map<String, String> student = {"name": "Pham Huy Thai", "Major": "IT"};
  print("Student name: ${student['name']}");
  print("Student Major: ${student['Major']}");
}

// Ex 3.Control Flow & Functions – implement logic using if/else, switch, loops, and functions.

void excercise3() {
  int score = 36;
  print("Grade: A");

  // If/else
  if (score >= 50) {
    print("Your score is passed");
  } else {
    print("You failed");
  }

  //Switch
  int day = 3;
  switch (day) {
    case 1:
      print("Monday");
      break;
    case 2:
      print("Tuesday");
      break;
    case 3:
      print("Wednesday");
      break;
    default:
      print("Invalid day");
  }

  //Loop
  List<String> animals = ["Cat", "Dog", "Bird"];
  for (int i = 0; i < 1; i++) {
    print("Animal: ${animals[i]}");
  }

  //for in loop
  for (var animal in animals) {
    print("for-in loop: $animal");
  }

  //Function
  print("Sum function: ${add(3, 6)}");
  print("Multiple function: ${multiply(4, 5)}");
}

int multiply(int i, int j) {
  return i * j;
}

int add(int i, int j) {
  return i + j;
}

//Ex 4.	Intro OOP – create classes, constructors, inheritance, and method overriding.
void excercise4() {
  Car car = Car("Mercedes", "S-Class");
  Car car2 = Car.namedConstructor("BMW");
  ElectricCar electricCar = ElectricCar("Tesla", "Model S");
  car.drive();
  car2.drive();
}

class Car {
  String brand;
  String model;

  Car(this.brand, this.model);

  Car.namedConstructor(this.brand) : model = "Unknown";

  //Method
  void drive() {
    print("Driving $brand $model");
  }
}

//Subclass with inheritance
class ElectricCar extends Car {
  ElectricCar(super.brand, super.model);

  // void charge() {
  //   print("Charging $brand $model");
  // }
  @override
  void drive() {
    print("Driving electric car $brand $model");
  }
}

//Ex 5. Asynchronous Programming – work with Futures, async/await, and Streams.
Future<void> excercise5() async {
  //Async & await
  print("fetching data....");
  String result = await fetchData();
  print("Data fetched: $result");

  //Null safety
  String? nullableName;
  print("Nullable value: ${nullableName ?? "Default Name"}");
  nullableName = "Pham Huy Thai";
  print("Nullable value after assignment: $nullableName");

  //Stream
  Stream<int> numberStream = countStream();
  numberStream.listen((value){
    print("Stream value: $value");
  });
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Data loaded successfully!";
}

// Create a stream
Stream<int> countStream() async* {
  for (int i = 1; i <= 1000; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}


