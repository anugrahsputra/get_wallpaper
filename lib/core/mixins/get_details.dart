import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/presentation.dart';

mixin GetDetails {
  void getDetailWallpaper(BuildContext context, int id) {
    context.read<DetailBloc>().add(Details(id));
  }
}
