import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'reflections_widget.dart' show ReflectionsWidget;
import 'package:flutter/material.dart';

class ReflectionsModel extends FlutterFlowModel<ReflectionsWidget> {
  ///  Local state fields for this page.

  bool showInfo = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Models for QuranVerses dynamic component.
  late FlutterFlowDynamicModels<QuranVersesModel> quranVersesModels;

  @override
  void initState(BuildContext context) {
    quranVersesModels = FlutterFlowDynamicModels(() => QuranVersesModel());
  }

  @override
  void dispose() {
    quranVersesModels.dispose();
  }
}
