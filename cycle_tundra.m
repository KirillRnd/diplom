ex_def=0.3;
a_def=42164000;
i_def=63.4/360*2*pi;
w_def = 270/360*2*pi;
omega_def=270/360*2*pi;
E_def=pi/3;

X_array_param=zeros(60,6);
Y_array_ret=zeros(60,6);

for i = (1:60)
    X_array_param(i,:)=[ex_def, a_def, i_def,w_def,omega_def,E_def]';
end

X_array_param(1:10,1)=(0.0:0.1:0.9);
X_array_param(11:20,2)=(1:1:10)*42164000/5;
X_array_param(21:30,3)=(0.0:0.1:0.9)*2*pi;
X_array_param(31:40,4)=(0.0:0.1:0.9)*2*pi;
X_array_param(41:50,5)=(0.0:0.1:0.9)*2*pi;
X_array_param(51:60,6)=(0.0:0.1:0.9)*2*pi;
for i = (1:60)
    Y_array_ret(i,:)=whole_parameters(X_array_param(i,:));
    i
end