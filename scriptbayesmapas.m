x1=imread('multi1.tif');
x2=imread('multi2.tif');
x3=imread('multi3.tif');
x4=imread('multi4.tif');

subplot(2,2,1),imshow(x1);
subplot(2,2,2),imshow(x2);
subplot(2,2,3),imshow(x3);
subplot(2,2,4),imshow(x4);
pause


clf

B1=roipoly(x1);
B2=roipoly(x1);
B3=roipoly(x4);

stack=cat(3,x1,x2,x3,x4);
[X1,R1]=imstack2vectors(stack,B1);
[X2,R2]=imstack2vectors(stack,B2);
[X3,R3]=imstack2vectors(stack,B3);

whos

Y1=X1(1:400,:);
Y2=X2(1:700,:);
Y3=X3(1:700,:);

[C1,m1]=covmatrix(Y1);
[C2,m2]=covmatrix(Y2);
[C3,m3]=covmatrix(Y3);
C1
m1
CA=cat(3,C1,C2,C3);
MA=cat(2,m1,m2,m3);

dY1=bayesgauss(Y1,CA,MA);
IY1=find(dY1~=1);

dY2=bayesgauss(Y2,CA,MA);
IY2=find(dY2~=2);

dY3=bayesgauss(Y3,CA,MA);
IY3=find(dY3~=3);

