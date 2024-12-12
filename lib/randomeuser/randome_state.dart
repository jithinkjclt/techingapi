part of 'randome_cubit.dart';

@immutable
sealed class RandomeState {}

final class RandomeInitial extends RandomeState {}

final class Randomeloding extends RandomeState {}

final class RandomeDataLoded extends RandomeState {
  final Randome data;

  RandomeDataLoded(this.data);
}

final class RandomeDataError extends RandomeState {
  final String error;

  RandomeDataError(this.error);
}
