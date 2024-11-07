import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_tracker/tasks/domain/subtask.dart';
import 'package:task_tracker/tasks/presentation/widgets/custom_checkbox_widget.dart';

class SubtaskCardWidget extends StatefulWidget {
  final Subtask subtask;
  final int index;
  final Function(bool?) onCheck;
  const SubtaskCardWidget({
    super.key,
    required this.subtask,
    required this.index,
    required this.onCheck,
  });

  @override
  State<SubtaskCardWidget> createState() => _SubtaskCardWidgetState();
}

class _SubtaskCardWidgetState extends State<SubtaskCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
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
    return Container(
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
              CustomCheckBox(
                isChecked: widget.subtask.isDone,
                onCheck: widget.onCheck,
              ),
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
          _CardText(
                  text: widget.subtask.name,
                  textStyle:
                      context.displayMedium!.copyWith(color: Colors.black))
              .animate(
                autoPlay: false,
                target: widget.subtask.isDone ? 1 : 0,
              )
              .crossfade(
                  curve: Curves.decelerate,
                  duration: 600.ms,
                  builder: (_) => _CardText(
                      text: widget.subtask.name,
                      textStyle: context.displayMedium!.copyWith(
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2,
                          decorationColor: Colors.black38))),
          const Gap(12),
        ],
      ),
    )
        .animate(autoPlay: false, controller: _controller)
        .scaleXY(begin: 1, end: 1 / 1.05, curve: Curves.decelerate)
        .then(delay: 10.ms)
        .scaleXY(begin: 1, end: 1.05)
        .slideY(begin: 0, end: yOffset, duration: 200.ms, delay: 30.ms);
  }
}

class _CardText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  const _CardText({
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.toUpperCase(),
      style: textStyle.copyWith(),
      softWrap: true,
      maxLines: 4,
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
    );
  }
}
