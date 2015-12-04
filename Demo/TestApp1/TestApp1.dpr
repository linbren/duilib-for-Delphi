program TestApp1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  DuiConst,
  DuiWindowImplBase,
  Duilib,
  DuilibHelper;

type

  TFrameWindowWnd = class(TDuiWindowImplBase)
  private
  protected
    procedure DoInitWindow; override;
    procedure DoNotify(var Msg: TNotifyUI); override;
    procedure DoHandleMessage(var Msg: TMessage; var bHandled: BOOL); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TFrameWindowWnd }

constructor TFrameWindowWnd.Create;
begin
  inherited Create('test1.xml', 'skin\TestAppRes');
  CreateWindow(0, '����һ����򵥵Ĳ�����exe���޸�test1.xml�Ϳ��Կ���Ч��', UI_WNDSTYLE_FRAME, WS_EX_WINDOWEDGE);
  SetClassStyle(UI_CLASSSTYLE_FRAME or CS_DBLCLKS);
  // Ĭ�ϵ��������ȥ���������ģ�����Ҫ���²���
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or WS_CAPTION);
  SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOSIZE or SWP_NOMOVE);
end;

destructor TFrameWindowWnd.Destroy;
begin
  RemoveThisInPaintManager;
  inherited;
end;

procedure TFrameWindowWnd.DoHandleMessage(var Msg: TMessage; var bHandled: BOOL);
begin
  case Msg.Msg of
    // ������������,���ñ�����������
    WM_NCACTIVATE,
    WM_NCCALCSIZE,
    WM_NCPAINT:
      begin
        bHandled := False;
      end;
    WM_ERASEBKGND: Msg.Result := 1;
    WM_DESTROY: PostQuitMessage(0);
  end;
end;

procedure TFrameWindowWnd.DoInitWindow;
begin
  inherited;

end;

procedure TFrameWindowWnd.DoNotify(var Msg: TNotifyUI);
begin
  inherited;

end;

var
  FrameWindowWnd: TFrameWindowWnd;

begin
  try
    DuiApplication.Initialize;
    FrameWindowWnd := TFrameWindowWnd.Create;
    FrameWindowWnd.CenterWindow;
    FrameWindowWnd.Show;
    DuiApplication.Run;
    FrameWindowWnd.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.