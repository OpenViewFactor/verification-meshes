% Don't know how to write stl file to a specific folder using stlwrite so
%   user must manually move the files to a folder
clear
addpath('submodules\distmesh-utilities\')

% Choose configuration
%   1 = Aligned Parallel Rectangles
%   2 = Perpendicular Rectangles (both elements span full shared edge)
%   3 = Coaxial Discs
%   4 = Coaxial Cylinders  **Does not work atm
config = 3;

% Choose scale
scale = 30;

if config == 1
    % Get User Inputs for Parameters 
    x = input('Enter x dimension of elements: ');
    y = input('Enter y dimension of elements: ');
    z = input('Enter distance between plates: ');

    % Dimensions of Single Plate21
    bt_pts = [0 0 0; x 0 0; x y 0; 0 y 0];

    % Generate Bottom Element
    bt_trngl = generateRectangle(bt_pts,scale);

    % Test Normals
    sngl_tri = [bt_trngl.Points(bt_trngl.ConnectivityList(1,1),:); bt_trngl.Points(bt_trngl.ConnectivityList(1,2),:); bt_trngl.Points(bt_trngl.ConnectivityList(1,3),:)];
    sngl_tri_nrm = cross(sngl_tri(2,:)-sngl_tri(1,:),sngl_tri(3,:)-sngl_tri(1,:));
    if sngl_tri_nrm(3) < 0
        bt_trngl = flipNormals(bt_trngl);
    end

    % Generate Upper Element
    tp_trngl = flipMeshAboutPlane(bt_trngl, [0 0 -z/2], [0 0 1]);

    % Save Meshes
    stlwrite(bt_trngl,['top-xDim=',num2str(x),'-yDim=',num2str(y),'-sep=',num2str(z),'.stl'],'binary');
    stlwrite(tp_trngl,['bottom-xDim=',num2str(x),'-yDim=',num2str(y),'-sep=',num2str(z),'.stl'],'binary');

elseif config == 2
    % Get User Inputs for Parameters 
    z = input('Enter vertical dimension of element: ');
    x = input('Enter horizontal dimension of element: ');
    y = input('Enter dimension of shared edge: ');

    % Dimensions of Both Plates
    xy_pl_pts = [0 0 0; x 0 0; x y 0; 0 y 0];
    yz_pl_pts = [0 0 0; 0 y 0; 0 y z; 0 0 z];

    % Generate Elements
    xy_pl_trngl = generateRectangle(xy_pl_pts,scale);
    yz_pl_trngl = generateRectangle(yz_pl_pts,scale);

    % Test Normals
    sngl_tri = [xy_pl_trngl.Points(xy_pl_trngl.ConnectivityList(1,1),:); xy_pl_trngl.Points(xy_pl_trngl.ConnectivityList(1,2),:); xy_pl_trngl.Points(xy_pl_trngl.ConnectivityList(1,3),:)];
    sngl_tri_nrm = cross(sngl_tri(2,:)-sngl_tri(1,:),sngl_tri(3,:)-sngl_tri(1,:));
    if sngl_tri_nrm(3) < 0
        xy_pl_trngl = flipNormals(xy_pl_trngl);
    end
    sngl_tri = [yz_pl_trngl.Points(yz_pl_trngl.ConnectivityList(1,1),:); yz_pl_trngl.Points(yz_pl_trngl.ConnectivityList(1,2),:); yz_pl_trngl.Points(yz_pl_trngl.ConnectivityList(1,3),:)];
    sngl_tri_nrm = cross(sngl_tri(2,:)-sngl_tri(1,:),sngl_tri(3,:)-sngl_tri(1,:));
    if sngl_tri_nrm(1) < 0
        yz_pl_trngl = flipNormals(yz_pl_trngl);
    end

    % Save Meshes
    stlwrite(xy_pl_trngl,['vertical-vertDim=',num2str(z),'-shrdDim=',num2str(y),'.stl'],'binary');
    stlwrite(yz_pl_trngl,['horizontal-horzDim=',num2str(x),'-shrdDim=',num2str(y),'.stl'],'binary');

elseif config == 3
    % Get User Inputs for Parameters 
    r = input('Enter radius of discs: ');
    z = input('Enter distance between discs: ');

    % Generate Lower Element
    bt_trngl = generateDisc(r,scale);

    % Test Normals
    sngl_tri = [bt_trngl.Points(bt_trngl.ConnectivityList(1,1),:); bt_trngl.Points(bt_trngl.ConnectivityList(1,2),:); bt_trngl.Points(bt_trngl.ConnectivityList(1,3),:)];
    sngl_tri_nrm = cross(sngl_tri(2,:)-sngl_tri(1,:),sngl_tri(3,:)-sngl_tri(1,:));
    if sngl_tri_nrm(3) < 0
        bt_trngl = flipNormals(bt_trngl);
    end

    % Generate Upper Element
    tp_trngl = flipMeshAboutPlane(bt_trngl, [0 0 -z/2], [0 0 1]);

    % Save Meshes
    stlwrite(bt_trngl,['bottom-r=',num2str(r),'.stl'],'binary');
    stlwrite(tp_trngl,['top-r=',num2str(r),'-sep=',num2str(z),'.stl'],'binary');

elseif config == 4
    % Get User Inputs for Parameters 
    ri = input('Enter radius of inner cylinder: ');
    ro = input('Enter radius of outer cylinder: ');
    h = input('Enter height of cylinders: ');

    % Generate Elements
    in_trngl = generateCylinder(0, h, 360, ri, [0 0 0], scale);
    out_trngl = generateCylinder(0, h, 360, ro, [0 0 0], scale);
    
    % 

else
    disp('Chosen configuration is not an option')
end