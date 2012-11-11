with Ada.Strings.Hash;

package body Sting.Store is

    function Count (E : in Engine) return Natural is
        (Natural (E.Backend.Length));


    procedure Insert (E : in out Engine;
                        Key : in SString;
                        Value : in SString) is
    begin
        E.Backend.Insert (Key, Value);
    end Insert;


    function Hersh (Key : SString) return Ada.Containers.Hash_Type is
    begin
        return Ada.Strings.Hash (Key.all);
    end Hersh;

end Sting.Store;
