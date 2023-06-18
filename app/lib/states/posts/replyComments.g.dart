// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replyComments.dart';

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

String _$ReplyCommentsNotifierHash() =>
    r'010df69a370fd2e84100c42e1c6f939f874327eb';

/// See also [ReplyCommentsNotifier].
class ReplyCommentsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ReplyCommentsNotifier,
        List<PostData>> {
  ReplyCommentsNotifierProvider(
    this.id,
  ) : super(
          () => ReplyCommentsNotifier()..id = id,
          from: replyCommentsNotifierProvider,
          name: r'replyCommentsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ReplyCommentsNotifierHash,
        );

  final dynamic id;

  @override
  bool operator ==(Object other) {
    return other is ReplyCommentsNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<PostData>> runNotifierBuild(
    covariant _$ReplyCommentsNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

typedef ReplyCommentsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<PostData>>;

/// See also [ReplyCommentsNotifier].
final replyCommentsNotifierProvider = ReplyCommentsNotifierFamily();

class ReplyCommentsNotifierFamily extends Family<AsyncValue<List<PostData>>> {
  ReplyCommentsNotifierFamily();

  ReplyCommentsNotifierProvider call(
    dynamic id,
  ) {
    return ReplyCommentsNotifierProvider(
      id,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<ReplyCommentsNotifier, List<PostData>>
      getProviderOverride(
    covariant ReplyCommentsNotifierProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'replyCommentsNotifierProvider';
}

abstract class _$ReplyCommentsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PostData>> {
  late final dynamic id;

  FutureOr<List<PostData>> build(
    dynamic id,
  );
}
