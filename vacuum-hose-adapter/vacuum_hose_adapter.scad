hole_1_dia = 35.3;
hole_2_dia = 33.7;
outer_dia = 38.0;
inner_dia = 31.0;
tolerance = 0.2;
height = 25.0;

difference() {
    cylinder(d = outer_dia, h = height);
    
    translate([0, 0, -1])
        cylinder(d = hole_1_dia + tolerance, h = height + 2);
}

translate([0, 0, height])
difference() {
    union() {
        cylinder(d = hole_2_dia - tolerance, h = height);
            
        cylinder(d = outer_dia, h = 5);
    }
    
    translate([0, 0, -1])
    cylinder(d = inner_dia, h = height + 2);
}
