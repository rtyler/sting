package body Sting.Store is

    function Count (E : in Engine) return Natural is
    begin
        return Natural (E.Backend.Length);
    end Count;


    procedure Insert (E : in Engine;
                        Key : in SString;
                        Value : in SString) is

        B : StingContainer.Map := E.Backend;
    begin
        B.Insert (Key, Value);
    end Insert;


    function Hersh (Key : SString) return Ada.Containers.Hash_Type is
        pragma Unreferenced (Key);
    begin
        return Ada.Containers.Hash_Type'Val (1);
    end Hersh;

end Sting.Store;
