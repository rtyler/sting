
package Sting is
    type Command_Type is (Ping, Create, Read, Delete, Keys, Count, Unknown);

    type Command is tagged private;

    procedure Hello;
    function Parse (Buffer : in String) return Command;

private

    type Command is tagged record
        Kind : Command_Type;
    end record;
end Sting;
