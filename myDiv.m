function [Div,Divg] = myDiv(In,i,j,h,k)
Ux = (In(i+1,j) - In(i-1,j))/(2*h);
Uy = (In(i,j+1) - In(i,j-1))/(2*h);
Uxx = (In(i+1,j) + In(i-1,j) - 2*In(i,j))/(h^2);
Uyy = (In(i,j+1) + In(i,j-1)-2*In(i,j))/(h^2);
Uxy = (In(i+1,j+1)-In(i-1,j+1)-In(i+1,j-1)+In(i-1,j-1))/(4*h^2);
Div = (Ux^2*Uyy - 2*Ux*Uy*Uxy + Uy^2*Uxx)/((Ux^2+Uy^2+0.0001)^(3/2));
Divg = (k^2*Uxx + k^2*Uyy-Ux^2*Uxx + Uy^2*Uxx - 4*Ux*Uy*Uxy + Ux^2*Uyy - Uy^2*Uyy)/...
    (((k^2+Ux^2+Uy^2)/k)^2);
end