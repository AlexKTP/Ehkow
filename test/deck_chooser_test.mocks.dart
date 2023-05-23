// Mocks generated by Mockito 5.4.0 from annotations
// in ehkow/test/deck_chooser_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:ehkow/business/model/deck.dart' as _i4;
import 'package:ehkow/business/services/deck_service.dart' as _i2;
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

/// A class which mocks [DeckService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeckService extends _i1.Mock implements _i2.DeckService {
  @override
  _i3.Future<List<dynamic>> getDeckList() => (super.noSuchMethod(
        Invocation.method(
          #getDeckList,
          [],
        ),
        returnValue: _i3.Future<List<dynamic>>.value(<dynamic>[]),
        returnValueForMissingStub: _i3.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i3.Future<List<dynamic>>);
  @override
  _i3.Future<dynamic> getDeckById(int? deckId) => (super.noSuchMethod(
        Invocation.method(
          #getDeckById,
          [deckId],
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<void> deleteDeck(_i4.Deck? deck) => (super.noSuchMethod(
        Invocation.method(
          #deleteDeck,
          [deck],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
