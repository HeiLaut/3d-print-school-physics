/* Schleuder */
//use <spirale.scad>;
use <spirale.scad>;
include <BOSL/constants.scad>;
use <BOSL/masks.scad>;
use <BOSL/shapes.scad>;
use <BOSL/transforms.scad>;


x_p = 95;
y_p = 70;
z_p = 8;

a_n = 55; //Abstand nubsi zu oberkante
x_n=6;
z_n=4;

x_a = 60; // Länge Arm
y_a = 10;
z_a = 2.5;
pos = [x_p/4-x_a+22,y_p/2-y_a,z_p/2];

//Wurfwarm
w_breite = 150;
w_tiefe = 10;
w_dicke = 4;
l_hoehe = 10; //Höhe Lippe
l_tiefe = 2; // 

//Spirale
arm_len = 8;
circles = 2.3;
thickness = 4;

r = 5;

//spiral(circles = 4, arm_len = 6, thickness = 3)
*color("green")translate([0,35,20])wurfarm();
baseplate();
*3stuetz();


module baseplate(){
difference(){
    
    cl = 0.3;
    translate([0,0,z_p/2])cuboid([x_p,y_p,z_p], fillet = 3, edges = EDGES_TOP+EDGES_Z_ALL,$fn=30);
    translate(pos)cube([x_a+2*cl,y_a+2*cl,z_p],center = true);
}
translate([1,0,z_p/2-z_a/2])translate(pos)cuboid([x_a,y_a,z_a]);

translate([-34,y_p/2-y_a,z_p])difference(){
    cylinder(h=2.5,d = 6, $fn=30);
    translate([-2,0,5])rotate([0,-30,0])cuboid(8);
}
//Halterung Spirale/ Mitte
translate([0,0,z_p+z_n/2])rotate([0,0,25])cuboid([x_n,x_n,z_n]);

//Druckknopf
translate([0,y_p/2-y_a,z_p])
difference(){
    cylinder(d1=6,d2=8,h=4, $fn=30);
    translate([0,0,13])sphere(r=10, $fn=50);
}
translate([0,-y_p/2+7,z_p])cylinder(r=4,h=3);

}
module wurfarm(){
    difference(){
        union(){
            translate([0,0,w_dicke/4])cuboid([w_breite, w_tiefe,w_dicke/2], fillet = 1,edges=EDGE_TOP_BK+EDGE_TOP_RT+EDGE_TOP_LF, $fn=24);
            translate([0,-w_tiefe/2-l_tiefe/2,l_hoehe/2])cuboid([w_breite, l_tiefe, l_hoehe],fillet = 1, edges = EDGE_TOP_FR+EDGE_TOP_BK);
           translate([0,-w_tiefe-arm_len*1.2,0]){
               difference(){
               union(){
                   linear_extrude(w_dicke)spiral(circles = circles, arm_len = arm_len, thickness = thickness);
               cylinder(r = x_n +1, h = w_dicke);
               }
               translate([0,0,w_dicke/2])cube([x_n+0.1,x_n+0.1,w_dicke], center = true);
           }
               }
        }
        for(i = [0,1]){
            a = w_breite/2-6;
            b = w_breite/2.5-6; 
            c = w_breite/3.4-6; 
            translate([a-2*a*i,0,6])sphere(r, $fn = 24);
            
            translate([b-2*b*i,0,6])sphere(r, $fn = 24);
            translate([c-2*c*i,0,6])sphere(r, $fn = 24);
    }
        
    }

}

module 3stuetz(){
translate([-x_a/2-8.4,pos[1],0])stuetze();
translate([-x_a/2+10,pos[1],0])stuetze();
translate([-x_a/2+30.4,pos[1],0])stuetze();
}
module stuetze(){
translate([0,0,0.2])cube([y_a-1,y_a-1,0.4],center = true);
translate([-(y_a-1)/2,0,(z_p-z_a)/2])cube([0.8,y_a,z_p-z_a-0.4], center = true);
translate([-(y_a-1)/2,0,(z_p-z_a)])cube([0.4,y_a,0.4], center = true);
}

  