module morphing_linear(steps = 20) {
  for (i = [0 : steps - 1] ) {
    t = i/steps;
    t2 = (i+1)/steps;
    hull() {
      minkowski() {
          scale(1-t) children(0);
          scale(t) children(1);
      }
      minkowski() {
          scale(1-t2) children(0);
          scale(t2) children(1);
      }
    }
  }
}

module morphing_cos(steps = 40, direction = [1, 1, 0]) {
  d1 = direction;
  d2 = [1, 1, 1] - d1;
  for (i = [0 : steps - 1] ) {
    t = i/steps;
    r11 = acos(t * 2 - 1) / 180;
    r12 = 1 - r11;
    t2 = (i+1)/steps;
    r21 = acos(t2 * 2 - 1) / 180;;
    r22 = 1 - r21;
    hull() {
      minkowski() {
          scale(r11 * d1 + (1-t) * d2) children(0);
          scale(r12 * d1 + t * d2) children(1);
      }
      minkowski() {
          scale(r21 * d1 + (1-t2) * d2) children(0);
          scale(r22 * d1 + t2 * d2) children(1);
      }
    }
  }
}


// Note: Usually the origin should be the common center of both children.
// The center can be shifted for interesting effects.
// The minkoski sums are not translation invariant, since the scales
// do not sum up to 1 for each step:
//   origin * r11 + origin * r12 != origin
module morphing_bone(steps = 20, origin=[0,0,0], direction = [1, 1, 0], bone = 1.0) {
  if ($fast) {
    hull() {
      children(0);
      children(1);
    }
  } else {
  d1 = direction;
  d2 = [1, 1, 1] - d1;
  for (i = [0 : steps-1] ) {
    t1 = i/steps;
    t11 = min(1, bone * t1);
    t12 = min(1, bone - bone * t1);
    r11 = 1 - sqrt(1 - (1-t11)*(1-t11));
    r12 = 1 - sqrt(1 - (1-t12)*(1-t12));
    t2 = (i+1)/steps;
    t21 = min(1, bone * t2);
    t22 = min(1, bone - bone * t2);
    r21 = 1 - sqrt(1 - (1-t21)*(1-t21));
    r22 = 1 - sqrt(1 - (1-t22)*(1-t22));
    translate(origin) 
    hull()
    {
      minkowski() {
          scale(r11 * d1 + (1-t1) * d2) translate(-origin) children(0);
          scale(r12 * d1 + t1 * d2) translate(-origin) children(1);
      }
      minkowski() {
          scale(r21 * d1 + (1-t2) * d2) translate(-origin) children(0);
          scale(r22 * d1 + t2 * d2) translate(-origin) children(1);
      }
    }
  }
  }
}


module morphing_bone_v2(steps = 20, p1, p2, direction = [1, 1, 0], bone = 1.0) {
  if ($fast) {
    hull() {
      translate(p1) children(0);
      translate(p2) children(1);
    }
  } else {
  origin = (p1 + p2) / 2;
  d1 = direction;
  d2 = [1, 1, 1] - d1;
  for (i = [0 : steps-1] ) {
    t1 = i/steps;
    t11 = min(1, bone * t1);
    t12 = min(1, bone - bone * t1);
    r11 = 1 - sqrt(1 - (1-t11)*(1-t11));
    r12 = 1 - sqrt(1 - (1-t12)*(1-t12));
    t2 = (i+1)/steps;
    t21 = min(1, bone * t2);
    t22 = min(1, bone - bone * t2);
    r21 = 1 - sqrt(1 - (1-t21)*(1-t21));
    r22 = 1 - sqrt(1 - (1-t22)*(1-t22));
    translate(origin) 
    hull()
    {
      minkowski() {
          scale(r11 * d1 + (1-t1) * d2) translate(p1 - origin) children(0);
          scale(r12 * d1 + t1 * d2) translate(p2 -origin) children(1);
      }
      minkowski() {
          scale(r21 * d1 + (1-t2) * d2) translate(p1 -origin) children(0);
          scale(r22 * d1 + t2 * d2) translate(p2 -origin) children(1);
      }
    }
  }
}
}

// Work in progress: Try to accelerate OpenSCAD rendering of this module
//
// module slice_morphing_bone(steps = 20, p1 = [0,0,0], p2, direction = [1, 1, 0], bone = 1.0) {
  
//   children(0);
//   children(1);
  
//   origin = (p1 + p2) / 2;
//   d1 = direction;
//   d2 = [1, 1, 1] - d1;
//   for (i = [0 : steps - 1] ) {
//     t1 = i/steps;
//     t11 = min(1, bone * t1);
//     t12 = min(1, bone - bone * t1);
//     r11 = 1 - sqrt(1 - (1-t11)*(1-t11));
//     r12 = 1 - sqrt(1 - (1-t12)*(1-t12));
//     t2 = (i+1)/steps;
//     t21 = min(1, bone * t2);
//     t22 = min(1, bone - bone * t2);
//     r21 = 1 - sqrt(1 - (1-t21)*(1-t21));
//     r22 = 1 - sqrt(1 - (1-t22)*(1-t22));
//     translate(origin) hull() {
//       if (i < 3) {
//         minkowski() {
//           scale(r11 * d1 + (1-t1) * d2) translate(-origin) children(0);
//           scale(r12 * d1 + t1 * d2) translate(-origin) children(1);
//         }
//       //   translate(p1 - origin) children(0);
//       } else
//       minkowski() {
//         scale(r11 * d1 + (1-t1) * d2) translate(p1 - origin) rotate([-90,0,0]) linear_extrude(height = 0.1) projection() rotate([90,0,0]) children(0);
//         scale(r12 * d1 + t1 * d2) translate(p2 - origin ) rotate([-90,0,0]) linear_extrude(height = 0.1) projection() rotate([90,0,0]) children(1);
//       }
//       if (i < 3 ) {
//       minkowski() {
//           scale(r21 * d1 + (1-t2) * d2) translate(-origin) children(0);
//           scale(r22 * d1 + t2 * d2) translate(-origin) children(1);
//       }

//       } else
//       minkowski() {
//         scale(r21 * d1 + (1-t2) * d2) translate(p1 - origin) rotate([-90,0,0]) linear_extrude(height = 0.1) projection() rotate([90,0,0]) children(0);
//         scale(r22 * d1 + t2 * d2) translate(p2 - origin ) rotate([-90,0,0]) linear_extrude(height = 0.1) projection() rotate([90,0,0]) children(1);
//       }
//     }
//   }
// }


// Backward comptibility
module morphing(steps = 20) {
  echo("'morphing' is DEPRECATED, use 'morphing_sqrt'.");
  morphing_sqrt(direction = [1, 1, 0]) {
    children(0);
    children(1);
  };
}


module morphing_sqrt(steps = 20, origin=[0,0,0], direction = [1, 1, 0]) { 
  d1 = direction;
  d2 = [1, 1, 1] - d1;

  for (i = [0 : steps-1] ) {
    t = i/steps;
    r11 = 1 - sqrt(1 - (1-t)*(1-t));
    r12 = 1 - r11;
    t2 = (i+1)/steps;
    r21 = 1 - sqrt(1 - (1-t2)*(1-t2));
    r22 = 1 - r21;
    translate(origin) hull() {
      minkowski() {
          scale(r11 * d1 + (1-t) * d2) translate(-origin) children(0);
          scale(r12 * d1 + t * d2) translate(-origin) children(1);
      }
      minkowski() {
          scale(r21 * d1 + (1-t2) * d2) translate(-origin) children(0);
          scale(r22 * d1 + t2 * d2) translate(-origin) children(1);
      }
    }
  }
}

module morphing_sqrt_v2(steps = 20, p1, p2, direction = [1, 1, 0]) {
  if ($fast) {
    hull() {
      translate(p1) children(0);
      translate(p2) children(1);
    }
  } else {

    d1 = direction;
    d2 = [1, 1, 1] - d1;

    for (i = [0 : steps-1] ) {
      t = i/steps;
      r11 = 1 - sqrt(1 - (1-t)*(1-t));
      r12 = 1 - r11;
      t2 = (i+1)/steps;
      r21 = 1 - sqrt(1 - (1-t2)*(1-t2));
      r22 = 1 - r21;
      origin = (p1 + p2) / 2;
      translate(origin) hull() {
        minkowski() {
          scale(r11 * d1 + (1-t) * d2) translate(p1-origin) children(0);
          scale(r12 * d1 + t * d2) translate(p2-origin) children(1);
        }
        minkowski() {
          scale(r21 * d1 + (1-t2) * d2) translate(p1-origin) children(0);
          scale(r22 * d1 + t2 * d2) translate(p2-origin) children(1);
        }
      }
    }

  }
}

module simplify_morph() {
  if ($fast) {
    children(0);
  } else {
    minkowski() {
      children(0);
      cube([0,0,0]);
    }
  }
}

module down(h) {
  for(i=[0:$children-1])
    translate([0,0,-h]) children(i);
}

module up(h) {
  for(i=[0:$children-1])
    translate([0,0,h]) children(i);
}




// module morphing_sqrt_ch(steps = 20, origin=[0,0,0], direction = [1, 1, 0]) {
//   d1 = direction;
//   d2 = [1, 1, 1] - d1;

//   transform(origin) chained_hull(
//   [ for (i = [0 : steps] ) {
//     t = i/steps;
//     r11 = 1 - sqrt(1 - (1-t)*(1-t));
//     r12 = 1 - r11;
//     minkowski() {
//           scale(r11 * d1 + (1-t) * d2) translate(-origin) children(0);
//           scale(r12 * d1 + t * d2) translate(-origin) children(1);
//     }
//   })
// }


// X = [1,2,3,4];

// //module blub(B) {
// //  for (i=[0:len(B)-2]) {
// //    translate([B[i]*2,B[i]*2,0]) difference() {
// //      cube([B[i+1],B[i+1],B[i+1]]);
// //      cube([B[i],B[i],B[i]]);
// //    }
// //  }
// //}
// //
// //blub(X);

// //morphing_sqrt_ch() {
// //  cube([3,4,3]);
// //  translate([20,0,0]) {
// //    difference() {
// //      sphere(r=6.01);
// //      translate([0,3,3]) sphere(r=3.05);
// //    }
// //  }
// //}
// //

// module chained_hull(chldrn) {
//   for(i=[0:len(chldrn)-2]) {
//     hull() {
//       chldrn[i];
//       chldrn[i+1];
//     }
//   }
// }


module chained_hull() {
  for(i=[0:$children-2]) {
    hull() {
      $children(i);
      $children(i+1);
    }
  }
}
