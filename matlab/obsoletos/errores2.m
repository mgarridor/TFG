function errores2(a1,b1,a2,b2,c2)
    
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

err_lineal=(1/length(y))*sum((y-y_lineal).^2);
err_cuad=(1/length(y))*sum((y-y_cuad).^2);

disp('error lineal total')
disp(err_lineal);
disp('error cuadratico total')
disp(err_cuad);


%% operaciones en punto fijo
% x S(3,8)
x_pf=double(fi(x,1,12,8));
% y U(0,12)
y_pf=double(fi(y,0,12,12));

%a S(-4,15)
%b U(-1,13)
%c U(0,12)
[a2_pf,b2_pf,c2_pf]=punto_fijo(a2_temp,b2_temp,c2_temp);

y_cuad_pf=a2_pf.*x_pf.^2+b2_pf.*x_pf+c2_pf;
err_cuad=(1/length(y_pf))*sum((y_pf-y_cuad_pf).^2);
disp('error cuadratico total con punto fijo')
disp(err_cuad);





end

