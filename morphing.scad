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

module morphing_cos(steps = 40) {  
  for (i = [0 : steps - 1] ) {
    t = i/steps;
    r11 = acos(t * 2 - 1) / 180;
    r12 = 1 - r11;
    t2 = (i+1)/steps;
    r21 = acos(t2 * 2 - 1) / 180;;
    r22 = 1 - r21;
    hull() {
      minkowski() {
          scale([r11,r11,(1-t)]) children(0); 
          scale([r12,r12,t]) children(1); 
      } 
      minkowski() { 
          scale([r21,r21,(1-t2)]) children(0); 
          scale([r22,r22,t2]) children(1); 
      } 
    }
  }
}


module morphing(steps = 20) {  
  for (i = [0 : steps - 1] ) {
    t = i/steps;
    r11 = 1 - sqrt(1 - (1-t)*(1-t));
    r12 = 1 - r11;
    t2 = (i+1)/steps;
    r21 = 1 - sqrt(1 - (1-t2)*(1-t2));
    r22 = 1 - r21;
    hull() {
      minkowski() {
          scale([r11,r11,(1-t)]) children(0); 
          scale([r12,r12,t]) children(1); 
      } 
      minkowski() { 
          scale([r21,r21,(1-t2)]) children(0); 
          scale([r22,r22,t2]) children(1); 
      } 
    }
  }
}