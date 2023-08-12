///Dummy data

class User {
  final String name;
  final String image;
  
  User({required this.name, required this.image});
}

final List<User> users = [
  User(name: "Abulla", image: "assets/dummy/person.jpg"),
  User(name: "Ahmed", image: "assets/dummy/person.jpg"),
  User(name: "Daniel", image: "assets/dummy/person.jpg"),
  User(name: "Muxar", image: "assets/dummy/person.jpg"),
  User(name: "Yasmeen", image: "assets/dummy/person.jpg"),
  User(name: "Yasmeen", image: "assets/dummy/person.jpg"),
  User(name: "Yasmeen", image: "assets/dummy/person.jpg"),
  User(name: "Yasmeen", image: "assets/dummy/person.jpg"),
];


///Data of bills history
enum BillStatus {
  processing,
  failed,
  success,
}
class Bill {
  final String title;
  final double amount;
  final String time;
  final BillStatus status;

  Bill({required this.title, required this.time, required this.amount, required this.status});
}
List<Bill> bills = [
  Bill(title: "Orange Internet", time: "8:32PM", amount: -65.000, status: BillStatus.processing),
  Bill(title: "New Home Internet", time: "8:32PM", amount: -82.000, status: BillStatus.failed),
  Bill(title: "Home 2 Internet", time: "8:32PM", amount: -89.000, status: BillStatus.success),
  Bill(title: "Electric Home", time: "8:32PM", amount: -65.000, status: BillStatus.success),
];

