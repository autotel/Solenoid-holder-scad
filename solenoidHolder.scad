/*
Solenoid holder, Joaquin Aldunate
http://autotel.co
*/

//render quality
$fn=80;
//units: mm
//how much space to leave for objects to fit. The 3d printer makes the objects a bit bigger than the design due to the filament's width.
fitOffset=0.25;
fitOffset2=fitOffset*2;

coilDiameter=10;
coilD=16.4;

topCapW=11;
topCapH=10;
topCapD=1.5;

topCuelloDiameter=5;

coilBoxD=coilD+topCapD;

columnD=18;
columnDiameter=4;
columnHeadDiameter=5;
columnHeadD=1.35;

//how much the plastic runner/column goes out of the body
pColumnOutbound=5;
//and how much it goes into the coil
pColumnInbound=1.4;
//how high is the solenoid holder out of the box
holderAmount=1.2;
//when boolean operation creates interfering faces, offset a tiny bit to overlap bodies
tinyBit=0.01;
tinyBit2=tinyBit*2;
//how much body to create around hollow
bodyWidth=1.2;
bodyWidth2=bodyWidth*2;

columnRestDistance=8;

//it is easier to think of the cubes in the same way as square cylinders. This function does that
module prismaCube(W,H,D){
    translate([0,0,D/2]){
        cube([W,H,D],center=true);
    }
}
bottomExtent=(columnRestDistance+columnHeadD);
bottomToRest=columnD+columnHeadD+topCapD+columnRestDistance+3;
union(){
    rotate([-90,0,0]){
        difference(){
            union(){
                prismaCube(topCapW+bodyWidth2,topCapH+bodyWidth2,coilBoxD+bodyWidth2+pColumnOutbound);
                translate([0,0,-bottomExtent]){
                    prismaCube(columnHeadDiameter+bodyWidth2,topCapH+bodyWidth2,bottomExtent);
                }
            }
            //cutout half of the container
            union(){
                translate([-100,-200,-tinyBit]){
                    cube(200,100,100);
                }
                translate([-100,-200-columnDiameter/2-bodyWidth,-100]){
 cube(200,200,200);
                }
            }
            translate([0,0,bodyWidth]){
                union(){
                    //sustraction of the solenoid shape
                    cylinder(d=coilDiameter+fitOffset2, h=coilD+topCapD+fitOffset2);
                    prismaCube(topCapW+fitOffset2,topCapH+fitOffset2,topCapD+fitOffset2);
                    //adding the part that holds the plastic runner/column
                    translate([0,0,-bottomExtent]){
                        cylinder(d=topCuelloDiameter+fitOffset2, h=bottomToRest);
                        translate([0,0,-bodyWidth-tinyBit]){
                            cylinder(d=columnDiameter+fitOffset2, h=bottomToRest);
                        }
                    }
                }
            }
        }
    }

    //make holder
    difference(){
        rotate([-90,0,0]){
            translate([0,0,bodyWidth+topCapD+fitOffset2]){
                difference(){
                    cylinder(d=coilDiameter+fitOffset2+bodyWidth*1.5, h=coilD-fitOffset2-topCapD+tinyBit);
                    translate([0,0,-tinyBit]){
                        cylinder(d=coilDiameter+fitOffset2, h=coilD-fitOffset2+tinyBit2);
                    }
                 }
            }
        }
        translate([0,0,holderAmount]){
            prismaCube(100,100,100);
        }
    }
}

//make sliding plastic column
rotate([-90,0,0]){
    union(){
        //sustraction of the solenoid shape
        //adding the part that holds the plastic runner/column
        translate([0,0,-bottomExtent]){
            
            translate([0,0,fitOffset+bodyWidth]){
                cylinder(d=topCuelloDiameter-fitOffset2, h=columnHeadD);
                
            }
            translate([0,0,-pColumnOutbound]){
                cylinder(d=columnDiameter-fitOffset2, h=bottomExtent+bodyWidth+pColumnOutbound+pColumnInbound);
            }
        }
    }
}





