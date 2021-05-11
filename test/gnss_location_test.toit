// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file.

import expect show *
import gnss_location show GnssLocation
import location show Location

main:
  lat := 10.21437
  lon := 56.15901
  loc ::= Location lat lon
  height ::= 20.0
  time ::= Time.epoch --s=10000 --ns=1000
  hacc ::= 210.0
  vacc ::= 430.0

  gnss_loc ::= GnssLocation loc height time hacc vacc

  expect_equals lat gnss_loc.latitude
  expect_equals lon gnss_loc.longitude
  expect_equals height gnss_loc.altitude_msl
  expect_equals time gnss_loc.time
  expect_equals hacc gnss_loc.horizontal_accuracy
  expect_equals vacc gnss_loc.vertical_accuracy

  gnss_loc_deserialized ::= GnssLocation.deserialize gnss_loc.to_byte_array
  expect gnss_loc_deserialized == gnss_loc
