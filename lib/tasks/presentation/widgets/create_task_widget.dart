import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  final bool isTask;
  final void Function(Color selectedColor, String text)? onSaveSubtask;
  final void Function(
          Color selectedColor, String text, TimeOfDay from, TimeOfDay to)?
      onSaveTask;
  const CreateTaskBottomSheet({
    super.key,
    this.onSaveTask,
    this.onSaveSubtask,
    required this.isTask,
  });

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  late final TextEditingController _controller;
  Color selectedColor = Colors.deepPurpleAccent;
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: TextFormField(
                maxLength: 24,
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Task",
                ),
              ),
            ),
            Flexible(
              child: DropdownMenu<Color>(
                  onSelected: (value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                  selectedTrailingIcon: const SizedBox.shrink(),
                  trailingIcon: const SizedBox.shrink(),
                  width: 30,
                  menuHeight: 240,
                  leadingIcon: AvatarImage(
                    backgroundColor: selectedColor,
                    radius: 12,
                  ),
                  inputDecorationTheme:
                      const InputDecorationTheme(border: InputBorder.none),
                  dropdownMenuEntries:
                      List.generate(Colors.accents.length, (index) {
                    return DropdownMenuEntry(
                        labelWidget: const SizedBox.shrink(),
                        trailingIcon: const SizedBox.shrink(),
                        leadingIcon: AvatarImage(
                          backgroundColor: Colors.accents[index],
                          radius: 16,
                        ),
                        value: Colors.accents[index],
                        label: "Color");
                  })),
            )
          ],
        ),
        if (widget.isTask)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () async {
                    fromTime = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.dialOnly,
                            context: context,
                            initialTime: TimeOfDay.now()) ??
                        TimeOfDay.now();
                    setState(() {});
                  },
                  child: Text("From ${fromTime.hour}: ${fromTime.minute}")),
              TextButton(
                  onPressed: () async {
                    toTime = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.dialOnly,
                            context: context,
                            initialTime: TimeOfDay.now()) ??
                        TimeOfDay.now();
                    setState(() {});
                  },
                  child: Text("To ${toTime.hour}: ${toTime.minute}")),
            ],
          ),
        const Gap(12),
        SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
                onPressed: () {
                  widget.isTask
                      ? widget.onSaveTask!(
                          selectedColor, _controller.text, fromTime, toTime)
                      : widget.onSaveSubtask!(selectedColor, _controller.text);

                  // context.pop();
                },
                label: const Text("Add"))),
        const Gap(32),
      ],
    ).paddingSymmetric(horizontal: 24);
  }
}
