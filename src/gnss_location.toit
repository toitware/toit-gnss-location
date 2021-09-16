// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be found
// in the LICENSE file.

import location show Location
import serialization

/**
Support for Global Navigation Satellite System (GNSS) locations.
*/

/**
A  Globale Navigation Satellite System (GNSS) location.

A GNSS location is comprised of a location, an altitude, a time, and
  an accuracy of the given location.
*/
class GnssLocation extends Location:
  /** The time (UTC) when this location was recorded. */
  time/Time
  /** The horizontal accuracy. */
  horizontal_accuracy/float ::= 0.0
  /** The vertical accuracy. */
  vertical_accuracy/float ::= 0.0
  /** The altitude relative to the median sea level. */
  altitude_msl/float ::= 0.0

  /** Constructs a GNSS location from the given parameters. */
  constructor location .altitude_msl .time .horizontal_accuracy .vertical_accuracy:
    super location.latitude location.longitude


  /**
  Constructs a GNSS location from the given bytes.

  This is the inverse operation of $to_byte_array.
  */
  constructor.deserialize bytes/ByteArray?:
    values := serialization.deserialize bytes
    return GnssLocation
      Location values[0] values[1]
      values[2]
      Time.deserialize values[3]
      values[4]
      values[5]

  /**
  Serializes this GNSS location.

  This is the inverse operation of $GnssLocation.deserialize.
  */
  to_byte_array:
    return serialization.serialize [
      latitude,
      longitude,
      altitude_msl,
      time.to_byte_array,
      horizontal_accuracy,
      vertical_accuracy,
    ]

  /** See $super. */
  operator == other:
    if other is not GnssLocation: return false
    return super other and
        time == other.time and
        horizontal_accuracy == other.horizontal_accuracy and
        vertical_accuracy == other.vertical_accuracy and
        altitude_msl == other.altitude_msl

  /** The hash code. */
  hash_code -> int:
    return super + time.hash_code * 19 + horizontal_accuracy * 23
        + vertical_accuracy * 29 + horizontal_accuracy * 37 + altitude_msl * 41
