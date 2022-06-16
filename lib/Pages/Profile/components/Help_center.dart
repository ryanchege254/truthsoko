import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../src/Widget/constants.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation animate;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animate = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
        backgroundColor: Global.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(Global.defaultPadding),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FAQ :",
              style: GoogleFonts.acme(fontSize: 26),
            ),
            const SizedBox(
              height: 15,
            ),
            ChangeNotifierProvider(
              create: ((context) => ShowAnswer()),
              child: Consumer<ShowAnswer>(
                builder: (context, selected, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: QnAModel.model.length,
                      itemBuilder: ((context, index) {
                        final model = QnAModel.model[index];
                        return _extendedQuestion((model) {
                          selected.itemSelected(model);
                        }, model);
                      }),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void tap() {
    animController.reset();
    animController.forward();
  }

  Widget _extendedQuestion(ValueChanged<QnAModel> onSelected, QnAModel model) {
    return AnimatedBuilder(
      animation: animController,
      builder: (BuildContext context, Widget? child) {
        return Consumer<ShowAnswer>(builder: (context, answer, child) {
          return Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      answer.onSelected(onSelected, model);
                      tap();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              colors: [
                                Colors.white,
                                Colors.yellow,
                                Colors.orange
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              model.question,
                              style: GoogleFonts.acme(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Global.grey),
                            right: BorderSide(color: Global.grey),
                            bottom: BorderSide(color: Global.grey))),
                    child: Transform.translate(
                      offset: Offset(
                        0.0,
                        animController.value * 10,
                      ),
                      child: model.selected
                          ? ListTile(
                              title: Text(
                                model.answer,
                                style: GoogleFonts.acme(fontSize: 15),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }
}

class ShowAnswer extends ChangeNotifier {
  onSelected(
    ValueChanged<QnAModel> onSelected,
    QnAModel model,
  ) {
    onSelected(model);
    notifyListeners();
    return true;
  }

  itemSelected(QnAModel model) {
    for (var item in QnAModel.model) {
      item.selected = false;
    }
    model.selected = true;
    notifyListeners();
  }

  /* bool liked = false;

  onLiked(QnAModel model) {
    liked = true;
    //notifyListeners();
  }*/
}

class QnAModel {
  final String question;
  final String answer;
  bool selected;

  QnAModel(this.question, this.answer, this.selected);
  static List<QnAModel> model = [
    QnAModel(
        "1st question goes herexjcnsdjcnsodjjcnsodjcnsokdjcnsoodjcnoisdjcnosdodjcnsodjnc odfoocnsdocn",
        "answer goes here ....below the answer above ",
        true),
    QnAModel(
        "1st question goes herexjcnsdjcnsodjjcnsodjcnsokdjcnsoodjcnoisdjcnosdodjcnsodjnc odfoocnsdocn",
        "answer goes here ....below the answer above",
        false),
    QnAModel(
        "3rd question goes here....",
        "1st question goes herexjcnsdjcnsodjjcnsodjcnsokdjcnsoodjcnoisdjcnosdodjcnsodjnc odfoocnsdocn",
        false),
    QnAModel(
        "What is truth soko....",
        "1st question goes herexjcnsdjcnsodjjcnsodjcnsokdjcnsoodjcnoisdjcnosdodjcnsodjnc odfoocnsdocn",
        false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel(
        "1st question goes herexjcnsdjcnsodjjcnsodjcnsokdjcnsoodjcnoisdjcnosdodjcnsodjnc odfoocnsdocn",
        "answer goes here ....below the answer above",
        false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
    QnAModel("3rd question goes here....",
        "answer goes here ....below the answer above", false),
  ];
}
