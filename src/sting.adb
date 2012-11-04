private with GNAT.String_Split;
use GNAT.String_Split;
with Ada.Text_IO,
     Ada.Characters.Latin_1;
use Ada.Text_IO;

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

        if Slice_Count (Parts) >= 2 then
            for I in 2 .. Slice_Count (Parts) loop
                declare
                    Keys : Slice_Set;
                begin
                    Create (Keys, Slice (Parts, I), "/", Mode => Multiple);
                    for J in 2 .. Slice_Count (Keys) loop
                        declare
                            Sub : String := Slice (Keys, J);
                            K : Key_Type := (others => Ada.Characters.Latin_1.NUL);
                        begin
                            -- WTF IS THIS WIZARDRY
                            K := Key_Type (Sub & String (K ((Sub'Length + 1).. K'Last)));
                            C.Keys.Append (K);
                        end;
                    end loop;
                end;
            end loop;
        end if;

        if Slice (Parts, 1) = "read" then
            C.Kind := Sting.Read;
        end if;

        return C;
    end Parse;

end Sting;
