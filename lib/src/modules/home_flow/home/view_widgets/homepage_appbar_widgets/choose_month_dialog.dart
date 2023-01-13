import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';

class ChooseMonthDialog extends StatelessWidget {

  final bloc = Modular.get<HomeBloc>();

  ChooseMonthDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Selecione o mês: '),
      shape: RoundedRectangleBorder(
			  borderRadius: BorderRadius.circular(16.0),
		  ),
      children:                   
            List.generate(
              bloc.months.length,
              (i) => 
              IconButton(
              onPressed: () { 
                bloc.setMonth(
                  newMonth: i+1,
                  );
                log('current month: ${bloc.currentMonth.toString()}');
                
                bloc.add(OnHomePageEmpty());
                Navigator.pop(context);
              }, 
              icon: Text(bloc.months[i].monthName),
              ),            
            ),      
    );
  }
}