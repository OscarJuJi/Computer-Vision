%input_matrix = uint8(randi([0 255], 4, 4));
input_matrix= uint8([1,2,3;4,5,6;7,8,9]);
%input_matrix=imread("test.jpg");
%input_matrix=rgb2gray(input_matrix);
predicted_matrix = predict_matrix(input_matrix);
disp(input_matrix);
disp("luego");
disp(predicted_matrix);
%figure (1);
%imshow(input_matrix);
%figure (2);
%imshow(predicted_matrix);
function predicted_matrix = predict_matrix(input_matrix)
% Predict a matrix using the sum of the known components around each unknown component
% input_matrix: the matrix to be predicted
% predicted_matrix: the predicted matrix

% Get the size of the input matrix
[n,~] = size(input_matrix);

% Initialize the predicted matrix with the first row and first column of the input matrix
predicted_matrix = uint8(zeros(n));
predicted_matrix(1,:) = input_matrix(1,:);
predicted_matrix(:,1) = input_matrix(:,1);

% Loop through the unknown components of the matrix and predict their value
for i = 2:n
    for j = 2:n
        % If the component is unknown, calculate the predicted value
        if predicted_matrix(i,j) == 0
            % Count the number of known components around the unknown component
            count = 0;
            sum = 0;
            if predicted_matrix(i-1,j) ~= 0 % Top neighbor
                count = count + 1;
                sum = sum + predicted_matrix(i-1,j);
            end
            if predicted_matrix(i,j-1) ~= 0 % Left neighbor
                count = count + 1;
                sum = sum + predicted_matrix(i,j-1);
            end
            if count > 0 % Only predict if there are known neighbors
                % Calculate the predicted value using the sum of the known components
                predicted_value = sum / count;
                % Round the predicted value to the nearest integer
                predicted_matrix(i,j) = uint8(round(predicted_value));
            end
        end
    end
end
end