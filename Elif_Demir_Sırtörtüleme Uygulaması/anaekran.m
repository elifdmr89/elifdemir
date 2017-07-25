
function varargout = anaekran(varargin)
% anaekran MATLAB code for anaekran.fig
%      anaekran, by itself, creates a new anaekran or raises the existing
%      singleton*.
%
%      H = anaekran returns the handle to a new anaekran or the handle to
%      the existing singleton*.
%
%      anaekran('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in anaekran.M with the given input arguments.
%
%      anaekran('Property','Value',...) creates a new anaekran or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anaekran_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anaekran_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anaekran

% Last Modified by GUIDE v2.5 04-Dec-2016 21:42:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anaekran_OpeningFcn, ...
                   'gui_OutputFcn',  @anaekran_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before anaekran is made visible.
function anaekran_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anaekran (see VARARGIN)

% Choose default command line output for anaekran
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anaekran wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anaekran_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.txt','Select the input txt file');
metin = fileread(fullfile(pathname, filename));
set(handles.text2, 'string', fullfile(pathname, filename));
set(handles.edit1, 'string', metin);
uzunluk_metin=length(metin);
if(uzunluk_metin>999)
    mesaj=msgbox('En fazla 999 karakter girilebilir?','Hata');
    set(handles.edit1, 'string', '');
else
    handles.metin=metin;
    guidata(hObject, handles);
end
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(get(handles.edit1,'String')))
      mesaj_deger=msgbox('Gizlenecek metin dosyasýný giriniz.','Hata');
else
[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
   'Select the image file');


set(handles.text3, 'string', fullfile(pathname, filename));
resim = imread(fullfile(pathname, filename));
axes(handles.axes1);
imshow(resim);
xlswrite('resim5.xlsx',resim(:,:,1),'Resim.1');
xlswrite('resim5.xlsx',resim(:,:,2),'Resim.2');
xlswrite('resim5.xlsx',resim(:,:,3),'Resim.3');
input= resim;
Red = input(:,:,1);
Green = input(:,:,2);
Blue = input(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
axes(handles.axes6);
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
handles.resim=resim;
guidata(hObject, handles);
%Bu kýsýmda histogram deðeri resimin gösterilecek

end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Alýnan resmin satýr sütun sayýsý belirlenir.
hata='';
        if(isempty(get(handles.axes1, 'Children')))
            hatali=msgbox('Resmi giriniz','Hata');
            hata=1;
        end
        if(isempty(get(handles.edit1,'String')))
            hatalimesaj=msgbox('Gizlenecek metni giriniz','Hata');
            hata=1;
        end 
        if(isempty(hata))
        resim=handles.resim;
        metin=handles.metin;
       
        
        [sa1,su1]=size(resim);

        Red = resim(:,:,1);
        Green = resim(:,:,2);
        Blue = resim(:,:,3);

        [yRed, x] = imhist(Red);
        [yGreen, x] = imhist(Green);
        [yBlue, x] = imhist(Blue);

        enbuyuk1=0;
        syr=0;
        for i=1:256
            buyukred=yRed(i,1);     %Kýrmýzý matrisi taranýr en büyük renk deðeri bulunur.
            syr=syr+1;
            if buyukred>enbuyuk1
                enbuyuk1=buyukred;  %En büyük kýrmýzý deðiþkeni enbuyuk1 deðerine atanýr.

            end
            if enbuyuk1==buyukred
                xr=syr;             %En büyük kýrmýzý rengin X eksenine gelen karþýlýðý bulunur.
            end

        end
        enbuyuk2=0;
        syg=0;
        for i=1:256
            buyukgreen=yGreen(i,1);
            syg=syg+1;
            if buyukgreen>enbuyuk2
                enbuyuk2=buyukgreen;

            end
            if enbuyuk2==buyukgreen
                xg=syg;
            end

        end
        enbuyuk3=0;
        syb=0;
        for i=1:256
            buyukblue=yBlue(i,1);
            syb=syb+1;
            if buyukblue>enbuyuk3
                enbuyuk3=buyukblue;

            end
            if enbuyuk3==buyukblue
                xb=syb;
            end

        end
        if xb>=xg && xb>=xr        

            R=1;
        elseif xg>=xb && xg>=xr

            R=2;
        else

            R=3;
        end

        %Girilen metnin uzunluðu belirlernir
        mtnuzn=length(metin);
        %Girilen metin ASCII kodlarýna çevirilir.
        ascimetin=double(metin);
        %ASCII kodlarýna çevrilen metin binary sayý sistemine çevrilir.
        binmetin=de2bi(ascimetin);
        %Oluþturulan Binary Matrisinin satýr sütun sayýsý kontrol edilir.
        [sa,su]=size(binmetin);
        %Binary matrisinin 7 olan sütun sayýsýný 8 yapmak için 1 sutunluk sýfýrmatrisi oluþturulur.
        sifirlar=zeros(sa,1);
        %Oluþturulan sýfýrlar matrisi binary matrisinin ilk sütununa eklenerek 8 sutun elde edilir.
        binary8=[sifirlar binmetin];
        %Yeni oluþturulan binary matrisinin satýr sutun sayýlarý kontrol edilir.
        [sa,su]=size(binary8);
        %Binary sayý sistemine çevrilerek 8 bit ile ifade edilen her harfin sadece
        %iki biti iþleme sokulmasý için for döngüsü içinde 1ler ve 0lar 2li gruplar
        %halinde toplanarak yeni bir vektöre atanýr.
        Decimal=[];
        sy=0;
        for i=1:sa
            for j=1:2:su
                sy=sy+1;
                 Decimal(sy)=bi2de(binary8(i:i,j:j+1));%TErsten almýyo

            end
        end
        sy=0;
        %Her harfin iki bitinin decimal deðerlere çevrilmesiyle oluþan decimal
        %matrisi uzunluðu kontrol edilir.
        boydeci=length(Decimal);
        %Herbir 2bitin decimal karþýlýðý için pixel deðerlerinin mod 4 deðerine
        %göre ayarlanmassý iþlemleri yapýlýr.
        
        for i=1:sa1
            for j=1:su1
                sy=sy+1;
                if sy>=(boydeci+1) 
                    break 
                end
                piksel(sy)= resim(i,j,R);
                 if Decimal(sy)==0
                     piksel(sy)= piksel(sy)-(mod(resim(i,j,R),2^2));
                 elseif Decimal(sy)==1
                   piksel(sy)= piksel(sy)-(mod(resim(i,j,R),2^2))+1;
                      elseif Decimal(sy)==2
                        piksel(sy)= piksel(sy)-(mod(resim(i,j,R),2^2))+2;
                 else 
                        piksel(sy)= piksel(sy)-(mod(resim(i,j,R),2^2))+3;


                 end
            end
        end
        %Ayarlanan pixel deðerleri gerekli konumlara for döngüsü içinde
        %yerleþtirilir.
        sy=0;
                for i=1:sa1
                    for j=1:su1
                        sy=sy+1;
                       if sy>=(boydeci+1)
                           break
                       end
                        resim(i,j,R)=piksel(sy);
                    end
                end

        %Resmin çözümlenmesi için gerekli olan metin uzunluðuda resmin içine gizlenerek karþý tarafa
        %gönderilir.
        [sa,su,k]=size(resim);
        %Karþý tarafa gönderilecek sayýnýn  birler basamaðý bulunur.
        birler=fix(mod(boydeci,10));
        %Onlar basamaðý bulunur.
        onlar=fix(mod((boydeci/10),10));
        %Yüzler basamaðý bulunur.
        yuzler=fix(mod((boydeci/100),10));
        

        %Resmin son pixellerine bulunan deðerler gizlenir.
        resim(sa,su,R)=(fix(resim(sa,su,R)/10)*10)+birler;
        resim(sa,su-1,R)=(fix(resim(sa,su-1,R)/10)*10)+onlar;
        resim(sa,su-2,R)=(fix(resim(sa,su-2,R)/10)*10)+yuzler;
        %resim(sa,su-2,R)=(fix(resim(sa,su-3,R)/10)*10)+binler;
        %resim(sa,su-3,1)=(fix(resim(sa,su-4,1)/10)*10)+R;
        resim(sa,su-3,1)=(fix(resim(sa,su-3,1)/10)*10)+R;
        %Ýþlemleri tamamlanan resim ilgili konuma þifreliresim olarak kayýt edilir.

                
        [filename, pathname] = uiputfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
  'Save encrypted image file', 'C:\Users\Elif\Desktop\sifrelenmisresimm.png');
    
           
       imwrite(resim, fullfile(pathname, filename), 'png');
       
       axes(handles.axes4);
       imshow(resim);
       xlswrite('resim6.xlsx',resim(:,:,1),'Resim.1');
       xlswrite('resim6.xlsx',resim(:,:,2),'Resim.2');
       xlswrite('resim6.xlsx',resim(:,:,3),'Resim.3');
        
%histogram degerini gösterme
input2=resim;
Red2 = input2(:,:,1);
Green2 = input2(:,:,2);
Blue2 = input2(:,:,3);
[yRed2, x2] = imhist(Red2);
[yGreen2, x2] = imhist(Green2);
[yBlue2, x2] = imhist(Blue2);
axes(handles.axes8);
plot(x2, yRed2, 'Red', x2, yGreen2, 'Green', x2, yBlue2, 'Blue');



      %mail
resim_gonderme=fullfile(pathname, filename);
mail = 'donemprojesi2016@gmail.com'; %gonderilecek mail
password = '60546054'; %sifresi

% Then this code will set up the preferences properly: 
setpref('Internet','E_mail',mail); 
setpref('Internet','SMTP_Server','smtp.gmail.com'); 
setpref('Internet','SMTP_Username',mail); 
setpref('Internet','SMTP_Password',password); 
props = java.lang.System.getProperties; 
props.setProperty('mail.smtp.auth','true'); 
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory'); 
props.setProperty('mail.smtp.socketFactory.port','465'); 
email=get(handles.edit4,'String'); 
if(isempty(get(handles.edit4,'String')))
      email='file.es.file@gmail.com';
end
% Send the email. Note that the first input is the address you are sending the email to 
setpref('Internet','SMTP_Server','smtp.gmail.com'); 
setpref('Internet','E_mail','an.example.email.address@gmail.com'); 
sendmail(email,'Veri Gizleme Bilimi', 'Gizli veriniz ektedir.',resim_gonderme); 
        end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
   'Select the image file');
set(handles.text3, 'string', fullfile(pathname, filename));
sifresim = imread(fullfile(pathname, filename));
axes(handles.axes5);
imshow(sifresim);

%Þifrelenmiþ resmin boyutlarý belirlenir.
[sa,su,R]=size(sifresim);



%Hangi boyut matrisinde iþlem yapýlacaðý resimden çekilir.
R=mod(sifresim(sa,su-3,1),10);

%Resim içine gizlenen metin uzunluðu belli pixeller içinden çekilir.

birler=mod(sifresim(sa,su,R),10);
onlar=mod(sifresim(sa,su-1,R),10);
yuzler=mod(sifresim(sa,su-2,R),10);
%binler=mod(sifresim(sa,su-3,R),10);
%boydeci=(binler*1000)+(yuzler*100)+(onlar*10)+(birler);
boydeci=(yuzler*100)+(onlar*10)+(birler);


%Metindeki harf sayýsý belirlenir
harf=boydeci/4;

%Þifreli pixellerin decimal deðerleri gerekli iþlemler yapýlarak bir vektör içine alýnýr
sy=0;
for i=1:sa
    for j=1:su
        sy=sy+1;
        if sy>=(boydeci+1)
                   break
               end
        sifpik(sy)=sifresim(i,j,R);
        deci(sy)=mod(sifpik(sy),4);
    end
end
%Alýnan 2 bitlik decimal deðerler tekrar binary yapýlarak birbirlerine
%eklenir ve 8 bitlik harfler ortaya çýkar.
deci=double(deci);
sy=0;
for i=1:harf
    for j=1:2:7
        sy=sy+1;
       
         binary(i:i,j:j+1)=de2bi(deci(sy));
          if deci(sy)==1
            binary(i:i,j:j+1)=[1 0];
        end
    end
end
binary=double(binary);
%Hesaplanan binary deðerler önce decimal deðerlere sonra da karakter
%karþýlýklarýna dönüþtürülür.
sy=0;
binary(:,1)=[];
for i=1:harf
        
        ascii(i)=bi2de(binary(i,:));
        metin(i)=char(ascii(i));
   
end

set(handles.text4, 'string', metin);

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
anaekran;
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
resimicerisine;
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
