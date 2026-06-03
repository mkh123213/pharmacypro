// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_movements_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockMovementsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockMovementsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockMovementsState()';
}


}

/// @nodoc
class $StockMovementsStateCopyWith<$Res>  {
$StockMovementsStateCopyWith(StockMovementsState _, $Res Function(StockMovementsState) __);
}


/// Adds pattern-matching-related methods to [StockMovementsState].
extension StockMovementsStatePatterns on StockMovementsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StockMovementsInitial value)?  initial,TResult Function( StockMovementsLoading value)?  loading,TResult Function( StockMovementsLoaded value)?  loaded,TResult Function( StockMovementsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StockMovementsInitial() when initial != null:
return initial(_that);case StockMovementsLoading() when loading != null:
return loading(_that);case StockMovementsLoaded() when loaded != null:
return loaded(_that);case StockMovementsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StockMovementsInitial value)  initial,required TResult Function( StockMovementsLoading value)  loading,required TResult Function( StockMovementsLoaded value)  loaded,required TResult Function( StockMovementsFailure value)  failure,}){
final _that = this;
switch (_that) {
case StockMovementsInitial():
return initial(_that);case StockMovementsLoading():
return loading(_that);case StockMovementsLoaded():
return loaded(_that);case StockMovementsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StockMovementsInitial value)?  initial,TResult? Function( StockMovementsLoading value)?  loading,TResult? Function( StockMovementsLoaded value)?  loaded,TResult? Function( StockMovementsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case StockMovementsInitial() when initial != null:
return initial(_that);case StockMovementsLoading() when loading != null:
return loading(_that);case StockMovementsLoaded() when loaded != null:
return loaded(_that);case StockMovementsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<StockMovementModel> movements,  List<StockMovementModel> filteredMovements,  String searchQuery,  String selectedType)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StockMovementsInitial() when initial != null:
return initial();case StockMovementsLoading() when loading != null:
return loading();case StockMovementsLoaded() when loaded != null:
return loaded(_that.movements,_that.filteredMovements,_that.searchQuery,_that.selectedType);case StockMovementsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<StockMovementModel> movements,  List<StockMovementModel> filteredMovements,  String searchQuery,  String selectedType)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case StockMovementsInitial():
return initial();case StockMovementsLoading():
return loading();case StockMovementsLoaded():
return loaded(_that.movements,_that.filteredMovements,_that.searchQuery,_that.selectedType);case StockMovementsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<StockMovementModel> movements,  List<StockMovementModel> filteredMovements,  String searchQuery,  String selectedType)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case StockMovementsInitial() when initial != null:
return initial();case StockMovementsLoading() when loading != null:
return loading();case StockMovementsLoaded() when loaded != null:
return loaded(_that.movements,_that.filteredMovements,_that.searchQuery,_that.selectedType);case StockMovementsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class StockMovementsInitial implements StockMovementsState {
  const StockMovementsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockMovementsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockMovementsState.initial()';
}


}




/// @nodoc


class StockMovementsLoading implements StockMovementsState {
  const StockMovementsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockMovementsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockMovementsState.loading()';
}


}




/// @nodoc


class StockMovementsLoaded implements StockMovementsState {
  const StockMovementsLoaded({required final  List<StockMovementModel> movements, required final  List<StockMovementModel> filteredMovements, this.searchQuery = '', this.selectedType = 'all'}): _movements = movements,_filteredMovements = filteredMovements;
  

 final  List<StockMovementModel> _movements;
 List<StockMovementModel> get movements {
  if (_movements is EqualUnmodifiableListView) return _movements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movements);
}

 final  List<StockMovementModel> _filteredMovements;
 List<StockMovementModel> get filteredMovements {
  if (_filteredMovements is EqualUnmodifiableListView) return _filteredMovements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredMovements);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedType;

/// Create a copy of StockMovementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockMovementsLoadedCopyWith<StockMovementsLoaded> get copyWith => _$StockMovementsLoadedCopyWithImpl<StockMovementsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockMovementsLoaded&&const DeepCollectionEquality().equals(other._movements, _movements)&&const DeepCollectionEquality().equals(other._filteredMovements, _filteredMovements)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_movements),const DeepCollectionEquality().hash(_filteredMovements),searchQuery,selectedType);

@override
String toString() {
  return 'StockMovementsState.loaded(movements: $movements, filteredMovements: $filteredMovements, searchQuery: $searchQuery, selectedType: $selectedType)';
}


}

/// @nodoc
abstract mixin class $StockMovementsLoadedCopyWith<$Res> implements $StockMovementsStateCopyWith<$Res> {
  factory $StockMovementsLoadedCopyWith(StockMovementsLoaded value, $Res Function(StockMovementsLoaded) _then) = _$StockMovementsLoadedCopyWithImpl;
@useResult
$Res call({
 List<StockMovementModel> movements, List<StockMovementModel> filteredMovements, String searchQuery, String selectedType
});




}
/// @nodoc
class _$StockMovementsLoadedCopyWithImpl<$Res>
    implements $StockMovementsLoadedCopyWith<$Res> {
  _$StockMovementsLoadedCopyWithImpl(this._self, this._then);

  final StockMovementsLoaded _self;
  final $Res Function(StockMovementsLoaded) _then;

/// Create a copy of StockMovementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movements = null,Object? filteredMovements = null,Object? searchQuery = null,Object? selectedType = null,}) {
  return _then(StockMovementsLoaded(
movements: null == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<StockMovementModel>,filteredMovements: null == filteredMovements ? _self._filteredMovements : filteredMovements // ignore: cast_nullable_to_non_nullable
as List<StockMovementModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StockMovementsFailure implements StockMovementsState {
  const StockMovementsFailure({required this.message});
  

 final  String message;

/// Create a copy of StockMovementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockMovementsFailureCopyWith<StockMovementsFailure> get copyWith => _$StockMovementsFailureCopyWithImpl<StockMovementsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockMovementsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StockMovementsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $StockMovementsFailureCopyWith<$Res> implements $StockMovementsStateCopyWith<$Res> {
  factory $StockMovementsFailureCopyWith(StockMovementsFailure value, $Res Function(StockMovementsFailure) _then) = _$StockMovementsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StockMovementsFailureCopyWithImpl<$Res>
    implements $StockMovementsFailureCopyWith<$Res> {
  _$StockMovementsFailureCopyWithImpl(this._self, this._then);

  final StockMovementsFailure _self;
  final $Res Function(StockMovementsFailure) _then;

/// Create a copy of StockMovementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StockMovementsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
