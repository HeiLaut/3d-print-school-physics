include <BOSL/constants.scad>
use <BOSL/threading.scad>
use <BOSL/shapes.scad>

//Diameter of the "Laser"
d = 13.3; 

//length of the mounting rod
l_r=65; 


$fn=40;
h=20;
r= 5; //Radius of the hinge
b = 5;
nut_d = 8;
rod_d = 10.8;

module thread_inner(rot = 0, l = 15){
    rotate([rot,0,0])translate([0,0,l/2])threaded_rod(d = nut_d, l = l, pitch = 2);
}

module scharnier(){
   
    
    cylinder(r=r, h =h/3-2);
    cylinder(r=r-3, h = h);
    translate([0,0,h-h/3+2])cylinder(r=r, h =h/3-2);
    translate([0,0,h/3-1])difference(){
        cylinder(r=r, h=h/3+2);
        cylinder(r=r-2.5, h=h/3+2);
    }
   
}



module halterung(screw=true){
   
    difference(){
        cylinder(d= d+2*b, h = h);
        translate([0,0,-0.5])cylinder(d= d, h = h+1);
        translate([0,(d+b)/2,h/2-0.5])cube([2*d,b+d+2,h+2], center = true);
    }
    
        if(screw){
            difference(){
                translate([b*3/2+d/2,-3.5,h/2])cuboid([b*3,b,h]);
                translate([b*3/2+d/2+1,0,h/2])rotate([90,0,0])thread_inner();
            }
        }else{
            difference(){
                translate([b*3/2+d/2,-3.5,h/2])cuboid([b*3,b,h]);
                translate([b*3/2+d/2+1.5,0,h/2])rotate([90,0,0])cylinder(d=nut_d,h=15);
            }
        }
}


module schraube(l = 50, knob_h = 15, knob_n = 10){
    cylinder(d = 10, h = knob_h, $fn = knob_n);
    translate([0,0,l/2+knob_h])threaded_rod(d = nut_d-1, l = l, pitch = 2, bevel = true);
}

module schale1(){
    difference(){
        translate([d/2+b,0,0])halterung();
        translate([0,0,h/3-2])cylinder(r=r+1, h=h/3+4);
        translate([d/2+b,-d/2+7.5,h/2])thread_inner(rot=90);

    }
}
module schale2(){

    difference(){
        translate([d/2+b,0,0])mirror([0,1,0])halterung(screw=false);
        cylinder(r=r+2, h =h/3-1);
        translate([0,0,h-h/3+1])cylinder(r=r+2, h =h/3-1);
        translate([0,0,h/3-1])cylinder(r=r-2.5, h=h/3+2);
    }    
    }
module schrauben(){
    translate([-40,0,0])schraube(l=10, knob_h=10);
    translate([-90,0,0]){
        cylinder(d=10,h=l_r);
        translate([0,0,l_r])schraube(l=5, knob_h=0);
    }
}

schale1();
schale2();
scharnier();
schrauben();

