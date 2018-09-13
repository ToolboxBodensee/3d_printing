$fn = 15;
difference() {
    union()  {
        import("D:/STL/gt2 pulley multec mod/24t_gt2_pulley.stl");
        //import("D:/STL/gt2 pulley multec mod/24t_gt2_pulley_CAP.stl");
        
        translate([0, 0, -1])
            cylinder(d = 11, h = 9);
    }
    


    translate([0, 0, -5])
        cylinder(d = 6.2, h = 20);
}
