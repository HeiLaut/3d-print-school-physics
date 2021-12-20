include <BOSL/constants.scad>
use <BOSL/threading.scad>
use <BOSL/shapes.scad>


$fn = 30;

nut_d = 11;
rod_d = 10.8;


module hole(l){
    rotate([0,0,45])
    linear_extrude(l)union(){
    circle(d = rod_d);
    square(rod_d/2);
}
}

//clamp for table - needs two screws 50 mm and 15 mm
module klemme(){
    h = 64;
    b = 45;
    d = 27.5;
    a = 12; //Abstand oberkante, unterkante
    a1 = 24; //Abstand Stativhalterung
    translate([0,0,d/2])
    difference(){
        cuboid([h,b,d], fillet = 3);
        translate([0,a1/2,0])cuboid([h - 2*a,b - a1+1,d+1],  center = true);
        scale([1,1,1.05])translate([-h/2-3,-a1/2+2,0])rotate([0,90,0])cylinder(d = rod_d, h = h+5);
        translate([0,-a1/2+2,-h/2])cylinder(d = rod_d, h = h+5);
        translate([0,-15/2-a1/2,0])rotate([90,0,0])threaded_rod(d = nut_d, l = 15, pitch = 3);
        translate([h/2-6,(b-a1)/2,0])rotate([0,90,0])threaded_rod(d = nut_d, l = 15, pitch = 3);
    }
}
//print vertical
module schraube(l = 50, knob_h = 15, knob_n = 10){
    cylinder(d = 20, h = knob_h, $fn = knob_n);
    translate([0,0,l/2+knob_h])threaded_rod(d = nut_d-1.5, l = l, pitch = 3, bevel = true);
}

//print horizontal (stronger?!)
module schraube2(l = 15,knob_a = 20, knob_c = 10){
    knob_b = 6.2;
    difference(){
    translate([0,0,l/2+knob_c])threaded_rod(d = nut_d-1, l = l, pitch = 3, bevel = true);
    translate([0,nut_d/2+3.1,l/2+knob_c])cube([nut_d,nut_d,l+2],center = true);
    translate([0,-nut_d/2-3.1,l/2+knob_c])cube([nut_d,nut_d,l+2],center = true);
    }
    translate([0,0,knob_c/2])cuboid([knob_a,knob_b,knob_c], fillet = 2,edges=EDGES_BOTTOM + EDGES_Z_ALL);
    
}
module muffe(){
    l = 45;
    d = rod_d*2;
    difference(){
        linear_extrude(l)difference(){
            circle(d = d);
            circle(d = rod_d);
        }
    //translate([-d/2,0,12.5])rotate([0,90,0])hole(d+2);
    //translate([0,+d/2,l-12.5])rotate([90,90,0])hole(d+2);
    scale([1,1,1.05])translate([-d/2,0,12.5])rotate([0,90,0])cylinder(d = rod_d, h = d+2);
    scale([1,1,1.05])translate([0,+d/2,l-12.5])rotate([90,0,0])cylinder(d = rod_d, h = d+2);
    translate([-15/2,0,l-12.5])rotate([0,90,0])threaded_rod(d = nut_d, l = 15, pitch = 3);
    translate([0,-15/2,12.5])rotate([90,0,0])threaded_rod(d = nut_d, l = 15, pitch = 3);
    }
}
cylinder(h = 250, d = 10, $fn = 10);

*schraube2(50);
*muffe();
*klemme();
