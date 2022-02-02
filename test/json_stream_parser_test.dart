// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library json_stream_parser.test;

import 'dart:async';
import 'dart:convert' as dart_convert;
import 'dart:typed_data';
import 'dart:core';
import 'package:collection/collection.dart';
import 'package:json_stream_parser/json_stream_parser.dart';
import 'package:test/test.dart';

void main() {
  test('basic test', () async {
    List<String> chunks = [];
    int chunkSize = 10;
    var letters = TEST_STRING.split("");
    for (var i = 0; i < letters.length; i += chunkSize) {
      var broken_chunk = letters.sublist(i, i+chunkSize > letters.length ? letters.length : i + chunkSize); 
      chunks.add(broken_chunk.join());
    }
    final stream = Stream.fromIterable(chunks + chunks + chunks).transform(ContinuousJsonDecoder());
    stream.listen(
      (data) => {
        print('Is equal?: ' + DeepCollectionEquality().equals(data, dart_convert.jsonDecode(TEST_STRING)).toString())
      }
    );
    await Future.delayed(Duration(seconds: 1));
  });
}

const TEST_STRING = r'''{
    "_id": "56088d4fd91cc0b3a010bfde",
    "index": 0,
    "guid": "f7b9afd6-77ce-49ad-9d36-96a4502773dc",
    "isActive": true,
    "balance": "$1,811.87",
    "picture": "http://placehold.it/32x32",
    "age": 28,
    "eyeColor": "blue",
    "name": "Pollard Robinson",
    "gender": "male",
    "company": "ZOSIS",
    "email": "pollardrobinson@zosis.com",
    "phone": "+1 (923) 491-2189",
    "address": "860 Varanda Place, Lawrence, New York, 9963",
    "about": "Dolore nostrud amet occaecat minim occaecat\nlabore anim excepteur aliquip\u25e2\"tempor aliqua magna. Eu cupidatat aliqua officia do sunt. Voluptate dolore veniam cillum minim ex elit exercitation tempor laboris magna.\r\n",
    "registered": "2014-05-23T11:31:33 +07:00",
    "latitude": -35.311561,
    "longitude": 142.474102,
    "tags": [
      "id",
      "consectetur",
      "Lorem",
      "exercitation",
      "aliquip",
      "incididunt",
      "reprehenderit"
    ],
    "friends": [
      [{
        "id": 0,
        "name": "Deborah Hyde"
      }],
      [{
        "id": 1,
        "name": "Morris Rutledge"
      }],
      [{
        "id": 2,
        "name": "Cristina Reed"
      }]
    ],
    "greeting": "Hello, Pollard Robinson! You have 8 unread messages.",
    "favoriteFruit": "strawberry"
  }
''';
