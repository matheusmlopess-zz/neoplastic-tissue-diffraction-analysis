function varargout = interface(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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

function interface_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
% clear all
% clc

global caminhoDosArquivosDeTexto;
            caminhoDosArquivosDeTexto = pwd;
            
         
        global    PA_04_VZ                 ...
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
                  Q;                     
             
      
       [  PA_04_VZ,                 ...
          PA_04_PLS,                ...
          PA_03_VZ_REP,             ...
          PA_03_PLS,                ...
          PA_02_VZ,                 ...
          PA_02_PLS,                ...
          PA_01_VZ,                 ...
          PA_01_PLS_1MIN,           ...
          PA_01_H2O_PLS_2MIN,       ...
          PA_01_H2O_PLS_1MIN,       ...
          Q ...
          TETA]                     ...
          =       inicializaVariaveis_();
       
       %VARIAVEIS CORRIGIDAS COM pA H20 COM Plastico IRRADIADO 1MIN:
        pA01_H20_PLS = PA_01_H2O_PLS_1MIN - PA_01_VZ     - PA_01_PLS_1MIN;
        pA02_H20_PLS = PA_01_H2O_PLS_1MIN - PA_02_VZ     - PA_02_PLS;
        pA03_H20_PLS = PA_01_H2O_PLS_1MIN - PA_03_VZ_REP - PA_03_PLS;
        pA04_H20_PLS = PA_01_H2O_PLS_1MIN - PA_04_VZ     - PA_04_PLS;

        %VARIAVEIS CORRIGIDAS COM pA H20 COM Plastico IRRADIADO 1MIN:
        pA01_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_01_VZ     - PA_01_PLS_1MIN;
        pA02_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_02_VZ     - PA_02_PLS;
        pA03_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_03_VZ_REP - PA_03_PLS;
        pA04_H20_PLS_2MIN = PA_01_H2O_PLS_2MIN - PA_04_VZ     - PA_04_PLS;

       format shortG;         
         
function listbox1_Callback(hObject, eventdata, handles)

global Arqselecionado;
global pAselecionado;
global TETA
global caminhoDosArquivosDeTexto; 
global dadosSelecionados;

            cla(handles.axes1,'reset');
            cla(handles.axes2,'reset');
            set(handles.tabela1, 'Data', cell(size(get(handles.tabela1,'Data'))));
            
                    contents      = cellstr(get(hObject,'String'));
                    Arqselecionado=      contents{get(hObject,'Value')} ;
                    [tipoPortaAmostra,matches] = strsplit(Arqselecionado,{' ','.txt'},'CollapseDelimiters',true);
                    pAselecionado=tipoPortaAmostra(2);
                    
                                 set(handles.portaAmostraValor,'String',pAselecionado);
                                 set(handles.tipoAmostra,'String',tipoPortaAmostra(1));

    aux= strcat( '\textData\',Arqselecionado);
    txtSelect=strcat(caminhoDosArquivosDeTexto,aux);

                    fid = fopen(txtSelect);
                         tline = fgetl(fid);
                         ok=0;
                         i=0;
                         tamanho=234;
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
%            Define op�oes da lista 2 para analise grafica da tabela 2 
             set(handles.listbox2,'String',{'Porta Amostra Vazio',...
                                            'Porta Amostra s� Plastico',...
                                            'Porta Amostra H20 1Min',....
                                            'Porta Amostra H20 2Min', ...
                                            'Core��o H20 1Min > (H20-Vazio-PLS)', ...
                                            'Core��o H20 2Min > (H20-Vazio-PLS)'});

                                        
     
%            Define variaveis presentes na tabela 1 (Tabela de corre�oes ou tabela superior)
             ColunaNomes = {'theta' 'q'  'Intensidade'};
             set(handles.tabela1,'ColumnName',ColunaNomes);
             set(handles.tabela1, 'ColumnWidth',{68},'units','Normalized');

%            Define variaveis presentes na tabela 2 (Tabela canto inferior a esquerda)
             ColunaNomes = {'theta' '2xtheta' 'Intensidade'};
             set(handles.tabela2,'ColumnName',ColunaNomes);
             set(handles.tabela2, 'ColumnWidth',{68},'units','Normalized');

%            Define variaveis presentes na tabela 3 (Tabela canto inferior a direita)
             ColunaNomes = {'Int. Amostra' 'pA_tipo Int'  'Corre��o'};
             set(handles.tabela3,'ColumnName',ColunaNomes);
             set(handles.tabela3, 'ColumnWidth',{70},'units','Normalized');

              dataTab = [TETA dadosSelecionados];
              set(handles.tabela2,'Data',dataTab);
 
function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% BOTAO PARA LER OS ARQUIVOS DE TEXTO DAS AMOSTRAS
function ler_Amostras_txt_Callback(hObject, eventdata, handles)
global caminhoDosArquivosDeTexto;
files = dir(fullfile(caminhoDosArquivosDeTexto,'\textData','*.txt'));

for x = 1 : length(files)
    set(handles.listbox1,'String',{files.name});
end

function listbox2_Callback(hObject, eventdata, handles)
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
                  Q;       
  
 
    contents      = cellstr(get(hObject,'String'));
    Arqselecionado2=      contents{get(hObject,'Value')};
    
%   Op�oes para mostras nos graficos e na tabela 1 quando selecionada
                                       
    opc1 ='Porta Amostra Vazio';
    opc2 ='Porta Amostra s� Plastico';
    opc3 ='Porta Amostra H20 1Min';
    opc4 ='Porta Amostra H20 2Min';
    opc5 ='Core��o H20 1Min > (H20-Vazio-PLS)';
    opc6 ='Core��o H20 2Min > (H20-Vazio-PLS)';
    
%   l� a op��o para plotar grafico em nova janela:
    mostarJanela= get(handles.PlotarEmNovaJanela,'Value');
%   se 0 significa que n�o esta selecionada se > 0 ou "1" significa que
%   esta selecionada e ativa --->  if(mostarJanela>0)

if(strcmp(Arqselecionado2,opc1))
              cla(handles.axes2,'reset')
              axes(handles.axes2);
              if(strcmp(pAselecionado,'PA01'))
                     dataTab = [TETA Q PA_01_VZ];
                     set(handles.tabela1,'Data',dataTab);
                     plotGraficoFacil(Q,PA_01_VZ,'Intensidades obtidas para PA01 Vazio','PA01 Vazio');
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_01_VZ,'Intensidades obtidas para PA01 Vazio','PA01 Vazio');
                     end                                             
              end
              if(strcmp(pAselecionado,'PA02'))
                     dataTab = [TETA Q PA_02_VZ];
                     set(handles.tabela1,'Data',dataTab);
                     plotGraficoFacil(Q,PA_02_VZ,'Intensidades obtidas para PA02 Vazio','PA02 Vazio');
                     if(mostarJanela>0)
                           figure
                           plotGraficoFacil(Q,PA_02_VZ,'Intensidades obtidas para PA02 Vazio','PA02 Vazio');
                     end         
              end
              if(strcmp(pAselecionado,'PA03'))
                     dataTab = [TETA Q PA_03_VZ_REP];
                     set(handles.tabela1,'Data',dataTab);
                     plotGraficoFacil(Q,PA_03_VZ_REP,'Intensidades obtidas para PA03 Vazio','PA03 Vazio');
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_03_VZ_REP,'Intensidades obtidas para PA03 Vazio','PA03 Vazio');
                     end     
              end
              if(strcmp(pAselecionado,'PA04'))
                     dataTab = [TETA Q PA_04_VZ];
                     set(handles.tabela1,'Data',dataTab);
                     plotGraficoFacil(Q,PA_04_VZ,'Intensidades obtidas para PA04 Vazio','PA04 Vazio');
                     if(mostarJanela>0)
                          figure
                          plotGraficoFacil(Q,PA_04_VZ,'Intensidades obtidas para PA04 Vazio','PA04 Vazio');
                     end      
              end

   end
if(strcmp(Arqselecionado2,opc2))
                           cla(handles.axes1,'reset')
                           axes(handles.axes1);
                           if(strcmp(pAselecionado,'PA01'))
                                dataTab = [TETA Q PA_01_PLS_1MIN];
                                set(handles.tabela1,'Data',dataTab);
                                plotGraficoFacil(Q,PA_01_PLS_1MIN,'Intensidades obtidas para PA01 com Pl�stico','PA01 Pl�stico');
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_01_PLS_1MIN,'Intensidades obtidas para PA01 com Pl�stico','PA01 Pl�stico');
                                end                                            
                          end
                          
                           if(strcmp(pAselecionado,'PA02'))
                                 dataTab = [TETA Q PA_02_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                 plotGraficoFacil(Q,PA_02_PLS,'Intensidades obtidas para PA02 com Pl�stico','PA02 Pl�stico');
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_02_PLS,'Intensidades obtidas para PA02 com Pl�stico','PA02 Pl�stico');
                                end                               
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA Q PA_03_PLS];
                                 set(handles.tabela1,'Data',dataTab);                                       
                                 plotGraficoFacil(Q,PA_03_PLS,'Intensidades obtidas para PA03 com Pl�stico','PA03 Pl�stico');
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_03_PLS,'Intensidades obtidas para PA03 com Pl�stico','PA03 Pl�stico');
                                end                              
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 dataTab = [TETA Q PA_04_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                 plotGraficoFacil(Q,PA_04_PLS,'Intensidades obtidas para PA04 com Pl�stico','PA04 Pl�stico');
                                if(mostarJanela>0) 
                                      figure
                                      plotGraficoFacil(Q,PA_04_PLS,'Intensidades obtidas para PA04 com Pl�stico','PA04 Pl�stico');
                                end
                          end
end  
if(strcmp(Arqselecionado2,opc3))
    
                           cla(handles.axes1,'reset')
                           cla(handles.axes2,'reset')
                           axes(handles.axes2);
    
                           
                                dataTab = [TETA Q PA_01_H2O_PLS_1MIN];
                                set(handles.tabela1,'Data',dataTab);
                                plotGraficoFacil(Q,PA_01_H2O_PLS_1MIN,'Intensidades obtidas para PA01 com H20 1MIN','PA01 H20 1MIN');
                                if(mostarJanela>0) 
                                      figure
                                       plotGraficoFacil(Q,PA_01_H2O_PLS_1MIN,'Intensidades obtidas para PA01 com H20 1MIN','PA01 H20 1MIN');
                                end                                            
end
if(strcmp(Arqselecionado2,opc4))
    
                           cla(handles.axes1,'reset')
                           axes(handles.axes1);
    
                           
                                dataTab = [TETA Q PA_01_H2O_PLS_2MIN];
                                set(handles.tabela1,'Data',dataTab);
                                plotGraficoFacil(Q,PA_01_H2O_PLS_2MIN,'Intensidades obtidas para PA01 com H20 2MIN','PA01 H20 2MIN');
                                if(mostarJanela>0) 
                                      figure
                                       plotGraficoFacil(Q,PA_01_H2O_PLS_2MIN,'Intensidades obtidas para PA01 com H20 2MIN','PA01 H20 2MIN');
                                end                                            
end
if(strcmp(Arqselecionado2,opc5))
                                 cla(handles.axes2,'reset')
                                 axes(handles.axes2);
                           
                              if(strcmp(pAselecionado,'PA01'))
                                 dataTab = [TETA Q pA01_H20_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA01_H20_PLS,'k');
%                                         hold
%                                         plot(Q,PA_01_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_01_PLS_1MIN,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                        title('Corre��o H20 = H20 - PA01 VAzio - PA01 PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA01 H20-Vz-Pl','k')                                       
%                                         legend('PA01 Vazio','b')
%                                         legend('PA01 Pl�stico','m')
%                                         legend('PA01 h20 1min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA01_H20_PLS,'k');
                                                hold
                                                plot(Q,PA_01_VZ,'b');
                                                hold all
                                                plot(Q,PA_01_PLS_1MIN,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                                title('Corre��o H20 = H20 - PA01 VAzio - PA01 PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA01 H20-Vz-Pl','k')                                       
                                                legend('PA01 Vazio','b')
                                                legend('PA01 Pl�stico','m')
                                                legend('PA01 h20 1min','r')
                                                grid on
                                            end     
                           end
                           if(strcmp(pAselecionado,'PA02'))
                                 dataTab = [TETA Q pA02_H20_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA02_H20_PLS,'k');
%                                         hold
%                                         plot(Q,PA_02_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_02_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                        title('Corre��o H20 = H20 - PA01 VAzio - PA01 PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA02 H20-Vz-Pl','k')                                       
%                                         legend('PA02 Vazio','b')
%                                         legend('PA02 Pl�stico','m')
%                                         legend('PA01 h20 1min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA02_H20_PLS,'k');
                                                hold
                                                plot(Q,PA_02_VZ,'b');
                                                hold all
                                                plot(Q,PA_02_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA02 H20-Vz-Pl','k')                                       
                                                legend('PA02 Vazio','b')
                                                legend('PA02 Pl�stico','m')
                                                legend('PA01 h20 1min','r')
                                                grid on
                                            end 
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA Q pA03_H20_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA03_H20_PLS,'k');
%                                         hold
%                                         plot(Q,PA_03_VZ_REP,'b');
%                                         hold all
%                                         plot(Q,PA_03_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA03 H20-Vz-Pl','k')                                       
%                                         legend('PA03 Vazio','b')
%                                         legend('PA03 Pl�stico','m')
%                                         legend('PA01 h20 1min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA03_H20_PLS,'k');
                                                hold
                                                plot(Q,PA_03_VZ_REP,'b');
                                                hold all
                                                plot(Q,PA_03_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA03 H20-Vz-Pl','k')                                       
                                                legend('PA03 Vazio','b')
                                                legend('PA03 Pl�stico','m')
                                                legend('PA01 h20 1min','r')
                                                grid on
                                            end                                 
                                        
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 dataTab = [TETA Q pA04_H20_PLS];
                                 set(handles.tabela1,'Data',dataTab);
                                         plot(Q,pA04_H20_PLS,'k');
%                                         hold
%                                         plot(Q,PA_04_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_04_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA04 H20-Vz-Pl','k')                                       
%                                         legend('PA04 Vazio','b')
%                                         legend('PA04 Pl�stico','m')
%                                         legend('PA01 h20 1min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA04_H20_PLS,'k');
                                                hold
                                                plot(Q,PA_04_VZ,'b');
                                                hold all
                                                plot(Q,PA_04_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_1MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA04 H20-Vz-Pl','k')                                       
                                                legend('PA04 Vazio','b')
                                                legend('PA04 Pl�stico','m')
                                                legend('PA01 h20 1min','r')
                                                grid on
                                            end                                            
                          end
    end
if(strcmp(Arqselecionado2,opc6))
                           cla(handles.axes1,'reset')
                           axes(handles.axes1);
                           
                              if(strcmp(pAselecionado,'PA01'))
                                 dataTab = [TETA Q pA01_H20_PLS_2MIN];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA01_H20_PLS_2MIN,'k');
%                                         hold
%                                         plot(Q,PA_01_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_01_PLS_1MIN,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA01 H20-Vz-Pl','k')                                       
%                                         legend('PA01 Vazio','b')
%                                         legend('PA01 Pl�stico','m')
%                                         legend('PA01 h20 2min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA01_H20_PLS_2MIN,'k');
                                                hold
                                                plot(Q,PA_01_VZ,'b');
                                                hold all
                                                plot(Q,PA_01_PLS_1MIN,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA01 H20-Vz-Pl','k')                                       
                                                legend('PA01 Vazio','b')
                                                legend('PA01 Pl�stico','m')
                                                legend('PA01 h20 2min','r')
                                                grid on
                                            end     
                           end
                           if(strcmp(pAselecionado,'PA02'))
                                 dataTab = [TETA Q pA02_H20_PLS_2MIN];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA02_H20_PLS_2MIN,'k');
%                                         hold
%                                         plot(Q,PA_02_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_02_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA02 H20-Vz-Pl','k')                                       
%                                         legend('PA02 Vazio','b')
%                                         legend('PA02 Pl�stico','m')
%                                         legend('PA01 h20 2min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA02_H20_PLS_2MIN,'k');
                                                hold
                                                plot(Q,PA_02_VZ,'b');
                                                hold all
                                                plot(Q,PA_02_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA02 H20-Vz-Pl','k')                                       
                                                legend('PA02 Vazio','b')
                                                legend('PA02 Pl�stico','m')
                                                legend('PA01 h20 2min','r')
                                                grid on
                                            end 
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA Q pA03_H20_PLS_2MIN];
                                 set(handles.tabela1,'Data',dataTab);
                                        plot(Q,pA03_H20_PLS_2MIN,'k');
%                                         hold
%                                         plot(Q,PA_03_VZ_REP,'b');
%                                         hold all
%                                         plot(Q,PA_03_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA03 H20-Vz-Pl','k')                                       
%                                         legend('PA03 Vazio','b')
%                                         legend('PA03 Pl�stico','m')
%                                         legend('PA01 h20 2min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA03_H20_PLS_2MIN,'k');
                                                hold
                                                plot(Q,PA_03_VZ_REP,'b');
                                                hold all
                                                plot(Q,PA_03_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA03 H20-Vz-Pl','k')                                       
                                                legend('PA03 Vazio','b')
                                                legend('PA03 Pl�stico','m')
                                                legend('PA01 h20 2min','r')
                                                grid on
                                            end                                 
                                        
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 dataTab = [TETA Q pA04_H20_PLS_2MIN];
                                 set(handles.tabela1,'Data',dataTab);
                                         plot(Q,pA04_H20_PLS_2MIN,'k');
%                                         hold
%                                         plot(Q,PA_04_VZ,'b');
%                                         hold all
%                                         plot(Q,PA_04_PLS,'m');
%                                         hold all
%                                         plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                        title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                        xlabel('q(\theta,\lambda)');
                                        ylabel('Intensidade');
%                                         legend('PA04 H20-Vz-Pl','k')                                       
%                                         legend('PA04 Vazio','b')
%                                         legend('PA04 Pl�stico','m')
%                                         legend('PA01 h20 2min','r')
                                        grid on
                                            if(mostarJanela>0)
                                            figure
                                                plot(Q,pA04_H20_PLS_2MIN,'k');
                                                hold
                                                plot(Q,PA_04_VZ,'b');
                                                hold all
                                                plot(Q,PA_04_PLS,'m');
                                                hold all
                                                plot(Q,PA_01_H2O_PLS_2MIN,'r');
                                                title('Corre��o H20 = H20 - PA01VAzio - PA01PLS');
                                                xlabel('q(\theta,\lambda)');
                                                ylabel('Intensidade');
                                                legend('PA04 H20-Vz-Pl','k')                                       
                                                legend('PA04 Vazio','b')
                                                legend('PA04 Pl�stico','m')
                                                legend('PA01 h20 2min','r')
                                                grid on
                                            end                                            
                          end
end
       
function listbox2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function plotarSemCorrigir_Callback(hObject, eventdata, handles)
  global dadosSelecionados;
  
    axes(handles.axes2);
    plot(dadosSelecionados(:,2), 'k');
    title('Amostra sem corrigir');
    xlabel('\theta');
    ylabel('Intensidade');
    grid on
    hold

% --- Executes on button press in soh_vazio.
function soh_vazio_Callback(hObject, eventdata, handles)
set(handles.soh_agua,'Value',0)
set(handles.soh_agua2,'Value',0)
set(handles.soh_plastico,'Value',0)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.h2o_mais_vazio2,'Value',0)

set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));
 
global            pAselecionado ...
                  PA_04_VZ                 ...
                  PA_03_VZ_REP             ...
                  PA_02_VZ                 ...
                  PA_01_VZ   ...
                  dadosSelecionados ...
                  plotCorrigido;
                            if(strcmp(pAselecionado,'PA01'))
                                  curr =    dadosSelecionados(:,2) -  PA_01_VZ;
                                  dataTab =  [dadosSelecionados(:,2)  PA_01_VZ curr];
                                  set(handles.tabela3,'Data',dataTab);
                                  plotCorrigido = curr;
                           end
                          
                           if(strcmp(pAselecionado,'PA02'))
                                   curr = dadosSelecionados(:,2) - PA_02_VZ;
                                   dataTab =  [dadosSelecionados(:,2)  PA_02_VZ curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                           end
                          if(strcmp(pAselecionado,'PA03'))
                                    curr = dadosSelecionados(:,2) - PA_03_VZ_REP;
                                    dataTab =  [dadosSelecionados(:,2) PA_03_VZ_REP curr];
                                    set(handles.tabela3,'Data',dataTab);
                                    plotCorrigido = curr;
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                   curr = dadosSelecionados(:,2) - PA_04_VZ;
                                   dataTab =  [dadosSelecionados(:,2)  PA_04_VZ curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                          end

function soh_agua_Callback(hObject, eventdata, handles)
%Configura bot�es para calcular coree��o dos resultados da amostras somente
%em rela��o ao pA s� com agua ERRO groceiro... mas serve para analise
set(handles.soh_agua2,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.soh_plastico,'Value',0)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.h2o_mais_vazio2,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));
        global pAselecionado ...
               dadosSelecionados ...
               plotCorrigido...
               PA_01_H2O_PLS_1MIN ;       
         

      curr =    dadosSelecionados(:,2) -  PA_01_H2O_PLS_1MIN;
      dataTab =  [dadosSelecionados(:,2)   PA_01_H2O_PLS_1MIN curr];
      set(handles.tabela3,'Data',dataTab);
      plotCorrigido = curr;

function h2o_mais_vazio_Callback(hObject, eventdata, handles)
set(handles.soh_agua,'Value',0)
set(handles.soh_agua2,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.soh_plastico,'Value',0)
set(handles.h2o_mais_vazio2,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));
        global pAselecionado ...
               dadosSelecionados ...
               plotCorrigido...
               pA01_H20_PLS ...
               pA02_H20_PLS ...
               pA03_H20_PLS ...
               pA04_H20_PLS ;       
         
if(strcmp(pAselecionado,'PA01'))
      curr =    dadosSelecionados(:,2) -  pA01_H20_PLS;
      dataTab =  [dadosSelecionados(:,2)   pA01_H20_PLS curr];
      set(handles.tabela3,'Data',dataTab);
      plotCorrigido = curr;
end

if(strcmp(pAselecionado,'PA02'))
     curr = dadosSelecionados(:,2) - pA02_H20_PLS;
     dataTab =  [dadosSelecionados(:,2)  pA02_H20_PLS curr];
     set(handles.tabela3,'Data',dataTab);
     plotCorrigido = curr;                                
end
if(strcmp(pAselecionado,'PA03'))
            curr = dadosSelecionados(:,2) - pA03_H20_PLS;
            dataTab =  [dadosSelecionados(:,2) pA03_H20_PLS curr];
            set(handles.tabela3,'Data',dataTab);
            plotCorrigido = curr;                                        
end
if(strcmp(pAselecionado,'PA04'))
        curr = dadosSelecionados(:,2) - pA04_H20_PLS;
       dataTab =  [dadosSelecionados(:,2)  pA04_H20_PLS curr];
       set(handles.tabela3,'Data',dataTab);
       plotCorrigido = curr;
end

function plot_corrigido_Callback(hObject, eventdata, handles)
     global plotCorrigido...
            Q ...
            media;
     x = Q
     y = plotCorrigido;
         media=mean(plotCorrigido,1)
         axes(handles.axes1);
         mostrarMedia= get(handles.checkbox9,'Value');
         
         if(mostrarMedia>0)
                hold
                plot(media*ones(234), 'LineWidth', 3)
         end
         
        plot(plotCorrigido, 'color',rand(1,3));     
        title('Grafico de intensidades (Corrigido)');
        xlabel('q(\theta,\lambda)');
        ylabel('Intensidade');
        
        mostrarPicos = get(handles.valor_de_pico,'Value');
            if(mostrarPicos>0)
                indexmin = find(min(y) == y);
                xmin = x(indexmin);
                ymin = y(indexmin);
                indexmax = find(max(y) == y);
                xmax = x(indexmax);
                ymax = y(indexmax);
                strmin = ['Minimum = ',num2str(ymin)];
                text(xmin,ymin,strmin,'HorizontalAlignment','left');
                strmax = ['Maximum = ',num2str(ymax)];
                text(xmax,ymax,strmax,'HorizontalAlignment','left');
              end

 grid on
 
% --- Executes on button press in h2o_mais_vazio2.
function h2o_mais_vazio2_Callback(hObject, eventdata, handles)
set(handles.soh_agua,'Value',0)
set(handles.soh_agua2,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.soh_plastico,'Value',0)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));

        global pAselecionado ...
               dadosSelecionados ...
               plotCorrigido...
                  pA01_H20_PLS_2MIN ...
                  pA02_H20_PLS_2MIN ...
                  pA03_H20_PLS_2MIN ...
                  pA04_H20_PLS_2MIN  ;       
         
if(strcmp(pAselecionado,'PA01'))
      curr =    dadosSelecionados(:,2) -  pA01_H20_PLS_2MIN;
      dataTab =  [dadosSelecionados(:,2)   pA01_H20_PLS_2MIN curr];
      set(handles.tabela3,'Data',dataTab);
      plotCorrigido = curr;
end

if(strcmp(pAselecionado,'PA02'))
     curr = dadosSelecionados(:,2) - pA02_H20_PLS_2MIN;
     dataTab =  [dadosSelecionados(:,2)  pA02_H20_PLS_2MIN curr];
     set(handles.tabela3,'Data',dataTab);
     plotCorrigido = curr;                                
end
if(strcmp(pAselecionado,'PA03'))
            curr = dadosSelecionados(:,2) - pA03_H20_PLS_2MIN;
            dataTab =  [dadosSelecionados(:,2) pA03_H20_PLS_2MIN curr];
            set(handles.tabela3,'Data',dataTab);
            plotCorrigido = curr;                                        
end
if(strcmp(pAselecionado,'PA04'))
        curr = dadosSelecionados(:,2) - pA04_H20_PLS_2MIN;
       dataTab =  [dadosSelecionados(:,2)  pA04_H20_PLS_2MIN curr];
       set(handles.tabela3,'Data',dataTab);
       plotCorrigido = curr;
end

% --- Executes on button press in soh_plastico.
function soh_plastico_Callback(hObject, eventdata, handles)
set(handles.soh_agua,'Value',0)
set(handles.soh_agua2,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.h2o_mais_vazio2,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));

  global pAselecionado ...
               dadosSelecionados ...
               plotCorrigido...
               PA_04_PLS                ...
               PA_03_PLS                ...
               PA_02_PLS                ...
               PA_01_PLS_1MIN ;       
           
                            if(strcmp(pAselecionado,'PA01'))
                                  curr =    dadosSelecionados(:,2) -  PA_01_PLS_1MIN;
                                  dataTab =  [dadosSelecionados(:,2)  PA_01_PLS_1MIN curr];
                                  set(handles.tabela3,'Data',dataTab);
                                  plotCorrigido = curr;
                           end
                          
                           if(strcmp(pAselecionado,'PA02'))
                                   curr = dadosSelecionados(:,2) - PA_02_PLS;
                                   dataTab =  [dadosSelecionados(:,2)  PA_02_PLS curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                           end
                          if(strcmp(pAselecionado,'PA03'))
                                    curr = dadosSelecionados(:,2) - PA_03_PLS;
                                    dataTab =  [dadosSelecionados(:,2) PA_03_PLS curr];
                                    set(handles.tabela3,'Data',dataTab);
                                    plotCorrigido = curr;
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                   curr = dadosSelecionados(:,2) - PA_04_PLS;
                                   dataTab =  [dadosSelecionados(:,2)  PA_04_PLS curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                          end

% --- Executes on button press in soh_agua2.
function soh_agua2_Callback(hObject, eventdata, handles)
set(handles.soh_agua,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.soh_plastico,'Value',0)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.h2o_mais_vazio2,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));
   global pAselecionado ...
               dadosSelecionados ...
               plotCorrigido...
               PA_01_H2O_PLS_2MIN ;       
         

      curr =    dadosSelecionados(:,2) -  PA_01_H2O_PLS_2MIN;
      dataTab =  [dadosSelecionados(:,2)   PA_01_H2O_PLS_2MIN curr];
      set(handles.tabela3,'Data',dataTab);
      plotCorrigido = curr;

function varargout = interface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end