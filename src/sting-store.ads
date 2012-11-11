with Ada.Containers.Hashed_Maps;

package Sting.Store is
    type Engine is tagged private;
    type SString is access String;

    function Count (E : in Engine) return Natural;
    procedure Insert (E : in Engine;
                        Key : in SString;
                        Value : in SString);

    function Hersh (Key : SString) return Ada.Containers.Hash_Type;

    package StingContainer is new Ada.Containers.Hashed_Maps
        (Key_Type => SString,
         Element_Type => SString,
         Hash => Hersh,
         Equivalent_Keys => "=");
private

    type Engine is tagged record
        Backend : StingContainer.Map;
    end record;

end Sting.Store;
