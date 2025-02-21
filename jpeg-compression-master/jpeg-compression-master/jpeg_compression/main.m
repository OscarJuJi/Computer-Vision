function main
input = imread('Lena.bmp');
x = [16];

[enco,tables] = JPEG_ENCO(input,16);
output = JPEG_DECO(enco,tables,16);
y(1) = psnr(input,output);
temp = size(enco,1) * size(enco,2);
temp2 = size(input,1) * size(input,2);
z(1) = ((temp2 - temp) / temp2) * 100;
figure,subplot(1,2,1),imshow(input);
title('N=1');
subplot(1,2,2),imshow(output);
title('N=1');
disp('N=1');
whos input enco output tables

function [enco,tables] = JPEG_ENCO(input,N)
Q = [16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22, 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99];
[H W] = size(input);
l=(H/8)*(W/8);
tables = cell(1,l);
n=1;
a=1;
for i=1:8:H,
    for j=1:8:W,
        block = input(i:i+7,j:j+7);
        b = double(block)-128;
        bd = dct2(b);
        bq = round(bd./(N*Q));
        zb = zigzag(bq);
        zb128 = uint8(zb + 128);
        dict = myhuffmandict(zb128);
        e = myhuffmanenco(zb128,dict);
        dict{1,257} = length(e);
        tables{1,n} = dict;
        n = n + 1;
        for k=a:a+length(e)-1,
            enco(k) = e(k-a+1);
        end
        a = a + length(e);
    end
end
tables{n}=H;
tables{n+1}=W;
end
figure,plot(x,y);
title('psnr');

figure,plot(x,z);
title('compression');
end
function out = JPEG_DECO(enco,tables,N)
Q = [16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22, 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99];
l=length(tables);
W=tables{l};
H=tables{l-1};
out = zeros(H,W);
a=1;
b=1;
for i=1:l-2,
    dict = tables{i};
    n = dict{257};
    e = enco(1:n);
    enco(1:n) = [];
    d = myhuffmandeco(e,dict);
    d = double(d) - 128;
    izd = izigzag(d);
    dq = izd.*(N*Q);
    idd = idct2(dq);
    d2 = round(idd+128);
    out(a:a+7,b:b+7) = uint8(d2);
    b = b + 8;
    if b > W
        b = 1;
        a = a + 8;
    end
    
end

out = uint8(out);
end
function out = zigzag(input)

t=0;
l=size(input);
sum=l(2)*l(1);
for d=2:sum
 c=rem(d,2);
    for i=1:l(1)
        for j=1:l(2)
            if((i+j)==d)
                t=t+1;
                if(c==0)
                out(t)=input(j,d-j);
                else          
                out(t)=input(d-j,j);
                end
             end    
         end
     end
end

end
function out = izigzag(input)

im = zeros(8,8);
t=0;
l=size(im);
sum=l(2)*l(1);
for d=2:sum
 c=rem(d,2);
    for i=1:l(1)
        for j=1:l(2)
            if((i+j)==d)
                t=t+1;
                if(c==0)
                    im(j,d-j) = input(t);
                else          
                    im(d-j,j) = input(t);
                end
             end    
         end
     end
end
out = im;
end
function out = myhuffmanenco(input, table)

    [h w] = size(input);
    enco = '';
    index = 1;
    
    for i=1 : h
        for j=1 : w
            if input(i,j) == 255
                enco = strcat(enco,char(table(256)));
            else
                enco = strcat(enco,char(table(input(i,j)+1)));
            end
            
            while length(enco) > 8
                out(index) = uint8(bin2dec(enco(1:8)));
                enco(1:8) = [];
                index = index + 1;
            end
        end
    end
    
    if ~isempty(enco)
        out(index) = uint8(bin2dec(enco(1:length(enco))));
        out(index+1) = uint8(length(enco));
    end
    
end
function out = myhuffmandict(input)
intensity = imhist(input);
index = 1;

for i=1 : 256,
    if intensity(i) ~= 0
        N(index) = dlnode(intensity(i),i-1);
        index = index + 1;
    end
end

if length(N) == 1,
    setCode('0',N(1));
    root = N(1);
    table = cell(1,256);
    table = setTable(root, table);
    out = table;

else
N = sort_all_node(N);

while length(N) ~= 1,

    a = N(1);
    b = N(2);
    c = dlnode(a.Intensity+b.Intensity, -1);
    if a.Intensity > b.Intensity,
        insertLeft(a,c);
        insertRight(b,c);
    else
        insertLeft(b,c);
        insertRight(a,c);
    end
    N(1) = [];
    N(1) = [];
    N(length(N)+1) = c;
    N = sort_last_node(N);
end

root = N(1);
table = cell(1,256);
table = setTable(root, table);
out = table;
end
end

function out = setTable(root, table)
    if root.Data >= 0
        table(root.Data+1) = {root.Code};
    end
    if ~isempty(root.Left)
        root.Left.Code = strcat(root.Code,'0');
        table = setTable(root.Left, table);
    end
    if ~isempty(root.Right)
        root.Right.Code = strcat(root.Code,'1');
        table = setTable(root.Right, table);
    end
    out = table;
end

function out = sort_last_node(nodes)
    l = length(nodes);
    i = l;
    while i ~= 1,
        if nodes(i-1).Intensity < nodes(l).Intensity
            break;
        end
        i = i-1;
    end
    tmp = nodes(l);
    nodes(i+1:l) = nodes(i:l-1);
    nodes(i) = tmp;
    out = nodes;
end

function out = sort_all_node(nodes)
    l = length(nodes);
    for i=1 : l-1,
        min = i;
        for j=i+1 : l,
            if nodes(min).Intensity > nodes(j).Intensity
                min = j;
            end
        end
        tmp = nodes(i);
        nodes(i) = nodes(min);
        nodes(min) = tmp;
    end
    out = nodes;
    
end
function out = myhuffmandeco(input, table)
    deco = '';
    index = 1;
    l = length(table);
    root = dlnode(-1,-1);
    
    for i=1 : l
        if ~isempty(table{i})
             root = makehuffmantree(root, i-1, table{i});
        end
    end
    
    r = root;
    while length(input) > 2
        if isempty(deco)
            deco = strcat(deco,dec2bin(input(1),8));
            input(1)=[];
        end
        
        if deco(1) == '0'
            r = r.Left;
        elseif deco(1) == '1'
            r = r.Right;
        end
        deco(1) = [];
        
        if isLeafNode(r)
            out(index) = uint8(r.Data);
            index = index + 1;
            r = root;
        end
    end
    
    if ~isempty(input)
        deco = strcat(deco,dec2bin(input(1),input(2)));
    end
    
    while ~isempty(deco)
        if isempty(deco)
            deco = strcat(deco,dec2bin(input(1),8));
            input(1)=[];
        end
        
        if deco(1) == '0'
            r = r.Left;
        elseif deco(1) == '1'
            r = r.Right;
        end
        deco(1) = [];
        
        if isLeafNode(r)
            out(index) = uint8(r.Data);
            index = index + 1;
            r = root;
        end
    end
end

function out = makehuffmantree(root, data, code)
    if isempty(code)
        root.Data = data;
    
    else
        if code(1) == '0'
            if isempty(root.Left)
                insertLeft(dlnode(-1,-1), root);
            end
            makehuffmantree(root.Left, data, code(2:length(code)));
            
        elseif code(1) == '1'
            if isempty(root.Right)
                insertRight(dlnode(-1,-1), root);
            end
            makehuffmantree(root.Right, data, code(2:length(code)));
        end
    end
    
    out = root;
end

function out = isLeafNode(node)
    out = isempty(node.Left) & isempty(node.Right);
end