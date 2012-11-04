private with GNAT.String_Split;
use GNAT.String_Split;

package body Sting is

    function Parse (Buffer : in String) return Command is
        C : Command;
        Parts : Slice_Set;
    begin
        -- Set the command kind as Unknown until we figure out what it is
        -- exactly
        C.Kind := Sting.Unknown;

        if Buffer = "ping" then
            C.Kind := Sting.Ping;
            return C;
        end if;

        -- For all other commands, we need to parse out the command from the
        -- key
        Create (Parts, Buffer, " ", Mode => Multiple);

        if Slice_Count (Parts) < 2 then
            -- TODO: Error out dummy!
            null;
        end if;

        if Slice (Parts, 1) = "read" then
            C.Kind := Sting.Read;
        end if;

        return C;
    end Parse;

end Sting;
