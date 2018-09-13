
dual = false;               // dual extruder version
mirrored = 1;               // 1 = "right",  0 = "left"

prometheus = false;          // E3D v6 otherwise

width = 42.5;
depth = 30;                     //filament to x carriage. Good for 40mm long motor
height = 51;
height_m = 20;     //motor to hotend top. You may need to increase this for prometheus!
cover_d = 16;

holes_top1 = 35;                //geetech, etc. (comment out to disable)
holes_spacing1 = 30;     

holes_top2 = 23;                //rework X-carriage       
holes_spacing2 = 23;
holes_top3 = holes_top2 + 23;        
holes_spacing3 = 23;

filament_d = 1.75;
gear_od = 12;                                    //outer diameter: mk8 = 9, mk7 = 12
gear_ed = 10.25;                                 //effective diameter: mk8 = 6.75, mk7 = 10.25
gear_groove_width = 3.5;
filament_offset = (gear_ed + filament_d)/2;     //mk8 = 4.25, mk7 = 6  
echo(filament_offset); 

//bearing
//603
//bearing_od = 9; bearing_id = 3; bearing_h = 3;
//623
//bearing_od = 10; bearing_id = 3; bearing_h = 4;
//624
bearing_od = 13; bearing_id = 4; bearing_h = 5;
//625
//bearing_od = 16; bearing_id = 5; bearing_h = 5;
//MR104
//bearing_od = 10; bearing_id = 4; bearing_h = 4;

brass_tube = false;

fillet = 1.5;
supports = true;


include <rounded.scad>
//use <pen_holder.scad>


//assembly();
//print();


//translate([0, -4.5, 0])
//    rotate([0, 0, -90])
//    assembly_multec();


//%translate([0, 0, -1.3])
//    multec_base();

//multec_mount();

mirror ([mirrored, 0, 0])
    lever();

module multec_mount() {
    $fn = 15;
    difference() {
        union() {
            multec_mount_plate();
            
            translate([0, -9, 0])
                mirror([0, 1, 0])
                multec_mount_plate();
        }
        
        for (i = [0 : (9.3 + 3.0) * 3 : 42])  {
            translate([-26 + 1.5 + 5.5 + i, -32 + 1.6 + 3, -1.5])
                cylinder(d = 3.2, h = 3.6);
            translate([-26 + 1.5 + 5.5 + i, -32 + 1.6 + 3 + 42.8 + 3, -1.5])
                cylinder(d = 3.2, h = 3.6);
        }
    }
    
    for(i = [0 : 1]) {
        translate([0, i * 44.4, 0])
        difference() {
            translate([-16, -27.7, 0])
                cube([28, 2, 10]);
            
            translate([-5, -25, 5])
                rotate([90, 0, 0])
                cylinder(d = 3.2, h = 6.2);
            translate([5, -25, 5])
                rotate([90, 0, 0])
                cylinder(d = 3.2, h = 6.2);
        }
    }
}

module multec_mount_plate() {
    hull() {
        translate([-24, -32, 0])
            cube([7, 8, 2]);
        translate([-16, -32, 0])
            cube([3, 4, 2]);
    }
    mirror([1, 0, 0])
    translate([4.5, 0, 0])
    hull() {
        translate([-27, -32, 0])
            cube([10, 8, 2]);
        translate([-16, -32, 0])
            cube([3, 4, 2]);
    }
    translate([-16, -32, 0])
        cube([28, 5, 2]);
}

module multec_base() {
    $fn = 15;
    difference() {
        cube([52, 64, 2.5], center=true);
        
        translate([0, -4, 0])
            cube([40, 36.8, 2.6], center=true);
        
        for (i = [0 : (9.3 + 3.0) : 42])  {
            translate([-26 + 1.5 + 5.5 + i, -32 + 1.6 + 3, -1.5])
                cylinder(d = 3.2, h = 3.6);
            translate([-26 + 1.5 + 5.5 + i, -32 + 1.6 + 3 + 42.8 + 3, -1.5])
                cylinder(d = 3.2, h = 3.6);
        }
    }
}

module assembly_multec() {
    mirror ([mirrored, 0, 0]) {
        assembly_top();
    }
}

module print() {    
    mirror ([mirrored, 0, 0]) {
        translate([0,31,depth]) rotate([-90, 0, 0]) base(dual);  
        translate([50,0,10]) rotate([-90, 0, 0]) top_plate();
        translate([50,0,10]) rotate([-90, 0, 0]) holder();      
        translate([100,0,00]) rotate([-90, 0, 0]) cover();        
        translate([105,50,height_m+42.5]) rotate([-180, 0, 0]) lever();              
        translate([30,65,-23]) rotate([-90, 0, 0]) duct_5015();
        
    }        
}


module assembly() {
    mirror ([mirrored, 0, 0]) {
        assembly_top();
        if (dual)
        {
            translate([width/2, 0, 0]) color("green") base(dual);
            translate([width, 0, 0]) mirror([1, 0, 0]) assembly_top();
        }
        else
        {
            color("green") base(dual);
        }
                             
        //translate([100,0,0]) ptfe_mount();                        
            
    }
    
    //translate([filament_offset, -cover_d, 0]) pen_holder_assembly(10);    
    
    translate([-width/2, -43/2+5, -38/2+5]) rotate([-90,180,90])  { 
        color("gray", 0.5) render() fan_5015();
        duct_5015();
    }

    translate([dual ? width/2 : 0,depth,height_m-34]) rotate([270,180,0]) color("gray",0.5) import("i3_rework_1v0_x-carriage-_X-CarriageMod_LME8UU_gt_holes.stl");   
    //translate([width/2+7.2,depth,-49]) color("gray",0.4) rotate([270,180,0]) import("PI3B-B03-carriage.STL");    
    //translate([26.5,depth,19]) rotate([270,180,0]) color("gray",0.5) import("X-axis-part_3_lm8uu_v1_1.stl");
    //translate ([-10, -10, -55.5 ]) color("white",0.25) cube([width+20,depth+30,1]); 
    

}



module assembly_top() {
    color("yellow") holder();
    color("yellow") top_plate();
    color("orange") cover(); 
    color("red") lever();
   
    color("silver", 0.5) bearing();                        
    color("blue", 0.25) translate([filament_offset,0, 0])  cylinder(d=filament_d, h=70, $fn=64);  //filament

    if (prometheus)
    { 
        translate([filament_offset+90, -90, -31]) rotate([0,0,90]) color("gray", 0.75) import("Aluminium_Heat_Sink_V1.1__5mm_.stl");
        translate([filament_offset, 0, -31]) color("gray", 0.5) rotate([180,0,0]) cylinder(d=5, h=19);
    }    
    else
        translate([filament_offset, 0, -13.5]) rotate([90,0,-90]) color("gray", 0.75) import("E3D_V6_1.75mm_Universal_HotEnd_Mockup.stl");
    
    
    
    
    translate([0,50,height_m+21.5]) rotate([90,0,0]) color("gray", 0.5) import("Nema17_40h.stl");
    translate([0,9.5,height_m+21.5]) rotate([90,0,0]) color("silver", 0.5) import("mk8gear.stl");     
}




module base(dual = false) {
    base_w = dual ? width*2 : width;
    xadd = dual ? width/2 : 0;
    difference()
    {
        union(){
            translate([-base_w/2, 10, 0]) rounded_cube(base_w, depth-10, height_m, 0, fillet, 0);            
            translate([-base_w/2, depth - 8, height_m-height]) rounded_cube(base_w, 8, height,fillet,fillet,fillet);
            
            translate([-xadd, 10, 14]) cube([width-24, 8, 5], center=true);
            if (dual)
                translate ([xadd, 10, 14]) cube([width-24, 8, 5], center=true);
        }        
        
        if (holes_top1!=undef) {        
            translate([-holes_spacing1/2, depth+0.1, height_m-holes_top1]) screw_hole_carriage();
            translate([ holes_spacing1/2, depth+0.1, height_m-holes_top1]) screw_hole_carriage();
        }
        if (holes_top2!=undef) {
            translate([-holes_spacing2/2, depth+0.1, height_m-holes_top2]) screw_hole_carriage();
            translate([ holes_spacing2/2, depth+0.1, height_m-holes_top2]) screw_hole_carriage();
        }
        if (holes_top2!=undef && holes_top3!=undef) {
            translate([-holes_spacing3/2, depth+0.1, height_m-holes_top3]) screw_hole_carriage();
            translate([ holes_spacing3/2, depth+0.1, height_m-holes_top3]) screw_hole_carriage();    
        }        

        
        translate ([-xadd, 0, 0]) screw_holes_main();        
        if (dual)
            translate ([xadd, 0, 0]) screw_holes_main();
        //aux mount holes
        screw_hole_x(15, 5, l=10, w = base_w);    
        screw_hole_x(depth - 4, -26, r=-90, l=7.5, w = base_w); 
        screw_hole_x(depth - 4, -6, r=-90, l=8, w = base_w);

    }
}


module holder() {
   difference()
    {
        union(){
            translate([-width/2, 0, 0]) rounded_cube(width, 10, height_m, 0, fillet, 0);          
            translate([-width/2, -6, height_m]) rounded_cube(width, 16, 11, fillet,fillet,fillet);  
            translate([-width/2, -6, height_m-5]) rounded_cube(width, 16, 10, 0,0,fillet);
            
            translate([filament_offset-5,0, height_m+10]) cube ([10, 7.5, 9]);    //tip for flex filament                                                
            
            translate([-12,0, height_m+10.9]) cylinder(d2 = 5, d1=8, h=2.1, $fn=64); //spring 
        }
        translate([-width/2-0.15, -15, 0.1]) rounded_cube(width+0.3, 15, height_m, fillet,fillet,fillet); 
        translate([0, 10, 14]) cube([width-23.8, 10, 5.2], center=true);
        translate([0, 9.6, 14]) cube([width-23.0, 0.4, 6], center=true);
        
        translate([0,10.1,height_m+21.5]) rotate([90,0,0]) cylinder(d=23, h=2.6, $fn=64);
        
        translate([-12,0, height_m+11]) cylinder(r = 1.5, h=20, $fn=64, center=true); //spring
        
        //hotend mount
        translate([filament_offset,0, 0]) {
            hotend_mount();
            translate([-5.1,-10,20]) cube([10.2, 10, 20]);
        }
        
        //motor screws
        translate([-31/2, -6, height_m+6]) rotate([-90, 0, 0]) {
            cylinder(r = 1.6, h = 25,  $fn=32);
            cylinder(r = 3.1, h = 6,  $fn=32, center=true);
        }
        translate([ 31/2, -6, height_m+6]) rotate([-90, 0, 0]) {
            cylinder(r = 1.6, h = 25,  $fn=32);
            cylinder(r = 3.1, h = 6,  $fn=32, center=true);
        }        
          

        screw_holes_main();
        
        flex_guide();
        
        //5015S fan mounts
        screw_hole_x(5, 5);    
        
    }  
    
    
    //tip supports
    if (supports)
        for (xx =[-5.2, -2.5, 0, 2.5, 4.7])
            translate([filament_offset+xx, 7.6, height_m+11.4]) cube ([0.55, 2.4, 8]);   
    
}    



module top_plate() {
    difference() {

        hull() {
            translate([-14.5, 6, height_m+39.5]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=32);            
            translate([-18, 6, height_m+36]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=32);
            translate([-18, 6, height_m+29]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=32);
            translate([ 31/2, 6, height_m+37]) rotate([-90, 0, 0]) cylinder(r = 5.5, h=4, $fn=32);  
            translate([18, 6, height_m+29]) rotate([-90, 0, 0]) cylinder(r=3, h=4, $fn=32);
        }

        
        translate([0,10.1,height_m+21.5]) rotate([90,0,0]) cylinder(d=24, h=5, $fn=64);
        
        //mount holes
        translate([-31/2, 5.9, height_m+37]) rotate([-90, 0, 0]) { 
            cylinder(r = 1.6, h = 5,  $fn=32);
            cylinder(r = 3.5, h = 2,  $fn=32);            
        }
        translate([ 31/2, 5.9, height_m+37]) rotate([-90, 0, 0]) {
            hd = brass_tube ? 4.2 : 3;
            cylinder(d = hd, h = 5,  $fn=32);
        }
                
        
    }
    

}



module lever () {
    bearing_x = filament_offset + filament_d/2+bearing_od/2; 
    lever_h = 12;  
     
    translate([0, 0, height_m]) difference() {
            union() {
                hull() {
                    translate([-8, -(lever_h/2), 32.5]) rounded_cube(38-14+fillet, lever_h, 10, noback = true);
                    translate([-13, -(lever_h/2), 39.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                    translate([-13, -(lever_h/2), 35.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                }    
                
                hull() {
                    translate([-13, -(lever_h/2), 39.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                    translate([-13, -(lever_h/2), 35.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                    translate([-18.5, -(lever_h/2), 35.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                    translate([-25, -(lever_h/2), 39.5]) rotate([-90, 0, 0]) rounded_cylinder(3, lever_h-1, fillet, true, true);
                }
                hull()
                {
                    translate([bearing_x-bearing_od/2+1, -(lever_h/2), 21.5]) 
                        rounded_cube(bearing_od/2, lever_h, 15);
                    translate([ 31/2, -(lever_h/2), 37]) rotate([-90, 0, 0])  
                    
                        rounded_cylinder(r = 5.5, h = lever_h, rrnd=fillet,  $fn=64);
                    
                    translate([bearing_x, 0, 21.5]) rotate([-90, 0, 0])                 
                        rounded_cylinder((bearing_od-2)/2, lever_h, center=true);                                
                    
                    if (bearing_od <= 16)
                    translate([min((bearing_x+2),20-(bearing_od-2)/2), 0, 21.5]) rotate([-90, 0, 0])                
                       rounded_cylinder((bearing_od-2)/2, lever_h, center=true);  
                }
    
                //translate([-12,0, 30.5]) cylinder(d1 = 5, d2=8, h=2.1, $fn=64); //spring tip
                
                translate([filament_offset,0, 30]) cylinder(d1 = 6, d2=10, h=3, $fn=64); //filament tip 
            }
            
            translate([filament_offset,0, 42.5-3]) cylinder(d1 = 4, d2=5, h=3, $fn=64);
            
            //mounting hole
            translate([ 31/2, -(lever_h/2), 37]) rotate([-90, 0, 0]) {
                hd = brass_tube ? 4.2 : 3;
                cylinder(d=hd, h = 20,  $fn=32);                     //change to r=1.5 if no brass pipe
                cylinder(d=8, h = 7,  $fn=32, center=true);           
            }
            
        translate([bearing_x, 0, 21.5]) rotate([-90, 0, 0]){
            difference() {
                cylinder(d=bearing_od+2, h=bearing_h+0.5, $fn=64, center=true);  
                difference() {
                    cylinder(d=bearing_id+(bearing_od-bearing_id)/3, h=bearing_h+0.5, $fn=64, center=true);
                    cylinder(d=bearing_od, h=bearing_h+0.1, $fn=64, center=true);
                }
            }
            cylinder(d=bearing_id*0.95, h=20, $fn=64, center=true);
        }
        

        //translate([filament_offset, -(bearing_h)/2, 0]) cube([20, bearing_h+0.1, 21.5]); 
        
        // filament hole
        translate([filament_offset,0, 25]) cylinder(d=4.2, h=20, $fn=64); 
        
        // spring screw
        translate([-12,0, 32.5]) { 
            cylinder(r = 1.6, h=30, $fn=64, center=true);            
            translate([-3, -3.3, 3]) cube([6, 10, 3.0]);
        }
        
        
  
    }       
}




module cover() {
    difference() {
        union() {

            translate([-width/2, -cover_d, 0]) rounded_cube(width, cover_d, height_m, fillet,fillet,fillet);        
            translate([filament_offset-5,-6, height_m-1]) cube ([10, 6, 20]);    
        }
        translate([filament_offset,0,0]) hotend_mount();
        screw_hole_x(-5, 5);
        
        screw_holes_main();
    
        flex_guide();
        
        //front fan mounts
        screw_hole_y(filament_offset+5, -cover_d, 5);
        screw_hole_y(filament_offset-5, -cover_d, 5);
        screw_hole_y(filament_offset-15, -cover_d, 5);
    }

    
}



module hotend_mount() {
        cylinder(d=4.2, h=46, $fn=64);
        cylinder(d=12.2, h=8, $fn=64);
        translate([0,0,8 - 4.1]) cylinder(d=17, h= prometheus ? 5 : 4.1, $fn=64);    
        translate([0,0,8]) cylinder(d=9, h=2, $fn=64);
}


module screw_hole_x(y, z, r=0, l=8, w=width) {
        translate([-w/2, y, z]) rotate([0, 90, 0]) {
            cylinder(r = 1.6, h = l*2,  $fn=32, center=true);
            rotate([0, 0, r]) translate([-3.3, -3, 3]) cube([10, 6, 3.0]);
        }
        translate([w/2, y, z]) rotate([0, -90, 0]) {
            cylinder(r = 1.6, h = l*2,  $fn=32, center=true);
            rotate([0, 0, -r]) translate([-6.6, -3, 3]) cube([10, 6, 3.0]);
        }     
}

module screw_hole_y(x, y, z, l=7.5) {
        translate([x, y, z]) rotate([-90, 90, 0]) {
            cylinder(r = 1.6, h = l*2,  $fn=32, center=true);
            translate([-3.3, -3, 3]) cube([10, 6, 3.0]);
        }   
}


module screw_hole_carriage() {
    rotate([90, 0, 0]) {
        cylinder( r = 1.6, h = 8.1, $fn=32);
        translate([0, 0, 6])cylinder( d = 6.6, h = 3, $fn=6);
        translate([0, 0, 9.6])cube( [8,6,3], $fn=32, center=true);
    }
}

module screw_holes_main() {
    translate([width/2-5.5, -cover_d, height_m/2]) rotate([-90, 0, 0]) {
        cylinder(r = 1.6, h = 50,  $fn=32);
        cylinder(r = 3.2, h = 11,  $fn=32, center=true);
    } 
    translate([-width/2+5.5, -cover_d, height_m/2]) rotate([-90, 0, 0]) {
        cylinder(r = 1.6, h = 50,  $fn=32);
        cylinder(r = 3.2, h = 11,  $fn=32, center=true);
    }    
    translate([width/2-5.5, depth-4, height_m/2]) rotate([-90, 0, 0]) cylinder( d = 6.6, h = 4.1, $fn=6);
    translate([-width/2+5.5, depth-4, height_m/2]) rotate([-90, 0, 0]) cylinder( d = 6.6, h = 4.1, $fn=6);
}


module flex_guide()
{
    
    difference() {
        translate([0, -10, height_m+6+31/2]) rotate([-90, 0, 0]) cylinder(d=gear_od+1, h=20, $fn=64);
        intersection() {
            translate([0, -10, height_m+6+31/2]) rotate([-90, 0, 0]) cylinder(d=gear_od+1, h=20, $fn=64);
            translate([0, 0, height_m+6+31/2]) rotate([90, 0, 0]) rotate_extrude($fn=64) {
                translate([gear_ed/2 + (gear_od - gear_ed)/2 +0.5, 0, 0])
                resize([(gear_od-gear_ed), gear_groove_width]) circle(d = gear_od-gear_ed, $fn=64);
            }
        }
    }
    
    translate([0, 3.5, height_m+6+31/2]) rotate([-90, 0, 0]) cylinder(d1=gear_od+1, d2 = gear_od+2, h=0.55, $fn=64);
    translate([0, 4, height_m+6+31/2]) rotate([-90, 0, 0]) cylinder(d=gear_od+2, h=20, $fn=64);
    
    translate([0, -3.5, height_m+6+31/2]) mirror([0,1,0]) rotate([-90, 0, 0]) cylinder(d1=gear_od+1, d2 = gear_od+2, h=0.55, $fn=64);
    translate([0, -4, height_m+6+31/2]) mirror([0,1,0]) rotate([-90, 0, 0]) cylinder(d=gear_od+2, h=20, $fn=64);    

    translate([bearing_od/2 + gear_ed/2 + filament_d,-10, height_m+6+31/2]) {
        rotate([-90, 0, 0]) cylinder(d=bearing_od+1, h=20, $fn=64);
        translate([0,0,-(bearing_od+1)/2]) cube([(bearing_od+1)/2, 20, (bearing_od+1)/2]);
    }
    
    
}

module bearing() {
    translate([bearing_od/2 + gear_ed/2+filament_d, 0, height_m+6+31/2]) {
        difference() {
            rotate([-90, 0, 0]) cylinder(d=bearing_od, h=bearing_h, $fn=64, center=true);
            rotate([-90, 0, 0]) cylinder(d=bearing_id, h=bearing_h+0.1, $fn=64, center=true);
        }
    }   
}




module ptfe_endmount() {
    $fn=32;
    difference() {
        rounded_cube(22, 26, 12, noback=false);

        //translate ([30,0,0]) rotate ([0,0,90]) 
        
        translate([0,0,3.4]) cube ([22, 13, 5.2]);
        translate([11,26-7,0]) cylinder(d=3.2, h=12);
        translate([11,26-7,0]) cylinder(d=5.5, h=7.5);        
        translate([11,26-7,0]) cylinder(d=9.5, h=1.5);
    }
}


module fan_5015() {
    $fn=64;
    difference() {
        linear_extrude(15) { 
            hull(){
                translate([0.5, 0]) circle(d=50);
                translate([-1, 0])circle(d=50);
            }
            hull() {
                translate([-43/2, 38/2]) circle(d=7);
                translate([43/2, -38/2]) circle(d=7);
            } 
            translate([-26, -26]) square([20,26]);
        }
        
        difference(){
            union() {
                translate([-26+16+11,-2,1]) cylinder(d=32, h=15);
                translate([0,0,1]) hull(){
                    translate([0.5, 0]) cylinder(d=48, h=13);
                    translate([-1, 0]) cylinder(d=48, h=13);
                }
                translate([-25,-26,1]) cube([18,25,13]);
            }
            translate([-26+16+11,-2,1]) cylinder(d=24, h=15);
        }
                
        translate([-43/2, 38/2]) cylinder(d=4.4, h=15);
        translate([43/2, -38/2]) cylinder(d=4.4, h=15);
    }
}

module duct_5015() {
    op_l = 14;
    op_h = 4;
    difference() {
        union() {
            translate([-25,-26,1]) cube([18,3,13]);
            translate([-25.5,-27,0.5]) cube([19,1,14]);
            hull() {
                translate([-25.5,-27,0.5]) cube([19,0.1,14]);
                translate([-23,-34.5,-7]) rotate ([50,0,0]) cube([14,0.1,5]);
            }
        }
        union() {
            translate([-24,-27,2]) cube([16,4,11]);
            hull() {
                translate([-24,-27,2]) cube([16,0.1,11]);
                translate([-22,-36,-7]) rotate ([50,0,0]) cube([12,0.1,3]);
            }
        }
    }
}





module motor_mount() {
    linear_extrude (height = 5)
    difference() {
        translate([-21, -21]) square([42, 42]);
        circle(r = 11);
        translate([31/2, 31/2]) circle(r=1.6, $fn=32);
        translate([31/2, -31/2]) circle(r=1.6, $fn=32);
        translate([-31/2, 31/2]) circle(r=1.6, $fn=32);
        translate([-31/2, -31/2]) circle(r=1.6, $fn=32);
    }
}



