



pi = 3.1415789;
ni = 1.0905e-3;  //bulk resistivity of 80-20 Nichrome wire Ohm-mm
rm=170;
watts = 250;
volts=23;


/*
union() {
	arcs (g=25,rm=170,n=6,a=60);
	translate ([0,0,5]) pegs(g=25,rm=170,n=6,a=60);
}



rotate ([0,0,90]) {
	difference() {
		arcs (g=25,rm=170,n=6,a=60);
		slots(g=25,rm=170,n=6,a=60);	
	}
}
*/
//sprials();
//serpentine_jig_22ga ();
//serpentine_jig_26ga();
//serpentine_jig_24ga();
serpentine_jig_28ga();


//arcwall (r=100,h=5,t=1,s=8,a=45);
//rotate ([0,0,22.5]) translate ([100,0,0]) peg (4,5,1);

module sprials(){
rotate ([0,0,240]) arche_wall (ro=170,ri=42*1/3,gap=42,h=3,t=5,s=360);
rotate ([0,0,120]) arche_wall (ro=170,ri=42*2/3,gap=42,h=3,t=5,s=360);
rotate ([0,0,0]) arche_wall (ro=170,ri=42*3/3,gap=42,h=3,t=5,s=360);
 for (i=[0:4]) {
	rotate ([0,0,i*90]) translate ([10,-3,0])cube([160,5,3]);
	rotate ([0,0,i*90]) translate ([10,3,0])cube([160,5,3]);	
	rotate ([0,0,i*90-15]) translate ([10,0,0]) cube([160,5,3]);
	rotate ([0,0,i*90+15]) translate ([10,0,0]) cube([160,5,3]);
	rotate ([0,0,i*90+45]) translate ([10,0,0]) cube([160,5,3]);
	
}
}

module serpentine_jig_22ga(){
	arcs(g=10,rm=170,n=16,wedges=4);	
	$fn=16;
	translate ([0,0,3]) pegs(g=10,rm=170,n=16,wedges=4,sw=awg_dia(22)*1.5);				
}

module serpentine_jig_26ga(){
	arcs(g=15,rm=170,n=10,wedges=5);	
	$fn=16;
	translate ([0,0,3]) pegs(g=15,rm=170,n=10,wedges=5,sw=awg_dia(26)*1.5);

}

module serpentine_jig_24ga(){
	arcs(g=15,rm=170,n=10,wedges=4);	
	$fn=16;
	translate ([0,0,3]) pegs(g=15,rm=170,n=10,wedges=4,sw=awg_dia(24)*1.5);
		
	
}

module serpentine_jig_28ga(){
	arcs(g=18.8,rm=170,n=8,wedges=6);	
	$fn=16;
	translate ([0,0,3]) pegs(g=18.8,rm=170,n=8,wedges=6,sw = awg_dia(28)*1.5);
}



  

module arcs_slots (g,rm,n) {

	difference(){
		union() {
			for (i=[0:n-1]){
				//assign (radm = (rm-g*i)) assign (radc = (radm-g/2)) assign (arcang=arcangle(radc,g)) assign (conang = (g/(2*pi*radc)*360))
				rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*(g/(2*pi*(rm-g*i-g/2))*360)]) {	
					translate ([(rm-g*i-g/2),0,0]) scale ([1,(i%2)*2-1,1]) arcwall (r=g/2,h=5,t=8,s=8,a=180); 
					arcwall(r=(rm-g*i),h=5,t=8,s=8,a=((i%2)*2-1)*-arcangle(rm-g*i-g/2,g,i));
				}		
			}
		} 
		union() {
			for (i=[0:n-1]){
				//assign (radm = rm-g*i) assign (radc = radm-g/2) assign (arcang=arcangle(radc,g)) assign (conang = g/(2*pi*radc)*360)
				rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*(g/(2*pi*(rm-g*i-g/2))*360)]) {	
					translate ([(rm-g*i-g/2),0,4])  scale ([1,(i%2)*2-1,1]) arcwall (r=g/2,h=2,t=1,s=8,a=180);
					translate ([0,0,4]) arcwall (r=(rm-g*i),h=2,t=1,s=8,a=((i%2)*2-1)*-arcangle(rm-g*i-g/2,g,i));
				}
			}
		}		
	}
}







 module arcs (g,rm,n,wedges){
	
	
	union (){
		for (i=[0:n-1]){
			assign (radm = rm-g*i) assign (radc = radm-g/2) assign ( wedgeang=360/wedges) assign (arcang=arcangle(radc,g,wedgeang)) assign (conang = g/(2*pi*radc)*360) 
			assign (stiffang = g/(2*pi*(radc+g))*360)
			if(conang<wedgeang/2) {
				rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*conang]) {  //puts the connector arcs g (along the cirfumference) away from the wedge edges, alternating
					union() {
						translate ([radc,0,0]) {
							scale ([1,(i%2)*2-1,1]) arcwall (r=g/2,h=3,t=5,s=8,a=180);  //the half circle connector							
							if (i>0) rotate ([0,0,conang*((i%2)*2-1)]) translate ([g,0,0]) cylinder (r=g/2,h=3);  //stiffener dot	
						}
						arcwall(r=radm,h=3,t=5,s=8,a=((i%2)*2-1)*-arcang);  //the arc
						if (i==0) {
							for (ti=[0:2]) {
								tape_holder (rad=radm+10,ang=(arcang)/3*(ti+0.5)-2.5); //translate ([180,0,0]) cylinder (r=1,h=6);
							}
						}
					}
					echo("conang: ",conang);
				}
			}	
			else { 
			assign(tweakconang=wedgeang/2)
				rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*tweakconang]) {  
					union() {
					translate ([radc,0,0]) scale ([1,(i%2)*2-1,1]) arcwall (r=g/2,h=3,t=5,s=8,a=180); 
						rotate ([0,0,(tweakconang-conang)/2]) arcwall(r=radm,h=3,t=5,s=8,a=((i%2)*2-1)*-arcang);
						//rotate ([0,0,conang*((i%2)*2-1)]) translate ([g,0,0]) cylinder (r=g/2,h=3);  //stiffener dot	
					}
				}		
			}
		}
	}
}

module tape_holder  (ang,rad) {
	rotate ([0,0,ang]) arcwall (r=rad,a=5,t=5,s=4,h=3);
	rotate ([0,0,ang])translate ([rad-5,0,1.5]) cube ([10,5,3], center=true);
	rotate ([0,0,ang+5])translate ([rad-5,0,1.5]) cube ([10,5,3], center=true);	
}	

module slots (g,rm,n){
	union() {
		for (i=[0:n-1]){
			assign (radm = rm-g*i) assign (radc = radm-g/2) assign (arcang=arcangle(radc,g)) assign (conang = g/(2*pi*radc)*360)
			rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*conang]) { 
				translate ([0,0,4]) union() {
					translate ([radc,0,0])  scale ([1,(i%2)*2-1,1]) arcwall (r=g/2,h=2,t=1,s=8,a=180);
					arcwall (r=radm,h=2,t=1,s=8,a=((i%2)*2-1)*-arcang);
				}
			}
		}
	}
}

module pegs (g,rm,n,wedges,sw) {

	for (i=[0:n-1]){
		//the calculation of pegn is a bit of a fudge but seems to work
		assign (radm = rm-g*i) assign (radc = radm-g/2) assign (wedgeang=360/wedges) assign (arcang=arcangle(radc,g,wedgeang)) assign (conang = g/(2*pi*radc)*360) assign (arclen = (rm-g*i)*2*pi/360*arcang) 
		assign (  pegn = min(4,round(arclen/12)))
		if (conang<wedgeang/2){
			rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*conang]) {
			
			
				for (k=[0:pegn-1]){
					 if ((k>0) && (k < (pegn-1))) rotate ([0,0,-arcang/(pegn-1)*k*((i%2)*2-1)]) translate ([radm,0,0]) peg(r=3,h=3,s=sw); // put the if  in front to remove the end pegs: if ((k>0) && (k < (pegn-1)))
				}
				//rotate ([0,0,conang/2*((i%2)*2-1)]) translate ([radc,0,0]) rotate ([0,0,90]) peg(r=3,h=3,s=sw+.5);// corner pegs have bigger slots
				translate ([radc,0,-3]) rotate ([0,0,90]) peg(r=g/2,h=6,s=0); //big peg just wrap around it, 0 slot worked!
			}
		}
		else { 
		assign (tweakconang=wedgeang/2)
			rotate ([0,0,wedgeang*(i%2)-1*((i%2)*2-1)*tweakconang]) {
				echo("conang set to wedgeang/2");
				for (k=[0:3]){
					rotate ([0,0,-arcang/3*k*((i%2)*2-1)]) translate ([radm,0,0]) peg(r=3,h=3,s=sw);//tweaked
				}
				rotate ([0,0,conang/2*((i%2)*2-1)]) translate ([radc,0,0]) rotate ([0,0,70]) peg(r=3,h=3,s=sw+.5); //tweaked
			}
		}
	
	}
}

module peg (r,h,s){
	translate ([0,0,h/2]) rotate ([0,0,90]) difference() {
		cylinder (r=r,h=h,center=true);
		cube([2*r,s,h],center=true);
	}
}

function arcangle(radc,g,wedgeang) = wedgeang - (g/2/pi/radc +g/2/pi/(radc+g))*360 ;



module arcwall(r,h,t,s,a){
//radius height thickness segments angle
	for (i=[0:s-1]){
		hull() {
			rotate ([0,0,a/s*i]) translate ([r,0,0]) cylinder(r=t/2,h=h);
			rotate ([0,0,a/s*(i+1)]) translate ([r,0,0]) cylinder(r=t/2,h=h);
		}
	}
}

module arche_wall (ro,ri,gap,h,t,s){
	b=gap/360;
	N=(ro-ri)/gap;
	A=N*360;
	for (k=[0:s-1]) {
		hull(){
		   rotate ([0,0,A/s*k]) translate ([ri+b*A/s*k,0,0]) cylinder(r=t/2,h=h);
		   rotate ([0,0,A/s*(k+1)]) translate ([ri+b*A/s*(k+1),0,0]) cylinder(r=t/2,h=h);	
		}
	}
}


			

function awg_dia (ga) = exp(2.1104 - 0.11594*ga);  //calculates the diameter (mm) of a wire of AWG ga
function res(w,v) = v*v/w;  //resistance from volts and Watts

//echo (ni);
function wire_len(w,v,ga,rb) =  res(w,v)*pi*awg_dia(ga)*awg_dia(ga)/4/ni;  //calculates the length in mm of a nichrome wire of AWG ga that generates w Watts for Voltage v

function gaps(rm,gap) = rm/gap;

function inc (a,i) = a+i;








	