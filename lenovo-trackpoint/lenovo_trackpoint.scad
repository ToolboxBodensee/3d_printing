translate([0,0,2.5]) {
    rotate([90,0,0])translate([-0.2,0,0])
        import("D:/Downloads/LenovoTrackpoint.stl");
    h=5;
    r1=3.6;
    r2=2.7/2;
    center = true;
    $fn=128;
    difference() {
        cylinder(h, r1, r1, center);
        #translate([0,0,0]) cylinder(h+1, r2, r2, center);
    }
}
