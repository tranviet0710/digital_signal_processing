
%using FFT
clear;
clc;
close all;
path='/Users/dinhgiabao/Desktop/HK1-nam3/XLTinHieu/TH2/NguyenAmHuanLuyen/';
files = dir('/Users/dinhgiabao/Desktop/HK1-nam3/XLTinHieu/TH2/NguyenAmHuanLuyen/');
numfilter=513;

%trainnings
a=zeros(21,numfilter-1);
u=zeros(21,numfilter-1);
e=zeros(21,numfilter-1);
ii=zeros(21,numfilter-1);
o=zeros(21,numfilter-1);

fa = zeros(21, 512);
fu = zeros(21, 512);
fe = zeros(21, 512);
fi = zeros(21, 512);
fo = zeros(21, 512);


for i=4:24
    p=strcat(path,files(i).name);
    p=strcat(p,'/');
    p1=strcat(p, '/*.wav');
    files1 = dir(p1);
    for j=1:length(files1)
        x = files(i).name + "/" + files1(j).name;
        p2=strcat(p,files1(j).name);
        [data,fs]= audioread(p2);
        index = (i-4)*j + j;
        
        %Trich xuat vecto theo tung nguyen am
        if (j==1)
            fa(i-3,:) = program1(data, fs, index, x,numfilter);
        elseif (j==2)
            fe(i-3,:) =program1(data, fs, index, x,numfilter);
        elseif (j==3)
            fi(i-3,:) =program1(data, fs, index, x,numfilter);
        elseif (j==4)
            fo(i-3,:) =program1(data, fs, index, x,numfilter);
        elseif (j==5)
            fu(i-3,:) =program1(data, fs, index, x,numfilter);
        end 
    end
end
vfa = mean(fa);
vfe = mean(fe);
vfi = mean(fi);
vfo = mean(fo);
vfu = mean(fu);

mang = zeros(5,512);
mang(1, :)  = vfa ;
mang(2, :) = vfe;
mang(3, :) = vfi;
mang(4, :) = vfo;
mang(5, :) = vfu;


path_kt='/Users/dinhgiabao/Desktop/HK1-nam3/XLTinHieu/TH2/NguyenAmKiemThu/';
files_kt = dir('/Users/dinhgiabao/Desktop/HK1-nam3/XLTinHieu/TH2/NguyenAmHuanLuyen/');
 
result= zeros(5,5);
wrong_result = 0;
for i=4:24
    p=strcat(path,files(i).name);
    p=strcat(p,'/');
    p1=strcat(p, '/*.wav');
    files1 = dir(p1);
    for j=1:length(files1)
        x = files(i).name + "/" + files1(j).name;
        p2=strcat(p,files1(j).name);
        [data,fs]= audioread(p2);
        vecto =program1(data, fs, index, x,numfilter);
        index= sokhop(files1(j).name ,vecto,mang,1);
        result(j, index) = result(j, index) + 1;
        if(j ~= index) wrong_result = wrong_result + 1;
        end
    end
end

nhan = {'a';'e';'i';'o';'u'};
rs_a = result(:,1);
rs_e =  result(:,2);
rs_i =  result(:,3);
rs_o =  result(:,4);
rs_u =  result(:,5);
T = table(nhan,rs_a,rs_e,rs_i,rs_o,rs_u)
Dochinhxac = (105 - wrong_result) * 100 / 105
