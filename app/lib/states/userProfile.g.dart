// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userProfile.dart';

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

String _$UserProfileNotifierHash() =>
    r'2b0f56b041fa075a3d8202d1ba2a5ccfa6a061c9';

/// See also [UserProfileNotifier].
class UserProfileNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserProfileNotifier, UserData> {
  UserProfileNotifierProvider(
    this.uid,
  ) : super(
          () => UserProfileNotifier()..uid = uid,
          from: userProfileNotifierProvider,
          name: r'userProfileNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$UserProfileNotifierHash,
        );

  final dynamic uid;

  @override
  bool operator ==(Object other) {
    return other is UserProfileNotifierProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<UserData> runNotifierBuild(
    covariant _$UserProfileNotifier notifier,
  ) {
    return notifier.build(
      uid,
    );
  }
}

typedef UserProfileNotifierRef = AutoDisposeAsyncNotifierProviderRef<UserData>;

/// See also [UserProfileNotifier].
final userProfileNotifierProvider = UserProfileNotifierFamily();

class UserProfileNotifierFamily extends Family<AsyncValue<UserData>> {
  UserProfileNotifierFamily();

  UserProfileNotifierProvider call(
    dynamic uid,
  ) {
    return UserProfileNotifierProvider(
      uid,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<UserProfileNotifier, UserData>
      getProviderOverride(
    covariant UserProfileNotifierProvider provider,
  ) {
    return call(
      provider.uid,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'userProfileNotifierProvider';
}

abstract class _$UserProfileNotifier
    extends BuildlessAutoDisposeAsyncNotifier<UserData> {
  late final dynamic uid;

  FutureOr<UserData> build(
    dynamic uid,
  );
}
