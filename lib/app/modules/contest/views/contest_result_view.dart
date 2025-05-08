import 'package:flutter/material.dart';
import 'package:lokkha/app/helper/global.dart';
import 'package:lokkha/app/modules/contest/models/contest_result_model.dart';

class ContestResultView extends StatelessWidget {
  final ContestResultModel contestResultModel;

  const ContestResultView({super.key, required this.contestResultModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rank List")),
      body: ListView.builder(
        itemCount: contestResultModel.contestResults!.length,
        itemBuilder: (context, index) {
          final user = contestResultModel.contestResults![index].user;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: buildAvatar(user!),
                title: Text(user.name.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(user.userId.toString()),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Rank #${(index + 1)}',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



