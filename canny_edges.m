%Author- Jay Upadhyay

function edge_map=canny_edges(input_image, threshold1, threshold2, ...
    sigma_for_gaussian_filter )

% figure;
% imshow(input_image);

%  figure;
%  imagesc(rgb2gray(input_image));
%  colormap gray;

% using red channel for this image

im=input_image(:,:,1);

% figure;
% imshow(im);

% convert image to double

im=im2double(im);

%convert to gray if rgb

dimensions = size(im);
if length(dimensions) > 2
    im=rgb2gray(im);
end

% Apply 7*7 gaussian filter with given sigma
fltr = fspecial('Gauss', 7, sigma_for_gaussian_filter );
im = imfilter( im, fltr, 'same', 'repl' );

% figure;
% imshow(im);

%Apply Sobel Filter for x and y magnitude of edges
sobel_dx = [-1  0  1 ; -2  0  2 ; -1  0  1]/(8);

sobel_dy = [1  2  1 ;  0  0  0 ; -1 -2 -1]/(8);

im_dx = imfilter( im, sobel_dx, 'same', 'repl' );
im_dy = imfilter( im, sobel_dy, 'same', 'repl' );

%get edge magnitude by eucliden formula
im_mag = (((im_dx).^(2))+((im_dy).^(2))).^(1/2);

%get angle of magnitudes and convert to degrees
im_angle = atan2(im_dy,im_dx)*180/pi;

%Quantize the angle to 0,45,90 and 135 and convert negative angle to
%positive
im_angle = round( im_angle / 45 ) * 45;
bool_negative_angle = im_angle < 0;
im_angle( bool_negative_angle ) = im_angle( bool_negative_angle ) + 180; 
im_angle( im_angle == 180 ) = 0;



% figure;
% imshow(im_mag);
% figure;
% imshow(im_angle);

%get boolean matrices with angles as 0,45,90 and 135 respectively
bool_0_angle = im_angle == 0;
bool_45_angle = im_angle == 45;
bool_90_angle = im_angle == 90;
bool_135_angle = im_angle == 135;

% figure;
% imshow(bool_0_angle);
% figure;
% imshow(bool_45_angle);
% figure;
% imshow(bool_90_angle);
% figure;
% imshow(bool_135_angle);

%get matrices where magnitude of pixel is greater than one of the other
%neighboring pixels respectively i.e 8 pixels for each pixel giving 8
%matrices one for each neighbor for each pixel
bool_0_1 = im_mag-circshift(im_mag,1,2)>0;
bool_0_2 = im_mag-circshift(im_mag,-1,2)>0;
bool_45_1 = im_mag-circshift(im_mag,[1,-1])>0;
bool_45_2 = im_mag-circshift(im_mag,[-1,1])>0;
bool_90_1 = im_mag-circshift(im_mag,1,1)>0;
bool_90_2 = im_mag-circshift(im_mag,-1,1)>0;
bool_135_1 = im_mag-circshift(im_mag,[1,1])>0;
bool_135_2 = im_mag-circshift(im_mag,[-1,-1])>0;

% Non Maximal supression by using and and or operations on the above
% created boolean matrices i.e when we get an angle 0 we use the values to
% the right and left and if it is greater on that 2 sides i.e it is one in
% the boolean matrix of that size we make it one i.e we and both the
% directions and the resulting matrix we and with that angle matrix and we
% take and or of matrices of all the angles to get the boolean matrix
% giving the final matrix i.e resultant of non maximal supression
bool_nms=(bool_0_angle & (bool_0_1 & bool_0_2)) | ...
    (bool_45_angle & (bool_45_1 & bool_45_2)) |...
    (bool_90_angle & (bool_90_1 & bool_90_2)) |...
    (bool_135_angle & bool_135_1 & bool_135_2) ;

% figure;
% imshow(bool_nms);

%get the matrix with the points in non maximal supressed matrix and greater
%than the first threshold i.e threshold1
seed_points=(bool_nms.*im_mag)>threshold1;


% figure;
% imshow(seed_points);

%points with magnitude greater than threshold2
t2=im_mag>threshold2;

%new_threshold same as after threshold1
new_thresh=seed_points;

%initialize thresh as ones 
thresh=ones(size(new_thresh));

%Hysterisis i.e changing the edges in the side of the edge using threshold2
%untill we have no change in the matrice
while isequal(thresh,new_thresh)==0
    thresh=new_thresh;    
        new_thresh=(circshift((bool_0_angle&new_thresh),1,1)&t2)|...
        (circshift((bool_0_angle&new_thresh),-1,1)&t2)|...
        (circshift((bool_45_angle&new_thresh),[1,1])&t2)|...
        (circshift((bool_45_angle&new_thresh),[-1,-1])&t2)|...
        (circshift((bool_90_angle&new_thresh),1,2)&t2)|...
        (circshift((bool_90_angle&new_thresh),-1,2)&t2)|...
        (circshift((bool_135_angle&new_thresh),[1,-1])&t2)|...
        (circshift((bool_135_angle&new_thresh),[-1,1])&t2);
    new_thresh=new_thresh|thresh;
end

% figure;
% imshow(thresh);

%assign thresh to edge_map to return
edge_map=thresh;


