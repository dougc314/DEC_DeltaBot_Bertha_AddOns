include <configuration.scad>
include <declib.scad>


tri_side = 444.667;
inCircleRad = sqrt(3)/6*tri_side;  // radius of the circle that is tangent to the beam centers
plateRad = 14/2*24.5;
plateThk = 0.25*25.4;
plateLift = 15; // bottom of plate to top of 2060 triangle
legLift = 10; //how much the leg lifts the plate
springod = 0.218*25.4;
springLift = 10; // how much the spring lifts the plate (apx)

//plate ();
//leg();
//translate ([-10,0,0])cube ([20,10,5],center=true);
//support_arm();


/*
hull() {
	cube ([50,.01,20],center=true);
	//rotate ([0,90,0]) cube ([50,.01,20],center=true);
	translate ([0,100,0]) rotate ([90,0,0]) radplate (xwid=50,ywid=50,rad=4,thk=.01);
}


hull() {
	//cube ([50,.01,20],center=true);
	rotate ([0,90,0]) cube ([50,.01,20],center=true);
	translate ([0,100,0]) rotate ([90,0,0]) radplate (xwid=50,ywid=50,rad=4,thk=.01);
}	

*/
//cube ([500,500,.001],center=true);
support_arm(leg=true);
support_arm (arm=true);


module support_arm (arm=false,leg=false){
	beamTop = 30; // distance to center of triangle 2060
	triRad = 150; //radius of inscribed circle
	supportThk=15;
	plateHgt = beamTop+plateLift; //bottom of plate
	supportHgt= plateHgt-legLift-springLift-supportThk;
	supportRad=plateRad;
	beamThk=4;
	bedDelta = plateRad-inCircleRad-10;  // how much the bed is past the outer edge of the 2060 beams
	

	if (arm==true)
	difference (){  //arm
		union() {

				translate ([0,bedDelta+bodyLen/2-overHang,supportHgt]) rotate([0,0,0]) radplate (xwid=bodyWid,ywid=bodyLen,thk=supportThk,rad=4) ; //mount
				rotate ([-90,0,0]) radplate (xwid=80,ywid=60,thk=5,rad=4); //plate
				hull(){ //beam
					translate ([6,bedDelta+bodyLen/2-overHang,supportHgt+supportThk-0]) rotate ([0,0,0]) radplate (xwid=beamThk,ywid=bodyLen,thk=.01,rad=beamThk/2);
					translate ([20,0,0]) rotate ([-90,0,0]) radplate (xwid=beamThk,ywid=40,thk=.01,rad=beamThk/2);
				}
				hull(){//beam
					translate ([-6,bedDelta+bodyLen/2-overHang,supportHgt+supportThk-0]) rotate ([0,0,0]) radplate (xwid=beamThk,ywid=bodyLen,thk=.01,rad=beamThk/2);
					translate ([-20,0,0]) rotate ([-90,0,0]) radplate (xwid=beamThk,ywid=40,thk=.01,rad=beamThk/2);
				}
				translate ([20,5,0]) rotate ([0,90,0]) obround_rod(rlen=40,rwid=beamThk*2) ; //joint strengtheners
				translate ([-20,5,0]) rotate ([0,90,0]) obround_rod(rlen=40,rwid=beamThk*2);
				translate ([0,5,supportHgt+2.5]) rotate ([0,0,0]) obround_rod (rwid=beamThk*2,rlen=48);
				
				 translate([0,0,supportHgt+2.5])  hull () {  //strengthen for printing in y axis
					cube ([40,.01,5], center=true);
					translate ([0,bedDelta,0]) cube ([bodyWid,.01,5],center=true);
				}	

		}
		rotate ([-90,0,0]) {
			cylinder (r=bolt_rad,h=10);
			translate ([-30,0,0]) cylinder (r=bolt_rad,h=10);
			translate ([30,0,0]) cylinder (r=bolt_rad,h=10);
			translate ([0,20,0]) {
				translate ([-30,0,0]) cylinder (r=bolt_rad,h=10);
				translate ([30,0,0]) cylinder (r=bolt_rad,h=10);		
			}
			translate ([0,-20,0]) {
				translate ([-30,0,0]) cylinder (r=bolt_rad,h=10);
				translate ([30,0,0]) cylinder (r=bolt_rad,h=10);		
			}
		}
		translate ([0,bedDelta+(bodyLen-overHang)/2,supportHgt]) {
				cylinder (r=bolt_rad,h=supportThk*2); //screw hole
				//translate ([0,0,0]) cylinder (r=nut_rad,h=nut_height,$fn=6);  //nut hole - cant be a hole in the bottom
				translate ([0,5,5]) hull () {  //open ended, bottom supported well for a 5mm nylon lock nut
					translate ([-8.1/2,0,0]) cube ([8.1,8,5.1]);
					translate ([0,-5,0]) rotate ([0,0,30]) cylinder (r=9/2,h=5.1 , $fn=6);
				}
				translate ([0,0,supportThk-springRad]) cylinder (r=springRad+1,h=springRad); //spring well
		}	
	}
		// make a clip that can hold the heated bed
	overTop=4;  //thickness of top overHang
	overHang=10; //length of overHang
	bodyWid=24;
	bodyLen=30;
	bodyHgt = legLift + plateThk + overTop;
	rad = 3;  //corner rads
	springRad = springod/2;
	if (leg==true)
		//translate ([0,0,bodyWid/2]) rotate ([90,0,0]) {//place for printing
		translate ([0,bedDelta,supportHgt+supportThk+springLift]) rotate ([0,0,0]) { //for placement analysis 
		difference (){//body
			union(){
				translate ([0,bodyLen/2-overHang,0])   //([0,-bodyLen/2+overHang,0]) 
				hull() {
					translate ([bodyWid/2-rad,bodyLen/2-rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([-bodyWid/2+rad,-bodyLen/2+rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([bodyWid/2-rad,-bodyLen/2+rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([-bodyWid/2+rad,bodyLen/2-rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
				}
				translate ([0,0,bodyHgt]) rotate ([0,90,0]) cylinder (r=rad,h=bodyWid,center=true); //beef up the top corner
			}
			translate ([0,-plateRad,bodyHgt-plateThk-overTop]) plate (); 
			translate ([0,-overHang/2,bodyHgt-plateThk-overTop-3]) {
				cylinder (r=5.6/2,h=3,$fn=6); //3mm nut trap
				cylinder (r=3.5/2,h=legLift+6,center=true,$fn=12); //3mm screw hole
				translate ([0,0,-legLift]) cylinder (r=4.5,h=6); //headhole
			}
			translate ([0,(bodyLen-overHang)/2,0]) {
				cylinder (r=bolt_rad,h=bodyHgt*2); //screw hole
				translate ([0,0,bodyHgt-4]) cylinder (r=bolt_cap_rad,h=4);  //head hole
				cylinder (r=springRad+1,h=springRad);
			}	
			
		}
	}
}  

module leg (){
	// make a clip that can hold the heated bed
	overTop=4;  //thickness of top overHang
	overHang=10; //length of overHang
	bodyWid=16;
	bodyLen=25;
	bodyHgt = legLift + plateThk + overTop;
	rad =3;  //corner rads
	//translate ([0,0,bodyWid/2]) rotate ([90,0,0]) {//place for printing
		difference (){//body
			union(){
				translate ([-bodyLen/2+overHang,0,0]) 
				hull() {
					translate ([bodyLen/2-rad,bodyWid/2-rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([-bodyLen/2+rad,-bodyWid/2+rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([bodyLen/2-rad,-bodyWid/2+rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
					translate ([-bodyLen/2+rad,bodyWid/2-rad,0]) cylinder (r=rad,h=bodyHgt,$fn=16);
				}
				translate ([0,0,bodyHgt]) rotate ([90,0,0]) cylinder (r=rad,h=bodyWid,center=true); //beef up the top corner
			}
			translate ([plateRad,0,bodyHgt-plateThk-overTop]) plate (); 
			translate ([overHang/2,0,bodyHgt-plateThk-overTop-3]) {
				cylinder (r=5.6/2,h=3,$fn=6); //3mm nut trap
				cylinder (r=3.5/2,h=bodyHgt,center=true,$fn=12); //3mm screw hole
			}
		}
	//}
}

module plate (r=plateRad,h=plateThk) { cylinder (r=r,h=h,$fn=32); }



