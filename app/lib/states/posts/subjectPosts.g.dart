// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjectPosts.dart';

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

String _$SubjectPostsNotifierHash() =>
    r'57dfc7af85ed3dcee76d472da2337dbca4b57d96';

/// See also [SubjectPostsNotifier].
class SubjectPostsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SubjectPostsNotifier, List<PostData>> {
  SubjectPostsNotifierProvider(
    this.subject,
  ) : super(
          () => SubjectPostsNotifier()..subject = subject,
          from: subjectPostsNotifierProvider,
          name: r'subjectPostsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$SubjectPostsNotifierHash,
        );

  final dynamic subject;

  @override
  bool operator ==(Object other) {
    return other is SubjectPostsNotifierProvider && other.subject == subject;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subject.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<PostData>> runNotifierBuild(
    covariant _$SubjectPostsNotifier notifier,
  ) {
    return notifier.build(
      subject,
    );
  }
}

typedef SubjectPostsNotifierRef
    = AutoDisposeAsyncNotifierProviderRef<List<PostData>>;

/// See also [SubjectPostsNotifier].
final subjectPostsNotifierProvider = SubjectPostsNotifierFamily();

class SubjectPostsNotifierFamily extends Family<AsyncValue<List<PostData>>> {
  SubjectPostsNotifierFamily();

  SubjectPostsNotifierProvider call(
    dynamic subject,
  ) {
    return SubjectPostsNotifierProvider(
      subject,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<SubjectPostsNotifier, List<PostData>>
      getProviderOverride(
    covariant SubjectPostsNotifierProvider provider,
  ) {
    return call(
      provider.subject,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'subjectPostsNotifierProvider';
}

abstract class _$SubjectPostsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PostData>> {
  late final dynamic subject;

  FutureOr<List<PostData>> build(
    dynamic subject,
  );
}
