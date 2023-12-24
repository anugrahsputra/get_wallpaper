import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/presentation.dart';

mixin Submitted {
  void submit(BuildContext context, String query, int page) {
    context.read<SearchBloc>().add(SearchQuery(query, page));
  }

  void clear(BuildContext context) {
    context.read<SearchBloc>().add(Started());
  }
}
