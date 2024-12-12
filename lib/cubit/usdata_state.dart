part of 'usdata_cubit.dart';

@immutable
sealed class UsdataState {}

final class UsdataInitial extends UsdataState {}

final class dataLoding extends UsdataState {}

final class dataLoded extends UsdataState {
  final UsData data;

  dataLoded(this.data);
}

final class dataLodedError extends UsdataState {
  final String error;

  dataLodedError(this.error);
}
