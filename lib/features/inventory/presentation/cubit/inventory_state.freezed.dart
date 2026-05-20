// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryState()';
}


}

/// @nodoc
class $InventoryStateCopyWith<$Res>  {
$InventoryStateCopyWith(InventoryState _, $Res Function(InventoryState) __);
}


/// Adds pattern-matching-related methods to [InventoryState].
extension InventoryStatePatterns on InventoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InventoryInitial value)?  initial,TResult Function( InventoryLoading value)?  loading,TResult Function( InventoryLoaded value)?  loaded,TResult Function( InventoryFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InventoryInitial() when initial != null:
return initial(_that);case InventoryLoading() when loading != null:
return loading(_that);case InventoryLoaded() when loaded != null:
return loaded(_that);case InventoryFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InventoryInitial value)  initial,required TResult Function( InventoryLoading value)  loading,required TResult Function( InventoryLoaded value)  loaded,required TResult Function( InventoryFailure value)  failure,}){
final _that = this;
switch (_that) {
case InventoryInitial():
return initial(_that);case InventoryLoading():
return loading(_that);case InventoryLoaded():
return loaded(_that);case InventoryFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InventoryInitial value)?  initial,TResult? Function( InventoryLoading value)?  loading,TResult? Function( InventoryLoaded value)?  loaded,TResult? Function( InventoryFailure value)?  failure,}){
final _that = this;
switch (_that) {
case InventoryInitial() when initial != null:
return initial(_that);case InventoryLoading() when loading != null:
return loading(_that);case InventoryLoaded() when loaded != null:
return loaded(_that);case InventoryFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<InventoryModel> inventory,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedBranchId,  String selectedStockStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InventoryInitial() when initial != null:
return initial();case InventoryLoading() when loading != null:
return loading();case InventoryLoaded() when loaded != null:
return loaded(_that.inventory,_that.medications,_that.branches,_that.searchQuery,_that.selectedBranchId,_that.selectedStockStatus,_that.isSubmitting,_that.errorMessage);case InventoryFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<InventoryModel> inventory,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedBranchId,  String selectedStockStatus,  bool isSubmitting,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case InventoryInitial():
return initial();case InventoryLoading():
return loading();case InventoryLoaded():
return loaded(_that.inventory,_that.medications,_that.branches,_that.searchQuery,_that.selectedBranchId,_that.selectedStockStatus,_that.isSubmitting,_that.errorMessage);case InventoryFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<InventoryModel> inventory,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedBranchId,  String selectedStockStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case InventoryInitial() when initial != null:
return initial();case InventoryLoading() when loading != null:
return loading();case InventoryLoaded() when loaded != null:
return loaded(_that.inventory,_that.medications,_that.branches,_that.searchQuery,_that.selectedBranchId,_that.selectedStockStatus,_that.isSubmitting,_that.errorMessage);case InventoryFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InventoryInitial implements InventoryState {
  const InventoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryState.initial()';
}


}




/// @nodoc


class InventoryLoading implements InventoryState {
  const InventoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryState.loading()';
}


}




/// @nodoc


class InventoryLoaded implements InventoryState {
  const InventoryLoaded({required final  List<InventoryModel> inventory, required final  List<MedicationModel> medications, required final  List<BranchModel> branches, this.searchQuery = '', this.selectedBranchId = 'all', this.selectedStockStatus = 'all', this.isSubmitting = false, this.errorMessage = null}): _inventory = inventory,_medications = medications,_branches = branches;
  

 final  List<InventoryModel> _inventory;
 List<InventoryModel> get inventory {
  if (_inventory is EqualUnmodifiableListView) return _inventory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inventory);
}

 final  List<MedicationModel> _medications;
 List<MedicationModel> get medications {
  if (_medications is EqualUnmodifiableListView) return _medications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medications);
}

 final  List<BranchModel> _branches;
 List<BranchModel> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedBranchId;
@JsonKey() final  String selectedStockStatus;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  String? errorMessage;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryLoadedCopyWith<InventoryLoaded> get copyWith => _$InventoryLoadedCopyWithImpl<InventoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryLoaded&&const DeepCollectionEquality().equals(other._inventory, _inventory)&&const DeepCollectionEquality().equals(other._medications, _medications)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId)&&(identical(other.selectedStockStatus, selectedStockStatus) || other.selectedStockStatus == selectedStockStatus)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inventory),const DeepCollectionEquality().hash(_medications),const DeepCollectionEquality().hash(_branches),searchQuery,selectedBranchId,selectedStockStatus,isSubmitting,errorMessage);

@override
String toString() {
  return 'InventoryState.loaded(inventory: $inventory, medications: $medications, branches: $branches, searchQuery: $searchQuery, selectedBranchId: $selectedBranchId, selectedStockStatus: $selectedStockStatus, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $InventoryLoadedCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory $InventoryLoadedCopyWith(InventoryLoaded value, $Res Function(InventoryLoaded) _then) = _$InventoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<InventoryModel> inventory, List<MedicationModel> medications, List<BranchModel> branches, String searchQuery, String selectedBranchId, String selectedStockStatus, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$InventoryLoadedCopyWithImpl<$Res>
    implements $InventoryLoadedCopyWith<$Res> {
  _$InventoryLoadedCopyWithImpl(this._self, this._then);

  final InventoryLoaded _self;
  final $Res Function(InventoryLoaded) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inventory = null,Object? medications = null,Object? branches = null,Object? searchQuery = null,Object? selectedBranchId = null,Object? selectedStockStatus = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(InventoryLoaded(
inventory: null == inventory ? _self._inventory : inventory // ignore: cast_nullable_to_non_nullable
as List<InventoryModel>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedBranchId: null == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String,selectedStockStatus: null == selectedStockStatus ? _self.selectedStockStatus : selectedStockStatus // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class InventoryFailure implements InventoryState {
  const InventoryFailure({required this.message});
  

 final  String message;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryFailureCopyWith<InventoryFailure> get copyWith => _$InventoryFailureCopyWithImpl<InventoryFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'InventoryState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $InventoryFailureCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory $InventoryFailureCopyWith(InventoryFailure value, $Res Function(InventoryFailure) _then) = _$InventoryFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InventoryFailureCopyWithImpl<$Res>
    implements $InventoryFailureCopyWith<$Res> {
  _$InventoryFailureCopyWithImpl(this._self, this._then);

  final InventoryFailure _self;
  final $Res Function(InventoryFailure) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InventoryFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
