// PREFERENCES
LAYER_HEIGHT=2;

// Ring
module Ring(radius, thickness, height=LAYER_HEIGHT) {
    difference() {
        cylinder(height, r=radius);
        cylinder(height, r=radius-thickness);
    }
}

// Escapement wheel
module EscapementWheelCog(lenght=10,crook=5,thickness=3,height=LAYER_HEIGHT) {
    linear_extrude(height) {
        polygon([
            [0,-thickness/2],
            [0,thickness/2],
            [lenght,-crook]
         ]);
    }
}

module EscapementWheel(radius, cog_count, height=LAYER_HEIGHT) {
    union() {
        Ring(radius, radius/10, height);
        Ring(radius/5, radius/10, height);
        
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
                    EscapementWheelCog(radius*0.5, radius*0.25, radius*0.15, height);
                }
            }
        }
    }
}

// Demo
EscapementWheel(20, 17);


