// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's2.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$S2NotifierHash() => r'ff09137a1153d9eb83b7281a8df842b4a15d3c1d';

/// See also [S2Notifier].
final s2NotifierProvider =
    AutoDisposeNotifierProvider<S2Notifier, List<String>>(
  S2Notifier.new,
  name: r's2NotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$S2NotifierHash,
);
typedef S2NotifierRef = AutoDisposeNotifierProviderRef<List<String>>;

abstract class _$S2Notifier extends AutoDisposeNotifier<List<String>> {
  @override
  List<String> build();
}
