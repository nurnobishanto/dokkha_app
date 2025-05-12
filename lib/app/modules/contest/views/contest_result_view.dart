import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokkha/app/helper/global.dart';

import '../../../models/contest_result.dart';
import '../../auth_views/auth_gateway/views/auth_gateway_view.dart';

class ContestResultView extends StatefulWidget {
  final List<ContestResult> contestResults;

  const ContestResultView({super.key, required this.contestResults});

  @override
  State<ContestResultView> createState() => _ContestResultViewState();
}

class _ContestResultViewState extends State<ContestResultView> {
  late List<ContestResult> filteredResults;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredResults = widget.contestResults;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredResults = widget.contestResults.where((result) {
        final name = result.user?.name?.toLowerCase() ?? '';
        final userId = result.user?.userId?.toString().toLowerCase() ?? '';
        return name.contains(searchQuery) || userId.contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("প্রতিযোগিতার র‍্যাঙ্ক")),
      body: isLoggedIn.value != true
          ? const AuthGatewayView()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: updateSearch,
                    decoration: InputDecoration(
                      hintText: 'নাম বা আইডি দিয়ে খুঁজুন...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                /// 📄 রেজাল্ট লিস্ট
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredResults.length,
                    itemBuilder: (context, index) {
                      final result = filteredResults[index];
                      final originalIndex =
                          widget.contestResults.indexOf(result);
                      final user = result.user;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: buildAvatar(user!),
                                  title: Text(
                                    user.name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('আইডি: ${user.userId}'),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'র‍্যাংক #${originalIndex + 1}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// সময়কাল
                                Row(
                                  children: [
                                    const Icon(Icons.timer,
                                        size: 20, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                        'সময়: ${result.completeDuration! ~/ 60} মিনিট ${result.completeDuration! % 60} সেকেন্ড'),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                /// সাবমিট টাইম
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 20, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                        'সাবমিট: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(result.updatedAt))}'),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                /// সঠিক ও ভুল উত্তর
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '✅ সঠিক উত্তর: ${result.correctAnswers}'),
                                    Text(
                                        '❌ ভুল উত্তর: ${result.incorrectAnswers}'),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                /// মোট নম্বর
                                Row(
                                  children: [
                                    const Icon(Icons.stars,
                                        size: 20, color: Colors.amber),
                                    const SizedBox(width: 6),
                                    Text(
                                      'মোট নম্বর: ${(result.correctAnswers!.toInt() * result.contest!.positiveMark!.toInt()) - (result.incorrectAnswers!.toInt() * result.contest!.negativeMark!.toInt())}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
