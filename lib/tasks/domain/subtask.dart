import 'package:equatable/equatable.dart';

class Subtask extends Equatable {
  final String name;
  final bool isDone;
  const Subtask({
    required this.name,
    required this.isDone,
  });

  @override
  List<Object> get props => [name, isDone];
}
