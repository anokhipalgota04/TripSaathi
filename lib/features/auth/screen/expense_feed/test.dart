// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:gonomad/models/expense.dart' as ExpenseModel;
// import 'package:gonomad/widgets/expenses_list/FilteredExpensesPage.dart';
// import 'package:gonomad/widgets/charts/chart.dart';
// import 'package:gonomad/features/auth/screen/expense_feed/new_expense.dart';
// import 'package:gonomad/widgets/progress_bar/ExpenseProgress.dart';
//
// class Expenses extends StatefulWidget {
//   const Expenses({Key? key}) : super(key: key);
//
//   @override
//   State<Expenses> createState() => _ExpensesState();
// }
//
// class _ExpensesState extends State<Expenses> {
//   final List<ExpenseModel.Expense> _registeredExpenses = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchExpenses();
//   }
//
//   Future<void> _fetchExpenses() async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('user_expenses').doc(user.uid).collection('expenses').get();
//         setState(() {
//           _registeredExpenses.clear();
//           _registeredExpenses.addAll(querySnapshot.docs.map((doc) {
//             final data = doc.data() as Map<String, dynamic>;
//             return ExpenseModel.Expense(
//               id: doc.id,
//               title: data['title'],
//               amount: data['amount'],
//               date: (data['date'] as Timestamp).toDate(), // Convert Timestamp to DateTime
//               category: ExpenseModel.Category.values.firstWhere(
//                     (e) => e.toString() == 'Category.${data['category']}',
//               ),
//               uid: user.uid,
//             );
//           }).toList());
//         });
//       }
//     } catch (e) {
//       print('Error fetching expenses: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Expense Tracker'),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (ctx) => NewExpense(onAddExpense: _addExpense),
//               );
//             },
//             icon: const Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           child: Column(
//             children: [
//               _buildFilterOptions(),
//               Chart(expenses: _registeredExpenses),
//               ExpenseProgressCard(
//                 totalExpenses: _calculateYearlyTotal(),
//                 // Set initial max budget to 0.00
//                 onMaxBudgetChanged: (newBudget) {
//                   // Handle max budget change if needed
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterOptions() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           SizedBox(width: 16),
//           _buildSquareButton('All Expenses', () {
//             _navigateToFilteredExpensesPage(_registeredExpenses);
//           }),
//           SizedBox(width: 8),
//           _buildSquareButton('Daily Expenses', () {
//             final filteredExpenses = _filterDailyExpenses(DateTime.now());
//             _navigateToFilteredExpensesPage(filteredExpenses);
//           }),
//           SizedBox(width: 8),
//           _buildSquareButton('Weekly Expenses', () {
//             final filteredExpenses = _filterWeeklyExpenses(DateTime.now());
//             _navigateToFilteredExpensesPage(filteredExpenses);
//           }),
//           SizedBox(width: 8),
//           _buildSquareButton('Monthly Expenses', () {
//             final filteredExpenses = _filterMonthlyExpenses(DateTime.now());
//             _navigateToFilteredExpensesPage(filteredExpenses);
//           }),
//           SizedBox(width: 8),
//           _buildSquareButton('Yearly Expenses', () {
//             final filteredExpenses = _filterYearlyExpenses(DateTime.now());
//             _navigateToFilteredExpensesPage(filteredExpenses);
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSquareButton(String text, Function() onPressed) {
//     return SizedBox(
//       width: 130,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           primary: Colors.lightBlueAccent[50], // Change the background color to light blue accent[50]
//         ),
//         child: Text(text),
//       ),
//     );
//
//   }
//
//   void _addExpense(ExpenseModel.Expense expense) {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         FirebaseFirestore.instance
//             .collection('user_expenses')
//             .doc(user.uid)
//             .collection('expenses')
//             .doc(expense.id)
//             .set({
//           'id': expense.id,
//           'uid': user.uid,
//           'title': expense.title,
//           'amount': expense.amount,
//           'date': expense.date,
//           'category': expense.category.toString().split('.').last,
//         })
//             .then((_) {
//           setState(() {
//             _registeredExpenses.add(expense);
//           });
//         })
//             .catchError((error) {
//           print('Error adding expense: $error');
//         });
//       }
//     } catch (e) {
//       print('Error adding expense: $e');
//     }
//   }
//
//   void _removeExpense(ExpenseModel.Expense expense) {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         FirebaseFirestore.instance
//             .collection('user_expenses')
//             .doc(user.uid)
//             .collection('expenses')
//             .doc(expense.id)
//             .delete()
//             .then((_) {
//           setState(() {
//             _registeredExpenses.remove(expense);
//           });
//         })
//             .catchError((error) {
//           print('Error removing expense: $error');
//         });
//       }
//     } catch (e) {
//       print('Error removing expense: $e');
//     }
//   }
//
//   List<ExpenseModel.Expense> _filterDailyExpenses(DateTime date) {
//     return _registeredExpenses.where((expense) => isSameDay(expense.date, date)).toList();
//   }
//
//   List<ExpenseModel.Expense> _filterWeeklyExpenses(DateTime date) {
//     final endDate = date;
//     final startDate = date.subtract(const Duration(days: 6));
//     return _registeredExpenses.where((expense) => expense.date.isAfter(startDate) && expense.date.isBefore(endDate)).toList();
//   }
//
//   List<ExpenseModel.Expense> _filterMonthlyExpenses(DateTime date) {
//     return _registeredExpenses.where((expense) => isSameMonth(expense.date, date)).toList();
//   }
//
//   List<ExpenseModel.Expense> _filterYearlyExpenses(DateTime date) {
//     return _registeredExpenses.where((expense) => isSameYear(expense.date, date)).toList();
//   }
//
//   double _calculateYearlyTotal() {
//     return _filterYearlyExpenses(DateTime.now()).fold(0.0, (sum, expense) => sum + expense.amount);
//   }
//
//   bool isSameDay(DateTime d1, DateTime d2) {
//     return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
//   }
//
//   bool isSameMonth(DateTime d1, DateTime d2) {
//     return d1.year == d2.year && d1.month == d2.month;
//   }
//
//   bool isSameYear(DateTime d1, DateTime d2) {
//     return d1.year == d2.year;
//   }
//
//   void _navigateToFilteredExpensesPage(List<ExpenseModel.Expense> filteredExpenses) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => FilteredExpensesPage(filteredExpenses: filteredExpenses, onRemove: _removeExpense)),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: Expenses(),
//   ));
// }




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gonomad/models/expense.dart';
//
// class ExpenseItem extends StatelessWidget {
//   const ExpenseItem({
//     Key? key,
//     required this.expense,
//     required this.onRemove,
//   }) : super(key: key);
//
//   final Expense expense;
//   final void Function(Expense) onRemove;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(expense.id),
//       direction: DismissDirection.horizontal,
//       onDismissed: (direction) {
//         onRemove(expense); // Call onRemove callback
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Deleted ${expense.title}'),
//             action: SnackBarAction(
//               label: 'Undo',
//               onPressed: () {
//                 // Implement functionality to undo deletion
//               },
//             ),
//           ),
//         );
//       },
//       background: Container(
//         color: Colors.red,
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.only(right: 20.0),
//         child: Icon(Icons.delete, color: Colors.white),
//       ),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(expense.title),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   Text(
//                     'Rs. ${expense.amount.toStringAsFixed(2)}',
//                   ),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Icon(categoryIcons[expense.category]),
//                       const SizedBox(width: 8),
//                       Text(expense.formattedDate),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FilteredExpensesPage extends StatelessWidget {
//   final List<Expense> filteredExpenses;
//   final void Function(Expense) onRemove; // Define onRemove callback
//
//   const FilteredExpensesPage({
//     Key? key,
//     required this.filteredExpenses,
//     required this.onRemove,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Filtered Expenses'),
//       ),
//       body: filteredExpenses.isEmpty
//           ? Center(
//         child: Text('No expenses found.'),
//       )
//           : ListView.builder(
//         itemCount: filteredExpenses.length,
//         itemBuilder: (context, index) {
//           final expense = filteredExpenses[index];
//           return ExpenseItem(
//             expense: expense,
//             onRemove: onRemove,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class Expenses extends StatelessWidget {
//   const Expenses({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Expense Tracker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 _buildSquareButton('Monthly Expenses', context, 'Monthly'),
//                 const SizedBox(width: 8),
//                 _buildSquareButton('Yearly Expenses', context, 'Yearly'),
//                 const SizedBox(width: 8),
//                 _buildSquareButton('Weekly Expenses', context, 'Weekly'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSquareButton(
//       String text, BuildContext context, String filter) {
//     return SizedBox(
//       width: 130,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: () {
//           _navigateToFilteredExpensesPage(context, filter);
//         },
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         child: Text(text),
//       ),
//     );
//   }
//
//   void _navigateToFilteredExpensesPage(
//       BuildContext context, String filter) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       // Handle case when user is not logged in
//       return;
//     }
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('user_expenses') // Main collection
//               .doc(user.uid) // Document with user's UID
//               .collection('expenses') // Subcollection for user's expenses
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//
//             final expenses = snapshot.data!.docs.map((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//               return Expense(
//                 id: doc.id,
//                 title: data['title'],
//                 amount: data['amount'],
//                 date: data['date'].toDate(),
//                 category: Category.values.firstWhere(
//                       (e) => e.toString() == 'Category.${data['category']}',
//                 ),
//                 uid: user.uid,
//               );
//             }).toList();
//
//             return FilteredExpensesPage(
//               filteredExpenses: expenses,
//               onRemove: (expense) {
//                 // Implement logic to remove expense from the database
//                 FirebaseFirestore.instance
//                     .collection('user_expenses') // Main collection
//                     .doc(user.uid) // Document with user's UID
//                     .collection('expenses') // Subcollection for user's expenses
//                     .doc(expense.id) // Document for this specific expense
//                     .delete();
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }