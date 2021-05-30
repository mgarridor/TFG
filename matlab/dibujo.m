%%%%%%%%%%%%
% Dibuja la función sigmoide encima de las interpolaciones lineal y
% cuadrática para poder compararlas
%%%%%%%%%%%%


function dibujo(a1,b1,a2,b2,c2)
    precision=0.001;
    ntramos=length(a1);

    
    a1_temp=zeros(1,16/precision);
    b1_temp=zeros(1,16/precision);
    a2_temp=zeros(1,16/precision);
    b2_temp=zeros(1,16/precision);
    c2_temp=zeros(1,16/precision);
    
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
    y_lineal=a1_temp.*x+b1_temp;
    y_cuad=a2_temp.*x.^2+b2_temp.*x+c2_temp;
    y=sigmoid(x);
    
    hold on
    plot (x,y_cuad,'blue')
    plot(x,y_lineal,'green')    
    plot (x,y,'red')
    hold off


end

