function [Vkor] = plotGraphVU1(V,U,orgraf,arc,Vkor,poz,Fontsize,lstor,spalva)
% plotGraphVU1 funkcija piesia grafa,kai jis nusakomas virsuniu ir
% briaunu(lanku) aibe.
% Braizomas grafas, duotas virsuniu aibe V ir dvielemenciu poaibiu aibe U
%       Jeigu poaibis is 2 elementu, jis zymi briauna (lanka);
%       Jeigu poaibis is 3 elementu, jis zymi briauna (lanka) ir jo svori; 
%
% orgraf  = 0 arba 1 - neorientuotas ar orientuotas grafas;
% arc = 0 arba 1 - tiesus ar apvalinti lankai;
% Vkor(1:nv,2) - grafo virsuniu koordinates plokstumoje. 
%                nebutinas parametras,pagal nutylejima virsunes 
%                isdestomos apskritimu. Jeigu ivestas Vkor=[], virsunes 
%                isdestomos taip pat pagal nutylejima (t.y. apskritimu) 
% poz =0, jei briaunos virsunes dazomos spalva, apibrezta pagal nutylejima,
%     =1, jei briaunos virsunes dazomos raudona spalva,
% Fontsize - srifto aukstis (pagal nutylejima 10), nebutinas parametras
% lstor - linijos storis, - nebutinas parametras (pagal nutylejima "1")
% spalva - linijos spalva (pagal nutylejima "b") nebutinas parametras
%**************************************************************************

hold on; axis equal; axis([-1.1,1.1,-1.1,1.1]);
s=size(V);nv=s(2);  % grafo eile
s=size(U);nb=s(2);  % briaunu(lanku) skaicius

dphi=2*pi/nv;   % virsuniu isdestymo kampinis zingsnis
R=1;            % virsuniu isdestymo apskritimo spindulys 
r=0.08;         % virsunes spindulys

if nargin < 5 || isempty(Vkor)  % virsuniu koordinates isdestomos ratu
    for i=1:nv, Vkor(i,:)=[R*cos((i-1)*dphi),R*sin((i-1)*dphi)];  end
end

if nargin<6, Fontsize=10; storis=1; spalva='b'; end

% briaunu braizymas:
for i=1:nb      % ciklas per briaunas
  a=U{i};       % "i-os" briaunos virsuniu numeriai
  jr=a(1); % "i-os" briaunos pirmos virsunes numeris
  j=find(V==jr); % virsunes "jr" eiles numeris vektoriuje V
  jr1=a(2); % "i-os" briaunos antros virsunes numeris
  j1=find(V==jr1); % antros virsunes eiles numeris vektoriuje V
          x=Vkor(j,1);y=Vkor(j,2);          % briaunos pirmos virsunes koordinates
          x1=Vkor(j1,1);y1=Vkor(j1,2);      % briaunos antros virsunes koordinates
  L=norm([x1-x,y1-y]);              % briaunos ilgis
  
  n=[x1-x,y1-y]/L;                  % briaunos krypties vektorius
  nt=[n(2),-n(1)];                  % vienetinis vektorius, statmenas n
  v1=[x+r*n(1)+0.1*r*nt(1),y+r*n(2)+0.1*r*nt(2)];v2=[x1-r*n(1)+0.1*r*nt(1),y1-r*n(2)+0.1*r*nt(2)];  % briaunos galu koordinates

  if ~arc   % tiesios briaunos braizymas
plot([v1(1),v2(1)],[v1(2),v2(2)],spalva,'LineWidth',lstor); 
      if orgraf % rodykles braizymas
         ang=pi/10; % 1/2 rodykles kampo
         n1=[cos(ang),-sin(ang);sin(ang),cos(ang)]*n';
 plot([v2(1),v2(1)-1*n1(1)*r ],[v2(2),v2(2)-1*n1(2)*r],spalva,'LineWidth',lstor);
         ang=-pi/10;
         n1=[cos(ang),-sin(ang);sin(ang),cos(ang)]*n';
plot([v2(1),v2(1)-1*n1(1)*r ],[v2(2),v2(2)-1*n1(2)*r],spalva,'LineWidth',lstor );
      end
      s=size(a);sv=[];if s(2)>2, sv=a(3);end  % lanko svoris
              if ~isempty(sv)   % uzrasomas lanko svoris
                  v=v1+0.4*(v2-v1);ll=2.5*r;hh=1.5*r;
                  rectangle('Position',[v(1)-ll/2,v(2)-hh/2,ll,hh],'Curvature',[0.2],'FaceColor',[1. 0.9 0.8]);
                  str=sprintf('%-6.2g',sv);
                  text(v(1)-ll/2+hh/4,v(2)-hh/4*0,str,'FontSize',Fontsize);   
              end
      
   else     % briaunos lanko braizymas 
      vm=v1+(v2-v1)/2+nt*r;  
      x=[v1(1),vm(1),v2(1)]; y=[v1(2),vm(2),v2(2)]; t=0:2;
      tt=0:0.1:2; xx=spline(t,x,tt); yy=spline(t,y,tt);
      plot(xx,yy,spalva);
      if orgraf % rodykles braizymas
         ang=pi/10; % 1/2 rodykles kampo
         dang=2*atan(2*r/L); % rodykles kampo korekcija del lanko kreivumo
         n1=[cos(ang+dang),-sin(ang+dang);sin(ang+dang),cos(ang+dang)]*n';
 plot([v2(1),v2(1)-1*n1(1)*r ],[v2(2),v2(2)-1*n1(2)*r],spalva,'LineWidth',lstor);
         n1=[cos(-ang+dang),-sin(-ang+dang);sin(-ang+dang),cos(-ang+dang)]*n';
plot([v2(1),v2(1)-1*n1(1)*r ],[v2(2),v2(2)-1*n1(2)*r],spalva,'LineWidth',lstor);
      end
      s=size(a);sv=[];if s(2)>2, sv=a(3);end  % lanko svoris
              if ~isempty(sv)   % uzrasomas lanko svoris
                  v=v1+0.8*(vm-v1);ll=2.5*r;hh=1.5*r;
                  rectangle('Position',[v(1)-ll/2,v(2)-hh/2,ll,hh],'Curvature',[0.2],'FaceColor',[1. 0.9 0.8]);
                  str=sprintf('%-6.2g',sv);
                  text(v(1)-ll/2+hh/4,v(2)-hh/4*0,str,'FontSize',Fontsize);  
              end
   end

end

% virsuniu braizymas:

for i=1:nv     % ciklas per virsunes
    x=Vkor(i,1);y=Vkor(i,2); % V(i) virsunes koordinates
 ccc=[0.8 0.9 1];if poz==1, ccc='r'; end
    rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'FaceColor',ccc);
          % uzrasomas virsunes numeris:
          if abs(V(i))<10,str=sprintf('%d',abs(V(i)));shiftx=0.2*r;
          elseif abs(V(i))<100,str=sprintf('%2d',abs(V(i)));shiftx=0.4*r;
          else, str=sprintf('%3d',abs(V(i)));shiftx=0.6*r;
          end
          text(x-shiftx,y,str); % 
end
return

