{ inputs, cell, ... }:
final: prev: {
  masterpdfeditor = prev.masterpdfeditor.overrideAttrs (_: {
    inherit (final.sources.masterpdfeditor) pname version src;
  });
}
