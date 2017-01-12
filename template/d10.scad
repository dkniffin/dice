/* [Die] */

// Distance from point to point
height = 7; // [10:100]
// Distance from one side to the other, through the middle
width = 5; // [10:100]

max_z = height/2;
max_y = width/2;

/* [Face text] */

// Font to use for the faces
text_font = "Roboto";
// Size of the text for the faces
text_size = 8.0; // [1:100]
// Depth of the text
text_depth = 0.2;

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

// The top and bottom are easy. The middle is a pentagon.
// http://mathworld.wolfram.com/Pentagon.html
c1 = (1/4)*(sqrt(5) - 1)*max_y;
c2 = (1/4)*(sqrt(5) + 1)*max_y;
s1 = (1/4)*(sqrt(10 + 2*sqrt(5)))*max_y;
s2 = (1/4)*(sqrt(10 - 2*sqrt(5)))*max_y;

points = [
  [0, 0, max_z],  // 0 - top
  [0, 0, -max_z], // 1 - bottom
  [0, max_y, 0],      // 2 - pentagon 1
  [s1, c1, 0],    // 3 - pentagon 2
  [s2, -c2, 0],   // 4 - pentagon 3
  [-s2, -c2, 0],  // 5 - pentagon 4
  [-s1, c1, 0]   // 6 - pentagon 5
];

faces = [
  [0, 3, 2], // 1
  [0, 4, 3], // 2
  [0, 5, 4], // 3
  [0, 6, 5], // 4
  [0, 2, 6], // 5
  [1, 2, 3], // 6
  [1, 3, 4], // 7
  [1, 4, 5], // 8
  [1, 5, 6], // 9
  [1, 6, 2] // 10
];

difference() {
  polyhedron(points, faces);
}
