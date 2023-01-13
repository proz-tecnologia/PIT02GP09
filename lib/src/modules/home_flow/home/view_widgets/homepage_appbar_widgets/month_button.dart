import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/choose_month_dialog.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/month_container.dart';

class MonthButton extends StatefulWidget {

  const MonthButton({
    super.key,
  });

  @override
  State<MonthButton> createState() => _MonthButtonState();
}

class _MonthButtonState extends State<MonthButton> {

  final bloc = Modular.get<HomeBloc>();

  MonthContainer? currentMonthContainer;

  @override
  void initState() {
    super.initState();
    final month = Modular.get<HomeBloc>().months[bloc.currentMonth - 1];
    log('currentmonth ${bloc.currentMonth.toString()}');
    log('currentmonth monthbutton ${Modular.get<HomeBloc>().months[bloc.currentMonth - 1]}');
    log('currentmonth monthbutton ${Modular.get<HomeBloc>().months[0]}');
    setState(() {
      currentMonthContainer = MonthContainer(month: month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [    
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context, 
                    barrierDismissible: false,
                    builder: (context) => ChooseMonthDialog(),
                    ).then((value) async {
                      final monthName = Modular.get<HomeBloc>().months[Modular.get<HomeBloc>().currentMonth];
                      setState(() {                                                  
                        currentMonthContainer = MonthContainer(month: monthName);
                      });
                                           
                    }
                    );                    
                },
                icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                  ),                
              ),
              BlocBuilder<HomeBloc, HomeState> (
                bloc: bloc,
                builder: (context, state) {
                    return currentMonthContainer!;
                }                
              ),
            ],
    );
  }
}

