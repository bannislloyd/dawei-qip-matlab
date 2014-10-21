clear;


A(1) = 21;
for w = 2:7
    A(w) = A(w-1)+3^w*nchoosek(qubits,w);
end

for ii = 1:7
    B(ii) = 0;
end

for ii = 1:1656
    N(ii) = Number*rand;
    if N(ii)<A(1)+1
        B(1) = B(1)+1;
    else if N(ii)<A(2)+1
            B(2) = B(2)+1;
        else if N(ii)<A(3)+1
                B(3) = B(3)+1;
            else if N(ii)<A(4)+1
                    B(4) = B(4)+1;
                    else if N(ii)<A(5)+1
                            B(5) = B(5)+1;
                        else if N(ii)<A(6)+1
                                B(6) = B(6)+1;
                            else B(7) = B(7)+1;
                            end
                        end
                end
            end
        end
    end
end

                