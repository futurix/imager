unit ngexpw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NGImage, StdCtrls, Registry, ColorPickerButton;

type
  TfrmXNG = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxFormat: TGroupBox;
    gbxAdv: TGroupBox;
    cbxAdvanced: TCheckBox;
    rbnPNG: TRadioButton;
    rbnJNG: TRadioButton;
    cpbTrans: TColorPickerButton;
    rbnTColor: TRadioButton;
    rbnTMask: TRadioButton;
    edtPath: TEdit;
    btnSelectFile: TButton;
    dlgSavePNG: TSaveDialog;
    dlgSaveJNG: TSaveDialog;
    dlgSelMask: TOpenDialog;
    procedure cbxAdvancedClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
    procedure cpbTransChange(Sender: TObject);
    procedure edtPathChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  GUID = 'D8A1CF40-4180-11D5-A350-CC91128ACE28';
  sReg = '\Software\Futuris\ImagerC';
  sFIPIS = '\Software\Futuris\FIPIS';
  sName = 'Futuris Imager';

var
  frmXNG: TfrmXNG;
  bmp: TBitmap;

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer; stdcall;

implementation

{$R *.DFM}

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer;
var
   reg: TRegistry;
begin
Application.Handle:=app;
// setting all
bmp:=TBitmap.Create();
bmp.Handle:=img;
frmXNG:=TfrmXNG.Create(Application);
// getting registry settings
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
if reg.OpenKey(sReg + '\Plug-ins\' + GUID,false) then begin
                                                      // reading
                                                      try if not reg.ReadBool('Check') then frmXNG.rbnJNG.Checked:=true except end;
                                                      try if reg.ReadBool('Adv') then begin
                                                                                      frmXNG.cbxAdvanced.Checked:=true;
                                                                                      frmXNG.gbxAdv.Enabled:=true;
                                                                                      end
                                                                                      except end;
                                                      try if reg.ReadBool('Mask') then frmXNG.rbnTMask.Checked:=true except end;
                                                      try frmXNG.cpbTrans.SelectionColor:=StringToColor(reg.ReadString('Color')) except end;
                                                      try frmXNG.edtPath.Text:=reg.ReadString('Path') except end;
                                                      reg.CloseKey();
                                                      end;
// working
frmXNG.ShowModal();
// saving settings
reg.OpenKey(sReg + '\Plug-ins\' + GUID,true);
if frmXNG.rbnPNG.Checked then reg.WriteBool('Check',true)
   else reg.WriteBool('Check',false);
if frmXNG.cbxAdvanced.Checked then reg.WriteBool('Adv',true)
   else reg.WriteBool('Adv',false);
if frmXNG.rbnTMask.Checked then reg.WriteBool('Mask',true)
   else reg.WriteBool('Mask',false);
reg.WriteString('Path',frmXNG.edtPath.Text);
reg.WriteString('Color',ColorToString(frmXNG.cpbTrans.SelectionColor));
reg.CloseKey();
// cleaning
frmXNG.Free();
bmp.Free();
Result:=1;
end;

procedure TfrmXNG.cbxAdvancedClick(Sender: TObject);
begin
if cbxAdvanced.Checked then gbxAdv.Enabled:=true
else gbxAdv.Enabled:=false;
end;

procedure TfrmXNG.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmXNG.btnOKClick(Sender: TObject);
var
   xng: TNGImage;
   path: string;
   alpha: TBitmap;
begin
if rbnJNG.Checked then begin
                       // saving JNG
                       if dlgSaveJNG.Execute then path:=dlgSaveJNG.FileName;
                       if path='' then Exit;
                       if cbxAdvanced.Checked then begin
                                                   // using special settings
                                                   if ((rbnTMask.Checked) and (edtPath.Text<>'') and (FileExists(edtPath.Text))) then
                                                      begin
                                                      // using mask
                                                      xng:=TNGImage.Create();
                                                      xng.Assign(bmp);
                                                      alpha:=TBitmap.Create();
                                                      alpha.LoadFromFile(edtPath.Text);
                                                      xng.SetAlphaBitmap(alpha);
                                                      alpha.Free();
                                                      xng.SaveToJNGfile(path);
                                                      xng.Free();
                                                      end
                                                   else begin
                                                        // using color
                                                        xng:=TNGImage.Create();
                                                        xng.Assign(bmp);
                                                        xng.SetAlphaColor(cpbTrans.SelectionColor);
                                                        xng.SaveToJNGfile(path);
                                                        xng.Free();
                                                        end;
                                                   end
                       else begin
                            // plain save
                            xng:=TNGImage.Create();
                            xng.Assign(bmp);
                            xng.SaveToJNGfile(path);
                            xng.Free();
                            end;
                       end
else begin
     // saving PNG
     if dlgSavePNG.Execute then path:=dlgSavePNG.FileName;
     if path='' then Exit;
     if cbxAdvanced.Checked then begin
                                 // using special settings
                                 if ((rbnTMask.Checked) and (edtPath.Text<>'') and (FileExists(edtPath.Text))) then
                                    begin
                                    // using mask
                                    xng:=TNGImage.Create();
                                    xng.Assign(bmp);
                                    alpha:=TBitmap.Create();
                                    alpha.LoadFromFile(edtPath.Text);
                                    xng.SetAlphaBitmap(alpha);
                                    alpha.Free();
                                    xng.SaveToPNGfile(path);
                                    xng.Free();
                                    end
                                 else begin
                                      // using color
                                      xng:=TNGImage.Create();
                                      xng.Assign(bmp);
                                      xng.SetAlphaColor(cpbTrans.SelectionColor);
                                      xng.SaveToPNGfile(path);
                                      xng.Free();
                                      end;
                                 end
     else begin
          // plain save
          xng:=TNGImage.Create();
          xng.Assign(bmp);
          xng.SaveToPNGfile(path);
          xng.Free();
          end;
     end;
Close();
end;

procedure TfrmXNG.btnSelectFileClick(Sender: TObject);
begin
if dlgSelMask.Execute then edtPath.Text:=dlgSelMask.FileName;
end;

procedure TfrmXNG.cpbTransChange(Sender: TObject);
begin
rbnTColor.Checked:=true;
end;

procedure TfrmXNG.edtPathChange(Sender: TObject);
begin
rbnTMask.Checked:=true;
end;

end.
