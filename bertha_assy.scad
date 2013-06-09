//include <effectors.scad>;  //effectors and brackets use the same variable namse and whack the other
include <brackets.scad>;
include <stepper-motors.scad>;
include <bedmtg.scad>;
include <electronics.scad>;



tri_side = 444.667;
inCircleRad = sqrt(3)/6*tri_side;
echo ("incirclerad: ",inCircleRad); //radius of a circle that is tangent to the beam centers
tower_len = 1000;
tri_rad = sin(60)*tri_side/1.5;
bracket_offset=46;
motor_offset = 94.18;
extrusion_len = 350;
tower_colors = ["red","green","blue"];

or_offset=3;
or_flat=19.5;
or_thick=2.37;
 
 
render (convexity=10) brackets();
render (convexity=10) tri_sides();
//render (convexity=10) posts();
//render (convexity=10) rail_effectors();
//translate ([0,0,470]) hotend_effector();
//translate ([0,0,60+plateLift]) plate();
/*translate ([0,inCircleRad+10,30]) {
	support_arm(leg=true);
	support_arm (arm=true);

}*/

rotate ([0,0,-30]) translate ([-135/2-32,-75/2,6])rumba();
rotate ([0,0,-30]) translate ([-35,0,-3]) rumba_plate ();

bottom_plate ();
//top_plate ();  

module rumba_plate () {
  cube ([140,80,6], center=true); 
}

rotate ([0,0,-30]) translate ([60,0,30]) rotate ([0,90,0]) 60mmfan ();

module 60mmfan () {
	cube ([60,60,25],center=true);
}

module top_plate () {
	translate ([0,0,-6+60]) {
		intersection () {
			  rotate ([0,0,30]) cylinder (r=tri_rad-22,h=6,$fn=3);
			rotate ([0,0,-30]) cylinder (r=tri_rad-bracket_offset,h=6,$fn=3);
		}
	}
}

module bottom_plate (){
	difference () {
		translate ([0,0,-6]) {
			intersection () {
				rotate ([0,0,30]) cylinder (r=tri_rad+20,h=6,$fn=3);
				rotate ([0,0,-30]) cylinder (r=tri_rad-bracket_offset,h=6,$fn=3);
			}
		}
		rotate ([0,0,-30]) translate ([-145/2-35,-85/2,-6]) cube ([145,85,6]);	
	}
}




//NEMA (NEMA17);
//#cylinder (r=inCircleRad,h=60);


//goofy ideas start
//gusset plates
/*
//translate ([-60,-tri_rad+60,0,970]) rotate ([90,0,-60]) cube ([60,60,5]);
 translate ([-60/sin(60),-tri_rad+90,970]) rotate ([-90,0,-60]) {
	translate ([-30,-30,0]) cube ([60,60,5]);
	//translate ([-10,-30,-5]) cube ([20,60,10]);
}

translate ([0,-tri_rad+bracket_offset-30,900]) rotate ([90,90,270]) union(){
	translate ([-30,-30,10]) cube ([60,60,5]);
	//rotate ([0,0,90]) translate ([-10,-30,10]) cube ([20,60,10]);
}*/
//heaters
/*translate ([0,0,60]) cylinder (r=200,h=8);//linear_extrude(height=8) circle(r=240,$fn=6)
color ("red"){
translate ([-175,-75,68]) cube ([90,150,4]);
translate ([85,-75,68]) cube ([90,150,4]);
translate ([-45,-175,68]) cube ([90,150,4]);
translate ([-45,25,68]) cube ([90,150,4]);
}
color ("red"){
	translate ([-45,-75,68]) cube ([90,150,4]);
	for (a=[0:3]) {
		rotate ([0,0,a*360/4]) translate ([-175,-75,68]) cube ([90,150,4]);
	}
}*/
//color ("red") translate ([-6*25.4,-6*25.4,68]) cube ([12*25.4,12*25.4,4]);

//translate ([-tri_rad,0,0]) rotate ([0,0,120]) translate ([0,-5,0])import ("60dega_2020_2060.stl");





//goofy ideas stop


module rail_effectors(){
	for (a=[0:2]){
		rotate ([0,0,a*120]) translate ([0,-tri_rad+bracket_offset+23.3,870]) rotate ([90,0,0]) rail_effector_assy ();
	}
}



module posts() {
	for (a=[0:2]){
		rotate ([0,0,120*a]){
			translate ([0,-30-tri_rad+bracket_offset,tower_len/2]) extrusion(tower_len);
			translate ([-or_offset-or_flat/2,or_thick-tri_rad+bracket_offset,940-750]) rotate ([0,0,0]) import_stl("or_750mm.stl");
			translate ([or_offset+or_flat/2,or_thick-tri_rad+bracket_offset,940-750]) rotate ([0,0,180]) import_stl("or_750mm.stl");
		}
	}
}	
	
	
	

module tri_sides () {
	for (a=[0:2]) {
		rotate ([0,0,a*120]){
			rotate ([90,0,90])translate ([tri_rad/2,30,0]) extrusion (extrusion_len);
			//translate ([0,0,940]) rotate ([90,0,90])translate ([tri_rad/2,30,0]) extrusion (extrusion_len);
		}
	}
}

module brackets () {
	for (a=[0:2]) rotate ([0,0,a*120]) {
		translate ([0,-tri_rad+bracket_offset,0]) {
			 color (tower_colors[a]) bracket(motor=true);
			translate ([0,0,940]) {
				color (tower_colors[a]) {
					//bracket(motor=false);
					//idler();
				}
			}
		}
		translate ([0,-tri_rad+motor_offset,30]) rotate ([90,0,0]) NEMA (NEMA17);
	}	
}



module extrusion (len) {
	color ("silver") translate ([-10,-30,0]) 
	scale ([25.4,25.4,1]) linear_extrude(height = len, center = true, convexity = 10)
	 import_dxf(file = "2060b.dxf");
}	 

module open_rail (len){
	import("or_750mm.stl");
}
	 
		 