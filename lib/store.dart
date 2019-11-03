library store;

import 'dart:async';
import 'dart:collection';

import 'package:conduite/features/home/home_screen.dart';
import 'package:conduite/models.dart';
import 'package:conduite/services.dart';
import 'package:conduite/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

part 'shared/store/store.dart';
part 'shared/store/middleware.dart';

part 'shared/store/app/app_state.dart';
part 'shared/store/app/app_reducer.dart';

part 'shared/store/auth/auth_state.dart';
part 'shared/store/auth/auth_actions.dart';
part 'shared/store/auth/auth_reducer.dart';

part 'shared/store/articles/articles_state.dart';
part 'shared/store/articles/articles_actions.dart';
part 'shared/store/articles/articles_reducer.dart';

part 'shared/store/comment/comment_state.dart';
part 'shared/store/comment/comment_actions.dart';
part 'shared/store/comment/comment_reducer.dart';

typedef Dispatch = void Function(dynamic);
