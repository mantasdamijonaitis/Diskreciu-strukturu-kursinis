function y = setMatchMatrix (graph)
    [rows_amount,columns_amount] = size(graph)
    matchMatrix = zeros (1, columns_amount + 1);
    for rows_index = 1 : rows_amount
        for columns_index = 1 : columns_amount
            if (graph(rows_index, columns_index) == 1)
                matchMatrix = appendToMatchMatrix(matchMatrix, rows_index, columns_index);
            end;
        end;
    end;
    y = matchMatrix;
end