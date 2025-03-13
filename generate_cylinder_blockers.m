% generate cylinder blockers

clear all
clc

addpath("submodules/distmesh-utilities/")

output_path = "coaxial-cylinders/blockers/";

radii = [0.125, 0.25, 0.5, 0.75, 1.0, 2.0, 10];
height = 1;
num_divisions = 500;

theta_span = @(N) 2 * pi / N;
section_length = @(r,N) r * sqrt( 2 - 2*cos(theta_span(N)) );
y_coord = @(r,l) sqrt( r^2 - (l/2)^2 );


theta = theta_span(num_divisions);

for i = 1 : length(radii)
  r = radii(i);

  L = section_length(r,num_divisions);
  y = y_coord(r,L);

  all_points = zeros(4 * num_divisions , 3);
  all_connectivity = zeros(2 * num_divisions , 3);

  starter_rectangle_p = [ L/2,y,0; -L/2,y,0; -L/2,y,height; L/2,y,height ];
  starter_rectangle_c = [ 1,2,3; 1,3,4 ];
  
  all_points(1:4 , :) = starter_rectangle_p;
  all_connectivity(1:2, :) = starter_rectangle_c;

  for j = 1 : num_divisions - 1
    rotation_matrix = [ cos(j*theta), -sin(j*theta); sin(j*theta), cos(j*theta) ];
    new_points = starter_rectangle_p;
    new_connectivity = starter_rectangle_c + j * 4;
    new_points( : , [1,2] ) = ( rotation_matrix * ( new_points( : , [1,2] )' ) )';
    
    all_points( j*4 + 1 : (j+1)*4 , : ) = new_points;
    all_connectivity( j*2 + 1 : j*2 + 2 , : ) = new_connectivity;
  end

  blocker_m = triangulation(all_connectivity, all_points);

  filename = output_path + "blocker-r=" + num2str(r) + "-h=" + num2str(height) + ".stl";
  stlwrite(blocker_m, filename, "binary")

end