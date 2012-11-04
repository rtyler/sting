with Ada.Containers;
with Ada.Containers.Doubly_Linked_Lists;

package Sting is
    type Command_Type is (Ping, Create, Read, Delete, Keys, Count, Unknown);
    Key_Type_Length : constant Natural := 255;
    type Key_Type is new String (1 .. Key_Type_Length);

    type Command is tagged private;

    function Parse (Buffer : in String) return Command;


    package Key_Chain is new Ada.Containers.Doubly_Linked_Lists (
            Element_Type => Key_Type);

private

    type Command is tagged record
        Kind : Command_Type;
        Keys : Key_Chain.List;
    end record;
end Sting;
