//*****************************************************************
// Name: Tyler Bartlett
// Class:CS360 Fall 2018
// Class time: 1300-1350
// Date: 10/08/18
// Project #: Lab 1
// Driver Name: NA
// Program Description: A simple render of a pyramid with a hollow spherical hollow
//                      center and crossed rings sitting inside it.
// Test Oracle: NA
//				
// NOTES:
//
//*****************************************************************   


// perspective (default) camera
camera {  
    perspective
    location  <4, 1.5, 4>
    look_at   <0.0, 1.0,  0.0>
}

// light source
light_source {
    <4,1.5,4>,
    color rgb <0.95,0.95,0.85>
}

// Create the pyramid with center removed                      
intersection{ //----------------------------------------------------------------
    // linear prism in x-direction: from ... to ..., number of points (first = last)
    prism { 
        linear_spline
        -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
    } // end of prism --------------------------------------------------------

    // linear prism in z-direction: from ,to ,number of points (first = last)
    prism { 
        linear_spline                                                                              
        -1.00 ,1.00 , 4
        <-1.00, 0.00>,  // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>, 
       <-1.00, 0.00>   // last point = first point!!!!
       rotate<-90,0,0>  
    } // end of prism --------------------------------------------------------
    
    sphere { <0,0.03,0>, 1.04 inverse}
    
    texture { 
        pigment{ color rgb<0.00, 1.00, 0.00>}
        finish { phong 1.0 reflection 0.00}
    } // end of texture
    rotate<0,15,0>
    scale <2, 2, 2> 
}// ------------------------------------------------------- end of intersection

//create the crossed-rings
union { //---------------------------------------
    torus { 1.0, 0.15 rotate<20,0,0> }
                    
    torus { 1.0, 0.15 rotate<20,0,95> }   

    texture { 
        pigment{ color rgb<1,0,0,>}
        finish { phong 1 reflection 0 } 
    } // end of texture
    scale <1,1,1> translate<0,1.0,0>
} //----------------end union  

//----------------------------------------------------------------------------------------- 
