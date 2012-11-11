with Ada.Strings.Hash;

package body Sting.Store is

    function Count (E : in Engine) return Natural is
        (Natural (E.Backend.Length));


    procedure Insert (E     : in out Engine;
                      Key   : in SString;
                      Value : in SString) is
    begin
        E.Backend.Insert (Key, Value);
    end Insert;


    function Retrieve (E   : in Engine;
                       Key : in SString) return SString is
        (E.Backend.Element (Key));


    function Hash (Key : SString) return Ada.Containers.Hash_Type is
        (Ada.Strings.Hash (Key.all));

end Sting.Store;
