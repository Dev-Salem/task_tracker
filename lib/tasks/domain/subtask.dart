// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Subtask extends Equatable {
  final String name;
  final Color cardColor;
  bool isDone;
  Subtask({
    required this.name,
    required this.cardColor,
    required this.isDone,
  });

  @override
  List<Object> get props => [name, isDone];
}
