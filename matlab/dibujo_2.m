function dibujo_2(a1,b1,a2,b2,c2)
    precision=0.001;
    ntramos=length(a1);

    
    a1_temp=zeros(1,16/precision);
    b1_temp=zeros(1,16/precision);
    a2_temp=zeros(1,16/precision);
    b2_temp=zeros(1,16/precision);
    c2_temp=zeros(1,16/precision);
    
    t12=zeros(1,16/precision);
    t22=zeros(1,16/precision);
    t32=zeros(1,16/precision);
    t42=zeros(1,16/precision);

    
    
    i2=1;

    for i=1:16/precision
        a1_temp(i)=a1(i2);
        b1_temp(i)=b1(i2);
        a2_temp(i)=a2(i2);
        b2_temp(i)=b2(i2);
        c2_temp(i)=c2(i2);
        if i>=(i2*16/(precision*ntramos))
            i2=i2+1;
        end
    end
    
    x=-8:precision:8-precision;
    
    t12=x.*b2_temp;
    t22=x.*a2_temp;
    t32=t12+c2_temp;
    t42=t22.*x;
    
    
    y_lineal=a1_temp.*x+b1_temp;
    y_cuad=a2_temp.*x.^2+b2_temp.*x+c2_temp;
    y=sigmoid(x);
    final=t32+t42;
     hold on
%     subplot(4,2,1);
%     plot(x,t12,'blue')
%     subplot(4,2,3);
%     plot(x,t22,'red')
%     subplot(4,2,5);
%     plot(x,t32,'yellow')
%     subplot(4,2,7);
%    plot(x,t42,'green')
%    plot(x,final,'black')
    
%     
%     subplot(3,2,1)
%         plot(x,a1_temp,'red')
%         title('a_1')
%     subplot(3,2,3)
%         plot(x,b1_temp,'yellow')
%         title('b_1')
%     subplot(3,2,2)
%         plot(x,a2_temp,'green')
%         title('a_2')
%     subplot(3,2,4)
%         plot(x,b2_temp,'blue')
%         title('b_2')
%     subplot(3,2,6)
%         plot(x,c2_temp,'magenta')
%         title('c_2')

%     plot (x,y_cuad,'blue')
%     plot(x,y_lineal,'green')    
%     plot (x,y,'red')
    hold off


end

