function y = convertMatrixToDrawable(graphMatrix)
    returnMatrix = [,];
    [rows_amount, columns_amount] = size (graphMatrix);
    for rows_index = 1 : rows_amount
        for columns_index = 1 : columns_amount
            if graphMatrix(rows_index, columns_index) == 1
                tempSet(1,1) = rows_index;
                tempSet(1,2) = columns_index;
                tempVar = [rows_index, columns_index]
                returnMatrix = horzcat(returnMatrix, {tempVar});
            end;
        end;
    end;
    %returnMatrix
    %[rows_amount, columns_amount] = size(returnMatrix);    
    %for rows_index = 1 : rows_amount
    %    returnMatrix(rows_index, 3) = 1;
    %end;
    y = returnMatrix
end