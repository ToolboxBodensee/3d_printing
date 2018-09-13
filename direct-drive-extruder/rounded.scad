

module rounded_cube(x, y, z, rx=fillet, ry=fillet, rz=fillet, noback=true, nobottom=false, notop=false) {
    $fs = 0.15;
    union() {
        
        if (rx == ry && ry == rz) {
             minkowski() {
                translate([rx, rx, rx])cube([x-rx*2, y-rx*2, z-rx*2]);                
                sphere(r = rx);
            }           
        } else {
            minkowski() {
                translate([rz+ry, rz+rx, rz+ry])cube([x-rz*2-ry*2, y-rz*2-rx*2, z-rx*2-ry*2]);
                cylinder(r = rz, h = 0.01);
                rotate ([0, 90, 0]) cylinder(r = rx, h = 0.01);
                rotate ([90, 0, 0]) cylinder(r = ry, h = 0.01);
            }
        }
        
        if (noback) {
            minkowski() {
                translate([ry, y/2, ry])cube([x-ry*2, y/2, z-ry*2]);
                rotate ([90, 0, 0]) cylinder(r = ry, h = 0.01);
            }
        }
        
        if (nobottom) {
            minkowski() {
                translate([rz, rz, 0])cube([x-rz*2, y-rz*2, z/2]);
                rotate ([0, 0, 0]) cylinder(r = rz, h = 0.01);
            }
        }
        
        if (notop) {
            minkowski() {
                translate([rz, rz, z/2])cube([x-rz*2, y-rz*2, z/2]);
                rotate ([0, 0, 0]) cylinder(r = rz, h = 0.01);
            }
        }
    }
    
}

module rounded_cylinder(r, h, rrnd = fillet, rtop = true, rbottom = false, center=false) {
    $fs = 0.15;    
    
    htr = center ? -h/2 : 0;
    translate([0, 0, htr]) union() {        
        minkowski() {
            translate([0,0,rrnd]) cylinder(r=r-rrnd, h=h-rrnd*2);
            sphere(rrnd);
        }
        
        if (!rbottom) 
                translate([0,0,h/2]) cylinder(r=r, h=h/2);
        if (!rtop) 
                translate([0,0,0]) cylinder(r=r, h=h/2);        
    }   
}
