/* [Die] */

// Distance between opposite sides of the die
rect_height = 15; // [10:100]

/* [Face text] */

// Font to use for the faces
text_font = "Papyrus";
// Size of the text for the faces
text_size = 3.0; // [1:100]
// Depth of the text
text_depth = 0.2;
text_extrude = text_depth * 2;

// Text to use the for "1" face
1_text = "1";
// Text to use the for "2" face
2_text = "2";
// Text to use the for "3" face
3_text = "3";
// Text to use the for "4" face
4_text = "4";
// Text to use the for "5" face
5_text = "5";
// Text to use the for "6" face
6_text = "6";
// Text to use the for "7" face
7_text = "7";
// Text to use the for "8" face
8_text = "8";
// Text to use the for "9" face
9_text = "9";
// Text to use the for "10" face
10_text = "10";
// Text to use the for "11" face
11_text = "11";
// Text to use the for "12" face
12_text = "12";
// Text to use the for "13" face
13_text = "13";
// Text to use the for "14" face
14_text = "14";
// Text to use the for "15" face
15_text = "15";
// Text to use the for "16" face
16_text = "16";
// Text to use the for "17" face
17_text = "17";
// Text to use the for "18" face
18_text = "18";
// Text to use the for "19" face
19_text = "19";
// Text to use the for "20" face
20_text = "20";

PHI=(1+sqrt(5))/2;

edge_length = rect_height/PHI;
triangle_face_height = (edge_length/2) * sqrt(3);

diameter = sqrt(pow(rect_height,2) + pow(edge_length,2));
radius = diameter/2;

// https://en.wikipedia.org/wiki/Dihedral_angle
dihedral_angle = acos(-sqrt(5)/3);
original_side_angle = dihedral_angle/2;
fifth = 360/5;

//Taken from: http://en.wikipedia.org/wiki/Icosahedron#Cartesian_coordinates
//Specifically: http://en.wikipedia.org/w/index.php?title=Icosahedron&oldid=568753314#Cartesian_coordinates
points = [
  [0,-1,-PHI], //1
  [0,-1,PHI],  //2
  [0,1,-PHI],  //3
  [0,1,PHI],   //4
  [-1,-PHI,0], //5
  [-1,PHI,0],  //6
  [1,-PHI,0],  //7
  [1,PHI,0],   //8
  [-PHI,0,-1], //9
  [PHI,0,-1],  //10
  [-PHI,0,1],  //11
  [PHI,0,1]    //12
]*edge_length/2;

faces =[
  [3,5,7],  // 1
  [5,3,10], // 2
  [1,10,3], // 3
  [1,3,11], // 4
  [3,7,11], // 5
  [11,7,9], // 6
  [7,2,9],  // 7
  [5,2,7],  // 8
  [8,2,5],  // 9
  [10,8,5], // 10
  [8,10,4], // 11
  [1,4,10], // 12
  [1,6,4],  // 13
  [1,11,6], // 14
  [6,11,9], // 15
  [0,6,9],  // 16
  [2,0,9],  // 17
  [0,2,8],  // 18
  [0,8,4],  // 19
  [6,0,4]   // 20
];

function towards_origin (start_point, distance) = (-start_point/norm(start_point))*distance;

module side_text (string, triangle_center, rotation) {
  translate(triangle_center)
  translate(towards_origin(triangle_center, text_depth))
  rotate(rotation)

  linear_extrude(height = text_depth*2)
  text(string, halign = "center", valign = "center", font = text_font, size = text_size);
}


difference() {
  polyhedron_angle = atan(edge_length/rect_height);
  color("red") {
    rotate([polyhedron_angle, 0, 0])
    polyhedron(points, faces);
  }

  color("blue") {
    side_angle = original_side_angle + polyhedron_angle;
    top_bottom_angle = 90 - original_side_angle + polyhedron_angle;

    tri_depth = sin(top_bottom_angle)*triangle_face_height;
    tri_height = tri_depth/tan(top_bottom_angle); // TODO: Make this independent of the tri_depth

    top_y = tri_depth * 2/3;
    top_z = radius - (tri_height * 2/3);

    // Top
    side_text(1_text, [0, top_y, top_z], [90-top_bottom_angle, 0, 180]);

    rotate([0,0,fifth])
      side_text(2_text, [0, top_y, top_z], [90-top_bottom_angle, 0, 180]);

    rotate([0,0,2*fifth])
      side_text(3_text, [0, top_y, top_z], [90-top_bottom_angle, 0, 180]);

    rotate([0,0,3*fifth])
      side_text(4_text, [0, top_y, top_z], [90-top_bottom_angle, 0, 180]);

    rotate([0,0,4*fifth])
      side_text(5_text, [0, top_y, top_z], [90-top_bottom_angle, 0, 180]);

    // Middle
    middle_tri_depth = -cos(side_angle)*triangle_face_height;
    middle_tri_height = sin(side_angle)*triangle_face_height;

    middle_y = tri_depth + middle_tri_depth/3; // TODO: I think this is wrong
    middle_z = middle_tri_height/2 - middle_tri_height/3;

    side_text(8_text, [0, middle_y, middle_z], [side_angle+180, 0, 0]);

    rotate([0, 0, fifth/2])
      side_text(9_text, [0, middle_y, -middle_z], [side_angle+180, 180, 0]);

    rotate([0, 0, fifth])
      side_text(10_text, [0, middle_y, middle_z], [side_angle+180, 0, 0]);

    rotate([0, 0, 3*fifth/2])
      side_text(11_text, [0, middle_y, -middle_z], [side_angle+180, 180, 0]);

    rotate([0, 0, 2*fifth])
      side_text(12_text, [0, middle_y, middle_z], [side_angle+180, 0, 0]);

    rotate([0, 0, 5*fifth/2])
      side_text(13_text, [0, middle_y, -middle_z], [side_angle+180, 180, 0]);

    rotate([0, 0, 3*fifth])
      side_text(14_text, [0, middle_y, middle_z], [side_angle+180, 0, 0]);

    rotate([0, 0, 7*fifth/2])
      side_text(15_text, [0, middle_y, -middle_z], [side_angle+180, 180, 0]);

    rotate([0, 0, 4*fifth])
      side_text(6_text, [0, middle_y, middle_z], [side_angle+180, 0, 0]);

    rotate([0, 0, 9*fifth/2])
      side_text(7_text, [0, middle_y, -middle_z], [side_angle+180, 180, 0]);

    // Bottom
    bottom_y = -top_y;
    bottom_z = -top_z;

    side_text(20_text, [0, bottom_y, bottom_z], [90-top_bottom_angle+180, 0, 180]);

    rotate([0,0,4*fifth])
      side_text(19_text, [0, bottom_y, bottom_z], [90-top_bottom_angle+180, 0, 180]);

    rotate([0,0,3*fifth])
      side_text(18_text, [0, bottom_y, bottom_z], [90-top_bottom_angle+180, 0, 180]);

    rotate([0,0,2*fifth])
      side_text(17_text, [0, bottom_y, bottom_z], [90-top_bottom_angle+180, 0, 180]);

    rotate([0,0,fifth])
      side_text(16_text, [0, bottom_y, bottom_z], [90-top_bottom_angle+180, 0, 180]);
  }
}
