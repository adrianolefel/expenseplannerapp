import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AddExpense_page.dart';

import 'report_page.dart';
import 'note_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double totalExpense = 0.0;
  double totalIncome = 0.0;
  double budgetLimit = 1000.0; // Default budget
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _fetchFinancialData();
  }

  Future<void> _fetchFinancialData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      double expenses = await _fetchTotal('expenses');
      double income = await _fetchTotal('income');
      setState(() {
        totalExpense = expenses;
        totalIncome = income;
      });
    }
  }

  Future<double> _fetchTotal(String collection) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 0.0;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(collection)
        .get();

    double total = snapshot.docs.fold(0.0, (sum, doc) {
      var amount = (doc['amount'] as num?)?.toDouble() ?? 0.0;
      return sum + amount;
    });

    return total;
  }

  Widget _buildBudgetProgress() {
    double budgetUsage = totalExpense / budgetLimit;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Monthly Budget Usage",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: budgetUsage.clamp(0, 1),
              backgroundColor: Colors.grey[300],
              color: budgetUsage > 1 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              "Spent: \$${totalExpense.toStringAsFixed(2)} / Budget: \$${budgetLimit.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Balance: \$${(totalIncome - totalExpense).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildBudgetProgress(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard('Total Expenses', Colors.red, totalExpense),
                _buildSummaryCard('Total Income', Colors.green, totalIncome),
              ],
            ),
            const SizedBox(height: 20),
            _buildRecentTransactions(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const AddExpensePage()));
                  },
                  child: const Text('Add Expense'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const ReportsPage()));
                  },
                  child: const Text('View Reports'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const NotePage()));
                  },
                  child: const Text('Notes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, Color color, double amount) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 5),
            Text('\$${amount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Text('No transactions found');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var transactions = snapshot.data!.docs;
        return Column(
          children: transactions.map((doc) {
            return ListTile(
              title: Text(doc['description'] ?? ''),
              subtitle: Text(doc['date']?.toDate().toString() ?? ''),
              trailing: Text('\$${doc['amount'].toString()}'),
            );
          }).toList(),
        );
      },
    );
  }
}
