// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedicationsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicationsState()';
}


}

/// @nodoc
class $MedicationsStateCopyWith<$Res>  {
$MedicationsStateCopyWith(MedicationsState _, $Res Function(MedicationsState) __);
}


/// Adds pattern-matching-related methods to [MedicationsState].
extension MedicationsStatePatterns on MedicationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MedicationsInitial value)?  initial,TResult Function( MedicationsLoading value)?  loading,TResult Function( MedicationsLoaded value)?  loaded,TResult Function( MedicationsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MedicationsInitial() when initial != null:
return initial(_that);case MedicationsLoading() when loading != null:
return loading(_that);case MedicationsLoaded() when loaded != null:
return loaded(_that);case MedicationsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MedicationsInitial value)  initial,required TResult Function( MedicationsLoading value)  loading,required TResult Function( MedicationsLoaded value)  loaded,required TResult Function( MedicationsFailure value)  failure,}){
final _that = this;
switch (_that) {
case MedicationsInitial():
return initial(_that);case MedicationsLoading():
return loading(_that);case MedicationsLoaded():
return loaded(_that);case MedicationsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MedicationsInitial value)?  initial,TResult? Function( MedicationsLoading value)?  loading,TResult? Function( MedicationsLoaded value)?  loaded,TResult? Function( MedicationsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case MedicationsInitial() when initial != null:
return initial(_that);case MedicationsLoading() when loading != null:
return loading(_that);case MedicationsLoaded() when loaded != null:
return loaded(_that);case MedicationsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MedicationModel> medications,  String searchQuery,  String selectedCategory,  bool isSubmitting)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MedicationsInitial() when initial != null:
return initial();case MedicationsLoading() when loading != null:
return loading();case MedicationsLoaded() when loaded != null:
return loaded(_that.medications,_that.searchQuery,_that.selectedCategory,_that.isSubmitting);case MedicationsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MedicationModel> medications,  String searchQuery,  String selectedCategory,  bool isSubmitting)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case MedicationsInitial():
return initial();case MedicationsLoading():
return loading();case MedicationsLoaded():
return loaded(_that.medications,_that.searchQuery,_that.selectedCategory,_that.isSubmitting);case MedicationsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MedicationModel> medications,  String searchQuery,  String selectedCategory,  bool isSubmitting)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case MedicationsInitial() when initial != null:
return initial();case MedicationsLoading() when loading != null:
return loading();case MedicationsLoaded() when loaded != null:
return loaded(_that.medications,_that.searchQuery,_that.selectedCategory,_that.isSubmitting);case MedicationsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MedicationsInitial implements MedicationsState {
  const MedicationsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicationsState.initial()';
}


}




/// @nodoc


class MedicationsLoading implements MedicationsState {
  const MedicationsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicationsState.loading()';
}


}




/// @nodoc


class MedicationsLoaded implements MedicationsState {
  const MedicationsLoaded({required final  List<MedicationModel> medications, this.searchQuery = '', this.selectedCategory = 'all', this.isSubmitting = false}): _medications = medications;
  

 final  List<MedicationModel> _medications;
 List<MedicationModel> get medications {
  if (_medications is EqualUnmodifiableListView) return _medications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medications);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String selectedCategory;
@JsonKey() final  bool isSubmitting;

/// Create a copy of MedicationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationsLoadedCopyWith<MedicationsLoaded> get copyWith => _$MedicationsLoadedCopyWithImpl<MedicationsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationsLoaded&&const DeepCollectionEquality().equals(other._medications, _medications)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_medications),searchQuery,selectedCategory,isSubmitting);

@override
String toString() {
  return 'MedicationsState.loaded(medications: $medications, searchQuery: $searchQuery, selectedCategory: $selectedCategory, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $MedicationsLoadedCopyWith<$Res> implements $MedicationsStateCopyWith<$Res> {
  factory $MedicationsLoadedCopyWith(MedicationsLoaded value, $Res Function(MedicationsLoaded) _then) = _$MedicationsLoadedCopyWithImpl;
@useResult
$Res call({
 List<MedicationModel> medications, String searchQuery, String selectedCategory, bool isSubmitting
});




}
/// @nodoc
class _$MedicationsLoadedCopyWithImpl<$Res>
    implements $MedicationsLoadedCopyWith<$Res> {
  _$MedicationsLoadedCopyWithImpl(this._self, this._then);

  final MedicationsLoaded _self;
  final $Res Function(MedicationsLoaded) _then;

/// Create a copy of MedicationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? medications = null,Object? searchQuery = null,Object? selectedCategory = null,Object? isSubmitting = null,}) {
  return _then(MedicationsLoaded(
medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class MedicationsFailure implements MedicationsState {
  const MedicationsFailure({required this.message});
  

 final  String message;

/// Create a copy of MedicationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationsFailureCopyWith<MedicationsFailure> get copyWith => _$MedicationsFailureCopyWithImpl<MedicationsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MedicationsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $MedicationsFailureCopyWith<$Res> implements $MedicationsStateCopyWith<$Res> {
  factory $MedicationsFailureCopyWith(MedicationsFailure value, $Res Function(MedicationsFailure) _then) = _$MedicationsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MedicationsFailureCopyWithImpl<$Res>
    implements $MedicationsFailureCopyWith<$Res> {
  _$MedicationsFailureCopyWithImpl(this._self, this._then);

  final MedicationsFailure _self;
  final $Res Function(MedicationsFailure) _then;

/// Create a copy of MedicationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MedicationsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
