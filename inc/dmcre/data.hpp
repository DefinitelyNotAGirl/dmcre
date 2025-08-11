
#pragma once
#include <cstddef>
#include <cstdint>
extern const uint8_t StaticData[];
static const uint16_t* Uint8ToHexAsciiMap = (uint16_t*)(StaticData + 0x0);
static const uint8_t* HexAsciiToUint8Map = (uint8_t*)(StaticData + 0x3030);
