import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../model/usDataModel.dart';

part 'usdata_state.dart';

class UsdataCubit extends Cubit<UsdataState> {
  UsdataCubit(this.context) : super(UsdataInitial()) {
    getData();
  }

  BuildContext context;

  getData() async {
    emit(dataLoding());
    const url =
        "https://datausa.io/api/data?drilldowns=Nation&measures=Population#";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = usDataFromJson(response.body);
      emit(dataLoded(data));
    } else {
      emit(dataLodedError("Error: ${response.body}"));
    }
  }
}
