function varargout = resimicerisine(varargin)
% RESIMICERISINE MATLAB code for resimicerisine.fig
%      RESIMICERISINE, by itself, creates a new RESIMICERISINE or raises the existing
%      singleton*.
%
%      H = RESIMICERISINE returns the handle to a new RESIMICERISINE or the handle to
%      the existing singleton*.
%
%      RESIMICERISINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESIMICERISINE.M with the given input arguments.
%
%      RESIMICERISINE('Property','Value',...) creates a new RESIMICERISINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resimicerisine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resimicerisine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resimicerisine

% Last Modified by GUIDE v2.5 18-Dec-2016 22:18:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resimicerisine_OpeningFcn, ...
                   'gui_OutputFcn',  @resimicerisine_OutputFcn, ...
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


% --- Executes just before resimicerisine is made visible.
function resimicerisine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resimicerisine (see VARARGIN)

% Choose default command line output for resimicerisine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resimicerisine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resimicerisine_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
   'Select the image file');
resim3 = imread(fullfile(pathname, filename));
axes(handles.axes1);
imshow(resim3);
input= resim3;
Red = input(:,:,1);
Green = input(:,:,2);
Blue = input(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
axes(handles.axes6);
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
handles.resim3=resim3;
guidata(hObject, handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hata='';
        if(isempty(get(handles.axes1, 'Children')))
            hatalim=msgbox('Örtü resmi giriniz','Hata');
            hata=1;
        end
        if(isempty(hata))
[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
   'Select the image file');
resim2 = imread(fullfile(pathname, filename));
axes(handles.axes2);
imshow(resim2);
input2=im2bw(resim2);
axes(handles.axes8);
imshow(input2,[]);
handles.resim2=resim2;
guidata(hObject, handles);
        end 
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hata='';
        if(isempty(get(handles.axes1, 'Children')))
            hatalim=msgbox('Örtü resmi giriniz','Hata');
            hata=1;
        end
         if(isempty(get(handles.axes2, 'Children')))
            hatalim2=msgbox('Gizlenecek resmi giriniz','Hata');
            hata=1;
        end
        if(isempty(hata))
target=handles.resim3;
resim=handles.resim2;
encrypt=im2bw(resim);
xlswrite('C:\Users\Elif\Desktop\bitirme projesi formu\Login\sig.xlsx',encrypt, 'Binary');
OnesPos=find(encrypt==1);
xlswrite('C:\Users\Elif\Desktop\bitirme projesi formu\Login\sig.xlsx',OnesPos, 'Ones');
ZerosPos=find(encrypt==0);
xlswrite('C:\Users\Elif\Desktop\bitirme projesi formu\Login\sig.xlsx',ZerosPos, 'Zeros');
target=imresize(target,[size(encrypt)]); %Both images must be the same size
Target_Red =target(:,:,1); 
Target_Green =target(:,:,2);
Target_Blue =target(:,:,3);
Target_Red2=Target_Red;
Target_Red2(OnesPos)=bitor(Target_Red(OnesPos),1);
Target_Red2(ZerosPos)=bitand(Target_Red(ZerosPos),254);
Encrypted_Target=cat(3,Target_Red2,Target_Green,Target_Blue);
%xlswrite('resimbinary.xlsx',Encrypted_Target(:,:,1),'Resim.1');
%xlswrite('resimbinary.xlsx',Encrypted_Target(:,:,2),'Resim.2');
%xlswrite('resimbinary.xlsx',Encrypted_Target(:,:,3),'Resim.3');

[filename, pathname] = uiputfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
  'Save encrypted image file', 'C:\Users\Elif\Desktop\gizliresimm.png');
imwrite(Encrypted_Target, fullfile(pathname, filename), 'png');

%Ýþlenmiþ resmi gösterme
resimislenmis = imread(fullfile(pathname, filename));
axes(handles.axes9);
imshow(resimislenmis);
input3= resimislenmis;
Red = input3(:,:,1);
Green = input3(:,:,2);
Blue = input3(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
axes(handles.axes12);
plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

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
email=get(handles.edit3,'String'); 
if(isempty(get(handles.edit3,'String')))
      email='file.es.file@gmail.com';
end
% Send the email. Note that the first input is the address you are sending the email to 
setpref('Internet','SMTP_Server','smtp.gmail.com'); 
setpref('Internet','E_mail','an.example.email.address@gmail.com'); 
sendmail(email,'Veri Gizleme Bilimi', 'Gizli veriniz ektedir.',resim_gonderme); 
        end 
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif','Image Files (*.jpg,*.png,*.gif)';}, ...
   'Select the image file');
resim5 = imread(fullfile(pathname, filename));
axes(handles.axes3);
imshow(resim5);
handles.resim5=resim5;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hata_coz='';
            if(isempty(get(handles.axes3, 'Children')))
            hatalim_mesaj=msgbox('Çözülecek olan resmi giriniz','Hata');
            hata_coz=1;
            end
            if(isempty(hata_coz))
Encrpted_Target_Red=handles.resim5(:,:,1);
Decrypted_Image=bitand(Encrpted_Target_Red,1);
%xlswrite('resimbinaryde.xlsx',Decrypted_Image(:,:,1),'Resim.1');
axes(handles.axes5);
imshow(Decrypted_Image,[]);
            end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
