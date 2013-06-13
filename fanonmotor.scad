include <declib.scad>;
include <stepper-motors.scad>


fanholder();
module fanholder(){
	difference () {
	//body
	union () {
		radplate (xwid=46,ywid=46,rad=6,thk=48); //motor grabber 
	

			union (){ //fan mtg screw bosses
				translate ([25,25,-40]) cylinder (r=5,h=10);
				translate ([-25,-25,-40]) cylinder (r=5,h=10);
				translate ([25,-25,-40]) cylinder (r=5,h=10);
				translate ([-25,25,-40]) cylinder (r=5,h=10);
			}


	
	
			hull (){//fan standoff
				translate ([0,0,-40]) radplate (xwid=60,ywid=60,thk=0.01,rad=6);
				radplate (xwid=46,ywid=46,rad=6,thk=0.01);
			}

	
	
		}
	
		translate ([0,0,3]) radplate (xwid=43,ywid=43,rad=6,thk=50); //motor hole
		translate ([0,0,28]) cube ([60,30,30],center=true); //air fow motor
		rotate ([0,0,,90])   translate ([0,0,28]) cube ([60,30,30],center=true); //airflow motor
		hull (){ //remove most of fan standoff
			translate ([0,0,-40]) cylinder (r=58/2,h=0.01);
			translate ([0,0,0]) radplate (xwid=40,ywid=40,rad=6,thk=0.01);
		}
		translate ([0,0,-18]) cube ([60,34,36],center=true); //air flow fan
		rotate ([0,0,90])  translate ([0,0,-18]) cube ([60,34,36],center=true); //airflow fan
		cylinder (r=38/2,h=10,center=true);
		union (){ //screw holes
			translate ([25,25,-40]) cylinder (r=3.25/2,h=20);
			translate ([-25,-25,-40]) cylinder (r=3.25/2,h=20);
			translate ([25,-25,-40]) cylinder (r=3.25/2,h=20);
			translate ([-25,25,-40]) cylinder (r=3.25/2,h=20);
		}
		translate ([0,0,7]) union (){ //nut wells
			translate ([25,25,-40]) cylinder (r=5.6/2,h=20);
			translate ([-25,-25,-40]) cylinder (r=5.6/2,h=20);
			translate ([25,-25,-40]) cylinder (r=5.6/2,h=20);
			translate ([-25,25,-40]) cylinder (r=5.6/2,h=20);
		}
  
	}
	union (){ //joint strengthener
		translate ([19,19,-1]) sphere (r=4);
		translate ([-19,-19,-1]) sphere (r=4);
		translate ([19,-19,-1]) sphere (r=4);
		translate ([-19,19,-1]) sphere (r=4);
	}
	translate ([0,0,-40]) difference () { //print brim
		radplate (xwid=65,ywid=65,rad=6,thk=0.25);
		cylinder (r=52/2,h=0.25);
	}
}

//translate ([0,0,50.5]) NEMA(NEMA17);

