// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shifts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShiftsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftsState()';
}


}

/// @nodoc
class $ShiftsStateCopyWith<$Res>  {
$ShiftsStateCopyWith(ShiftsState _, $Res Function(ShiftsState) __);
}


/// Adds pattern-matching-related methods to [ShiftsState].
extension ShiftsStatePatterns on ShiftsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShiftsInitial value)?  initial,TResult Function( ShiftsLoading value)?  loading,TResult Function( ShiftsLoaded value)?  loaded,TResult Function( ShiftsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShiftsInitial() when initial != null:
return initial(_that);case ShiftsLoading() when loading != null:
return loading(_that);case ShiftsLoaded() when loaded != null:
return loaded(_that);case ShiftsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShiftsInitial value)  initial,required TResult Function( ShiftsLoading value)  loading,required TResult Function( ShiftsLoaded value)  loaded,required TResult Function( ShiftsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ShiftsInitial():
return initial(_that);case ShiftsLoading():
return loading(_that);case ShiftsLoaded():
return loaded(_that);case ShiftsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShiftsInitial value)?  initial,TResult? Function( ShiftsLoading value)?  loading,TResult? Function( ShiftsLoaded value)?  loaded,TResult? Function( ShiftsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ShiftsInitial() when initial != null:
return initial(_that);case ShiftsLoading() when loading != null:
return loading(_that);case ShiftsLoaded() when loaded != null:
return loaded(_that);case ShiftsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ShiftModel> shifts,  List<StaffModel> staff,  List<BranchModel> branches,  DateTime weekStart,  String searchQuery,  String selectedStatus,  String selectedBranchId,  String selectedStaffId,  bool isSubmitting,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShiftsInitial() when initial != null:
return initial();case ShiftsLoading() when loading != null:
return loading();case ShiftsLoaded() when loaded != null:
return loaded(_that.shifts,_that.staff,_that.branches,_that.weekStart,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.selectedStaffId,_that.isSubmitting,_that.errorMessage);case ShiftsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ShiftModel> shifts,  List<StaffModel> staff,  List<BranchModel> branches,  DateTime weekStart,  String searchQuery,  String selectedStatus,  String selectedBranchId,  String selectedStaffId,  bool isSubmitting,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ShiftsInitial():
return initial();case ShiftsLoading():
return loading();case ShiftsLoaded():
return loaded(_that.shifts,_that.staff,_that.branches,_that.weekStart,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.selectedStaffId,_that.isSubmitting,_that.errorMessage);case ShiftsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ShiftModel> shifts,  List<StaffModel> staff,  List<BranchModel> branches,  DateTime weekStart,  String searchQuery,  String selectedStatus,  String selectedBranchId,  String selectedStaffId,  bool isSubmitting,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ShiftsInitial() when initial != null:
return initial();case ShiftsLoading() when loading != null:
return loading();case ShiftsLoaded() when loaded != null:
return loaded(_that.shifts,_that.staff,_that.branches,_that.weekStart,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.selectedStaffId,_that.isSubmitting,_that.errorMessage);case ShiftsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ShiftsInitial implements ShiftsState {
  const ShiftsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftsState.initial()';
}


}




/// @nodoc


class ShiftsLoading implements ShiftsState {
  const ShiftsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftsState.loading()';
}


}




/// @nodoc


class ShiftsLoaded implements ShiftsState {
  const ShiftsLoaded({required final  List<ShiftModel> shifts, required final  List<StaffModel> staff, required final  List<BranchModel> branches, required this.weekStart, this.searchQuery = '', this.selectedStatus = 'all', this.selectedBranchId = 'all', this.selectedStaffId = 'all', this.isSubmitting = false, this.errorMessage = null}): _shifts = shifts,_staff = staff,_branches = branches;
  

 final  List<ShiftModel> _shifts;
 List<ShiftModel> get shifts {
  if (_shifts is EqualUnmodifiableListView) return _shifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shifts);
}

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

 final  DateTime weekStart;
@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedStatus;
@JsonKey() final  String selectedBranchId;
@JsonKey() final  String selectedStaffId;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  String? errorMessage;

/// Create a copy of ShiftsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiftsLoadedCopyWith<ShiftsLoaded> get copyWith => _$ShiftsLoadedCopyWithImpl<ShiftsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftsLoaded&&const DeepCollectionEquality().equals(other._shifts, _shifts)&&const DeepCollectionEquality().equals(other._staff, _staff)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId)&&(identical(other.selectedStaffId, selectedStaffId) || other.selectedStaffId == selectedStaffId)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shifts),const DeepCollectionEquality().hash(_staff),const DeepCollectionEquality().hash(_branches),weekStart,searchQuery,selectedStatus,selectedBranchId,selectedStaffId,isSubmitting,errorMessage);

@override
String toString() {
  return 'ShiftsState.loaded(shifts: $shifts, staff: $staff, branches: $branches, weekStart: $weekStart, searchQuery: $searchQuery, selectedStatus: $selectedStatus, selectedBranchId: $selectedBranchId, selectedStaffId: $selectedStaffId, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ShiftsLoadedCopyWith<$Res> implements $ShiftsStateCopyWith<$Res> {
  factory $ShiftsLoadedCopyWith(ShiftsLoaded value, $Res Function(ShiftsLoaded) _then) = _$ShiftsLoadedCopyWithImpl;
@useResult
$Res call({
 List<ShiftModel> shifts, List<StaffModel> staff, List<BranchModel> branches, DateTime weekStart, String searchQuery, String selectedStatus, String selectedBranchId, String selectedStaffId, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$ShiftsLoadedCopyWithImpl<$Res>
    implements $ShiftsLoadedCopyWith<$Res> {
  _$ShiftsLoadedCopyWithImpl(this._self, this._then);

  final ShiftsLoaded _self;
  final $Res Function(ShiftsLoaded) _then;

/// Create a copy of ShiftsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shifts = null,Object? staff = null,Object? branches = null,Object? weekStart = null,Object? searchQuery = null,Object? selectedStatus = null,Object? selectedBranchId = null,Object? selectedStaffId = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(ShiftsLoaded(
shifts: null == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<ShiftModel>,staff: null == staff ? _self._staff : staff // ignore: cast_nullable_to_non_nullable
as List<StaffModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,selectedBranchId: null == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String,selectedStaffId: null == selectedStaffId ? _self.selectedStaffId : selectedStaffId // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ShiftsFailure implements ShiftsState {
  const ShiftsFailure({required this.message});
  

 final  String message;

/// Create a copy of ShiftsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShiftsFailureCopyWith<ShiftsFailure> get copyWith => _$ShiftsFailureCopyWithImpl<ShiftsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ShiftsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ShiftsFailureCopyWith<$Res> implements $ShiftsStateCopyWith<$Res> {
  factory $ShiftsFailureCopyWith(ShiftsFailure value, $Res Function(ShiftsFailure) _then) = _$ShiftsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ShiftsFailureCopyWithImpl<$Res>
    implements $ShiftsFailureCopyWith<$Res> {
  _$ShiftsFailureCopyWithImpl(this._self, this._then);

  final ShiftsFailure _self;
  final $Res Function(ShiftsFailure) _then;

/// Create a copy of ShiftsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ShiftsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
