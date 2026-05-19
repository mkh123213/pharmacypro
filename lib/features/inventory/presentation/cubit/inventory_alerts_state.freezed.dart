// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_alerts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryAlertsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryAlertsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryAlertsState()';
}


}

/// @nodoc
class $InventoryAlertsStateCopyWith<$Res>  {
$InventoryAlertsStateCopyWith(InventoryAlertsState _, $Res Function(InventoryAlertsState) __);
}


/// Adds pattern-matching-related methods to [InventoryAlertsState].
extension InventoryAlertsStatePatterns on InventoryAlertsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InventoryAlertsInitial value)?  initial,TResult Function( InventoryAlertsLoading value)?  loading,TResult Function( InventoryAlertsLoaded value)?  loaded,TResult Function( InventoryAlertsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InventoryAlertsInitial() when initial != null:
return initial(_that);case InventoryAlertsLoading() when loading != null:
return loading(_that);case InventoryAlertsLoaded() when loaded != null:
return loaded(_that);case InventoryAlertsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InventoryAlertsInitial value)  initial,required TResult Function( InventoryAlertsLoading value)  loading,required TResult Function( InventoryAlertsLoaded value)  loaded,required TResult Function( InventoryAlertsFailure value)  failure,}){
final _that = this;
switch (_that) {
case InventoryAlertsInitial():
return initial(_that);case InventoryAlertsLoading():
return loading(_that);case InventoryAlertsLoaded():
return loaded(_that);case InventoryAlertsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InventoryAlertsInitial value)?  initial,TResult? Function( InventoryAlertsLoading value)?  loading,TResult? Function( InventoryAlertsLoaded value)?  loaded,TResult? Function( InventoryAlertsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case InventoryAlertsInitial() when initial != null:
return initial(_that);case InventoryAlertsLoading() when loading != null:
return loading(_that);case InventoryAlertsLoaded() when loaded != null:
return loaded(_that);case InventoryAlertsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<InventoryAlertModel> alerts,  List<InventoryAlertModel> filteredAlerts,  String selectedType,  String searchQuery,  bool isSubmitting,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InventoryAlertsInitial() when initial != null:
return initial();case InventoryAlertsLoading() when loading != null:
return loading();case InventoryAlertsLoaded() when loaded != null:
return loaded(_that.alerts,_that.filteredAlerts,_that.selectedType,_that.searchQuery,_that.isSubmitting,_that.errorMessage);case InventoryAlertsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<InventoryAlertModel> alerts,  List<InventoryAlertModel> filteredAlerts,  String selectedType,  String searchQuery,  bool isSubmitting,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case InventoryAlertsInitial():
return initial();case InventoryAlertsLoading():
return loading();case InventoryAlertsLoaded():
return loaded(_that.alerts,_that.filteredAlerts,_that.selectedType,_that.searchQuery,_that.isSubmitting,_that.errorMessage);case InventoryAlertsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<InventoryAlertModel> alerts,  List<InventoryAlertModel> filteredAlerts,  String selectedType,  String searchQuery,  bool isSubmitting,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case InventoryAlertsInitial() when initial != null:
return initial();case InventoryAlertsLoading() when loading != null:
return loading();case InventoryAlertsLoaded() when loaded != null:
return loaded(_that.alerts,_that.filteredAlerts,_that.selectedType,_that.searchQuery,_that.isSubmitting,_that.errorMessage);case InventoryAlertsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InventoryAlertsInitial implements InventoryAlertsState {
  const InventoryAlertsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryAlertsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryAlertsState.initial()';
}


}




/// @nodoc


class InventoryAlertsLoading implements InventoryAlertsState {
  const InventoryAlertsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryAlertsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryAlertsState.loading()';
}


}




/// @nodoc


class InventoryAlertsLoaded implements InventoryAlertsState {
  const InventoryAlertsLoaded({required final  List<InventoryAlertModel> alerts, required final  List<InventoryAlertModel> filteredAlerts, this.selectedType = 'all', this.searchQuery = '', this.isSubmitting = false, this.errorMessage = null}): _alerts = alerts,_filteredAlerts = filteredAlerts;
  

 final  List<InventoryAlertModel> _alerts;
 List<InventoryAlertModel> get alerts {
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alerts);
}

 final  List<InventoryAlertModel> _filteredAlerts;
 List<InventoryAlertModel> get filteredAlerts {
  if (_filteredAlerts is EqualUnmodifiableListView) return _filteredAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredAlerts);
}

@JsonKey() final  String selectedType;
@JsonKey() final  String searchQuery;
@JsonKey() final  bool isSubmitting;
@JsonKey() final  String? errorMessage;

/// Create a copy of InventoryAlertsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryAlertsLoadedCopyWith<InventoryAlertsLoaded> get copyWith => _$InventoryAlertsLoadedCopyWithImpl<InventoryAlertsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryAlertsLoaded&&const DeepCollectionEquality().equals(other._alerts, _alerts)&&const DeepCollectionEquality().equals(other._filteredAlerts, _filteredAlerts)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_alerts),const DeepCollectionEquality().hash(_filteredAlerts),selectedType,searchQuery,isSubmitting,errorMessage);

@override
String toString() {
  return 'InventoryAlertsState.loaded(alerts: $alerts, filteredAlerts: $filteredAlerts, selectedType: $selectedType, searchQuery: $searchQuery, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $InventoryAlertsLoadedCopyWith<$Res> implements $InventoryAlertsStateCopyWith<$Res> {
  factory $InventoryAlertsLoadedCopyWith(InventoryAlertsLoaded value, $Res Function(InventoryAlertsLoaded) _then) = _$InventoryAlertsLoadedCopyWithImpl;
@useResult
$Res call({
 List<InventoryAlertModel> alerts, List<InventoryAlertModel> filteredAlerts, String selectedType, String searchQuery, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$InventoryAlertsLoadedCopyWithImpl<$Res>
    implements $InventoryAlertsLoadedCopyWith<$Res> {
  _$InventoryAlertsLoadedCopyWithImpl(this._self, this._then);

  final InventoryAlertsLoaded _self;
  final $Res Function(InventoryAlertsLoaded) _then;

/// Create a copy of InventoryAlertsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alerts = null,Object? filteredAlerts = null,Object? selectedType = null,Object? searchQuery = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(InventoryAlertsLoaded(
alerts: null == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<InventoryAlertModel>,filteredAlerts: null == filteredAlerts ? _self._filteredAlerts : filteredAlerts // ignore: cast_nullable_to_non_nullable
as List<InventoryAlertModel>,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class InventoryAlertsFailure implements InventoryAlertsState {
  const InventoryAlertsFailure({required this.message});
  

 final  String message;

/// Create a copy of InventoryAlertsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryAlertsFailureCopyWith<InventoryAlertsFailure> get copyWith => _$InventoryAlertsFailureCopyWithImpl<InventoryAlertsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryAlertsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'InventoryAlertsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $InventoryAlertsFailureCopyWith<$Res> implements $InventoryAlertsStateCopyWith<$Res> {
  factory $InventoryAlertsFailureCopyWith(InventoryAlertsFailure value, $Res Function(InventoryAlertsFailure) _then) = _$InventoryAlertsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InventoryAlertsFailureCopyWithImpl<$Res>
    implements $InventoryAlertsFailureCopyWith<$Res> {
  _$InventoryAlertsFailureCopyWithImpl(this._self, this._then);

  final InventoryAlertsFailure _self;
  final $Res Function(InventoryAlertsFailure) _then;

/// Create a copy of InventoryAlertsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InventoryAlertsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
