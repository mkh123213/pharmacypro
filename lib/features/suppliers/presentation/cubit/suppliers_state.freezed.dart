// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suppliers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SuppliersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SuppliersState()';
}


}

/// @nodoc
class $SuppliersStateCopyWith<$Res>  {
$SuppliersStateCopyWith(SuppliersState _, $Res Function(SuppliersState) __);
}


/// Adds pattern-matching-related methods to [SuppliersState].
extension SuppliersStatePatterns on SuppliersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SuppliersInitial value)?  initial,TResult Function( SuppliersLoading value)?  loading,TResult Function( SuppliersLoaded value)?  loaded,TResult Function( SuppliersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SuppliersInitial() when initial != null:
return initial(_that);case SuppliersLoading() when loading != null:
return loading(_that);case SuppliersLoaded() when loaded != null:
return loaded(_that);case SuppliersFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SuppliersInitial value)  initial,required TResult Function( SuppliersLoading value)  loading,required TResult Function( SuppliersLoaded value)  loaded,required TResult Function( SuppliersFailure value)  failure,}){
final _that = this;
switch (_that) {
case SuppliersInitial():
return initial(_that);case SuppliersLoading():
return loading(_that);case SuppliersLoaded():
return loaded(_that);case SuppliersFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SuppliersInitial value)?  initial,TResult? Function( SuppliersLoading value)?  loading,TResult? Function( SuppliersLoaded value)?  loaded,TResult? Function( SuppliersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SuppliersInitial() when initial != null:
return initial(_that);case SuppliersLoading() when loading != null:
return loading(_that);case SuppliersLoaded() when loaded != null:
return loaded(_that);case SuppliersFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<SupplierModel> suppliers,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SuppliersInitial() when initial != null:
return initial();case SuppliersLoading() when loading != null:
return loading();case SuppliersLoaded() when loaded != null:
return loaded(_that.suppliers,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case SuppliersFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<SupplierModel> suppliers,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SuppliersInitial():
return initial();case SuppliersLoading():
return loading();case SuppliersLoaded():
return loaded(_that.suppliers,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case SuppliersFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<SupplierModel> suppliers,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SuppliersInitial() when initial != null:
return initial();case SuppliersLoading() when loading != null:
return loading();case SuppliersLoaded() when loaded != null:
return loaded(_that.suppliers,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case SuppliersFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SuppliersInitial implements SuppliersState {
  const SuppliersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SuppliersState.initial()';
}


}




/// @nodoc


class SuppliersLoading implements SuppliersState {
  const SuppliersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SuppliersState.loading()';
}


}




/// @nodoc


class SuppliersLoaded implements SuppliersState {
  const SuppliersLoaded({required final  List<SupplierModel> suppliers, this.searchQuery = '', this.selectedStatus = 'all', this.isSubmitting = false, this.errorMessage = null}): _suppliers = suppliers;
  

 final  List<SupplierModel> _suppliers;
 List<SupplierModel> get suppliers {
  if (_suppliers is EqualUnmodifiableListView) return _suppliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suppliers);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedStatus;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  String? errorMessage;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuppliersLoadedCopyWith<SuppliersLoaded> get copyWith => _$SuppliersLoadedCopyWithImpl<SuppliersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersLoaded&&const DeepCollectionEquality().equals(other._suppliers, _suppliers)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suppliers),searchQuery,selectedStatus,isSubmitting,errorMessage);

@override
String toString() {
  return 'SuppliersState.loaded(suppliers: $suppliers, searchQuery: $searchQuery, selectedStatus: $selectedStatus, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuppliersLoadedCopyWith<$Res> implements $SuppliersStateCopyWith<$Res> {
  factory $SuppliersLoadedCopyWith(SuppliersLoaded value, $Res Function(SuppliersLoaded) _then) = _$SuppliersLoadedCopyWithImpl;
@useResult
$Res call({
 List<SupplierModel> suppliers, String searchQuery, String selectedStatus, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$SuppliersLoadedCopyWithImpl<$Res>
    implements $SuppliersLoadedCopyWith<$Res> {
  _$SuppliersLoadedCopyWithImpl(this._self, this._then);

  final SuppliersLoaded _self;
  final $Res Function(SuppliersLoaded) _then;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? suppliers = null,Object? searchQuery = null,Object? selectedStatus = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(SuppliersLoaded(
suppliers: null == suppliers ? _self._suppliers : suppliers // ignore: cast_nullable_to_non_nullable
as List<SupplierModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SuppliersFailure implements SuppliersState {
  const SuppliersFailure({required this.message});
  

 final  String message;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuppliersFailureCopyWith<SuppliersFailure> get copyWith => _$SuppliersFailureCopyWithImpl<SuppliersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuppliersFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SuppliersState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SuppliersFailureCopyWith<$Res> implements $SuppliersStateCopyWith<$Res> {
  factory $SuppliersFailureCopyWith(SuppliersFailure value, $Res Function(SuppliersFailure) _then) = _$SuppliersFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SuppliersFailureCopyWithImpl<$Res>
    implements $SuppliersFailureCopyWith<$Res> {
  _$SuppliersFailureCopyWithImpl(this._self, this._then);

  final SuppliersFailure _self;
  final $Res Function(SuppliersFailure) _then;

/// Create a copy of SuppliersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SuppliersFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
