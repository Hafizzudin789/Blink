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
class PostPaidBill {
  final String title;
  final String subTitle;
  final String iconPath;
  final double dueAmount;

  PostPaidBill({required this.title, required this.subTitle,
    required this.iconPath, required this.dueAmount});
}
List<PostPaidBill> postPaidBills = [
  PostPaidBill(title: "Electric Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/electric.svg", dueAmount: 65.3),
  PostPaidBill(title: "Home 2 Internet", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 73.3),
  PostPaidBill(title: "My New number", subTitle: "Jordan Electricity", iconPath: "assets/icons/electric.svg", dueAmount: 65.3),
  PostPaidBill(title: "Wife zein", subTitle: "Jordan Electricity", iconPath: "assets/icons/electric.svg", dueAmount: 89.3),
  PostPaidBill(title: "Rental Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 78.3),
  PostPaidBill(title: "Water Bill Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/electric.svg", dueAmount: 65.3),
  PostPaidBill(title: "Electric Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 65.3),
  PostPaidBill(title: "Electric Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 78.3),
  PostPaidBill(title: "Electric Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 109.3),
  PostPaidBill(title: "Electric Home", subTitle: "Jordan Electricity", iconPath: "assets/icons/bill.svg", dueAmount: 65.3),
];


///Post paid bills data
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

