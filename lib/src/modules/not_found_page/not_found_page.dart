import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/routes/consts_routes.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/utils/consts.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:const Color(0xFF34B99B),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            SizedBox(
              height:MediaQuery.of(context).size.height * 2,
              child: Image.asset(
                Consts.pathImageNotFoundPage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.14,
              left: MediaQuery.of(context).size.width * 0.065,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 25,
                      color: Colors.black.withOpacity(0.17),
                    ),
                  ],
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () =>Modular.to.navigate(ConstsRoutes.loginPage),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Consts.textTextButtonNotFoundPage.toUpperCase()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
