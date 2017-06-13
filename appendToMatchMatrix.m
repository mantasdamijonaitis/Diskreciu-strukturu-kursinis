function y = appendToMatchMatrix(matchMatrix, from, to)
    [rowsAmount, columnsAmount] = size (matchMatrix);
    wasInserted = 0;
    for rows_index = 1 : rowsAmount
        for columns_index = 1 : columnsAmount
            if (columns_index ~= 1 && ...
                    matchMatrix(rows_index, columns_index - 1) ~= 0) && ...
                   (matchMatrix(rows_index, columns_index - 1) == from) && ...
                   (matchMatrix(rows_index, columns_index) == 0)
                tempMatrix = matchMatrix (rows_index,:);
                tempMatrix (1, columns_index) = to;
                matchMatrix = [matchMatrix; tempMatrix];
                wasInserted = 1;
            end;
        end;
    end;
    if (wasInserted == 0)
        for rows_index = 1 : rowsAmount
            if (matchMatrix(rows_index, 1) == 0 && wasInserted == 0)
                tempMatrix = zeros(1, columnsAmount);
                tempMatrix (1, 1) = from;
                tempMatrix (1, 2) = to;
                matchMatrix = [matchMatrix; tempMatrix];
                wasInserted = 1;
            end;
        end;
    end;
    y = matchMatrix;
end