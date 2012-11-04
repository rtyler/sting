
package body Sting is

    procedure Hello is
    begin
        null;
    end Hello;

    function Parse (Buffer : in String) return Command is
        C : Command;
    begin
        if Buffer = "ping" then
            C.Kind := Sting.Ping;
        end if;

        return C;
    end Parse;

end Sting;
