with POSIX.Memory_Mapping,
     POSIX.Permissions;

package body Sting.Blockstore is

    protected body Bitmap_Store is

        procedure Initialize_Bitmap_File is
        begin
            Data.Initialize (Block_Bitmap_File);
        end Initialize_Bitmap_File;

    end Bitmap_Store;


    procedure Initialize (Bitmap    : in out Bitmap_Type;
                          File_Path : in String) is

        use POSIX,
            POSIX.Memory_Mapping;
    begin
        Bitmap.File_Handle := POSIX.IO.Open_Or_Create
                                  (Name        => POSIX.To_POSIX_String (File_Path),
                                   Mode        => POSIX.IO.Read_Only,
                                   Permissions => POSIX.Permissions.Access_Permission_Set);


        Bitmap.Mapped_Address := POSIX.Memory_Mapping.Map_Memory
                                     (First => System.Null_Address,
                                      Length     => Block_Bitmap_Bytes,
                                      Protection => Allow_Read,
                                      Mapping    => Map_Shared,
                                      Location   => Exact_Address,
                                      File       => Bitmap.File_Handle,
                                      Offset     => 0);

    end Initialize;


end Sting.Blockstore;
