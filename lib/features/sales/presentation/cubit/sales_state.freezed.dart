// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState()';
}


}

/// @nodoc
class $SalesStateCopyWith<$Res>  {
$SalesStateCopyWith(SalesState _, $Res Function(SalesState) __);
}


/// Adds pattern-matching-related methods to [SalesState].
extension SalesStatePatterns on SalesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SalesInitial value)?  initial,TResult Function( SalesLoading value)?  loading,TResult Function( SalesLoaded value)?  loaded,TResult Function( SalesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SalesInitial() when initial != null:
return initial(_that);case SalesLoading() when loading != null:
return loading(_that);case SalesLoaded() when loaded != null:
return loaded(_that);case SalesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SalesInitial value)  initial,required TResult Function( SalesLoading value)  loading,required TResult Function( SalesLoaded value)  loaded,required TResult Function( SalesFailure value)  failure,}){
final _that = this;
switch (_that) {
case SalesInitial():
return initial(_that);case SalesLoading():
return loading(_that);case SalesLoaded():
return loaded(_that);case SalesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SalesInitial value)?  initial,TResult? Function( SalesLoading value)?  loading,TResult? Function( SalesLoaded value)?  loaded,TResult? Function( SalesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SalesInitial() when initial != null:
return initial(_that);case SalesLoading() when loading != null:
return loading(_that);case SalesLoaded() when loaded != null:
return loaded(_that);case SalesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String? errorMessage,  List<SaleModel> sales,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  bool isSubmitting)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SalesInitial() when initial != null:
return initial();case SalesLoading() when loading != null:
return loading();case SalesLoaded() when loaded != null:
return loaded(_that.errorMessage,_that.sales,_that.medications,_that.branches,_that.searchQuery,_that.isSubmitting);case SalesFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String? errorMessage,  List<SaleModel> sales,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  bool isSubmitting)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case SalesInitial():
return initial();case SalesLoading():
return loading();case SalesLoaded():
return loaded(_that.errorMessage,_that.sales,_that.medications,_that.branches,_that.searchQuery,_that.isSubmitting);case SalesFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String? errorMessage,  List<SaleModel> sales,  List<MedicationModel> medications,  List<BranchModel> branches,  String searchQuery,  bool isSubmitting)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case SalesInitial() when initial != null:
return initial();case SalesLoading() when loading != null:
return loading();case SalesLoaded() when loaded != null:
return loaded(_that.errorMessage,_that.sales,_that.medications,_that.branches,_that.searchQuery,_that.isSubmitting);case SalesFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SalesInitial implements SalesState {
  const SalesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.initial()';
}


}




/// @nodoc


class SalesLoading implements SalesState {
  const SalesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.loading()';
}


}




/// @nodoc


class SalesLoaded implements SalesState {
  const SalesLoaded({this.errorMessage = null, required final  List<SaleModel> sales, required final  List<MedicationModel> medications, required final  List<BranchModel> branches, this.searchQuery = '', this.isSubmitting = false}): _sales = sales,_medications = medications,_branches = branches;
  

@JsonKey() final  String? errorMessage;
 final  List<SaleModel> _sales;
 List<SaleModel> get sales {
  if (_sales is EqualUnmodifiableListView) return _sales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sales);
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
@JsonKey() final  bool isSubmitting;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLoadedCopyWith<SalesLoaded> get copyWith => _$SalesLoadedCopyWithImpl<SalesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoaded&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._sales, _sales)&&const DeepCollectionEquality().equals(other._medications, _medications)&&const DeepCollectionEquality().equals(other._branches, _branches)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,const DeepCollectionEquality().hash(_sales),const DeepCollectionEquality().hash(_medications),const DeepCollectionEquality().hash(_branches),searchQuery,isSubmitting);

@override
String toString() {
  return 'SalesState.loaded(errorMessage: $errorMessage, sales: $sales, medications: $medications, branches: $branches, searchQuery: $searchQuery, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $SalesLoadedCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesLoadedCopyWith(SalesLoaded value, $Res Function(SalesLoaded) _then) = _$SalesLoadedCopyWithImpl;
@useResult
$Res call({
 String? errorMessage, List<SaleModel> sales, List<MedicationModel> medications, List<BranchModel> branches, String searchQuery, bool isSubmitting
});




}
/// @nodoc
class _$SalesLoadedCopyWithImpl<$Res>
    implements $SalesLoadedCopyWith<$Res> {
  _$SalesLoadedCopyWithImpl(this._self, this._then);

  final SalesLoaded _self;
  final $Res Function(SalesLoaded) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = freezed,Object? sales = null,Object? medications = null,Object? branches = null,Object? searchQuery = null,Object? isSubmitting = null,}) {
  return _then(SalesLoaded(
errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,sales: null == sales ? _self._sales : sales // ignore: cast_nullable_to_non_nullable
as List<SaleModel>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SalesFailure implements SalesState {
  const SalesFailure({required this.message});
  

 final  String message;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesFailureCopyWith<SalesFailure> get copyWith => _$SalesFailureCopyWithImpl<SalesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SalesState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SalesFailureCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesFailureCopyWith(SalesFailure value, $Res Function(SalesFailure) _then) = _$SalesFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SalesFailureCopyWithImpl<$Res>
    implements $SalesFailureCopyWith<$Res> {
  _$SalesFailureCopyWithImpl(this._self, this._then);

  final SalesFailure _self;
  final $Res Function(SalesFailure) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SalesFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
