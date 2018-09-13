outer_dia = 23.5;
inner_dia = 11.5;
lip_dia = 17.0;
lip_outer_dia = 15.0;

wall = 1.5;

height = 3;
wall_height = 2;
tower_height = 5;
lip_height = 1;

//guss form
form_w = 25;
form_l = 25;
form_h = 10;

$fn = 40;

module plug() {
    difference() {
        union() {
            cylinder(d = outer_dia, h = height);
            
            translate([0, 0, height])
            difference() {
                cylinder(d = outer_dia, h = wall_height);
                
                translate([0, 0, -1])
                cylinder(d = outer_dia - wall, h = wall_height + 2);
            }
            
            translate([0, 0, height])
            cylinder(d = lip_outer_dia, h = tower_height);
            
            translate([0, 0, height + tower_height])
            cylinder(d = lip_dia, h = lip_height);
        }
        
        translate([0, 0, -1])
        cylinder(d = inner_dia, h = height + tower_height + lip_height + 2);
    }
}

//plug();

module form() {
    difference() {
        translate([-form_w / 2, -form_l / 2, 0])
        cube([form_w, form_l, form_h]);
        
        plug();
        
        //translate([-0.05, -form_l / 2, -1])
        //    cube([0.1, form_l, form_h + 2]);
    }
}

rotate([0, 180, 0])
form();
