% generate perpendicular plates (sharing)

clear all
close all
clc

addpath("submodules/distmesh-utilities/")

output_folder = "perpendicular-plates/";

scale_factors = [2, 5, 10, 20, 50, 80];
shared_dimension = 1;
horzDim = [0.1, 0.2, 0.4, 0.6, 1.0, 2.0, 4.0, 10.0];
vertDim = [0.1, 0.2, 0.4, 0.6, 1.0, 2.0, 4.0, 10.0];

for i = 1 : length(scale_factors)
  folder_name = output_folder + "L" + num2str(i) + "/";

  for j = 1 : length(horzDim)
    horiz = horzDim(j);
    vertic = vertDim(j);

    hP = [ 0,0,0; horiz,0,0; horiz,horiz,0; 0,horiz,0 ];
    vP = [ 0,0,0; 0,vertic,0; 0,vertic,vertic; 0,0,vertic ];
    
    hM = generateRectangle( hP, scale_factors(i) );
    vM = generateRectangle( vP, scale_factors(i) );

    horizontal_name = "horizontal-horzDim=" + num2str(horiz) + "-shrdDim=" + num2str(shared_dimension) + ".stl";
    vertical_name = "vertical-vertDim=" + num2str(vertic) + "-shrdDim=" + num2str(shared_dimension) + ".stl";
  
    stlwrite(hM, folder_name + horizontal_name, "binary")
    stlwrite(vM, folder_name + vertical_name, "binary")
  end

end