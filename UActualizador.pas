unit UActualizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient, StdCtrls, DB, DBClient, SimpleDS, SqlExpr, Gauges, Buttons,
  Menus, IniFiles, Grids, DBGrids, ComCtrls, ShellApi, Registry;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SimpleDataSet1: TSimpleDataSet;
    Label1: TLabel;
    IdIcmpClient1: TIdIcmpClient;
    BitBtn1: TBitBtn;
    CbTerminal: TComboBox;
    CbModo: TComboBox;
    BitBtn2: TBitBtn;
    SimpleDataSet1UPGRADE: TSmallintField;
    SimpleDataSet1ACTUAL: TSmallintField;
    SimpleDataSet1ADM_8: TSmallintField;
    SimpleDataSet1ADM_ALTA: TSmallintField;
    SimpleDataSet1ADM_GLENY: TSmallintField;
    SimpleDataSet1ADM_MIGUELITO: TSmallintField;
    SimpleDataSet1ADM_RAQUEL: TSmallintField;
    SimpleDataSet1ADM_ROBERTO: TSmallintField;
    SimpleDataSet1ADM_ROSSY: TSmallintField;
    SimpleDataSet1ADM_SOPORTE: TSmallintField;
    SimpleDataSet1ALCARRIZOS: TSmallintField;
    SimpleDataSet1ALMACEN: TSmallintField;
    SimpleDataSet1BOCA_CHICA: TSmallintField;
    SimpleDataSet1CAMBITA: TSmallintField;
    SimpleDataSet1ELECTROMUEBLES: TSmallintField;
    SimpleDataSet1ELIAS_PINA: TSmallintField;
    SimpleDataSet1EXTRA_1: TSmallintField;
    SimpleDataSet1EXTRA_2: TSmallintField;
    SimpleDataSet1EXTRA_3: TSmallintField;
    SimpleDataSet1HAINA_1: TSmallintField;
    SimpleDataSet1HAINA_2: TSmallintField;
    SimpleDataSet1HAINA_3: TSmallintField;
    SimpleDataSet1HATO_NUEVO: TSmallintField;
    SimpleDataSet1INDEPENDENCIA: TSmallintField;
    SimpleDataSet1KM_22: TSmallintField;
    SimpleDataSet1KM_25: TSmallintField;
    SimpleDataSet1LA_PARED: TSmallintField;
    SimpleDataSet1LAS_AMERICAS: TSmallintField;
    SimpleDataSet1LAS_PALMAS: TSmallintField;
    SimpleDataSet1LOS_FRAILES: TSmallintField;
    SimpleDataSet1NIGUA_1: TSmallintField;
    SimpleDataSet1NIGUA_2: TSmallintField;
    SimpleDataSet1NIZAO: TSmallintField;
    SimpleDataSet1PALENQUE: TSmallintField;
    SimpleDataSet1PANTOJA: TSmallintField;
    SimpleDataSet1QUITA_SUENO: TSmallintField;
    SimpleDataSet1SAN_CRISTOBAL: TSmallintField;
    SimpleDataSet1SAN_VICENTE: TSmallintField;
    SimpleDataSet1VILLA_MELLA: TSmallintField;
    BitBtn3: TBitBtn;
    CbRutaES: TComboBox;
    BitBtn4: TBitBtn;
    CbRutaApp: TComboBox;
    Gauge1: TGauge;
    
      
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);


  private
  Procedure Probar_Conexion;
  public

  end;

var
  Form1: TForm1;
  Ini, Ini2  : TIniFile;
  Configurado, Terminal, Cad3, Sql, Ruta,Ruta_Winrar, IpServidor, Modo: String;
  Num1, Num2, Num_Act: Integer;
  lpFileOp: TSHFileOpStruct;
implementation

{$R *.dfm}

//PROBANDO CONEXION: INICIO
Procedure TForm1.Probar_Conexion;
begin
if Modo = 'Local' then
    IpServidor:= '10.0.0.15';

    if Modo = 'Remoto' then
    IpServidor:= '5.108.175.106';

IdIcmpClient1.Host:= IpServidor;
IdIcmpClient1.Ping;

if IdIcmpClient1.ReplyStatus.BytesReceived = 0 then
    begin
      Label1.Caption:= 'No Conectado';
    end else begin
      Label1.Caption:= 'Conectado '+ IpServidor;
    end;

end;
//PROBANDO CONEXION: FIN

procedure TForm1.BitBtn1Click(Sender: TObject);
var lpFileOp2: TSHFileOpStruct; Unrar:String;
begin
Unrar:='x "'+Ruta+'Easy_System_S2010.part01.rar" '+'"'+Ruta+'"';
ShellExecute(Form1.Handle,nil,PChar(Ruta_Winrar),Pchar(Unrar),'',SW_HIDE);
//ShellExecute(Handle, 'Open', 'C:\Archivos de programa\WinRAR\rar.exe', 'x "D:\Easy System S2010\Easy_System_S2010.part01.rar" '+'"'+Ruta+'"', nil, SW_HIDE);
    { Relleno de la estructura }
    {lpFileOp2.Wnd := Self.Handle;
    lpFileOp2.wFunc := FO_DELETE;
    lpFileOp2.pFrom := PChar('D:\Easy System S2010\Easy_System_S2010.*.rar' + #0#0);
    lpFileOp2.pTo := nil;
    lpFileOp2.fFlags:= FOF_SIMPLEPROGRESS or FOF_FILESONLY or FOF_NOCONFIRMATION;
    lpFileOp2.fAnyOperationsAborted := FALSE;
    lpFileOp2.hNameMappings := nil;
    lpFileOp2.lpszProgressTitle := PChar('Trasladando archivos al disco D' + #0#0);
    { Mover el archivo }
    //SHFileOperation(lpFileOp2);
end;
procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  try
    Ini.WriteString( 'ComboBox1', 'Terminal', CbTerminal.Text);
    Ini.WriteString( 'ComboBox1', 'Modo', CbModo.Text );
    Ini.WriteString( 'ComboBox1', 'Rutas', CbRutaES.Text );
    Ini.WriteString( 'ComboBox1', 'Iniciado?', 'SI' );
    Ini.WriteString( 'ComboBox1', 'Ruta_Winrar', CbRutaApp.Text );
    //Ini.WriteString( 'ComboBox1', 'Num_Act', '' );
    Ini.WriteBool( 'Form', 'InitMax', WindowState = wsMaximized );
  finally
    Ini.Free;

  end;
end;




procedure TForm1.FormCreate(Sender: TObject);
begin
Cad3:='ADM_SOPORTE';
Ini2 := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );

    Configurado:= Ini2.ReadString( 'ComboBox1', 'Iniciado?', '' );
    Terminal:=    Ini2.ReadString( 'ComboBox1', 'Terminal', '' );
    Modo:=        Ini2.ReadString( 'ComboBox1', 'Modo', '' );
    Num1:=StrToInt(Ini2.ReadString('ComboBox1', 'Num_Act', ''));
    Num2:= SimpleDataSet1UPGRADE.AsInteger;
    Ruta:=        Ini2.ReadString( 'ComboBox1', 'Rutas', '' );
    Ruta_Winrar:=Ini2.ReadString( 'ComboBox1', 'Ruta_Winrar', '' );



  if Configurado = 'SI' then
    begin
   CbTerminal.Visible:= False;
   CbModo.Visible:= False;
   BitBtn2.Visible:=False;
  end;
   //if Terminal = 'Adm_Soporte' then begin

    //Num2:= SimpleDataSet1UPGRADE.AsInteger;
    //SimpleDataSet1.Close;
     //if Num1 < Num2 then
      //Iniciar Copiar
      //SimpleDataSet1.DataSet.CommandText := 'UPDATE ACTUALIZADOR  SET ADM_SOPORTE = ADM_SOPORTE + 1';
      //SimpleDataSet1.Open;
end;


procedure TForm1.BitBtn3Click(Sender: TObject);
var lpFileOp: TSHFileOpStruct;
begin
Probar_Conexion;

 if Num1 < Num2 then
 begin
 //ShowMessage('Iniciando');

begin

    { Relleno de la estructura }
    {lpFileOp.Wnd := Self.Handle;
    lpFileOp.wFunc := FO_COPY;
    lpFileOp.pFrom := PChar('D:\Actualizaciones\*.*' + #0#0);
    lpFileOp.pTo := PChar('D:\Easy System S2010' + #0#0);
    lpFileOp.fFlags:= FOF_SIMPLEPROGRESS or FOF_FILESONLY;
    lpFileOp.fAnyOperationsAborted := FALSE;
    lpFileOp.hNameMappings := nil;
    lpFileOp.lpszProgressTitle := PChar('Trasladando archivos al disco D' + #0#0);
    ProgressBar1.Position:= 50;
   
    { Mover el archivo }
    //SHFileOperation(lpFileOp);

 //origen:= 'D:\Actualizaciones\*.*';
 //destino:= 'D:\Easy System S2010';

end;
end;
end;
procedure TForm1.BitBtn4Click(Sender: TObject);
begin
if Modo = 'Local' then
    IpServidor:= '10.0.0.15';

      ShowMessage(IpServidor);
end;

Function Letra_Sistema: String;
var
  WinDir: PChar;
  R, NOB: String;
  En_C, Con_Inf: Boolean;
begin
  GetMem(WinDir, 144);
  GetWindowsDirectory(WinDir, 144);
  R:= Copy(WinDir, 0, 3);
  end;
Function AGregarSlash(S: String):String;
begin


  if S<>'' then begin
  if Copy(S, Length(S), 1)<>'\' then
   result:= S+ '\'
   else result:= S;
  end else
     Result:='';
end;
Function Carpet_ProgramFilesDir: String;
var
  Reg : TRegistry;
  Ruta, Drive: String;
begin
 Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion', True) then
    begin

     Ruta:= Reg.ReadString('ProgramFilesDir');
  
     if Length(Ruta)<5 then begin
        Drive:= Letra_Sistema;
         if DirectoryExists(Drive+'Archivos de programa')then
            Ruta:= Drive+'Archivos de programa\'
            else
         if DirectoryExists(Drive+'Program Files')then
            Ruta:= Drive+'Program Files\';
     end;  // fin if Length(Ruta)<5
     
     if Length(Ruta)>5 then
        Ruta:=  AGregarSlash(Ruta);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;

  end;
 Result:=  Ruta

  
END;

end.
