// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prescriptions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrescriptionsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PrescriptionsState()';
}


}

/// @nodoc
class $PrescriptionsStateCopyWith<$Res>  {
$PrescriptionsStateCopyWith(PrescriptionsState _, $Res Function(PrescriptionsState) __);
}


/// Adds pattern-matching-related methods to [PrescriptionsState].
extension PrescriptionsStatePatterns on PrescriptionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PrescriptionsInitial value)?  initial,TResult Function( PrescriptionsLoading value)?  loading,TResult Function( PrescriptionsLoaded value)?  loaded,TResult Function( PrescriptionsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PrescriptionsInitial() when initial != null:
return initial(_that);case PrescriptionsLoading() when loading != null:
return loading(_that);case PrescriptionsLoaded() when loaded != null:
return loaded(_that);case PrescriptionsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PrescriptionsInitial value)  initial,required TResult Function( PrescriptionsLoading value)  loading,required TResult Function( PrescriptionsLoaded value)  loaded,required TResult Function( PrescriptionsFailure value)  failure,}){
final _that = this;
switch (_that) {
case PrescriptionsInitial():
return initial(_that);case PrescriptionsLoading():
return loading(_that);case PrescriptionsLoaded():
return loaded(_that);case PrescriptionsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PrescriptionsInitial value)?  initial,TResult? Function( PrescriptionsLoading value)?  loading,TResult? Function( PrescriptionsLoaded value)?  loaded,TResult? Function( PrescriptionsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PrescriptionsInitial() when initial != null:
return initial(_that);case PrescriptionsLoading() when loading != null:
return loading(_that);case PrescriptionsLoaded() when loaded != null:
return loaded(_that);case PrescriptionsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PrescriptionModel> prescriptions,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PrescriptionsInitial() when initial != null:
return initial();case PrescriptionsLoading() when loading != null:
return loading();case PrescriptionsLoaded() when loaded != null:
return loaded(_that.prescriptions,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case PrescriptionsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PrescriptionModel> prescriptions,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case PrescriptionsInitial():
return initial();case PrescriptionsLoading():
return loading();case PrescriptionsLoaded():
return loaded(_that.prescriptions,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case PrescriptionsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PrescriptionModel> prescriptions,  List<BranchModel> branches,  List<MedicationModel> medications,  String searchQuery,  String selectedStatus,  bool isSubmitting,  String? errorMessage)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case PrescriptionsInitial() when initial != null:
return initial();case PrescriptionsLoading() when loading != null:
return loading();case PrescriptionsLoaded() when loaded != null:
return loaded(_that.prescriptions,_that.branches,_that.medications,_that.searchQuery,_that.selectedStatus,_that.isSubmitting,_that.errorMessage);case PrescriptionsFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PrescriptionsInitial implements PrescriptionsState {
  const PrescriptionsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PrescriptionsState.initial()';
}


}




/// @nodoc


class PrescriptionsLoading implements PrescriptionsState {
  const PrescriptionsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PrescriptionsState.loading()';
}


}




/// @nodoc


class PrescriptionsLoaded implements PrescriptionsState {
  const PrescriptionsLoaded({required final  List<PrescriptionModel> prescriptions, required final  List<BranchModel> branches, required final  List<MedicationModel> medications, this.searchQuery = '', this.selectedStatus = 'all', this.isSubmitting = false, this.errorMessage = null}): _prescriptions = prescriptions,_branches = branches,_medications = medications;
  

 final  List<PrescriptionModel> _prescriptions;
 List<PrescriptionModel> get prescriptions {
  if (_prescriptions is EqualUnmodifiableListView) return _prescriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prescriptions);
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
@JsonKey() final  bool isSubmitting;
@JsonKey() final  String? errorMessage;

/// Create a copy of PrescriptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrescriptionsLoadedCopyWith<PrescriptionsLoaded> get copyWith => _$PrescriptionsLoadedCopyWithImpl<PrescriptionsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionsLoaded&&const DeepCollectionEquality().equals(other._prescriptions, _prescriptions)&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._medications, _medications)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_prescriptions),const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_medications),searchQuery,selectedStatus,isSubmitting,errorMessage);

@override
String toString() {
  return 'PrescriptionsState.loaded(prescriptions: $prescriptions, branches: $branches, medications: $medications, searchQuery: $searchQuery, selectedStatus: $selectedStatus, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PrescriptionsLoadedCopyWith<$Res> implements $PrescriptionsStateCopyWith<$Res> {
  factory $PrescriptionsLoadedCopyWith(PrescriptionsLoaded value, $Res Function(PrescriptionsLoaded) _then) = _$PrescriptionsLoadedCopyWithImpl;
@useResult
$Res call({
 List<PrescriptionModel> prescriptions, List<BranchModel> branches, List<MedicationModel> medications, String searchQuery, String selectedStatus, bool isSubmitting, String? errorMessage
});




}
/// @nodoc
class _$PrescriptionsLoadedCopyWithImpl<$Res>
    implements $PrescriptionsLoadedCopyWith<$Res> {
  _$PrescriptionsLoadedCopyWithImpl(this._self, this._then);

  final PrescriptionsLoaded _self;
  final $Res Function(PrescriptionsLoaded) _then;

/// Create a copy of PrescriptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? prescriptions = null,Object? branches = null,Object? medications = null,Object? searchQuery = null,Object? selectedStatus = null,Object? isSubmitting = null,Object? errorMessage = freezed,}) {
  return _then(PrescriptionsLoaded(
prescriptions: null == prescriptions ? _self._prescriptions : prescriptions // ignore: cast_nullable_to_non_nullable
as List<PrescriptionModel>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<BranchModel>,medications: null == medications ? _self._medications : medications // ignore: cast_nullable_to_non_nullable
as List<MedicationModel>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class PrescriptionsFailure implements PrescriptionsState {
  const PrescriptionsFailure({required this.message});
  

 final  String message;

/// Create a copy of PrescriptionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrescriptionsFailureCopyWith<PrescriptionsFailure> get copyWith => _$PrescriptionsFailureCopyWithImpl<PrescriptionsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrescriptionsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PrescriptionsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PrescriptionsFailureCopyWith<$Res> implements $PrescriptionsStateCopyWith<$Res> {
  factory $PrescriptionsFailureCopyWith(PrescriptionsFailure value, $Res Function(PrescriptionsFailure) _then) = _$PrescriptionsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PrescriptionsFailureCopyWithImpl<$Res>
    implements $PrescriptionsFailureCopyWith<$Res> {
  _$PrescriptionsFailureCopyWithImpl(this._self, this._then);

  final PrescriptionsFailure _self;
  final $Res Function(PrescriptionsFailure) _then;

/// Create a copy of PrescriptionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PrescriptionsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
