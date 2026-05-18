// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaffState()';
}


}

/// @nodoc
class $StaffStateCopyWith<$Res>  {
$StaffStateCopyWith(StaffState _, $Res Function(StaffState) __);
}


/// Adds pattern-matching-related methods to [StaffState].
extension StaffStatePatterns on StaffState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StaffInitial value)?  initial,TResult Function( StaffLoading value)?  loading,TResult Function( StaffLoaded value)?  loaded,TResult Function( StaffFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StaffInitial() when initial != null:
return initial(_that);case StaffLoading() when loading != null:
return loading(_that);case StaffLoaded() when loaded != null:
return loaded(_that);case StaffFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StaffInitial value)  initial,required TResult Function( StaffLoading value)  loading,required TResult Function( StaffLoaded value)  loaded,required TResult Function( StaffFailure value)  failure,}){
final _that = this;
switch (_that) {
case StaffInitial():
return initial(_that);case StaffLoading():
return loading(_that);case StaffLoaded():
return loaded(_that);case StaffFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StaffInitial value)?  initial,TResult? Function( StaffLoading value)?  loading,TResult? Function( StaffLoaded value)?  loaded,TResult? Function( StaffFailure value)?  failure,}){
final _that = this;
switch (_that) {
case StaffInitial() when initial != null:
return initial(_that);case StaffLoading() when loading != null:
return loading(_that);case StaffLoaded() when loaded != null:
return loaded(_that);case StaffFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<StaffModel> staff,  List<BranchModel> branches,  String searchQuery,  String selectedRole,  bool isSubmitting)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StaffInitial() when initial != null:
return initial();case StaffLoading() when loading != null:
return loading();case StaffLoaded() when loaded != null:
return loaded(_that.staff,_that.branches,_that.searchQuery,_that.selectedRole,_that.isSubmitting);case StaffFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<StaffModel> staff,  List<BranchModel> branches,  String searchQuery,  String selectedRole,  bool isSubmitting)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case StaffInitial():
return initial();case StaffLoading():
return loading();case StaffLoaded():
return loaded(_that.staff,_that.branches,_that.searchQuery,_that.selectedRole,_that.isSubmitting);case StaffFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<StaffModel> staff,  List<BranchModel> branches,  String searchQuery,  String selectedRole,  bool isSubmitting)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case StaffInitial() when initial != null:
return initial();case StaffLoading() when loading != null:
return loading();case StaffLoaded() when loaded != null:
return loaded(_that.staff,_that.branches,_that.searchQuery,_that.selectedRole,_that.isSubmitting);case StaffFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class StaffInitial implements StaffState {
  const StaffInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaffState.initial()';
}


}




/// @nodoc


class StaffLoading implements StaffState {
  const StaffLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StaffState.loading()';
}


}




/// @nodoc


class StaffLoaded implements StaffState {
  const StaffLoaded({required final  List<StaffModel> staff, required final  List<BranchModel> branches, this.searchQuery = '', this.selectedRole = 'all', this.isSubmitting = false}): _staff = staff,_branches = branches;
  

 final  List<StaffModel> _staff;
 List<StaffModel> get staff {
  if (_staff is EqualUnmodifiableListView) return _staff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_staff);
}

 final  List<BranchModel> _branches;
 List<BranchModel> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedRole;
@JsonKey() final  bool isSubmitting;

/// Create a copy of StaffState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffLoadedCopyWith<StaffLoaded> get copyWith => _$StaffLoadedCopyWithImpl<StaffLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffLoaded&&const DeepCollectionEquality().equals(other._staff, _staff)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedRole, selectedRole) || other.selectedRole == selectedRole)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_staff),const DeepCollectionEquality().hash(_branches),searchQuery,selectedRole,isSubmitting);

@override
String toString() {
  return 'StaffState.loaded(staff: $staff, branches: $branches, searchQuery: $searchQuery, selectedRole: $selectedRole, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $StaffLoadedCopyWith<$Res> implements $StaffStateCopyWith<$Res> {
  factory $StaffLoadedCopyWith(StaffLoaded value, $Res Function(StaffLoaded) _then) = _$StaffLoadedCopyWithImpl;
@useResult
$Res call({
 List<StaffModel> staff, List<BranchModel> branches, String searchQuery, String selectedRole, bool isSubmitting
});




}
/// @nodoc
class _$StaffLoadedCopyWithImpl<$Res>
    implements $StaffLoadedCopyWith<$Res> {
  _$StaffLoadedCopyWithImpl(this._self, this._then);

  final StaffLoaded _self;
  final $Res Function(StaffLoaded) _then;

/// Create a copy of StaffState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? staff = null,Object? branches = null,Object? searchQuery = null,Object? selectedRole = null,Object? isSubmitting = null,}) {
  return _then(StaffLoaded(
staff: null == staff ? _self._staff : staff // ignore: cast_nullable_to_non_nullable
as List<StaffModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedRole: null == selectedRole ? _self.selectedRole : selectedRole // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StaffFailure implements StaffState {
  const StaffFailure({required this.message});
  

 final  String message;

/// Create a copy of StaffState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffFailureCopyWith<StaffFailure> get copyWith => _$StaffFailureCopyWithImpl<StaffFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StaffState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $StaffFailureCopyWith<$Res> implements $StaffStateCopyWith<$Res> {
  factory $StaffFailureCopyWith(StaffFailure value, $Res Function(StaffFailure) _then) = _$StaffFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StaffFailureCopyWithImpl<$Res>
    implements $StaffFailureCopyWith<$Res> {
  _$StaffFailureCopyWithImpl(this._self, this._then);

  final StaffFailure _self;
  final $Res Function(StaffFailure) _then;

/// Create a copy of StaffState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StaffFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
