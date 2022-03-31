import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final inviteTextStateProvider = StateProvider((ref) => TextEditingController());
final phoneTextStateProvider = StateProvider((ref) => TextEditingController());
final countryCodeTextStateProvider = StateProvider((ref) => "+91");

final continueBottonStateProvider = StateProvider((ref) => true);
