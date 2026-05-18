// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState()';
}


}

/// @nodoc
class $ReportsStateCopyWith<$Res>  {
$ReportsStateCopyWith(ReportsState _, $Res Function(ReportsState) __);
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsInitial value)?  initial,TResult Function( ReportsLoading value)?  loading,TResult Function( ReportsLoaded value)?  loaded,TResult Function( ReportsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsInitial value)  initial,required TResult Function( ReportsLoading value)  loading,required TResult Function( ReportsLoaded value)  loaded,required TResult Function( ReportsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial():
return initial(_that);case ReportsLoading():
return loading(_that);case ReportsLoaded():
return loaded(_that);case ReportsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsInitial value)?  initial,TResult? Function( ReportsLoading value)?  loading,TResult? Function( ReportsLoaded value)?  loaded,TResult? Function( ReportsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ReportsSummaryModel summary,  List<BranchModel> branches,  String selectedBranchId)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.summary,_that.branches,_that.selectedBranchId);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ReportsSummaryModel summary,  List<BranchModel> branches,  String selectedBranchId)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial():
return initial();case ReportsLoading():
return loading();case ReportsLoaded():
return loaded(_that.summary,_that.branches,_that.selectedBranchId);case ReportsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ReportsSummaryModel summary,  List<BranchModel> branches,  String selectedBranchId)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.summary,_that.branches,_that.selectedBranchId);case ReportsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ReportsInitial implements ReportsState {
  const ReportsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.initial()';
}


}




/// @nodoc


class ReportsLoading implements ReportsState {
  const ReportsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsState.loading()';
}


}




/// @nodoc


class ReportsLoaded implements ReportsState {
  const ReportsLoaded({required this.summary, required final  List<BranchModel> branches, this.selectedBranchId = 'all'}): _branches = branches;
  

 final  ReportsSummaryModel summary;
 final  List<BranchModel> _branches;
 List<BranchModel> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

@JsonKey() final  String selectedBranchId;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsLoadedCopyWith<ReportsLoaded> get copyWith => _$ReportsLoadedCopyWithImpl<ReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoaded&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_branches),selectedBranchId);

@override
String toString() {
  return 'ReportsState.loaded(summary: $summary, branches: $branches, selectedBranchId: $selectedBranchId)';
}


}

/// @nodoc
abstract mixin class $ReportsLoadedCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsLoadedCopyWith(ReportsLoaded value, $Res Function(ReportsLoaded) _then) = _$ReportsLoadedCopyWithImpl;
@useResult
$Res call({
 ReportsSummaryModel summary, List<BranchModel> branches, String selectedBranchId
});




}
/// @nodoc
class _$ReportsLoadedCopyWithImpl<$Res>
    implements $ReportsLoadedCopyWith<$Res> {
  _$ReportsLoadedCopyWithImpl(this._self, this._then);

  final ReportsLoaded _self;
  final $Res Function(ReportsLoaded) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? branches = null,Object? selectedBranchId = null,}) {
  return _then(ReportsLoaded(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ReportsSummaryModel,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,selectedBranchId: null == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReportsFailure implements ReportsState {
  const ReportsFailure({required this.message});
  

 final  String message;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFailureCopyWith<ReportsFailure> get copyWith => _$ReportsFailureCopyWithImpl<ReportsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ReportsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ReportsFailureCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsFailureCopyWith(ReportsFailure value, $Res Function(ReportsFailure) _then) = _$ReportsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ReportsFailureCopyWithImpl<$Res>
    implements $ReportsFailureCopyWith<$Res> {
  _$ReportsFailureCopyWithImpl(this._self, this._then);

  final ReportsFailure _self;
  final $Res Function(ReportsFailure) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ReportsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
