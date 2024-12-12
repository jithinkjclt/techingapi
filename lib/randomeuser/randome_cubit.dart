import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:usdata/model/randomUser.dart';

part 'randome_state.dart';

class RandomeCubit extends Cubit<RandomeState> {
  RandomeCubit() : super(RandomeInitial()) {
    getData();
  }

  Future<void> getData() async {
    try {
      emit(Randomeloding());
      const url = "https://randomuser.me/api/";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = randomeFromJson(response.body);
        emit(RandomeDataLoded(data));
      } else {
        emit(RandomeDataError(
            "Error: ${response.statusCode} - ${response.body}"));
      }
    } catch (e) {
      emit(RandomeDataError("An unexpected error occurred: $e"));
    }
  }
}
