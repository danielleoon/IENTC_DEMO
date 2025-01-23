import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/providers/bloc/ThemeBloc.dart';
import 'package:ientc_jdls/providers/events/ThemeEvent.dart';
import 'package:ientc_jdls/providers/states/ThemeState.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final themeData = themeState.themeData;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: themeData.scaffoldBackgroundColor,
                floating: true,
                snap: true,
                expandedHeight: 110.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/logodb.webp',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 50,
                                  ))),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ThemeBloc>()
                                    .add(ToggleThemeEvent());
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: themeData.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    themeState.themeData.brightness ==
                                            Brightness.dark
                                        ? Icons.dark_mode
                                        : Icons.light_mode,
                                    color: themeData.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Información",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Daniel-Bold',
                              color: DanielAcentColors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Bienvenido a la app de presentación de conocimientos para IENTC",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Daniel-Bold',
                              color: themeState.themeData.primaryColorDark,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Desarrollado por Daniel León",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Daniel-Regular',
                              fontStyle: FontStyle.italic,
                              color: themeState.themeData.primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Esta aplicación sirve como demostración de las habilidades técnicas y el conocimiento adquirido en el desarrollo de soluciones móviles y digitales.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: themeState.themeData.primaryColorDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
