with Alog.Logger;

procedure Main is
    Log : Alog.Logger.Instance (Init => True);
begin
    Log.Log_Message (Level => Alog.Info,
                     Msg => "Starting stingd..");
end Main;
