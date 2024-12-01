import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.black,
        color: const Color.fromARGB(166, 107, 166, 254),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}', style:const  TextStyle(fontSize: 15),),
                  const SizedBox(width: 130),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(expense.formattedDate),
                    ],
                  )
                ],
              )
            ],
          )),
        ),
    );
  }
}
