import 'package:sparkd/core/constants/imports.dart';

class BudgetWidget extends StatelessWidget {
  BudgetWidget(
      {super.key, this.selectedObjective, required this.onObjectiveSelection});

  final String? selectedObjective;
  final Function(String) onObjectiveSelection;
  final List<String> _objectiveList = [
    'Under \$25',
    '\$25-\$50',
    '\$50-\$100',
    '\$100+',
    'Generate',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "What’s your budget range?",
          style: context.headlineMedium?.copyWith(
            color: context.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SB.h(35),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return _Container(
                  objective: _objectiveList[index],
                  selectedObjective: selectedObjective,
                  onObjectiveSelection: onObjectiveSelection,
                );
              },
              separatorBuilder: (context, index) {
                return SB.h(0);
              },
              itemCount: _objectiveList.length),
        )
      ],
    ).paddingAll(20);
  }
}

class _Container extends StatelessWidget {
  const _Container(
      {super.key,
      required this.objective,
      this.selectedObjective,
      required this.onObjectiveSelection});

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
            ]),
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
