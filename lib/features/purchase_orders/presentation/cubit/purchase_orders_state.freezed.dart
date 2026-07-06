// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseOrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseOrdersState()';
}


}

/// @nodoc
class $PurchaseOrdersStateCopyWith<$Res>  {
$PurchaseOrdersStateCopyWith(PurchaseOrdersState _, $Res Function(PurchaseOrdersState) __);
}


/// Adds pattern-matching-related methods to [PurchaseOrdersState].
extension PurchaseOrdersStatePatterns on PurchaseOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PurchaseOrdersInitial value)?  initial,TResult Function( PurchaseOrdersLoading value)?  loading,TResult Function( PurchaseOrdersLoaded value)?  loaded,TResult Function( PurchaseOrdersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PurchaseOrdersInitial() when initial != null:
return initial(_that);case PurchaseOrdersLoading() when loading != null:
return loading(_that);case PurchaseOrdersLoaded() when loaded != null:
return loaded(_that);case PurchaseOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PurchaseOrdersInitial value)  initial,required TResult Function( PurchaseOrdersLoading value)  loading,required TResult Function( PurchaseOrdersLoaded value)  loaded,required TResult Function( PurchaseOrdersFailure value)  failure,}){
final _that = this;
switch (_that) {
case PurchaseOrdersInitial():
return initial(_that);case PurchaseOrdersLoading():
return loading(_that);case PurchaseOrdersLoaded():
return loaded(_that);case PurchaseOrdersFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PurchaseOrdersInitial value)?  initial,TResult? Function( PurchaseOrdersLoading value)?  loading,TResult? Function( PurchaseOrdersLoaded value)?  loaded,TResult? Function( PurchaseOrdersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PurchaseOrdersInitial() when initial != null:
return initial(_that);case PurchaseOrdersLoading() when loading != null:
return loading(_that);case PurchaseOrdersLoaded() when loaded != null:
return loaded(_that);case PurchaseOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PurchaseOrderModel> purchaseOrders,  List<SupplierModel> suppliers,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  String selectedBranchId,  bool isSubmitting,  bool isLoadingMore,  bool hasMore,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PurchaseOrdersInitial() when initial != null:
return initial();case PurchaseOrdersLoading() when loading != null:
return loading();case PurchaseOrdersLoaded() when loaded != null:
return loaded(_that.purchaseOrders,_that.suppliers,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.isSubmitting,_that.isLoadingMore,_that.hasMore,_that.errorMessage);case PurchaseOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PurchaseOrderModel> purchaseOrders,  List<SupplierModel> suppliers,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  String selectedBranchId,  bool isSubmitting,  bool isLoadingMore,  bool hasMore,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case PurchaseOrdersInitial():
return initial();case PurchaseOrdersLoading():
return loading();case PurchaseOrdersLoaded():
return loaded(_that.purchaseOrders,_that.suppliers,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.isSubmitting,_that.isLoadingMore,_that.hasMore,_that.errorMessage);case PurchaseOrdersFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PurchaseOrderModel> purchaseOrders,  List<SupplierModel> suppliers,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  String selectedBranchId,  bool isSubmitting,  bool isLoadingMore,  bool hasMore,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case PurchaseOrdersInitial() when initial != null:
return initial();case PurchaseOrdersLoading() when loading != null:
return loading();case PurchaseOrdersLoaded() when loaded != null:
return loaded(_that.purchaseOrders,_that.suppliers,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.selectedBranchId,_that.isSubmitting,_that.isLoadingMore,_that.hasMore,_that.errorMessage);case PurchaseOrdersFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PurchaseOrdersInitial implements PurchaseOrdersState {
  const PurchaseOrdersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrdersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseOrdersState.initial()';
}


}




/// @nodoc


class PurchaseOrdersLoading implements PurchaseOrdersState {
  const PurchaseOrdersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PurchaseOrdersState.loading()';
}


}




/// @nodoc


class PurchaseOrdersLoaded implements PurchaseOrdersState {
  const PurchaseOrdersLoaded({required final  List<PurchaseOrderModel> purchaseOrders, required final  List<SupplierModel> suppliers, required final  List<BranchModel> branches, required final  List<MedicationModel> medications, this.searchQuery = '', this.selectedStatus = 'all', this.selectedBranchId = 'all', this.isSubmitting = false, this.isLoadingMore = false, this.hasMore = true, this.errorMessage = null}): _purchaseOrders = purchaseOrders,_suppliers = suppliers,_branches = branches,_medications = medications;
  

 final  List<PurchaseOrderModel> _purchaseOrders;
 List<PurchaseOrderModel> get purchaseOrders {
  if (_purchaseOrders is EqualUnmodifiableListView) return _purchaseOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchaseOrders);
}

 final  List<SupplierModel> _suppliers;
 List<SupplierModel> get suppliers {
  if (_suppliers is EqualUnmodifiableListView) return _suppliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suppliers);
}

 final  List<BranchModel> _branches;
 List<BranchModel> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

 final  List<MedicationModel> _medications;
 List<MedicationModel> get medications {
  if (_medications is EqualUnmodifiableListView) return _medications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medications);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedStatus;
@JsonKey() final  String selectedBranchId;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  bool isLoadingMore;
@JsonKey() final  bool hasMore;
@JsonKey() final  String? errorMessage;

/// Create a copy of PurchaseOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOrdersLoadedCopyWith<PurchaseOrdersLoaded> get copyWith => _$PurchaseOrdersLoadedCopyWithImpl<PurchaseOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrdersLoaded&&const DeepCollectionEquality().equals(other._purchaseOrders, _purchaseOrders)&&const DeepCollectionEquality().equals(other._suppliers, _suppliers)&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._medications, _medications)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_purchaseOrders),const DeepCollectionEquality().hash(_suppliers),const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_medications),searchQuery,selectedStatus,selectedBranchId,isSubmitting,isLoadingMore,hasMore,errorMessage);

@override
String toString() {
  return 'PurchaseOrdersState.loaded(purchaseOrders: $purchaseOrders, suppliers: $suppliers, branches: $branches, medications: $medications, searchQuery: $searchQuery, selectedStatus: $selectedStatus, selectedBranchId: $selectedBranchId, isSubmitting: $isSubmitting, isLoadingMore: $isLoadingMore, hasMore: $hasMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PurchaseOrdersLoadedCopyWith<$Res> implements $PurchaseOrdersStateCopyWith<$Res> {
  factory $PurchaseOrdersLoadedCopyWith(PurchaseOrdersLoaded value, $Res Function(PurchaseOrdersLoaded) _then) = _$PurchaseOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<PurchaseOrderModel> purchaseOrders, List<SupplierModel> suppliers, List<BranchModel> branches, List<MedicationModel> medications, String searchQuery, String selectedStatus, String selectedBranchId, bool isSubmitting, bool isLoadingMore, bool hasMore, String? errorMessage
});




}
/// @nodoc
class _$PurchaseOrdersLoadedCopyWithImpl<$Res>
    implements $PurchaseOrdersLoadedCopyWith<$Res> {
  _$PurchaseOrdersLoadedCopyWithImpl(this._self, this._then);

  final PurchaseOrdersLoaded _self;
  final $Res Function(PurchaseOrdersLoaded) _then;

/// Create a copy of PurchaseOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? purchaseOrders = null,Object? suppliers = null,Object? branches = null,Object? medications = null,Object? searchQuery = null,Object? selectedStatus = null,Object? selectedBranchId = null,Object? isSubmitting = null,Object? isLoadingMore = null,Object? hasMore = null,Object? errorMessage = freezed,}) {
  return _then(PurchaseOrdersLoaded(
purchaseOrders: null == purchaseOrders ? _self._purchaseOrders : purchaseOrders // ignore: cast_nullable_to_non_nullable
as List<PurchaseOrderModel>,suppliers: null == suppliers ? _self._suppliers : suppliers // ignore: cast_nullable_to_non_nullable
as List<SupplierModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,selectedBranchId: null == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PurchaseOrdersFailure implements PurchaseOrdersState {
  const PurchaseOrdersFailure({required this.message});
  

 final  String message;

/// Create a copy of PurchaseOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOrdersFailureCopyWith<PurchaseOrdersFailure> get copyWith => _$PurchaseOrdersFailureCopyWithImpl<PurchaseOrdersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrdersFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PurchaseOrdersState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PurchaseOrdersFailureCopyWith<$Res> implements $PurchaseOrdersStateCopyWith<$Res> {
  factory $PurchaseOrdersFailureCopyWith(PurchaseOrdersFailure value, $Res Function(PurchaseOrdersFailure) _then) = _$PurchaseOrdersFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PurchaseOrdersFailureCopyWithImpl<$Res>
    implements $PurchaseOrdersFailureCopyWith<$Res> {
  _$PurchaseOrdersFailureCopyWithImpl(this._self, this._then);

  final PurchaseOrdersFailure _self;
  final $Res Function(PurchaseOrdersFailure) _then;

/// Create a copy of PurchaseOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PurchaseOrdersFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
