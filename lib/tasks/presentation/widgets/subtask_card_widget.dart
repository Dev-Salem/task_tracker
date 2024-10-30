// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:task_tracker/tasks/domain/subtask.dart';
import 'package:task_tracker/tasks/presentation/widgets/custom_checkbox_widget.dart';

class SubtaskCardWidget extends StatefulWidget {
  final Subtask subtask;
  final int index;
  const SubtaskCardWidget({
    super.key,
    required this.subtask,
    required this.index,
  });

  @override
  State<SubtaskCardWidget> createState() => _SubtaskCardWidgetState();
}

class _SubtaskCardWidgetState extends State<SubtaskCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final normalOffset = const Offset(1, 1);
  final shrunkOffset = const Offset(1 / 1.05, 1 / 1.05);
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final yOffset = -.2 + (widget.index == 0 ? -0.04 : widget.index * -0.1);
    return Animate(
      autoPlay: false,
      controller: _controller,
      effects: [
        ScaleEffect(
            begin: normalOffset, end: shrunkOffset, curve: Curves.decelerate),
        ThenEffect(delay: 10.ms),
        ScaleEffect(
            begin: normalOffset,
            end: const Offset(1.05, 1.05),
            curve: Curves.decelerate),
        // ThenEffect(delay: 20.ms),
        SlideEffect(
            begin: const Offset(0, 0),
            end: Offset(0, yOffset),
            duration: 200.ms,
            delay: 30.ms,
            curve: Curves.decelerate)
      ],
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: widget.subtask.cardColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32), bottom: Radius.circular(32))),
        child: Column(
          children: [
            const Gap(12),
            Row(
              children: [
                const Gap(12),
                const CustomCheckBox(),
                const Expanded(child: SizedBox()),
                IconButton(
                    color: Colors.black,
                    onPressed: () {
                      if (_controller.status.isCompleted) {
                        _controller.reverse();
                      } else {
                        _controller.forward();
                      }
                    },
                    icon: const Icon(
                      Icons.open_in_full,
                    )),
                const Gap(12),
              ],
            ),
            const Gap(12),
            Text(
              widget.subtask.name.toUpperCase() * 2,
              style: context.displayMedium!.copyWith(color: Colors.black),
              softWrap: true,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
