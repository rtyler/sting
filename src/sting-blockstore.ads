with POSIX.IO,
     System,
     System.Storage_Elements;


package Sting.Blockstore is

    --- constant: Storage_Root
    ---
    --- Root directory for all Sting storage to go
    Storage_Root : constant String := "/tmp/sting";

    --- constant: Block_Bitmap_File
    ---
    --- Full path to the block bitmap file on disk
    Block_Bitmap_File : constant String := Storage_Root & "/block_bitmap";

    --- constant: Block_Bitmap_Bytes
    ---
    --- Size of the block bitmap file to mmap(2) onto disk
    Block_Bitmap_Bytes : constant System.Storage_Elements.Storage_Offset := 134217728;


    --- type: Bitmap_Type
    ---
    --- This type is merely a container for the file handle to a Sting block
    --- bitmap file
    type Bitmap_Type is tagged record
        File_Handle : POSIX.IO.File_Descriptor;
        Mapped_Address : System.Address;
    end record;

    --- function: Initialize
    ---
    --- Initialize the given <Bitmap_Type> with the given file path
    procedure Initialize (Bitmap : in out Bitmap_Type; File_Path : in String);


    --- class: Bitmap_Store
    ---
    --- The Bitmap_Store is a "singleton" protected object which will
    --- synchronize access to the underlying <Bitmap_Type>
    ---
    protected Bitmap_Store is

        --- function: Initialize_Bitmap_File
        ---
        --- This procedure will open/create the Sting block bitmap file for mapping
        --- which blocks in the DB are free/used.
        procedure Initialize_Bitmap_File;

    private
        Data : Bitmap_Type;
    end Bitmap_Store;

end Sting.Blockstore;
