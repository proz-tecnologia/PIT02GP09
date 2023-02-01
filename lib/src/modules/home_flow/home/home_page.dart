import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_bloc.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_event.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/home_state.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/homepage_appbar_avatar.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/homepage_appbar_settings_button.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_appbar_widgets/homepage_appbar_title.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_body_widgets/homepage_body_barraprog.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_body_widgets/homepage_body_inkwell.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/formatters.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/widgets/show_loader/show_loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final bloc = Modular.get<HomeBloc>();

  
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(OnHomePageEmpty());
    log(bloc.currentValue.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState> (
        bloc: bloc,
        builder:(context, state) {
          if (state is HomeStateEmpty) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                title: const Text('Homepage Empty'),
                actions: [
                  IconButton(
                    onPressed: () {                
                      Modular.get<HomeBloc>().add(OnHomePageLogout());
                      Modular.to.popAndPushNamed(ConstsRoutes.loginFlowModule);
                    },
                    icon: const Icon(Icons.logout))
                ],
              ),
            );
          
          } else if (state is HomeStateSuccess) {
            log(state.toString());
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 80.0,
                title: const HomepageAppBarTitle(),
                automaticallyImplyLeading: false,
                actions: const [
                  HomepageAppBarSettingsButton(),
                ],
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            "Saldo",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                                
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            Formatters.formatToReal(bloc.userModel!.balance),
                                            style: const TextStyle(
                                              fontSize: 38,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                                
                                        //area do progresso.
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text("Total"),
                                        ),
                                                
                                        //barra de progresso.
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: HomePageProgBar(
                                            currentValue: bloc.currentValue! >= 0 ? bloc.currentValue!.toInt() : 0,
                                            planning: bloc.planning!.toInt(),
                                          ),
                                        ),
                                                
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Text(
                                                Formatters.formatToReal(bloc.userModel!.balance),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                ' de ${Formatters.formatToReal(bloc.monthPlanningValue!)}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                                
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Planejamento de ${bloc.months[bloc.currentMonth-1].monthName}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                                
                                        //linha horizontal
                                        Container(
                                          height: 2,
                                          width: double.infinity,
                                          color: Colors.grey.shade300,
                                          margin: const EdgeInsets.all(5),
                                          child: null,
                                        ),
                                      
                            ],
                          ),
                        ),
              
                        //menu
                        const Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 30,
                            runSpacing: 30,
                            children: [
                              //botão primeiro
                              HomePageBodyInkWell(
                                imageSrc: 'images/wallet.png',
                                name: 'Carteiras',
                                namedRoute: ConstsRoutes.walletsPage,
                              ),
              
                              //botão segundo
                              HomePageBodyInkWell(
                                imageSrc: 'images/cashFlux.png',
                                name: 'Transações',
                                namedRoute: ConstsRoutes.transactionsPage,
                              ),                      
              
                              //botão terceiro
                              HomePageBodyInkWell(
                                imageSrc: 'images/bank.png',
                                name: 'Investimentos',
                                namedRoute: ConstsRoutes.investmentsPage,
                              ),                      
              
                              //botão quarto
                              HomePageBodyInkWell(
                                imageSrc: 'images/neko.png',
                                name: 'Planejamentos',
                                namedRoute: ConstsRoutes.planningsPage,
                              ),                      
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            
          } else if (state is HomeStateLoading) {
            log(state.toString());
            return const ShowLoader();

          } else if (state is HomeStateError) {
            log(state.toString());
            log(state.erro.toString());
            log(state.runtimeType.toString());
            return Text(state.erro.toString());
          }
          return const SizedBox.shrink();
        }
      ),
    );
  }
}