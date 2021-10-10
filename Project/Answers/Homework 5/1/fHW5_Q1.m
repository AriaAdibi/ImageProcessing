function hw5_q1()
image=imread('../inputs/tasbih.jpg');
image=double(image);

figure(1);
I=gradian(image);


%{
normImage = mat2gray(I);
imshow(normImage);
%}


imshow(uint8(image));         
hold on;            %# Add subsequent plots to the image

rect=getrect();
v=get_vertices(rect);
%v=[224,275,319,374,222,273,319,370,226,219,405,404 ; 253,259,257,257,379,384,386,385,304,357,257,307];
plot(v(1,:),v(2,:),'r.');  %# Show dots on image)!


line(v(1,:),v(2,:));
line([v(1,1),v(1,size(v,2))],[v(2,1),v(2,size(v,2))]);


    
g=gradian(image);

tic
for u=1:5
v=E_total(image,v,g,25, 1);

line(v(1,:),v(2,:));
line([v(1,1),v(1,size(v,2))],[v(2,1),v(2,size(v,2))]);

plot(v(1,:),v(2,:),'w.');  %# Show dots on image)!
end
toc

plot(v(1,:),v(2,:),'w.');  %# Show dots on image)!
end



function I=gradian_X(Image)
I=zeros(size(Image,1),size(Image,2));

for i1=2:size(Image,1)-1
    for i2=2:size(Image,2)-1
        
            I(i1,i2)=abs(-Image(i1,i2-1)+Image(i1,i2+1));
  
    end
end


end

function I=gradian_Y(Image)
I=zeros(size(Image,1),size(Image,2));

for i1=2:size(Image,1)-1
    for i2=2:size(Image,2)-1
        
            I(i1,i2)=abs(-Image(i1-1,i2)+Image(i1+1,i2));
  
    end
end


end

function I=gradian(image)

X=gradian_X(image);
Y=gradian_Y(image);


I=zeros(size(X,1),size(X,2));
I=double(I);

for i1=1:size(X,1)
    for i2=1:size(X,2)
        
            I(i1,i2)=(X(i1,i2)^2 + Y(i1,i2)^2);
  
    end
end

end

function vertices=E_total(I,vertices,gradian,state_size, alfa)
s=sqrt(state_size);% number of states we have
n=size(vertices,2);% number of vertices we have

dynamicTable=zeros(state_size,n,2);
a=zeros(1,state_size);
a=double(a);


for j=2:n
    for i=1:state_size
        [Y,X]=win(i,s);
        for k=1:state_size
            
            [y,x]=win(k,s);
            v1_x=vertices(1,j)+X;
            v1_y=vertices(2,j)+Y;
            v2_x=vertices(1,j-1)+x;
            v2_y=vertices(2,j-1)+y;
            a(k)= E_i(I,v1_x , v1_y , v2_x , v2_y , gradian , alfa)+dynamicTable(k,j-1,2);
            
         
        end
        pre=find(a==min(a));
        dynamicTable(i,j,1)=pre(1);
        dynamicTable(i,j,2)=min(a);

    end
    
end


 
pre=find(dynamicTable(:,n,2)==min(dynamicTable(:,n,2)));
m=pre(1);
for i=n:-1:1
    [y,x]=win(m,s);
    vertices(1,i)=vertices(1,i)+x;
    vertices(2,i)=vertices(2,i)+y;
    m=dynamicTable(m,i,1);
    
end
        


end

function [r,c]=win(i,size)

c=mod(i,size);
if(c==0)
   c= size;
end 
r=ceil(i/size);

r=r-(ceil((size-1)/2))-1;
c=c-(ceil((size-1)/2))-1;

r=r*20;
c=c*20;
end


function v=get_vertices(rect)

step=50;

xmin=uint16(rect(1));
ymin=uint16(rect(2));
width =uint16(rect(3));
height=uint16(rect(4));

v=zeros(2,0);


s=1;
for i=xmin:step:(xmin+width)
    v(1,s)=i;
    v(2,s)=ymin;
    s=s+1;
    
end

for i=ymin:step:(ymin+height)
    v(1,s)=xmin+width;
    v(2,s)=i;
    s=s+1;
end

 for i=(xmin+width):-step:xmin
    v(1,s)=i;
    v(2,s)=ymin+height;
    s=s+1;
 end



for  i=(ymin+height):-step:ymin
    v(1,s)=xmin;
    v(2,s)=i;
    s=s+1;
end


end



function e=E_i(I,x1,y1,x2,y2,gradian,alfa)

e=-gradian(y1,x1)+alfa*(SSD(I,x1,y1,x2,y2));


end
function ssd=SSD(I,x1,y1,x2,y2)

ssd=0;
ssd=double(ssd);
ssd=(I(y1,x1,1)-I(y2,x2,1))^2+(I(y1,x1,2)-I(y2,x2,2))^2+(I(y1,x1,3)-I(y2,x2,3))^2;

end