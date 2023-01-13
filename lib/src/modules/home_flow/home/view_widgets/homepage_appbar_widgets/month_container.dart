import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/months/month_model.dart';
class MonthContainer extends StatelessWidget {

final bloc = Modular.get<HomeBloc>();
final Month month;

  MonthContainer({
    required this.month,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Text(                       
        month.monthName,
        style: const TextStyle(
        fontSize: 13.0, 
        ),
      ),
    );
  }
}