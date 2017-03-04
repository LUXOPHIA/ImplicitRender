unit Main;

interface //####################################################################

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.Types3D, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Objects3D, FMX.Controls3D, FMX.Viewport3D, FMX.TabControl,
  LUX, LUX.D3, LUX.FMX, LUX.FMX.Context.DX11,
  LIB.Material;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
      TabItemV: TTabItem;
        Viewport3D1: TViewport3D;
          Dummy1: TDummy;
            Dummy2: TDummy;
              Camera1: TCamera;
          Light1: TLight;
          Grid3D1: TGrid3D;
          StrokeCube1: TStrokeCube;
      TabItemS: TTabItem;
        TabControlS: TTabControl;
          TabItemSV: TTabItem;
            TabControlSV: TTabControl;
              TabItemSVC: TTabItem;
                MemoSVC: TMemo;
              TabItemSVE: TTabItem;
                MemoSVE: TMemo;
          TabItemSP: TTabItem;
            TabControlSP: TTabControl;
              TabItemSPC: TTabItem;
                MemoSPC: TMemo;
              TabItemSPE: TTabItem;
                MemoSPE: TMemo;
    Panel1: TPanel;
      ScrollBar1: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { private 宣言 }
    _MouseS :TShiftState;
    _MouseP :TPointF;
    ///// メソッド
    procedure ImportShader;
  public
    { public 宣言 }
    _MathCube :TMathCube;
  end;

var
  Form1: TForm1;

implementation //###############################################################

{$R *.fmx}

uses System.Math,
     LUX.FMX.Types3D;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.ImportShader;
var
   T :String;
begin
     MemoSVC.Lines.LoadFromFile( '..\..\_DATA\ShaderV.hlsl' );
     MemoSPC.Lines.LoadFromFile( '..\..\_DATA\ShaderP.hlsl' );

     with _MathCube.Material do
     begin
          with ShaderV do
          begin
               Source.Text := MemoSVC.Text;

               with Errors do
               begin
                    for T in Keys do
                    begin
                         with MemoSVE.Lines do
                         begin
                              Add( '▼ ' + T   );
                              Add( Errors[ T ] );
                         end;
                    end;

                    if Count > 0 then
                    begin
                         if ContainsKey( 'vs_5_0' ) then TabItemS.IsSelected := True;

                         TabItemSV .IsSelected := True;
                         TabItemSVE.IsSelected := True;
                    end;
               end;
          end;

          with ShaderP do
          begin
               Source.Text := MemoSPC.Text;

               with Errors do
               begin
                    for T in Keys do
                    begin
                         with MemoSPE.Lines do
                         begin
                              Add( '▼ ' + T   );
                              Add( Errors[ T ] );
                         end;
                    end;

                    if Count > 0 then
                    begin
                         if ContainsKey( 'ps_5_0' ) then TabItemS.IsSelected := True;

                         TabItemSP .IsSelected := True;
                         TabItemSPE.IsSelected := True;
                    end;
               end;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     Assert( Viewport3D1.Context.ClassName = 'TLuxDX11Context', 'TLuxDX11Context class is not applied!' );

     //////////

     _MathCube := TMathCube.Create( Viewport3D1 );

     with _MathCube do
     begin
          Parent := Viewport3D1;

          Width  := 10;
          Height := 10;
          Depth  := 10;
     end;

     ImportShader;
end;

//------------------------------------------------------------------------------

procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TPointF.Create( X, Y );
end;

procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TPointF;
begin
     if ssLeft in _MouseS then
     begin
          P := TPointF.Create( X, Y );

          with Dummy1.RotationAngle do Y := Y + ( P.X - _MouseP.X ) / 2;
          with Dummy2.RotationAngle do X := X - ( P.Y - _MouseP.Y ) / 2;

          _MouseP := P;
     end;
end;

procedure TForm1.Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     Viewport3D1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

//------------------------------------------------------------------------------

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
     _MathCube.Material.Phase := Pi4 * ScrollBar1.Value;

     Viewport3D1.Repaint;
end;

end. //#########################################################################
