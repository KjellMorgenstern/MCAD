// TODO Imbus bolts - DIN 912
include <units.scad>

module imbus(sep, height, tolerance = 0.01) {
  cylinder(r=sep/2/cos(30)-tolerance,h=height,$fn=6);
}


