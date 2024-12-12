import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usdata/randomeuser/randome_cubit.dart';

class Randomeuser extends StatelessWidget {
  const Randomeuser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RandomeCubit(),
      child: BlocBuilder<RandomeCubit, RandomeState>(
        builder: (context, state) {
          final cubit = context.read<RandomeCubit>();
          bool isLoading = state is Randomeloding;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Choose a Random User"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Show loader or error
                if (state is Randomeloding)
                  const Center(child: CircularProgressIndicator()),
                if (state is RandomeDataLoded) ...[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: state.data.results!.first.picture != null
                                  ? Image.network(state.data.results!.first.picture!.large!)
                                  : const Icon(Icons.person, size: 50),
                            ),
                          ),
                          Text(
                            "Name: ${state.data.results!.first.name?.first ?? ''} "
                                "${state.data.results!.first.name?.last ?? ''}",
                          ),
                          Text("Email: ${state.data.results!.first.email ?? 'N/A'}"),
                          Text("Phone: ${state.data.results!.first.phone ?? 'N/A'}"),
                          Text("Country: ${state.data.results!.first.location?.country ?? 'N/A'}"),
                        ],
                      ),
                    ),
                  ),
                ],
                if (state is RandomeDataError)
                  Text(state.error, style: const TextStyle(color: Colors.red)),

                // Elevated button with loading state
                ElevatedButton(
                  onPressed: isLoading
                      ? null // Disable button while loading
                      : cubit.getData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLoading ? Colors.grey : Colors.white24,
                  ),
                  child: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text("Press Again"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
