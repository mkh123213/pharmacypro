// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerOrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState()';
}


}

/// @nodoc
class $CustomerOrdersStateCopyWith<$Res>  {
$CustomerOrdersStateCopyWith(CustomerOrdersState _, $Res Function(CustomerOrdersState) __);
}


/// Adds pattern-matching-related methods to [CustomerOrdersState].
extension CustomerOrdersStatePatterns on CustomerOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CustomerOrdersInitial value)?  initial,TResult Function( CustomerOrdersLoading value)?  loading,TResult Function( CustomerOrdersLoaded value)?  loaded,TResult Function( CustomerOrdersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial(_that);case CustomerOrdersLoading() when loading != null:
return loading(_that);case CustomerOrdersLoaded() when loaded != null:
return loaded(_that);case CustomerOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CustomerOrdersInitial value)  initial,required TResult Function( CustomerOrdersLoading value)  loading,required TResult Function( CustomerOrdersLoaded value)  loaded,required TResult Function( CustomerOrdersFailure value)  failure,}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial():
return initial(_that);case CustomerOrdersLoading():
return loading(_that);case CustomerOrdersLoaded():
return loaded(_that);case CustomerOrdersFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CustomerOrdersInitial value)?  initial,TResult? Function( CustomerOrdersLoading value)?  loading,TResult? Function( CustomerOrdersLoaded value)?  loaded,TResult? Function( CustomerOrdersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial(_that);case CustomerOrdersLoading() when loading != null:
return loading(_that);case CustomerOrdersLoaded() when loaded != null:
return loaded(_that);case CustomerOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CustomerOrderModel> orders,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedStatus,  bool isSubmitting)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial();case CustomerOrdersLoading() when loading != null:
return loading();case CustomerOrdersLoaded() when loaded != null:
return loaded(_that.orders,_that.medications,_that.branches,_that.searchQuery,_that.selectedStatus,_that.isSubmitting);case CustomerOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CustomerOrderModel> orders,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedStatus,  bool isSubmitting)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial():
return initial();case CustomerOrdersLoading():
return loading();case CustomerOrdersLoaded():
return loaded(_that.orders,_that.medications,_that.branches,_that.searchQuery,_that.selectedStatus,_that.isSubmitting);case CustomerOrdersFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CustomerOrderModel> orders,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  String selectedStatus,  bool isSubmitting)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial();case CustomerOrdersLoading() when loading != null:
return loading();case CustomerOrdersLoaded() when loaded != null:
return loaded(_that.orders,_that.medications,_that.branches,_that.searchQuery,_that.selectedStatus,_that.isSubmitting);case CustomerOrdersFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CustomerOrdersInitial implements CustomerOrdersState {
  const CustomerOrdersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState.initial()';
}


}




/// @nodoc


class CustomerOrdersLoading implements CustomerOrdersState {
  const CustomerOrdersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState.loading()';
}


}




/// @nodoc


class CustomerOrdersLoaded implements CustomerOrdersState {
  const CustomerOrdersLoaded({required final  List<CustomerOrderModel> orders, required final  List<MedicationModel> medications, required final  List<BranchModel> branches, this.searchQuery = '', this.selectedStatus = 'all', this.isSubmitting = false}): _orders = orders,_medications = medications,_branches = branches;
  

 final  List<CustomerOrderModel> _orders;
 List<CustomerOrderModel> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
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
@JsonKey() final  String selectedStatus;
@JsonKey() final  bool isSubmitting;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrdersLoadedCopyWith<CustomerOrdersLoaded> get copyWith => _$CustomerOrdersLoadedCopyWithImpl<CustomerOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersLoaded&&const DeepCollectionEquality().equals(other._orders, _orders)&&const DeepCollectionEquality().equals(other._medications, _medications)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),const DeepCollectionEquality().hash(_medications),const DeepCollectionEquality().hash(_branches),searchQuery,selectedStatus,isSubmitting);

@override
String toString() {
  return 'CustomerOrdersState.loaded(orders: $orders, medications: $medications, branches: $branches, searchQuery: $searchQuery, selectedStatus: $selectedStatus, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $CustomerOrdersLoadedCopyWith<$Res> implements $CustomerOrdersStateCopyWith<$Res> {
  factory $CustomerOrdersLoadedCopyWith(CustomerOrdersLoaded value, $Res Function(CustomerOrdersLoaded) _then) = _$CustomerOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<CustomerOrderModel> orders, List<MedicationModel> medications, List<BranchModel> branches, String searchQuery, String selectedStatus, bool isSubmitting
});




}
/// @nodoc
class _$CustomerOrdersLoadedCopyWithImpl<$Res>
    implements $CustomerOrdersLoadedCopyWith<$Res> {
  _$CustomerOrdersLoadedCopyWithImpl(this._self, this._then);

  final CustomerOrdersLoaded _self;
  final $Res Function(CustomerOrdersLoaded) _then;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? medications = null,Object? branches = null,Object? searchQuery = null,Object? selectedStatus = null,Object? isSubmitting = null,}) {
  return _then(CustomerOrdersLoaded(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<CustomerOrderModel>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CustomerOrdersFailure implements CustomerOrdersState {
  const CustomerOrdersFailure({required this.message});
  

 final  String message;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrdersFailureCopyWith<CustomerOrdersFailure> get copyWith => _$CustomerOrdersFailureCopyWithImpl<CustomerOrdersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CustomerOrdersState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CustomerOrdersFailureCopyWith<$Res> implements $CustomerOrdersStateCopyWith<$Res> {
  factory $CustomerOrdersFailureCopyWith(CustomerOrdersFailure value, $Res Function(CustomerOrdersFailure) _then) = _$CustomerOrdersFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CustomerOrdersFailureCopyWithImpl<$Res>
    implements $CustomerOrdersFailureCopyWith<$Res> {
  _$CustomerOrdersFailureCopyWithImpl(this._self, this._then);

  final CustomerOrdersFailure _self;
  final $Res Function(CustomerOrdersFailure) _then;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CustomerOrdersFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
