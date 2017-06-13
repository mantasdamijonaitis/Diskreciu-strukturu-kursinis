function y = analyzeMatchMatrix(matchMatrix)
    connectedOneSide = 0;
    loopDetected = 0;
    [row_amount, column_amount] = size (matchMatrix);
    for rows_index = 1 : row_amount
        oneSideChainAmount = 0;
        for columns_index = 1 : column_amount
            if matchMatrix(rows_index, columns_index) == columns_index
                oneSideChainAmount = oneSideChainAmount + 1;
                if (oneSideChainAmount == column_amount - 1)
                    connectedOneSide = 1;
                end;
            end;
        end
        if matchMatrix(rows_index, 1) == 1 && matchMatrix(rows_index, column_amount) == 1
            loopDetected = 1;
        end;
    end;
    y = '';
    
    if (loopDetected == 1 && connectedOneSide == 1)
        y = 'Grafas yra stipriai jungus';
    end;
    if (loopDetected == 0 && connectedOneSide == 1)
        y = 'Grafas yra vienakryptiškai jungus';
    end;
    if (loopDetected == 0 && connectedOneSide == 0)
        y = 'Grafas yra silpnai jungus';
    end;
end