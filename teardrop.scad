/* Kjell Morgenstern
* 
* The 
*/

module teardrop(h, r, max_a=45, center) {
  linear_extrude(h, center=center) {
    hull() {
      circle(r);
      square([r / cos(max_a), 0.01]);
    }
  }
}

module bridged_teardrop(h, r, max_a=45, center) {
  linear_extrude(h, center=center) {
    intersection() {
      hull() {
        circle(r);
        square([r / cos(max_a), 0.01]);
      }
      square([2* r , 2* r], center = true);
    }
  }
}

module bridged_cone(h, r1, r2, max_a=45, center) {
  linear_extrude(h, center=center, scale=r2/r1) {
    intersection() {
      hull() {
        circle(r1);
        square([r1 / cos(max_a), 0.01]);
      }
      square([2* r1 , 2* r1], center = true);
    }
  }
}

module test_teardrop(){
    translate([0, -50, 0]) teardrop(5, 20, max_a=90); // degenerate case: 90 degree means a normal circle
    translate([0, 0, 0]) teardrop(5, 20, max_a=60);
    translate([0, 50, 0]) teardrop(5, 20, max_a=45);
}

module test_bridged_teardrop(){
    translate([0, 0, 0]) bridged_teardrop(5, 20, max_a=60);
}

//test_bridged_teardrop();
//test_teardrop();