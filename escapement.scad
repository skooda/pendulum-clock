// Ring
module Ring(height, radius, thickness) {
    difference() {
        cylinder(height, r=radius);
        cylinder(height, r=radius-thickness);
    }
}

// Escapement
module EscapementWheelCog(lenght=10,crook=5,thickness=3) {
    linear_extrude(2) {
        polygon([
            [0,-thickness/2],
            [0,thickness/2],
            [lenght,crook]
         ]);
    }
}

module EscapementWheel(height, radius, cog_count) {
    union() {
        Ring(height, radius, radius/10);
        Ring(height, radius/5, radius/10);
        
        for (i = [0:360/5:360]) {
           rotate([0, 0, i]) {
              translate([radius*0.15, 0, 0]) {
                cube([radius * 0.80, radius/10, height]);
              }
           }
        }
        
        for (i = [0:360/cog_count:360]) {
            rotate([0, 0, i]) {
                translate([radius*0.95, 0, 0]) {
                    EscapementWheelCog(radius*0.5, radius*0.2, radius*0.15);
                }
            }
        }
    }
}


// Demo
EscapementWheel(2, 20, 16);