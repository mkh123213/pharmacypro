// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branches_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BranchesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BranchesState()';
}


}

/// @nodoc
class $BranchesStateCopyWith<$Res>  {
$BranchesStateCopyWith(BranchesState _, $Res Function(BranchesState) __);
}


/// Adds pattern-matching-related methods to [BranchesState].
extension BranchesStatePatterns on BranchesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BranchesInitial value)?  initial,TResult Function( BranchesLoading value)?  loading,TResult Function( BranchesLoaded value)?  loaded,TResult Function( BranchesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BranchesInitial() when initial != null:
return initial(_that);case BranchesLoading() when loading != null:
return loading(_that);case BranchesLoaded() when loaded != null:
return loaded(_that);case BranchesFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BranchesInitial value)  initial,required TResult Function( BranchesLoading value)  loading,required TResult Function( BranchesLoaded value)  loaded,required TResult Function( BranchesFailure value)  failure,}){
final _that = this;
switch (_that) {
case BranchesInitial():
return initial(_that);case BranchesLoading():
return loading(_that);case BranchesLoaded():
return loaded(_that);case BranchesFailure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BranchesInitial value)?  initial,TResult? Function( BranchesLoading value)?  loading,TResult? Function( BranchesLoaded value)?  loaded,TResult? Function( BranchesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BranchesInitial() when initial != null:
return initial(_that);case BranchesLoading() when loading != null:
return loading(_that);case BranchesLoaded() when loaded != null:
return loaded(_that);case BranchesFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<BranchModel> branches,  bool isSubmitting)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BranchesInitial() when initial != null:
return initial();case BranchesLoading() when loading != null:
return loading();case BranchesLoaded() when loaded != null:
return loaded(_that.branches,_that.isSubmitting);case BranchesFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<BranchModel> branches,  bool isSubmitting)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case BranchesInitial():
return initial();case BranchesLoading():
return loading();case BranchesLoaded():
return loaded(_that.branches,_that.isSubmitting);case BranchesFailure():
return failure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<BranchModel> branches,  bool isSubmitting)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case BranchesInitial() when initial != null:
return initial();case BranchesLoading() when loading != null:
return loading();case BranchesLoaded() when loaded != null:
return loaded(_that.branches,_that.isSubmitting);case BranchesFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BranchesInitial implements BranchesState {
  const BranchesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BranchesState.initial()';
}


}




/// @nodoc


class BranchesLoading implements BranchesState {
  const BranchesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BranchesState.loading()';
}


}




/// @nodoc


class BranchesLoaded implements BranchesState {
  const BranchesLoaded({required final  List<BranchModel> branches, this.isSubmitting = false}): _branches = branches;
  

 final  List<BranchModel> _branches;
 List<BranchModel> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

@JsonKey() final  bool isSubmitting;

/// Create a copy of BranchesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchesLoadedCopyWith<BranchesLoaded> get copyWith => _$BranchesLoadedCopyWithImpl<BranchesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesLoaded&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_branches),isSubmitting);

@override
String toString() {
  return 'BranchesState.loaded(branches: $branches, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $BranchesLoadedCopyWith<$Res> implements $BranchesStateCopyWith<$Res> {
  factory $BranchesLoadedCopyWith(BranchesLoaded value, $Res Function(BranchesLoaded) _then) = _$BranchesLoadedCopyWithImpl;
@useResult
$Res call({
 List<BranchModel> branches, bool isSubmitting
});




}
/// @nodoc
class _$BranchesLoadedCopyWithImpl<$Res>
    implements $BranchesLoadedCopyWith<$Res> {
  _$BranchesLoadedCopyWithImpl(this._self, this._then);

  final BranchesLoaded _self;
  final $Res Function(BranchesLoaded) _then;

/// Create a copy of BranchesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? branches = null,Object? isSubmitting = null,}) {
  return _then(BranchesLoaded(
branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class BranchesFailure implements BranchesState {
  const BranchesFailure({required this.message});
  

 final  String message;

/// Create a copy of BranchesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchesFailureCopyWith<BranchesFailure> get copyWith => _$BranchesFailureCopyWithImpl<BranchesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchesFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BranchesState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $BranchesFailureCopyWith<$Res> implements $BranchesStateCopyWith<$Res> {
  factory $BranchesFailureCopyWith(BranchesFailure value, $Res Function(BranchesFailure) _then) = _$BranchesFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BranchesFailureCopyWithImpl<$Res>
    implements $BranchesFailureCopyWith<$Res> {
  _$BranchesFailureCopyWithImpl(this._self, this._then);

  final BranchesFailure _self;
  final $Res Function(BranchesFailure) _then;

/// Create a copy of BranchesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BranchesFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
