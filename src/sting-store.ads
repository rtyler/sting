with Ada.Containers.Hashed_Maps;

package Sting.Store is
    type Engine is tagged private;
    type SString is access String;

    function Count (E : in Engine) return Natural;

    function Hash (Key : SString) return Ada.Containers.Hash_Type;

    procedure Insert (E     : in out Engine;
                      Key   : in SString;
                      Value : in SString);

    function Retrieve (E   : in Engine;
                       Key : in SString) return SString;

private

    package StingContainer is new Ada.Containers.Hashed_Maps
        (Key_Type        => SString,
         Element_Type    => SString,
         Hash            => Hash,
         Equivalent_Keys => "=");

    type Engine is tagged record
        Backend : StingContainer.Map;
    end record;

end Sting.Store;
