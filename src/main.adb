with Ada.Text_IO;
with Alog.Logger;

procedure Main is
    Log : Alog.Logger.Instance (Init => True);
begin
    Log.Log_Message (Level => Alog.Info,
                     Msg => "Stingd! logging");
end Main;
