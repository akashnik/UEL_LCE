clc
clear all

% Define rectangle/square dimensions 
rectWidth = 10; % Width of the rectangle
rectHeight = 2; % Height of the rectangle

% Number of Voronoi centers
numPoints = 1500;

% Generate Voronoi centers within the rectangular shape
voronoiCenters = [rand(numPoints,1)*rectWidth, rand(numPoints,1)*rectHeight];

% Compute Voronoi diagram
[vx, vy] = voronoi(voronoiCenters(:,1), voronoiCenters(:,2));

% Plot Voronoi diagram; just for visulization
figure;
plot(vx, vy, 'b-', voronoiCenters(:,1), voronoiCenters(:,2), 'ro');
axis equal;
axis([0 rectWidth 0 rectHeight]);


% Assign integer values to Voronoi regions, 0 to 90 i.e parallel tp perpendicular 
voronoiValues = randi([0, 90], numPoints, 1); % Random integer values for Voronoi regions

% Read element data from INP create Element.dat by just copy paste element with mesh connectivity
elementData = importdata('Element.dat');
elementCenters = zeros(size(elementData, 1), 2);
elementValues = zeros(size(elementData, 1), 1);

for i = 1:size(elementData, 1)
    nodes = elementData(i, 2:end);
    
    % Read node coordinates from the node data file, copy till all nodes with x,y data 
    nodeData = importdata('Node.dat');
    nodeCoordinates = nodeData(nodes, 2:3);
    
    elementCenters(i, :) = mean(nodeCoordinates);
    
    % Find the closest Voronoi center
    distances = sqrt(sum((voronoiCenters - elementCenters(i, :)).^2, 2));
    [~, minIndex] = min(distances);
    elementValues(i) = voronoiValues(minIndex);
end

% Output element values
disp('Element values:');
disp(elementValues);

% Write element numbers and their assigned values to separate files
elementNumbers = elementData(:, 1);

% Combine element numbers and values into a single array
elementDataCombined = [elementNumbers, elementValues];

% Write element numbers and their assigned values to a single file
dlmwrite('Vornoi.dat', elementDataCombined, ' ');

% Plot element centers and their assigned values
hold on;
scatter(elementCenters(:,1), elementCenters(:,2), 'gx');
for i = 1:size(elementCenters, 1)
    text(elementCenters(i,1), elementCenters(i,2), num2str(elementValues(i)), 'Color', 'g');
end
hold off;



