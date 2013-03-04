with Alog.Logger;

with Sting.Blockstore;

procedure Main is
    Log : Alog.Logger.Instance (Init => True);
begin
    Sting.Blockstore.Bitmap_Store.Initialize_Bitmap_File;

    Log.Log_Message (Level => Alog.Info,
                     Msg => "Starting stingd..");
end Main;
