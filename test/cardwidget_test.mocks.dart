// Mocks generated by Mockito 5.4.0 from annotations
// in ehkow/test/cardwidget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:ehkow/business/data/flashcard_repository.dart' as _i3;
import 'package:ehkow/business/model/flashcard.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFlashCard_0 extends _i1.SmartFake implements _i2.FlashCard {
  _FakeFlashCard_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FlashCardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlashCardRepository extends _i1.Mock
    implements _i3.FlashCardRepository {
  @override
  _i4.Future<int> create(dynamic entity) => (super.noSuchMethod(
        Invocation.method(
          #create,
          [entity],
        ),
        returnValue: _i4.Future<int>.value(0),
        returnValueForMissingStub: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<_i2.FlashCard> findById(dynamic id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _i4.Future<_i2.FlashCard>.value(_FakeFlashCard_0(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.FlashCard>.value(_FakeFlashCard_0(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.FlashCard>);
  @override
  _i4.Future<void> delete(dynamic entity) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [entity],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i2.FlashCard>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i4.Future<List<_i2.FlashCard>>.value(<_i2.FlashCard>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.FlashCard>>.value(<_i2.FlashCard>[]),
      ) as _i4.Future<List<_i2.FlashCard>>);
  @override
  _i4.Future<List<dynamic>> getAllByDeckId(dynamic id) => (super.noSuchMethod(
        Invocation.method(
          #getAllByDeckId,
          [id],
        ),
        returnValue: _i4.Future<List<dynamic>>.value(<dynamic>[]),
        returnValueForMissingStub: _i4.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i4.Future<List<dynamic>>);
  @override
  _i4.Future<int> update(dynamic entity) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [entity],
        ),
        returnValue: _i4.Future<int>.value(0),
        returnValueForMissingStub: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<int?> rowCount() => (super.noSuchMethod(
        Invocation.method(
          #rowCount,
          [],
        ),
        returnValue: _i4.Future<int?>.value(),
        returnValueForMissingStub: _i4.Future<int?>.value(),
      ) as _i4.Future<int?>);
}
