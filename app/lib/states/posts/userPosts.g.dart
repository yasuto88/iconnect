// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userPosts.dart';

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

String _$UserPostsNotifierHash() => r'39ed1a981af10b7fd34382c61150577dcd4b5164';

/// See also [UserPostsNotifier].
class UserPostsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserPostsNotifier, List<PostData>> {
  UserPostsNotifierProvider(
    this.posts,
  ) : super(
          () => UserPostsNotifier()..posts = posts,
          from: userPostsNotifierProvider,
          name: r'userPostsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$UserPostsNotifierHash,
        );

  final List<dynamic> posts;

  @override
  bool operator ==(Object other) {
    return other is UserPostsNotifierProvider && other.posts == posts;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, posts.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<PostData>> runNotifierBuild(
    covariant _$UserPostsNotifier notifier,
  ) {
    return notifier.build(
      posts,
    );
  }
}

typedef UserPostsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<PostData>>;

/// See also [UserPostsNotifier].
final userPostsNotifierProvider = UserPostsNotifierFamily();

class UserPostsNotifierFamily extends Family<AsyncValue<List<PostData>>> {
  UserPostsNotifierFamily();

  UserPostsNotifierProvider call(
    List<dynamic> posts,
  ) {
    return UserPostsNotifierProvider(
      posts,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<UserPostsNotifier, List<PostData>>
      getProviderOverride(
    covariant UserPostsNotifierProvider provider,
  ) {
    return call(
      provider.posts,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'userPostsNotifierProvider';
}

abstract class _$UserPostsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PostData>> {
  late final List<dynamic> posts;

  FutureOr<List<PostData>> build(
    List<dynamic> posts,
  );
}
