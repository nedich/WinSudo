program sudo;

uses
  windows,
  sysutils,
  classes,
  ActiveX,
  ShlObj,
  //u_ini,
  dialogs,
  math,
  //jclsysinfo,
  ShellApi;

//{$R *.res}

var
  params: string;
  i: integer;
  h: HINST;
  app: string;

const
  help2 = 'Usage: sudo application parameters';
  help1 = 'Purpose: run elevated application';
  
begin

  if(paramcount=0) then begin
      ShowMessage(help1 + #13#10 + help2);
    EXIT;
  end;

  app := ParamStr(1);
  
  params := '';
  if(ParamCount>1) then begin
    params := '';
    for i := 2 to ParamCount do begin
      if(Pos(' ', ParamStr(i))=0) then 
        params := params + ParamStr(i) + ' '
      else
        params := params + AnsiQuotedStr(ParamStr(i), '"') + ' ';
    end;
     
  end;

  //expand env var
  if(app[1]='%') and (app[Length(app)]='%') then begin
    app := GetEnvironmentVariable(Copy(app, 2, Length(app)-2));
  end;
  
  h := shellexecute(0, 'runas', PChar(app), PChar(params), PChar(GetCurrentDir), SW_NORMAL);
  ExitCode := h;
  
end.
