import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/usDataModel.dart';

class UsDatass extends StatefulWidget {
  const UsDatass({super.key});

  @override
  State<UsDatass> createState() => _UsDatassState();
}

class _UsDatassState extends State<UsDatass> {
  Future<UsData> getData() async {
    const url =
        "https://datausa.io/api/data?drilldowns=Nation&measures=Population#";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return usDataFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(" Data")),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data?.data ?? [];

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final details = data[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade300,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ID Nation:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.idNation.toString() ?? "N/A"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Nation:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.nation.toString() ?? "N/A"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ID Year:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.idYear?.toString() ?? "N/A"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Year:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.year ?? "N/A"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Population:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.population?.toString() ?? "N/A"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Slug Nation:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(details.slugNation.toString() ?? "N/A"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
