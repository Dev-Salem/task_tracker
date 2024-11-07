import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Subtask extends Equatable {
  final String name;
  final String id;
  final Color cardColor;
  final bool isDone;
  const Subtask({
    required this.name,
    required this.id,
    required this.cardColor,
    required this.isDone,
  });

  @override
  List<Object> get props => [name, isDone, cardColor, isDone];

  Subtask copyWith({
    String? name,
    String? id,
    Color? cardColor,
    bool? isDone,
  }) {
    return Subtask(
      name: name ?? this.name,
      id: id ?? this.id,
      cardColor: cardColor ?? this.cardColor,
      isDone: isDone ?? this.isDone,
    );
  }
}
