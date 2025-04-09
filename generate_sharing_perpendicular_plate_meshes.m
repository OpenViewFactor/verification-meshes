% generate perpendicular plates (sharing)

clear all
close all
clc

addpath("submodules/distmesh-utilities/")

output_folder = "perpendicular-plates/";

num_divisions = [ 5 , 21 , 51 , 101 , 151 , 201 ];
shared_dimension = 1;
horzDim = [0.1, 0.2, 0.4, 0.6, 1.0, 2.0, 4.0, 10.0];
vertDim = [0.1, 0.2, 0.4, 0.6, 1.0, 2.0, 4.0, 10.0];

for i = 1 : length(num_divisions)
  folder_name = output_folder + "L" + num2str(i) + "/";

  for j = 1 : length(horzDim)
    horiz = horzDim(j);
    vertic = vertDim(j);
    
    hM = generateRectangle2( horiz , vertic , num_divisions(i) );
    vM = flipNormals( rotateMesh( hM , pi/2 , 2 ) );

    horizontal_name = "horizontal-horzDim=" + num2str(horiz) + "-shrdDim=" + num2str(shared_dimension) + ".stl";
    vertical_name = "vertical-vertDim=" + num2str(vertic) + "-shrdDim=" + num2str(shared_dimension) + ".stl";
  
    stlwrite(hM, folder_name + horizontal_name, "binary")
    stlwrite(vM, folder_name + vertical_name, "binary")
  end

end