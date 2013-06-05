
//near the top

/for switch mount DEC
//translate ([0,17,5]) rotate ([-90,0,0]) switch(); //for placement modeling

switch_bracket_screwed();  //positioned for analysis, print on edge. use #2 plastic (1/2 inch long) screws for mounting switch
//translate ([0,46,-40]) rotate ([90,0,0]){
//	idler(); //moved for switch placement check
//}	
translate ([0,28.5,15]) rotate ([-90,0,0]) {
//	bearing_625();
//	translate ([0,0,-5]) import ("44733.stl");
}













// at the bottom
module switch_bracket_screwed() {
  //mounting plate, taken from "acccess hole down center" in the bracket module then modified
	translate([0,3.5,height/2]) rotate([90,0,0]) {
		difference (){
			rotate([0,0,180/8]) cylinder(r=25/2/cos(22.5), h=7,center=true, $fn=8);//oct
			cylinder (r=3.5/2,h=16,center=true,$fn=16);//screw hole
			translate ([0,0,-4]) cylinder (r=4,h=3,center=false,$fn=16);//head relief
		}

		//switch mount
		difference () {
			union() {
				translate ([0,-17.5,-2.5]) cube ([25,25,2],center=true);//plate
				hull(){//makes a filleted top mtg block
					#translate ([0,-24,-7.05+3.5]) cube ([25,12,.1],center=true); //teeny flat bottom
					union() { //rounded corners
						#translate ([11.5,-24,3.5-6-6.725]) rotate ([90,0,0]) cylinder (r=1,h=12,center=true);
						#translate ([-11.5,-24,3.5-6-6.725]) rotate ([90,0,0]) cylinder (r=1,h=12,center=true);
						//#translate ([0,-19,3.5-6-6.725]) rotate ([0,90,0]) cylinder (r=1,h=23,center=true);
					}
					//#translate ([0,-24,3.5-6.95-6.725]) cube ([25,12,.1],center=true);//mtg block
				}

				
			}
			translate ([0,-20,-5]) cylinder (r=bolt_cap_rad+0.5,h=5,center=false);//head clearance
			translate ([0,-20.25,-9]) rotate ([0,0,0]) { //switch holes for plastic screws
				#translate ([9.5/2,-2.4,0]) cylinder (r=0.95,h=10,center=true);
				translate ([-9.5/2,-2.4,0]) cylinder (r=0.95,h=10,center=true);
			}	
		}
	}
} 



module switch() { //models donghai kw4-3z-3 switch
	//body
	difference () {
		cube ([20,10,6.55],center=true);
		translate ([9.5/2,-2.4,0]) cylinder (r=1.25,h=7,center=true);
		translate ([-9.5/2,-2.4,0]) cylinder (r=1.25,h=7,center=true);
	}
	
	//roller
	translate ([8.25,12.2,0]) cylinder (r=4.75/2,h=3.3,center=true);
	//lever
	translate ([1.5,7.5,0]) rotate ([0,0,10]) {
		cube ([20,.4,4], center=true);
		translate ([-10,-1,0]) rotate ([0,0,100]) cube ([2,.4,4], center=true);
	}
	//terminals
	translate ([16.5/2,-7,0]) cube ([.44,4,3.4],center=true);
	translate ([-16.5/2,-7,0]) cube ([.44,4,3.4],center=true);
	translate ([-0.75,-7,0]) cube ([.44,4,3.4],center=true);
}
