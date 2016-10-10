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
clear all
clc

global caminhoDosArquivosDeTexto;
       caminhoDosArquivosDeTexto = pwd;
            
        global pA_H20_PLS;
        global pA_04;
        global pA_03;
        global pA_02_vazio;
        global pA_02;
        global pA_04_filme_plasticoVazio;
        global pA_03_repetidoVazio;
        global pA_03_paraFilme_vazio2;
        global pA_02_vazio_repetido;
        global pA_03_plastico;
        global pA_01_vazio2;
        global TETA2
        global TETA
             
       [pA_H20_PLS,pA_04,pA_03,pA_02_vazio,pA_02,pA_04_filme_plasticoVazio,pA_03_repetidoVazio,pA_03_plastico,pA_03_paraFilme_vazio2,pA_02_vazio_repetido,pA_01_vazio2,TETA2,TETA]=inicializaVariaveis();
       format shortG;         

            
   
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


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

             set(handles.listbox2,'String',{'Porta Amostra vazio (só Pástico)',  'Porta Amostra com H20', 'Coreção pA. c/Vazio+H20' });

             ColunaNomes = {'Theta' 'Thetax2'  'Intensidade'};
             set(handles.tabela1,'ColumnName',ColunaNomes);
             set(handles.tabela1, 'ColumnWidth',{68},'units','Normalized');

             ColunaNomes = {'Theta' 'Thetax2' 'Intensidade'};
             set(handles.tabela2,'ColumnName',ColunaNomes);
             set(handles.tabela2, 'ColumnWidth',{68},'units','Normalized');

            ColunaNomes = {'Int. Amostra' 'pA_tipo Int'  'Correção'};
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
set(handles.listbox1,'String',{files.name});

function listbox2_Callback(hObject, eventdata, handles)
        global pA_H20_PLS;
        global pA_03_plastico;
        global pA_01_vazio2;
        global pA_02_vazio;
        global pA_04_filme_plasticoVazio;
        global TETA2
        global TETA
        global pAselecionado;
        global Arqselecionado2;

 contents      = cellstr(get(hObject,'String'));
 Arqselecionado2=      contents{get(hObject,'Value')} ;
        
   if(strcmp(Arqselecionado2,'Porta Amostra vazio (só Pástico)'))
                                   
                          cla(handles.axes2,'reset')
                          if(strcmp(pAselecionado,'PA01'))
                                 dataTab = [TETA TETA2 pA_01_vazio2];
                                 set(handles.tabela1,'Data',dataTab);
                                         axes(handles.axes2);
                                        plot(pA_01_vazio2);
                                        title('Porta Amostra vazio (só Pástico)');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA01) vazio ')
                           end
                           if(strcmp(pAselecionado,'PA02'))
                                 dataTab = [TETA TETA2 pA_02_vazio];
                                 set(handles.tabela1,'Data',dataTab);
                                       axes(handles.axes2);
                                        plot(pA_02_vazio);
                                        title('Porta Amostra vazio (só Pástico)');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                       legend(' Porta Amostras (PA02) vazio ')
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA TETA2 pA_03_plastico];
                                 set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes2);
                                        plot(pA_03_plastico);
                                        title('Porta Amostra vazio (só Pástico)');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA03) vazio ')
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 dataTab = [TETA TETA2 pA_04_filme_plasticoVazio];
                                 set(handles.tabela1,'Data',dataTab);
                                         axes(handles.axes2);
                                        plot(pA_04_filme_plasticoVazio);
                                        title('Porta Amostra vazio (só Pástico)');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA04) vazio ')
                         end

   end
      
   if(strcmp(Arqselecionado2,'Porta Amostra com H20'))
                           cla(handles.axes1,'reset')
                          if(strcmp(pAselecionado,'PA01'))
                               dataTab = [TETA TETA2 pA_H20_PLS];
                                        set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes1);
                                        plot(pA_H20_PLS);
                                        title('Porta Amostra com H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA01) com agua ')
                          end
                          
                           if(strcmp(pAselecionado,'PA02'))
                               dataTab = [TETA TETA2 pA_H20_PLS];
                                        set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes1);
                                        plot(pA_H20_PLS);
                                        title('Porta Amostra com H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA02) com agua ')
                                        
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 dataTab = [TETA TETA2 pA_H20_PLS];
                                        set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes1);
                                        plot(pA_H20_PLS);
                                        title('Porta Amostra com H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA03) com agua ')
                                        
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                dataTab = [TETA TETA2 pA_H20_PLS];
                                        set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes1);
                                        plot(pA_H20_PLS);
                                        title('Porta Amostra com H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        legend(' Porta Amostras (PA04) com agua ')                                                             
                          end
    end
    if(strcmp(Arqselecionado2,'Coreção pA. c/Vazio+H20' ))
                          cla(handles.axes1,'reset')
                           cla(handles.axes2,'reset')
                          if(strcmp(pAselecionado,'PA01'))
                                 corrrct = [pA_H20_PLS+pA_01_vazio2];
                                 dataTab = [TETA TETA2 corrrct];
                                 set(handles.tabela1,'Data',dataTab);
                                         axes(handles.axes2);
                                        plot(corrrct);
                                        title('Coreção pA. c/Vazio+H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        hold	
                                        plot(pA_H20_PLS,'r') 
                                        plot(pA_01_vazio2,'g') 
                                        
                                     legend('H20+Vazio ','Porta Amostras (PA01) com agua ', 'Porta Amostras (PA01) vazio')
                           end
                          
                           if(strcmp(pAselecionado,'PA02'))
                               corrrct = [pA_H20_PLS+pA_02_vazio];
                                 dataTab = [TETA TETA2 corrrct];
                                 set(handles.tabela1,'Data',dataTab);
                                         axes(handles.axes2);
                                        plot(corrrct);
                                        title('Coreção pA. c/Vazio+H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        hold	
                                        plot(pA_H20_PLS,'r')
                                        plot(pA_02_vazio,'g') 
                                         legend('H20+Vazio ','Porta Amostras (PA02) com agua ', 'Porta Amostras (PA02) vazio')
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                 corrrct = [pA_H20_PLS+pA_03_plastico];
                                 dataTab = [TETA TETA2 corrrct];
                                 set(handles.tabela1,'Data',dataTab);
                                        axes(handles.axes2);
                                        plot(corrrct);
                                        title('Coreção pA. c/Vazio+H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        hold	
                                        plot(pA_H20_PLS,'r') 
                                        plot(pA_03_plastico,'g') 
                                          legend('H20+Vazio ','Porta Amostras (PA03) com agua ', 'Porta Amostras (PA03) vazio')
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                 corrrct = [pA_H20_PLS+pA_04_filme_plasticoVazio];
                                 dataTab = [TETA TETA2 corrrct];
                                 set(handles.tabela1,'Data',dataTab);
                                      
                                        axes(handles.axes2);
                                        plot(corrrct);
                                        title('Coreção pA. c/Vazio+H20');
                                        xlabel('theta');
                                        ylabel('Intensidade');
                                        grid on
                                        hold	
                                        plot(pA_H20_PLS,'r') 
                                        plot(pA_04_filme_plasticoVazio,'g') 
                                        legend('H20+Vazio ','Porta Amostras (PA04) com agua ', 'Porta Amostras (PA04) vazio')
                                        
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
    title('H20+Vazio+Amostra sem corrigir');
    xlabel('theta');
    ylabel('Intensidade');
    grid on
    hold

  


% --- Executes on button press in soh_vazio.
function soh_vazio_Callback(hObject, eventdata, handles)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.soh_agua,'Value',0)

set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));

        global pA_03_plastico;
        global pA_01_vazio2;
        global pA_02_vazio;
        global pA_04_filme_plasticoVazio;
        global pAselecionado;
        global dadosSelecionados;
        global plotCorrigido;
                            if(strcmp(pAselecionado,'PA01'))
                                  curr =    dadosSelecionados(:,2) -  pA_01_vazio2;
                                  dataTab =  [dadosSelecionados(:,2)  pA_01_vazio2 curr];
                                  set(handles.tabela3,'Data',dataTab);
                                  plotCorrigido = curr;
                           end
                          
                           if(strcmp(pAselecionado,'PA02'))
                                   curr = dadosSelecionados(:,2) - pA_02_vazio;
                                   dataTab =  [dadosSelecionados(:,2)  pA_02_vazio curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                           end
                          if(strcmp(pAselecionado,'PA03'))
                                    curr = dadosSelecionados(:,2) - pA_03_plastico;
                                    dataTab =  [dadosSelecionados(:,2) pA_03_plastico curr];
                                    set(handles.tabela3,'Data',dataTab);
                                    plotCorrigido = curr;
                          end
                          if(strcmp(pAselecionado,'PA04'))
                                   curr = dadosSelecionados(:,2) - pA_04_filme_plasticoVazio;
                                   dataTab =  [dadosSelecionados(:,2)  pA_04_filme_plasticoVazio curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                          end

function soh_agua_Callback(hObject, eventdata, handles)
set(handles.h2o_mais_vazio,'Value',0)
set(handles.soh_vazio,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));
        global pA_H20_PLS;
        global pAselecionado;
        global dadosSelecionados;
        global plotCorrigido;
         
                            if(strcmp(pAselecionado,'PA01'))
                                  curr =    dadosSelecionados(:,2) -  pA_H20_PLS;
                                  dataTab =  [dadosSelecionados(:,2)   pA_H20_PLS curr];
                                  set(handles.tabela3,'Data',dataTab);
                                  plotCorrigido = curr;
                           end
                          
                           if(strcmp(pAselecionado,'PA02'))
                                 curr = dadosSelecionados(:,2) - pA_H20_PLS;
                                 dataTab =  [dadosSelecionados(:,2)  pA_H20_PLS curr];
                                 set(handles.tabela3,'Data',dataTab);
                                 plotCorrigido = curr;                                
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                        curr = dadosSelecionados(:,2) - pA_H20_PLS;
                                        dataTab =  [dadosSelecionados(:,2) pA_H20_PLS curr];
                                        set(handles.tabela3,'Data',dataTab);
                                        plotCorrigido = curr;                                        
                          end
                           if(strcmp(pAselecionado,'PA04'))
                                    curr = dadosSelecionados(:,2) - pA_H20_PLS;
                                   dataTab =  [dadosSelecionados(:,2)  pA_H20_PLS curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                          end


function h2o_mais_vazio_Callback(hObject, eventdata, handles)
set(handles.soh_vazio,'Value',0)
set(handles.soh_agua,'Value',0)
set(handles.tabela3, 'Data', cell(size(get(handles.tabela3,'Data'))));

        global pA_H20_PLS;
        global pA_04;
        global pA_03;
        global pA_02_vazio;
        global pA_02;
        global pA_04_filme_plasticoVazio;
        global pA_03_repetidoVazio;
        global pA_03_paraFilme_vazio2;
        global pA_02_vazio_repetido;
        global pA_03_plastico;
        global pA_01_vazio2;
         global pAselecionado;
        global dadosSelecionados;
        global plotCorrigido;
        
                            if(strcmp(pAselecionado,'PA01'))
                                  aux = pA_H20_PLS+pA_01_vazio2;
                                  curr =    dadosSelecionados(:,2) -  aux;
                                  dataTab =  [dadosSelecionados(:,2)   pA_H20_PLS curr];
                                  set(handles.tabela3,'Data',dataTab);
                                  plotCorrigido = curr;
                           end
                           if(strcmp(pAselecionado,'PA02'))
                                  aux = pA_H20_PLS+pA_02_vazio_repetido;
                                  curr =    dadosSelecionados(:,2) -  aux;
                                  dataTab =  [dadosSelecionados(:,2)  pA_H20_PLS curr];
                                 set(handles.tabela3,'Data',dataTab);
                                 plotCorrigido = curr;                                
                          end
                          if(strcmp(pAselecionado,'PA03'))
                                         aux = pA_H20_PLS+pA_03_repetidoVazio;
                                        curr =    dadosSelecionados(:,2) -  aux;
                                        dataTab =  [dadosSelecionados(:,2) pA_H20_PLS curr];
                                        set(handles.tabela3,'Data',dataTab);
                                        plotCorrigido = curr;                                        
                          end
                           if(strcmp(pAselecionado,'PA04'))
                                   aux = pA_H20_PLS+pA_04;
                                   curr =    dadosSelecionados(:,2) -  aux;
                                   dataTab =  [dadosSelecionados(:,2)  pA_H20_PLS curr];
                                   set(handles.tabela3,'Data',dataTab);
                                   plotCorrigido = curr;
                          end



function plot_corrigido_Callback(hObject, eventdata, handles)
     global plotCorrigido;
     global TETA;
     global media;
     
     
     x = TETA
     y =plotCorrigido;
       
     media=mean(plotCorrigido,1)

         axes(handles.axes1);
       
         
         mostrarMedia= get(handles.checkbox9,'Value');
         if(mostrarMedia>0)
         hold
         plot(media*ones(234), 'LineWidth', 5)
         end
         
         plot(plotCorrigido, 'color',rand(1,3));     
         %         stem(plotCorrigido)
        title('Grafico Corrigido');
        xlabel('theta');
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
     
     


function fazAnalise_Callback(hObject, eventdata, handles)



function valor_de_pico_Callback(hObject, eventdata, handles)

