import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'goals_and_prayers_widget.dart' show GoalsAndPrayersWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GoalsAndPrayersModel extends FlutterFlowModel<GoalsAndPrayersWidget> {
  ///  Local state fields for this page.

  bool showInfo = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Models for QuranVerses dynamic component.
  late FlutterFlowDynamicModels<QuranVersesModel> quranVersesModels;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {
    quranVersesModels = FlutterFlowDynamicModels(() => QuranVersesModel());
  }

  @override
  void dispose() {
    quranVersesModels.dispose();
  }
}
