import 'package:flutter/material.dart';

import 'package:sparkd/core/constants/imports.dart';

class GiftWidget extends StatefulWidget {
  GiftWidget({
    super.key,
    this.selectedObjective,
    required this.onObjectiveSelection,
    this.onNameSelected,
  });

  final String? selectedObjective;
  final Function(String) onObjectiveSelection;
  final Function(String)? onNameSelected;
  final List<String> _objectiveList = [
    'Your date',
    'Partner',
    'Crush',
    'Someone from the chats',
  ];

  @override
  State<GiftWidget> createState() => _GiftWidgetState();
}

class _GiftWidgetState extends State<GiftWidget> {
  List<String>? _randomNames;
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    if (widget.selectedObjective == 'Someone from the chats') {
      _generateRandomNames();
    }
  }

  @override
  void didUpdateWidget(covariant GiftWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedObjective != widget.selectedObjective) {
      if (widget.selectedObjective == 'Someone from the chats') {
        _generateRandomNames();
      } else {
        _randomNames = null;
        _selectedName = null;
      }
    }
  }

  void _generateRandomNames() {
    List<String> allNames = [
      'John',
      'Alice',
      'Bob',
      'Eve',
      'Charlie',
      'Diana',
      'Frank',
      'Grace'
    ];
    allNames.shuffle();
    setState(() {
      _randomNames = allNames.take(3).toList();
      _selectedName =
          _randomNames?.isNotEmpty == true ? _randomNames!.first : null;
    });
    if (_selectedName != null) {
      widget.onNameSelected?.call(_selectedName!);
    }
  }

  Widget _buildAdditionalContainer(BuildContext context) {
    if (_randomNames == null) return Container();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.primary,
              context.secondary,
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: context.scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedName,
                items: _randomNames!.map((String name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: context.titleMedium,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedName = newValue;
                    });
                    widget.onNameSelected?.call(newValue);
                  }
                },
                underline: Container(),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: context.primary),
                borderRadius: BorderRadius.circular(12),
                style: context.titleMedium?.copyWith(color: context.primary),
                dropdownColor: context.scaffoldBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Who is this gift for?",
          style: context.headlineMedium?.copyWith(
            color: context.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SB.h(35),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index < widget._objectiveList.length) {
                return _Container(
                  objective: widget._objectiveList[index],
                  selectedObjective: widget.selectedObjective,
                  onObjectiveSelection: widget.onObjectiveSelection,
                );
              } else {
                return _buildAdditionalContainer(context);
              }
            },
            separatorBuilder: (context, index) => SB.h(0),
            itemCount: widget._objectiveList.length +
                (widget.selectedObjective == 'Someone from the chats' ? 1 : 0),
          ),
        ),
      ],
    ).paddingAll(20);
  }
}

class _Container extends StatelessWidget {
  const _Container({
    super.key,
    required this.objective,
    this.selectedObjective,
    required this.onObjectiveSelection,
  });

  final String objective;
  final String? selectedObjective;
  final Function(String) onObjectiveSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.primary,
            context.secondary,
          ],
        ),
      ),
      child: InkWell(
        onTap: () => onObjectiveSelection(objective),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: objective == selectedObjective
                ? null
                : context.scaffoldBackgroundColor,
            gradient: objective == selectedObjective
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                        context.secondary,
                        context.primary,
                      ])
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                objective,
                style: context.titleMedium?.copyWith(
                  color: objective == selectedObjective ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
