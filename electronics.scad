include <declib.scad>
//supply_model ();
//rumba ();

module supply_model () {
	translate ([4.4*25.4+10,-4.7/2*25.4+50/2+2,2.2/2*25.4-30/2]) rotate ([0,90,0]) uxcell_power_entry();
	24V_supply();
}

module uxcell_power_entry () {


	difference () {
		union () {
			radplate (xwid=30,ywid=50,thk=3,rad=3); //faceplate 
			translate([0,0,-21.5]) difference () {
				radplate (xwid=27.25,ywid=47.25,rad=3,thk=21.5); //simplified body, thickness includes connection tabs
				translate ([-sqrt(2)*4-17/2,47.25/2,0]) rotate ([0,0,45]) translate ([-4,-4,0]) cube ([8,8,21.5]);
				translate ([sqrt(2)*4+17/2,47.25/2,0]) rotate ([0,0,45]) translate ([-4,-4,0]) cube ([8,8,21.5]);		
			}
			translate ([0,-16,0]) rotate ([0,-15,0])cube ([16.4,10.4,8],center=true); //apx to the switch
				
		}			

		#scale ([.9,.9,1]) translate([0,0,-17.5]) difference () {
			translate ([0,15,0]) radplate (xwid=27.25,ywid=17.25,rad=3,thk=21.5); //changed the length of the body, shrunk and translated it depth of well in question
			translate ([-sqrt(2)*4-17/2,47.25/2,0]) rotate ([0,0,45]) translate ([-4,-4,0]) cube ([8,8,21.5]);
			translate ([sqrt(2)*4+17/2,47.25/2,0]) rotate ([0,0,45]) translate ([-4,-4,0]) cube ([8,8,21.5]);		
		}	
	}	
}

module 24V_supply () {
	xdim = 8.8*25.4;  //dimensions off of Amazon
	ydim=4.7*25.4;
	zdim=2.2*25.4;
	difference () {
		cube ([xdim,ydim,zdim],center=true); 
		translate ([xdim/2-25/2,0,8]) cube ([25,ydim-2,zdim-8],center=true); //guess for now
	}
}

module rumba () {
	translate ([-10,-10,0]) import ("rumba.stl");
}



/*
intersection  (){
	cube ([10,15,5],center=true);
	translate ([5,0,0]) cylinder (r=10,h=5,$fn=3,center=true);
}
*/