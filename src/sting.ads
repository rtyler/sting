with Ada.Containers,
     Ada.Containers.Indefinite_Doubly_Linked_Lists;

package Sting is
    type Command_Type is (Ping, Create, Read, Delete, Keys, Count, Unknown);
    type Command is tagged private;

    function Parse (Buffer : in String) return Command with
        Pre => Buffer'Length >0;

    package Key_Chain is new Ada.Containers.Indefinite_Doubly_Linked_Lists (
            Element_Type => String);

    Invalid_Key_Error : exception;
    Max_Key_Length : constant Positive := 255;

private

    type Command is tagged record
        Kind : Command_Type;
        Keys : Key_Chain.List;
    end record;
end Sting;
