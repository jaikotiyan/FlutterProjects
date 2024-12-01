import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'flutter',
        amount: 19.99,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        category: Category.leisure,
        title: 'vacation',
        amount: 109.99,
        date: DateTime.now()),
    Expense(
        category: Category.travel,
        title: 'vacation',
        amount: 39.99,
        date: DateTime.now()),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: addExpense);
        });
  }

  void addExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: (){
          setState(() {
            _registerExpenses.insert(expenseIndex, expense);
          });
        }),
      content: const Text("Expense Deleted"),),);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No expenses found. Start adding some !"),
    );
    if(_registerExpenses.isNotEmpty){
      mainContent = ExpenseList(expenses: _registerExpenses, onRemoveExpense: removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker', style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add, color: Colors.white,))
        ],
      ),
      body: Center(
        child: Column(
          children: [
                Chart(expenses: _registerExpenses),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
