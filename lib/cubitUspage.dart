import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usdata/cubit/usdata_cubit.dart';

class Cubituspage extends StatelessWidget {
  const Cubituspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsData"),
      ),
      body: BlocProvider(
        create: (context) => UsdataCubit(context),
        child: BlocBuilder<UsdataCubit, UsdataState>(
          builder: (context, state) {
            if (state is dataLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is dataLoded) {
              return ListView.builder(
                itemCount: state.data.data!.length,
                itemBuilder: (context, index) {
                  final details = state.data.data![index];
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
            } else if (state is dataLodedError) {
              print(state.error);

              return Center(
                child: Container(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 55,
                      ),
                      Text("Error${state.error}")
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
